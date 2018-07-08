package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.*;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.generator.Output;
import nl.tudelft.serg.evosql.brew.sql.CleaningBuilder;
import nl.tudelft.serg.evosql.brew.sql.DestructionBuilder;
import nl.tudelft.serg.evosql.brew.sql.InsertionBuilder;
import nl.tudelft.serg.evosql.brew.sql.TableCreationBuilder;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import javax.annotation.Generated;
import javax.lang.model.element.Modifier;
import java.sql.SQLException;
import java.util.*;
import java.util.function.Consumer;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import static nl.tudelft.serg.evosql.brew.generator.junit.JUnitGeneratorHelper.*;

@RequiredArgsConstructor
public abstract class JUnitGenerator implements Generator {

    @NonNull
    private final JUnitGeneratorSettings jUnitGeneratorSettings;
    private final boolean testMethodsPublic;
    @NonNull
    private final Class<?> testAnnotation;
    @NonNull
    private final Class<?> beforeAllAnnotation;
    @NonNull
    private final Class<?> afterAllAnnotation;
    @NonNull
    private final Class<?> beforeEachAnnotation;
    @NonNull
    private final Class<?> afterEachAnnotation;
    @NonNull
    private final Class<?> assertionClass;

    private static final String NAME_PRODUCTION_QUERY = "PRODUCTION_QUERY";

    /**
     * Generates JUnit test suites based on the given result.
     *
     * @param result        The result to generate unit tests from.
     * @param vendorOptions The database vendor options.
     * @return String representation of generated data.
     */
    @Override
    public final List<Output> generate(Result result, VendorOptions vendorOptions) {
        AnnotationSpec generatedAnnotation = AnnotationSpec.builder(Generated.class)
                .addMember("value", "$S", getClass().getCanonicalName())
                .build();
        TypeSpec.Builder typeSpecBuilder = TypeSpec.classBuilder(jUnitGeneratorSettings.getClassName())
                .addModifiers(Modifier.PUBLIC)
                .addAnnotation(generatedAnnotation);

        FieldSpec productionQuery = FieldSpec.builder(String.class, NAME_PRODUCTION_QUERY)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                .initializer("$S", result.getInputQuery())
                .addJavadoc("The production query used to test the generated fixtures on.\n")
                .build();

        typeSpecBuilder.addField(productionQuery);

        if (jUnitGeneratorSettings.isGenerateSqlExecutorImplementation()) {
            addConnectionDataFields(typeSpecBuilder);
        }

        addRunMethods(typeSpecBuilder);
        typeSpecBuilder.addMethod(generateCreateTables(result, vendorOptions));
        typeSpecBuilder.addMethod(generateCleanTables(result, vendorOptions));
        typeSpecBuilder.addMethod(generateDropTables(result, vendorOptions));

        typeSpecBuilder.addMethod(generateBeforeAll());
        typeSpecBuilder.addMethod(generateBeforeEach());
        typeSpecBuilder.addMethod(generateAfterEach());
        typeSpecBuilder.addMethod(generateAfterAll());

        for (Path path : result.getPaths()) {
            typeSpecBuilder.addMethod(generatePathTest(path, vendorOptions));
        }

        JavaFile javaFile = JavaFile.builder(jUnitGeneratorSettings.getFilePackage(), typeSpecBuilder.build()).build();
        Output output = new Output(jUnitGeneratorSettings.getClassName() + ".java", javaFile.toString());
        return Collections.singletonList(output);
    }

    private void addConnectionDataFields(TypeSpec.Builder typeSpecBuilder) {
        FieldSpec jdbcUrlField = FieldSpec.builder(String.class, NAME_DB_JDBC_URL)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                .initializer("$S", jUnitGeneratorSettings.getConnectionData().getConnectionString())
                .addJavadoc("The JDBC url used to connect to the test database.\n")
                .build();
        typeSpecBuilder.addField(jdbcUrlField);

        FieldSpec jdbcUserField = FieldSpec.builder(String.class, NAME_DB_USER)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                .initializer("$S", jUnitGeneratorSettings.getConnectionData().getUsername())
                .addJavadoc("The username used to connect to the test database.\n")
                .build();
        typeSpecBuilder.addField(jdbcUserField);

        FieldSpec jdbcPasswordField = FieldSpec.builder(String.class, NAME_DB_PASSWORD)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                .initializer("$S", jUnitGeneratorSettings.getConnectionData().getPassword())
                .addJavadoc("The password used to connect to the test database.\n")
                .build();
        typeSpecBuilder.addField(jdbcPasswordField);
    }

    /**
     * Adds suitable run methods.
     */
    private void addRunMethods(TypeSpec.Builder typeSpecBuilder) {
        JUnitGeneratorHelper helper = new JUnitGeneratorHelper();
        if (jUnitGeneratorSettings.isGenerateSqlExecutorImplementation()) {
            typeSpecBuilder.addMethod(helper.buildRunSqlImplementation());
            typeSpecBuilder.addMethod(helper.buildGetResultColumns());
            typeSpecBuilder.addMethod(helper.buildMapMaker());
        } else {
            typeSpecBuilder.addMethod(helper.buildRunSqlEmpty());
        }
    }

    /**
     * Generates a method specification for a method that creates the tables required for queries.
     *
     * @param result        Result containing data.
     * @param vendorOptions Vendor options for the database.
     * @return A method specification for a method that drops the tables.
     */
    private MethodSpec generateCreateTables(Result result, VendorOptions vendorOptions) {
        // Method signature
        MethodSpec.Builder createTables = MethodSpec.methodBuilder("createTables")
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(TypeName.VOID)
                .addException(SQLException.class)
                .addJavadoc("Creates tables required for queries.\n");

        // Create tables code
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(vendorOptions);
        Set<String> tableCreateStrings = new HashSet<>();
        result.getPaths().stream().map(tableCreationBuilder::buildQueries).forEach(tableCreateStrings::addAll);
        for (String s : tableCreateStrings) {
            createTables.addStatement("$L($S, true)", RUN_SQL_NAME, s);
        }

        return createTables.build();
    }

    /**
     * Generates a method specification for a method that truncates the tables.
     *
     * @param result        Result containing data.
     * @param vendorOptions Vendor options for the database
     * @return A method specification for a method that drops the tables.
     */
    private MethodSpec generateCleanTables(Result result, VendorOptions vendorOptions) {
        // Method signature
        MethodSpec.Builder cleanTables = MethodSpec.methodBuilder("cleanTables")
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(TypeName.VOID)
                .addException(SQLException.class)
                .addJavadoc("Truncates the tables.\n");

        // Create tables code
        CleaningBuilder cleaningBuilder = new CleaningBuilder(vendorOptions);
        Set<String> tableCleanStrings = new HashSet<>();
        result.getPaths().stream().map(cleaningBuilder::buildQueries).forEach(tableCleanStrings::addAll);
        for (String s : tableCleanStrings) {
            cleanTables.addStatement("$L($S, true)", RUN_SQL_NAME, s);
        }

        return cleanTables.build();
    }

    /**
     * Generates a method specification for a method that drops the tables.
     *
     * @param result        Result containing data.
     * @param vendorOptions Vendor options for the database.
     * @return A method specification for a method that drops the tables.
     */
    private MethodSpec generateDropTables(Result result, VendorOptions vendorOptions) {
        // Method signature
        MethodSpec.Builder dropTables = MethodSpec.methodBuilder("dropTables")
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(TypeName.VOID)
                .addException(SQLException.class)
                .addJavadoc("Drops the tables.\n");

        // Create tables code
        DestructionBuilder destructionBuilder = new DestructionBuilder(vendorOptions);
        Set<String> destructionStrings = new HashSet<>();
        result.getPaths().stream().map(destructionBuilder::buildQueries).forEach(destructionStrings::addAll);
        for (String s : destructionStrings) {
            dropTables.addStatement("$L($S, true)", RUN_SQL_NAME, s);
        }

        return dropTables.build();
    }

    /**
     * Creates a standard JUnit test infrastructure method.
     *
     * @param name        The name of the method.
     * @param annotation  The JUnit annotation to add.
     * @param isStatic    Whether the method should be static.
     * @param bodyBuilder The consumer governing the body of the method.
     * @return A JUnit infrastructure method.
     */
    private MethodSpec makeTestMethod(String name, Class<?> annotation, boolean isStatic,
                                      Consumer<MethodSpec.Builder> bodyBuilder) {
        MethodSpec.Builder method = MethodSpec.methodBuilder(name)
                .returns(TypeName.VOID)
                .addException(SQLException.class)
                .addAnnotation(annotation);

        if (isStatic) {
            method.addModifiers(Modifier.STATIC);
        }
        if (testMethodsPublic) {
            method.addModifiers(Modifier.PUBLIC);
        }

        bodyBuilder.accept(method);
        return method.build();
    }

    /**
     * Generates a method specification for a before all test method.
     *
     * @return A method specification for a before all test method.
     */
    private MethodSpec generateBeforeAll() {
        return makeTestMethod("beforeAll", beforeAllAnnotation, true,
                m -> {
                    if (jUnitGeneratorSettings.isCreateTablesBeforeRunning()) {
                        m.addStatement("createTables()");
                    }
                }
        );
    }

    /**
     * Generates a method specification for a before each test method.
     *
     * @return A method specification for a before each test method.
     */
    private MethodSpec generateBeforeEach() {
        return makeTestMethod("beforeEach", beforeEachAnnotation, false,
                m -> {
                    if (jUnitGeneratorSettings.isCleanTablesBeforeEachRun()) {
                        m.addStatement("cleanTables()");
                    }
                }
        );
    }

    /**
     * Generates a method specification for an after each test method.
     *
     * @return A method specification for an after each test method.
     */
    private MethodSpec generateAfterEach() {
        return makeTestMethod("afterEach", afterEachAnnotation, false,
                m -> {
                    if (jUnitGeneratorSettings.isCleanTableAfterEachRun()) {
                        m.addStatement("cleanTables()");
                    }
                }
        );
    }

    /**
     * Generates a method specification for an after all test method.
     *
     * @return A method specification for an after all test method.
     */
    private MethodSpec generateAfterAll() {
        return makeTestMethod("afterAll", afterAllAnnotation, true,
                m -> {
                    if (jUnitGeneratorSettings.isDropTablesAfterRunning()) {
                        m.addStatement("dropTables()");
                    }
                }
        );
    }

    /**
     * Generates a unit test method specification for a path in the test data.
     * General structure of the test:
     * <p>
     * - Arrange: insert data into database.
     * - Act: Execute select statement on database.
     * - Assert: Assert that a result is given back from the database.
     * <p>
     * In order to execute SQL queries, this method will reference the
     * generated runSQL method.
     *
     * @param path          The path to generate a test for.
     * @param vendorOptions The vendor options to use.
     * @return A method specification for a single unit test.
     */
    private MethodSpec generatePathTest(Path path, VendorOptions vendorOptions) {
        // Method signature
        MethodSpec.Builder pTestBuilder = MethodSpec.methodBuilder(
                String.format("generatedTest%d", path.getPathNumber()))
                .returns(TypeName.VOID)
                .addException(SQLException.class)
                .addAnnotation(testAnnotation);

        if (testMethodsPublic) {
            pTestBuilder.addModifiers(Modifier.PUBLIC);
        }

        // Arrange part
        pTestBuilder.addComment("Arrange: set up the fixture data");
        InsertionBuilder insertionBuilder = new InsertionBuilder(vendorOptions);
        for (String s : insertionBuilder.buildQueries(path)) {
            pTestBuilder.addStatement("$L($S, true)", RUN_SQL_NAME, s);
        }

        // Act
        pTestBuilder.addComment("Act: run a selection query on the database");
        pTestBuilder.addStatement("$T result = $L($L, false)", RUN_SQL_RETURN_TYPE, RUN_SQL_NAME, NAME_PRODUCTION_QUERY);

        // Assert
        pTestBuilder.addComment("Assert: verify that the expected number of rows is returned");
        pTestBuilder.addStatement("$T.assertEquals($L, result.size())", assertionClass, path.getProductionOutput().size());

        if (path.getProductionOutput().size() > 0) {
            pTestBuilder.addComment("Assert: verify that the results are correct");
            for (Map<String, String> output : path.getProductionOutput()) {
                // create a pattern of "column1", "value1", "column2", "value2", etc.
                List<String> mapSpec = output.entrySet().stream()
                        .flatMap(e -> Stream.of(e.getKey(), e.getValue()))
                        .collect(Collectors.toList());

                // create a pattern of "$S", "$S", etc. to use in JavaPoet statement
                String paramPlaceholder = IntStream.range(0, mapSpec.size())
                        .mapToObj(i -> "$S")
                        .collect(Collectors.joining(", "));

                // create a list of arguments for JavaPoet
                List<Object> arguments = new ArrayList<>(2 + mapSpec.size());
                arguments.add(assertionClass);
                arguments.add(MAP_MAKER_NAME);
                arguments.addAll(mapSpec);

                pTestBuilder.addStatement("$T.assertTrue(result.contains($L(" + paramPlaceholder + ")))",
                        arguments.toArray());
            }
        }

        return pTestBuilder.build();
    }
}

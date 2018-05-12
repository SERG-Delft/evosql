package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.*;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.generator.Output;
import nl.tudelft.serg.evosql.brew.sql.*;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import javax.annotation.Generated;
import javax.lang.model.element.Modifier;
import java.sql.*;
import java.util.*;

@RequiredArgsConstructor
public abstract class JUnitGenerator implements Generator {

    @NonNull private final JUnitGeneratorSettings jUnitGeneratorSettings;
    private final boolean testMethodsPublic;
    @NonNull private final Class<?> testAnnotation;
    @NonNull private final Class<?> beforeAllAnnotation;
    @NonNull private final Class<?> afterAllAnnotation;
    @NonNull private final Class<?> beforeEachAnnotation;
    @NonNull private final Class<?> afterEachAnnotation;
    @NonNull private final Class<?> assertionClass;

    private static final String
            NAME_DB_JDBC_URL = "DB_JDBC_URL",
            NAME_DB_USER = "DB_USER",
            NAME_DB_PASSWORD = "DB_PASSWORD",
            NAME_PRODUCTION_QUERY = "PRODUCTION_QUERY";

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

        FieldSpec fieldSpec = FieldSpec.builder(String.class, NAME_PRODUCTION_QUERY)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                .initializer("$S", result.getInputQuery())
                .addJavadoc("The production query used to test the generated fixtures on.\n")
                .build();

        typeSpecBuilder.addField(fieldSpec);

        if (jUnitGeneratorSettings.isGenerateSqlExecutorImplementation()) {
            addConnectionDataFields(typeSpecBuilder);
        }

        typeSpecBuilder.addMethod(generateRunSQL());
        typeSpecBuilder.addMethod(generateCreateTables(result, vendorOptions));
        typeSpecBuilder.addMethod(generateCleanTables(result, vendorOptions));
        typeSpecBuilder.addMethod(generateDropTables(result, vendorOptions));

        typeSpecBuilder.addMethod(generateBeforeAll());
        typeSpecBuilder.addMethod(generateBeforeEach());
        typeSpecBuilder.addMethod(generateAfterEach());
        typeSpecBuilder.addMethod(generateAfterAll());

        for (Path path : result.getPaths()) {
            typeSpecBuilder.addMethod(generatePathTest(path, vendorOptions, path.getProductionOutput().size()));
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
     * Generates a method specification for the runSQL method.
     *
     * @return method.
     */
    private MethodSpec generateRunSQL() {
        MethodSpec.Builder runSQL = MethodSpec.methodBuilder("runSQL")
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(TypeName.INT)
                .addParameter(String.class, "sql")
                .addParameter(boolean.class, "isUpdate");

        if (jUnitGeneratorSettings.isGenerateSqlExecutorImplementation()) {
            runSQL.addJavadoc(""
                    + "Executes an SQL query on the database.\n\n"
                    + "@param  query    The SQL query to execute\n"
                    + "@param  isUpdate Whether the query is a data modification statement.\n"
                    + "@return Whether the query execution has succeeded.\n")
                    .beginControlFlow("try")
                    .addStatement(
                            "$T connection = $T.getConnection($L, $L, $L)",
                            Connection.class, DriverManager.class,
                            NAME_DB_JDBC_URL, NAME_DB_USER, NAME_DB_PASSWORD)
                    .addStatement("$T statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, " +
                            "ResultSet.CONCUR_READ_ONLY)", Statement.class)
                    .beginControlFlow("if (isUpdate == true)")
                    .addStatement("statement.executeUpdate(sql)")
                    .addStatement("return 0")
                    .nextControlFlow("else")
                    .addStatement("$T resultSet = statement.executeQuery(sql)", ResultSet.class)
                    .beginControlFlow("if(resultSet.last())")
                    .addStatement("return resultSet.getRow()")
                    .nextControlFlow("else")
                    .addStatement("return 0")
                    .endControlFlow()
                    .endControlFlow()
                    .nextControlFlow("catch ($T sqlException)", SQLException.class)
                    .addStatement("sqlException.printStackTrace()")
                    .addStatement("return 0")
                    .endControlFlow();
        } else {
            runSQL.addJavadoc(""
                    + "This method should connect to your database and execute the given query.\n"
                    + "In order for the assertions to work correctly this method must return true in the case\n"
                    + "that the query yields at least one result and false if there is no result.\n\n"
                    + "@param  query    The SQL query to execute\n"
                    + "@param  isUpdate Whether the query is a data modification statement.\n"
                    + "@return Whether the query execution has succeeded.\n")
                    .addComment("TODO: Implement method stub")
                    .addStatement("return 0");
        }

        return runSQL.build();
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
                .addJavadoc("Creates tables required for queries.\n");

        // Create tables code
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(vendorOptions);
        Set<String> tableCreateStrings = new HashSet<>();
        result.getPaths().stream().map(tableCreationBuilder::buildQueries).forEach(tableCreateStrings::addAll);
        for (String s : tableCreateStrings) {
            createTables.addStatement("runSQL($S, true)", s);
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
                .addJavadoc("Truncates the tables.\n");

        // Create tables code
        CleaningBuilder cleaningBuilder = new CleaningBuilder(vendorOptions);
        Set<String> tableCleanStrings = new HashSet<>();
        result.getPaths().stream().map(cleaningBuilder::buildQueries).forEach(tableCleanStrings::addAll);
        for (String s : tableCleanStrings) {
            cleanTables.addStatement("runSQL($S, true)", s);
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
                .addJavadoc("Drops the tables.\n");

        // Create tables code
        DestructionBuilder destructionBuilder = new DestructionBuilder(vendorOptions);
        Set<String> destructionStrings = new HashSet<>();
        result.getPaths().stream().map(destructionBuilder::buildQueries).forEach(destructionStrings::addAll);
        for (String s : destructionStrings) {
            dropTables.addStatement("runSQL($S, true)", s);
        }

        return dropTables.build();
    }

    /**
     * Generates a method specification for a before all test method.
     *
     * @return A method specification for a before all test method.
     */
    private MethodSpec generateBeforeAll() {
        MethodSpec.Builder beforeAll = MethodSpec.methodBuilder("beforeAll")
                .addModifiers(Modifier.STATIC)
                .returns(TypeName.VOID)
                .addAnnotation(beforeAllAnnotation);

        if (testMethodsPublic) {
            beforeAll.addModifiers(Modifier.PUBLIC);
        }

        if (jUnitGeneratorSettings.isCreateTablesBeforeRunning()) {
            beforeAll.addStatement("createTables()");
        }
        return beforeAll.build();
    }

    /**
     * Generates a method specification for a before each test method.
     *
     * @return A method specification for a before each test method.
     */
    private MethodSpec generateBeforeEach() {
        MethodSpec.Builder beforeEach = MethodSpec.methodBuilder("beforeEach")
                .returns(TypeName.VOID)
                .addAnnotation(beforeEachAnnotation);

        if (testMethodsPublic) {
            beforeEach.addModifiers(Modifier.PUBLIC);
        }

        if (jUnitGeneratorSettings.isCleanTablesBeforeEachRun()) {
            beforeEach.addStatement("cleanTables()");
        }
        return beforeEach.build();
    }

    /**
     * Generates a method specification for an after each test method.
     *
     * @return A method specification for an after each test method.
     */
    private MethodSpec generateAfterEach() {
        MethodSpec.Builder afterEach = MethodSpec.methodBuilder("afterEach")
                .returns(TypeName.VOID)
                .addAnnotation(afterEachAnnotation);

        if (testMethodsPublic) {
            afterEach.addModifiers(Modifier.PUBLIC);
        }

        if (jUnitGeneratorSettings.isCleanTableAfterEachRun()) {
            afterEach.addStatement("cleanTables()");
        }
        return afterEach.build();
    }

    /**
     * Generates a method specification for an after all test method.
     *
     * @return A method specification for an after all test method.
     */
    private MethodSpec generateAfterAll() {
        MethodSpec.Builder afterAll = MethodSpec.methodBuilder("afterAll")
                .addModifiers(Modifier.STATIC)
                .returns(TypeName.VOID)
                .addAnnotation(afterAllAnnotation);

        if (testMethodsPublic) {
            afterAll.addModifiers(Modifier.PUBLIC);
        }

        if (jUnitGeneratorSettings.isDropTablesAfterRunning()) {
            afterAll.addStatement("dropTables()");
        }
        return afterAll.build();
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
    private MethodSpec generatePathTest(Path path, VendorOptions vendorOptions, int expected) {
        // Method signature
        MethodSpec.Builder pTestBuilder = MethodSpec.methodBuilder(
                String.format("generatedTest%d", path.getPathNumber()));
        pTestBuilder.addModifiers(Modifier.PUBLIC)
                .returns(TypeName.VOID)
                .addAnnotation(testAnnotation);

        // Arrange part
        pTestBuilder.addComment("Arrange: set up the fixture data");
        InsertionBuilder insertionBuilder = new InsertionBuilder(vendorOptions);
        for (String s : insertionBuilder.buildQueries(path)) {
            pTestBuilder.addStatement("runSQL($S, true)", s);
        }

        // Act
        pTestBuilder.addComment("Act: run a selection query on the database");
        pTestBuilder.addStatement("$T result = runSQL($L, false)", int.class, NAME_PRODUCTION_QUERY);

        // Assert
        pTestBuilder.addComment("Assert: verify that the expected amount of rows are returned");
        pTestBuilder.addStatement("$T.assertEquals($L, result)", assertionClass, expected);
        return pTestBuilder.build();
    }
}

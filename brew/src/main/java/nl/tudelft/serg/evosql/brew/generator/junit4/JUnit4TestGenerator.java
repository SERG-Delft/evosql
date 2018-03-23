package nl.tudelft.serg.evosql.brew.generator.junit4;

import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.TypeName;
import com.squareup.javapoet.TypeSpec;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.generator.TestGeneratorSettings;
import nl.tudelft.serg.evosql.brew.sql.*;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;
import org.junit.*;

import javax.lang.model.element.Modifier;
import java.util.HashSet;
import java.util.Set;

public class JUnit4TestGenerator implements Generator {

    private final TestGeneratorSettings testGeneratorSettings;

    /**
     * Initializes a new instance of the JUnit4TestGenerator class.
     *
     * @param testGeneratorSettings The settings used for this generator.
     */
    public JUnit4TestGenerator(TestGeneratorSettings testGeneratorSettings) {
        this.testGeneratorSettings = testGeneratorSettings;
    }

    @Override
    public String generate(Result result, VendorOptions vendorOptions) {
        TypeSpec.Builder typeSpecBuilder = TypeSpec.classBuilder("EvoSQLQueryTest");

        typeSpecBuilder.addMethod(generateRunSQL());
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

        JavaFile javaFile = JavaFile.builder(testGeneratorSettings.getFilePackage(), typeSpecBuilder.build()).build();
        return javaFile.toString();
    }

    /**
     * Generates a method specification for the runSQL method.
     *
     * @return method.
     */
    private MethodSpec generateRunSQL() {
        return MethodSpec.methodBuilder("runSQL")
                .addModifiers(Modifier.PRIVATE)
                .returns(TypeName.BOOLEAN)
                .addParameter(String.class, "query")
                .addJavadoc(""
                        + "This method should connect to your database and execute the given query.\n"
                        + "In order for the assertions to work this method must return true in the case \n"
                        + "that the query yields at least one result and false if there is no result.\n\n"
                        + "@param  query sql query to execute\n"
                        + "@return result of query.\n")
                .addComment("TODO: Implement method stub")
                .addStatement("return false")
                .build();
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
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addJavadoc("Creates tables required for queries.\n");

        // Create tables code
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(vendorOptions);
        Set<String> tableCreateStrings = new HashSet<>();
        result.getPaths().stream().map(tableCreationBuilder::buildQueries).forEach(tableCreateStrings::addAll);
        for (String s : tableCreateStrings) {
            createTables.addStatement("runSQL($S)", s);
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
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addJavadoc("Truncates the tables.\n");

        // Create tables code
        CleaningBuilder cleaningBuilder = new CleaningBuilder(vendorOptions);
        Set<String> tableCleanStrings = new HashSet<>();
        result.getPaths().stream().map(cleaningBuilder::buildQueries).forEach(tableCleanStrings::addAll);
        for (String s : tableCleanStrings) {
            cleanTables.addStatement("runSQL($S)", s);
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
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addJavadoc("Drops the tables.\n");

        // Create tables code
        DestructionBuilder destructionBuilder = new DestructionBuilder(vendorOptions);
        Set<String> destructionStrings = new HashSet<>();
        result.getPaths().stream().map(destructionBuilder::buildQueries).forEach(destructionStrings::addAll);
        for (String s : destructionStrings) {
            dropTables.addStatement("runSQL($S)", s);
        }

        return dropTables.build();
    }


    /**
     * Generates a method specification for a before all test method.
     * @return A method specification for a before all test method.
     */
    private MethodSpec generateBeforeAll() {
        MethodSpec.Builder beforeAll = MethodSpec.methodBuilder("beforeAll")
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addAnnotation(BeforeClass.class);

        if (testGeneratorSettings.isCreateTablesBeforeRunning()) {
            beforeAll.addStatement("createTables()");
        }
        return beforeAll.build();
    }

    /**
     * Generates a method specification for a before each test method.
     * @return A method specification for a before each test method.
     */
    private MethodSpec generateBeforeEach() {
        MethodSpec.Builder beforeEach = MethodSpec.methodBuilder("beforeEach")
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addAnnotation(Before.class);

        if (testGeneratorSettings.isCleanTablesBeforeEachRun()) {
            beforeEach.addStatement("cleanTables()");
        }
        return beforeEach.build();
    }

    /**
     * Generates a method specification for an after each test method.
     * @return A method specification for an after each test method.
     */
    private MethodSpec generateAfterEach() {
        MethodSpec.Builder beforeEach = MethodSpec.methodBuilder("afterEach")
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addAnnotation(After.class);

        if (testGeneratorSettings.isCreateTablesBeforeRunning()) {
            beforeEach.addStatement("cleanTables()");
        }
        return beforeEach.build();
    }

    /**
     * Generates a method specification for an after all test method.
     * @return A method specification for an after all test method.
     */
    private MethodSpec generateAfterAll() {
        MethodSpec.Builder beforeEach = MethodSpec.methodBuilder("afterAll")
                .returns(TypeName.VOID)
                .addModifiers(Modifier.STATIC)
                .addAnnotation(AfterClass.class);

        if (testGeneratorSettings.isDropTablesAfterRunning()) {
            beforeEach.addStatement("dropTables()");
        }
        return beforeEach.build();
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
                String.format("generatedTest%d", path.getPathNumber()));
        pTestBuilder.returns(TypeName.VOID);
        pTestBuilder.addAnnotation(Test.class);

        // Arrange part
        pTestBuilder.addComment("Arrange: set up the fixture data");
        InsertionBuilder insertionBuilder = new InsertionBuilder(vendorOptions);
        for (String s : insertionBuilder.buildQueries(path)) {
            pTestBuilder.addStatement("runSQL($S)", s);
        }

        // Act
        pTestBuilder.addComment("Act: run a selection query on the database");
        SelectionBuilder selectionBuilder = new SelectionBuilder(vendorOptions);
        String select = selectionBuilder.buildQueries(path).get(0);
        pTestBuilder.addStatement("$T result = runSQL($S)", boolean.class, select);

        // Assert
        pTestBuilder.addComment("Assert: verify that at least one resulting row was returned");
        pTestBuilder.addStatement("$T.assertTrue(result)", Assert.class);
        return pTestBuilder.build();
    }
}

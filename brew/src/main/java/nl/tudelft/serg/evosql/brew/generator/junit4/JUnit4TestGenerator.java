package nl.tudelft.serg.evosql.brew.generator.junit4;

import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.TypeName;
import com.squareup.javapoet.TypeSpec;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.sql.*;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;
import org.junit.*;

import javax.lang.model.element.Modifier;
import java.util.HashSet;
import java.util.Set;

public class JUnit4TestGenerator implements Generator {
    /**
     * Parameters for generating certain methods.
     * These can probably be moved to a 'Settings' class.
     */
    static final boolean GENERATE_BEFORE_ALL = true;
    static final boolean GENERATE_BEFORE_EACH = true;
    static final boolean GENERATE_AFTER_ALL = true;
    static final boolean GENERATE_AFTER_EACH = true;


    @Override
    public String generate(Result result, VendorOptions vendorOptions) {
        TypeSpec.Builder typeSpecBuilder = TypeSpec.classBuilder("EvoSQLQueryTest");
        if (GENERATE_BEFORE_ALL) {
            typeSpecBuilder.addMethod(generateBeforeAll(result, vendorOptions));
        }
        if (GENERATE_BEFORE_EACH) {
            typeSpecBuilder.addMethod(generateBeforeEach(result, vendorOptions));
        }
        if (GENERATE_AFTER_ALL) {
            typeSpecBuilder.addMethod(generateAfterAll(result, vendorOptions));
        }
        if (GENERATE_AFTER_EACH) {
            typeSpecBuilder.addMethod(generateAfterEach(result, vendorOptions));
        }
        typeSpecBuilder.addMethod(generateRunSQLTest());
        for (int i = 0; i < result.getPaths().size(); i++) {
            typeSpecBuilder.addMethod(generatePathTest(result.getPaths().get(i), "queryTest" + i, vendorOptions));
        }

        JavaFile javaFile = JavaFile.builder(getClass().getPackage().getName(), typeSpecBuilder.build()).build();
        return javaFile.toString();
    }


    /**
     * Generates a unit test for a path in the test data.
     * General pseudocode:
     * <p>
     * - Arrange: insert data into database.
     * - Act: Execute select statement on database.
     * - Assert: Assert that a result is given back from the database.
     * <p>
     * In order to execute sql queries, this method will reference the
     * generated runSQL method.
     *
     * @param path
     * @return
     */
    private MethodSpec generatePathTest(Path path, String name, VendorOptions vendorOptions) {

        //Setup method structure
        MethodSpec.Builder pTestBuilder = MethodSpec.methodBuilder(name);
        pTestBuilder.addModifiers(Modifier.PUBLIC);
        pTestBuilder.returns(TypeName.VOID);
        pTestBuilder.addAnnotation(Test.class);

        // Arrange part
        InsertionBuilder insertionBuilder = new InsertionBuilder(vendorOptions);
        for (String s : insertionBuilder.buildQueries(path)) {
            pTestBuilder.addCode("runSQL($S);\n", s);
        }
        SelectionBuilder selectionBuilder = new SelectionBuilder(vendorOptions);

        // Act with Assert part
        String select = selectionBuilder.buildQueries(path).get(0);
        pTestBuilder.addStatement("$T.assertTrue(runSQL($S))", Assert.class, select);
        return pTestBuilder.build();
    }


    /**
     * Generate beforeAll method which creates the required tables for the queries.
     *
     * @param result        result containing data
     * @param vendorOptions VendorOptions for the database
     * @return before all method.
     */
    private MethodSpec generateBeforeAll(Result result, VendorOptions vendorOptions) {
        // Setup method structure
        MethodSpec.Builder beforeAllBuilder = MethodSpec.methodBuilder("beforeAll");
        beforeAllBuilder.addAnnotation(BeforeClass.class);
        beforeAllBuilder.returns(TypeName.VOID);
        beforeAllBuilder.addModifiers(Modifier.PUBLIC);

        // Create tables code
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(vendorOptions);
        Set<String> tableCreateStrings = new HashSet<>();
        result.getPaths().stream().forEach(x -> tableCreateStrings.addAll(tableCreationBuilder.buildQueries(x)));
        for (String s : tableCreateStrings) {
            beforeAllBuilder.addStatement("runSQL($S)", s);
        }

        return beforeAllBuilder.build();
    }


    /**
     * Generate beforeEach method which truncates the required tables for the queries.
     *
     * @param result        result containing data
     * @param vendorOptions VendorOptions for the database
     * @return before each method.
     */
    private MethodSpec generateBeforeEach(Result result, VendorOptions vendorOptions) {
        // Setup method structure
        MethodSpec.Builder beforeEachBuilder = MethodSpec.methodBuilder("beforeEach");
        beforeEachBuilder.addAnnotation(Before.class);
        beforeEachBuilder.returns(TypeName.VOID);
        beforeEachBuilder.addModifiers(Modifier.PUBLIC);

        // Create tables code
        CleaningBuilder cleaningBuilder = new CleaningBuilder(vendorOptions);
        Set<String> tableCleanStrings = new HashSet<>();
        result.getPaths().stream().forEach(x -> tableCleanStrings.addAll(cleaningBuilder.buildQueries(x)));
        for (String s : tableCleanStrings) {
            beforeEachBuilder.addStatement("runSQL($S)", s);
        }

        return beforeEachBuilder.build();
    }

    /**
     * Generate afterEach method which truncates the required tables for the queries.
     *
     * @param result        result containing data
     * @param vendorOptions VendorOptions for the database
     * @return after each method.
     */
    private MethodSpec generateAfterEach(Result result, VendorOptions vendorOptions) {
        // Setup method structure
        MethodSpec.Builder beforeEachBuilder = MethodSpec.methodBuilder("afterEach");
        beforeEachBuilder.addAnnotation(After.class);
        beforeEachBuilder.returns(TypeName.VOID);
        beforeEachBuilder.addModifiers(Modifier.PUBLIC);

        // Create tables code
        CleaningBuilder cleaningBuilder = new CleaningBuilder(vendorOptions);
        Set<String> tableCleanStrings = new HashSet<>();
        result.getPaths().stream().forEach(x -> tableCleanStrings.addAll(cleaningBuilder.buildQueries(x)));
        for (String s : tableCleanStrings) {
            beforeEachBuilder.addStatement("runSQL($S)", s);
        }

        return beforeEachBuilder.build();
    }

    /**
     * Generate afterAll method which drops the required tables for the queries.
     *
     * @param result        result containing data
     * @param vendorOptions VendorOptions for the database
     * @return after all method.
     */
    private MethodSpec generateAfterAll(Result result, VendorOptions vendorOptions) {
        // Setup method structure
        MethodSpec.Builder afterAllBuilder = MethodSpec.methodBuilder("afterAll");
        afterAllBuilder.addAnnotation(AfterClass.class);
        afterAllBuilder.returns(TypeName.VOID);
        afterAllBuilder.addModifiers(Modifier.PUBLIC);

        // Create tables code
        DestructionBuilder destructionBuilder = new DestructionBuilder(vendorOptions);
        Set<String> destructionStrings = new HashSet<>();
        result.getPaths().stream().forEach(x -> destructionStrings.addAll(destructionBuilder.buildQueries(x)));
        for (String s : destructionStrings) {
            afterAllBuilder.addStatement("runSQL($S)", s);
        }

        return afterAllBuilder.build();
    }

    /**
     * Generate the empty method runSQL.
     *
     * @return method.
     */
    private MethodSpec generateRunSQLTest() {
        return MethodSpec.methodBuilder("runSQL")
                .addModifiers(Modifier.PRIVATE)
                .addJavadoc(""
                        + "This method should connect to your database and execute the given query.\n"
                        + "In order for the assertions to work this method must return true in the case \n"
                        + "that the query yields at least one result and false if there is not result.\n\n"
                        + "@param  query sql query to execute\n"
                        + "@return result of query.\n")
                .returns(TypeName.BOOLEAN)
                .addParameter(String.class, "query")
                .addComment("TODO: Implement method stub.")
                .addStatement("return false")
                .build();
    }
}

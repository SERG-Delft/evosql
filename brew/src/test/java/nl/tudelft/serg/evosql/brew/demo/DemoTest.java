package nl.tudelft.serg.evosql.brew.demo;

import java.lang.String;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.annotation.Generated;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

@Generated("nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator")
public class DemoTest {
    /**
     * The JDBC url used to connect to the test database.
     */
    private static final String DB_JDBC_URL = "jdbc:postgresql://localhost:5432/evosql_brew_test";

    /**
     * The username used to connect to the test database.
     */
    private static final String DB_USER = "postgres";

    /**
     * The password used to connect to the test database.
     */
    private static final String DB_PASSWORD = "";

    /**
     * Executes an SQL query on the database.
     *
     * @param  query    The SQL query to execute
     * @param  isUpdate Whether the query is a data modification statement.
     * @return Whether the query execution has succeeded.
     */
    private static boolean runSQL(String sql, boolean isUpdate) {
        try {
            Connection connection = DriverManager.getConnection(DB_JDBC_URL, DB_USER, DB_PASSWORD);
            Statement statement = connection.createStatement();
            if (isUpdate == true) {
                statement.executeUpdate(sql);
                return true;
            } else {
                ResultSet resultSet = statement.executeQuery(sql);
                return resultSet.next();
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
            return false;
        }
    }

    /**
     * Creates tables required for queries.
     */
    private static void createTables() {
        runSQL("CREATE TABLE \"PRODUCTS\" (\"ID\" INTEGER, \"PRODUCT\" VARCHAR(500), \"PRICE\" REAL);", true);
        runSQL("CREATE TABLE \"PRODUCT_DETAIL\" (\"ID\" INTEGER, \"NAME\" VARCHAR(500), \"TYPE\" INTEGER);", true);
    }

    /**
     * Truncates the tables.
     */
    private static void cleanTables() {
        runSQL("TRUNCATE TABLE \"PRODUCT_DETAIL\";", true);
        runSQL("TRUNCATE TABLE \"PRODUCTS\";", true);
    }

    /**
     * Drops the tables.
     */
    private static void dropTables() {
        runSQL("DROP TABLE \"PRODUCTS\";", true);
        runSQL("DROP TABLE \"PRODUCT_DETAIL\";", true);
    }

    @BeforeAll
    static void beforeAll() {
        createTables();
    }

    @BeforeEach
    void beforeEach() {
        cleanTables();
    }

    @AfterEach
    void afterEach() {
    }

    @AfterAll
    static void afterAll() {
        dropTables();
    }

    @Test
    public void generatedTest1() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (10, 'L|H@Q1]r(T,o\"zrLIg9O$,''g],*;mSoKS-<', 14);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (-591, 'L|H@Q1]r(T,o\"zrLIg9O$,''g],*;mSoKS-<', 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE (\"T\".\"PRICE\" < (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\")) AND (\"T\".\"PRICE\" > (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\") - 10)", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest2() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (NULL, 'i%\\?`zD2TuTaPayH1]amh=>I~BNk3hTXVNP;}7F)^', 10);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (10, 'i%\\?`zD2TuTaPayH1]amh=>I~BNk3hTXVNP;}7F)^', 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE NOT (\"T\".\"PRICE\" < (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\")) AND (\"T\".\"PRICE\" > (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\") - 10)", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest3() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (NULL, 'i%\\?`zD2TuTaPayH1]amh=>I~BNk3hTXVNP;}7F)^', 10);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (-579, 'i%\\?`zD2TuTaPayH1]amh=>I~BNk3hTXVNP;}7F)^', 1);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE (\"T\".\"PRICE\" = (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\") - 10 + 1) AND (\"T\".\"PRICE\" < (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\"))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest4() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (114, '\"#8b{TKn~0kN!h?Gu#z;$_:I', 20);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (10, '\"#8b{TKn~0kN!h?Gu#z;$_:I', 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE (\"T\".\"PRICE\" = (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\") - 10) AND (\"T\".\"PRICE\" < (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\"))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest5() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (-22, 'aaAl6J\\|c S#24+C(O/x\\i:-$mGuJtYi)G>Ar_6', 12);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (-748, 'aaAl6J\\|c S#24+C(O/x\\i:-$mGuJtYi)G>Ar_6', 1);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE (\"T\".\"PRICE\" = (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\") - 10 - 1) AND (\"T\".\"PRICE\" < (SELECT MAX(\"TYPE\") FROM \"PRODUCT_DETAIL\" \"T2\" WHERE \"T\".\"PRODUCT\" = \"T2\".\"NAME\"))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest6() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (10, '*>j&lqsZZsI|RNUPMZXj@rMytzo,S.!Sf{S', 10);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (453, 'KW\\D4>SrtUArD=H-N)lD;3s', 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE EXISTS (SELECT * FROM \"PRODUCT_DETAIL\" \"T2\" WHERE NOT (\"T\".\"PRODUCT\" = \"T2\".\"NAME\"))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest7() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (10, '*>j&lqsZZsI|RNUPMZXj@rMytzo,S.!Sf{S', 10);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (10, '*>j&lqsZZsI|RNUPMZXj@rMytzo,S.!Sf{S', 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE EXISTS (SELECT * FROM \"PRODUCT_DETAIL\" \"T2\" WHERE (\"T\".\"PRODUCT\" = \"T2\".\"NAME\"))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest8() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (1, '5P''cRD{d`]c,uYTEy5;Z$]u8EN#;5Y+TnNH\"', 876);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (-973, NULL, 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE EXISTS (SELECT * FROM \"PRODUCT_DETAIL\" \"T2\" WHERE (\"T\".\"PRODUCT\" IS NULL))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }

    @Test
    public void generatedTest9() {
        // Arrange: set up the fixture data
        runSQL("INSERT INTO \"PRODUCT_DETAIL\" (\"ID\", \"NAME\", \"TYPE\") VALUES (10, NULL, NULL);", true);
        runSQL("INSERT INTO \"PRODUCTS\" (\"ID\", \"PRODUCT\", \"PRICE\") VALUES (453, 'KW\\D4>SrtUArD=H-N)lD;3s', 10);", true);
        // Act: run a selection query on the database
        boolean result = runSQL("SELECT * FROM \"PRODUCTS\" \"T\" WHERE EXISTS (SELECT * FROM \"PRODUCT_DETAIL\" \"T2\" WHERE (\"T2\".\"NAME\" IS NULL))", false);
        // Assert: verify that at least one resulting row was returned
        Assertions.assertTrue(result);
    }
}

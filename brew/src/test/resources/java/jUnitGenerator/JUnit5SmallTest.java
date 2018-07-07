package brew.test.generated;

import java.lang.String;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Generated;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

@Generated("nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator")
public class JUnit5SmallTest {
  /**
   * The production query used to test the generated fixtures on.
   */
  private static final String PRODUCTION_QUERY = "Select * From table1 Where column1_2 < 1;";

  /**
   * The JDBC url used to connect to the test database.
   */
  private static final String DB_JDBC_URL = "jdbc:mysql://localhost:3306/evosql_brew_test";

  /**
   * The username used to connect to the test database.
   */
  private static final String DB_USER = "root";

  /**
   * The password used to connect to the test database.
   */
  private static final String DB_PASSWORD = "";

  /**
   * Executes an SQL query on the database.
   *
   * @param query    The query to execute.
   * @param isUpdate Whether the query is a data modification statement.
   *
   * @returns The resulting table, or null if the query is an update.
   */
  private static ArrayList<HashMap<String, String>> runSql(String query, boolean isUpdate) throws
      SQLException {
    Connection connection = DriverManager.getConnection(DB_JDBC_URL, DB_USER, DB_PASSWORD);
    Statement statement = connection.createStatement();
    if (isUpdate == true) {
      statement.executeUpdate(query);
      return null;
    } else {
      ArrayList<HashMap<String, String>> tableStructure = new ArrayList<HashMap<String, String>>();
      ResultSet resultSet = statement.executeQuery(query);
      List<String> columns = getResultColumns(resultSet);
      while (resultSet.next()) {
        HashMap<String, String> values = new HashMap<>();
        for (String column : columns) {
          values.put(column, resultSet.getObject(column).toString());
        }
        tableStructure.add(values);
      }
      return tableStructure;
    }
  }

  /**
   * Gets the columns of a statement result set.
   */
  private static List<String> getResultColumns(ResultSet result) throws SQLException {
    ResultSetMetaData meta = result.getMetaData();
    List<String> columns = new ArrayList<>();
    // Start at one; this is 1-indexed
    for (int i = 1; i <= meta.getColumnCount(); ++i) {
      columns.add(meta.getColumnName(i));
    }
    return columns;
  }

  /**
   * Generates a string map from a list of strings.
   */
  private static Map<String, String> makeMap(String... strings) {
    Map<String, String> result = new HashMap<>();
    for(int i = 0; i < strings.length; i += 2) {
      result.put(strings[i], strings[i + 1]);
    }
    return result;
  }

  /**
   * Creates tables required for queries.
   */
  private static void createTables() throws SQLException {
    runSql("CREATE TABLE `table1` (`column1_1` INTEGER, `column1_2` DOUBLE, `column1_3` VARCHAR(100));", true);
  }

  /**
   * Truncates the tables.
   */
  private static void cleanTables() throws SQLException {
    runSql("TRUNCATE TABLE `table1`;", true);
  }

  /**
   * Drops the tables.
   */
  private static void dropTables() throws SQLException {
    runSql("DROP TABLE `table1`;", true);
  }

  @BeforeAll
  static void beforeAll() throws SQLException {
    createTables();
  }

  @BeforeEach
  void beforeEach() throws SQLException {
    cleanTables();
  }

  @AfterEach
  void afterEach() throws SQLException {
  }

  @AfterAll
  static void afterAll() throws SQLException {
  }

  @Test
  public void generatedTest1() throws SQLException {
    // Arrange: set up the fixture data
    runSql("INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');", true);
    // Act: run a selection query on the database
    ArrayList<HashMap<String, String>> result = runSql(PRODUCTION_QUERY, false);
    // Assert: verify that the expected number of rows is returned
    Assertions.assertEquals(1, result.size());
  }

  @Test
  public void generatedTest2() throws SQLException {
    // Arrange: set up the fixture data
    runSql("INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');", true);
    // Act: run a selection query on the database
    ArrayList<HashMap<String, String>> result = runSql(PRODUCTION_QUERY, false);
    // Assert: verify that the expected number of rows is returned
    Assertions.assertEquals(1, result.size());
  }
}

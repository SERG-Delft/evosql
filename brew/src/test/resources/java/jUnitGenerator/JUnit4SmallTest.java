package brew.test.generated;

import java.lang.String;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

@Generated("nl.tudelft.serg.evosql.brew.generator.junit.JUnit4TestGenerator")
public class JUnit4SmallTest {
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
   * @param  query    The SQL query to execute
   * @param  isUpdate Whether the query is a data modification statement.
   * @return Whether the query execution has succeeded.
   */
  private static int runSQL(String sql, boolean isUpdate) {
    try {
      Connection connection = DriverManager.getConnection(DB_JDBC_URL, DB_USER, DB_PASSWORD);
      Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      if (isUpdate == true) {
        return statement.executeUpdate(sql);
      } else {
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet.last()) {
          return resultSet.getRow();
        } else {
          return 0;
        }
      }
    } catch (SQLException sqlException) {
      sqlException.printStackTrace();
      return -1;
    }
  }

  /**
   * Creates tables required for queries.
   */
  private static void createTables() {
    runSQL("CREATE TABLE `table1` (`column1_1` INTEGER, `column1_2` DOUBLE, `column1_3` VARCHAR(100));", true);
  }

  /**
   * Truncates the tables.
   */
  private static void cleanTables() {
    runSQL("TRUNCATE TABLE `table1`;", true);
  }

  /**
   * Drops the tables.
   */
  private static void dropTables() {
    runSQL("DROP TABLE `table1`;", true);
  }

  @BeforeClass
  public static void beforeAll() {
    createTables();
  }

  @Before
  public void beforeEach() {
    cleanTables();
  }

  @After
  public void afterEach() {
  }

  @AfterClass
  public static void afterAll() {
  }

  @Test
  public void generatedTest1() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');", true);
    // Act: run a selection query on the database
    int result = runSQL(PRODUCTION_QUERY, false);
    // Assert: verify that the expected number of rows is returned
    Assert.assertEquals(1, result);
  }

  @Test
  public void generatedTest2() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');", true);
    // Act: run a selection query on the database
    int result = runSQL(PRODUCTION_QUERY, false);
    // Assert: verify that the expected number of rows is returned
    Assert.assertEquals(1, result);
  }

  /**
   * Generates a string map from a list of strings.
   */
  private Map<String, String> makeMap(String... strings) {
    Map<String, String> result = new HashMap<>();
    for(int i = 0; i < strings.length; i += 2) {
      result.put(strings[i], strings[i + 1]);
    }
    return result;
  }
}

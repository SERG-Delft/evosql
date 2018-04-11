package brew.test.generated;

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
public class JUnit5SmallTest {
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
  }

  @Test
  public void generatedTest1() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');", true);
    // Act: run a selection query on the database
    boolean result = runSQL("Select * From table1 Where column1_2 < 1;", false);
    // Assert: verify that at least one resulting row was returned
    Assertions.assertEquals(true, result);
  }

  @Test
  public void generatedTest2() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');", true);
    // Act: run a selection query on the database
    boolean result = runSQL("Select * From table1 Where column1_2 < 1;", false);
    // Assert: verify that at least one resulting row was returned
    Assertions.assertEquals(false, result);
  }
}

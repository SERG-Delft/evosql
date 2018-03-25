package brew.test.generated;

import java.lang.String;
import javax.annotation.Generated;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

@Generated("nl.tudelft.serg.evosql.brew.generator.junit.JUnit4TestGenerator")
public class JUnit4MediumTest {
  /**
   * This method should connect to your database and execute the given query.
   * In order for the assertions to work correctly this method must return true in the case
   * that the query yields at least one result and false if there is no result.
   *
   * @param  query    The SQL query to execute
   * @param  isUpdate Whether the query is a data modification statement.
   * @return Whether the query execution has succeeded.
   */
  private static boolean runSQL(String sql, boolean isUpdate) {
    // TODO: Implement method stub
    return false;
  }

  /**
   * Creates tables required for queries.
   */
  private static void createTables() {
    runSQL("CREATE TABLE `products` (`product_name` VARCHAR(100), `expired` BIT, `expiry_date` DATETIME);", true);
    runSQL("CREATE TABLE `table1` (`column1_1` INTEGER, `column1_2` VARCHAR(100));", true);
  }

  /**
   * Truncates the tables.
   */
  private static void cleanTables() {
    runSQL("TRUNCATE TABLE `products`;", true);
    runSQL("TRUNCATE TABLE `table1`;", true);
  }

  /**
   * Drops the tables.
   */
  private static void dropTables() {
    runSQL("DROP TABLE `products`;", true);
    runSQL("DROP TABLE `table1`;", true);
  }

  @BeforeClass
  public static void beforeAll() {
  }

  @Before
  public void beforeEach() {
  }

  @After
  public void afterEach() {
    cleanTables();
  }

  @AfterClass
  public static void afterAll() {
    dropTables();
  }

  @Test
  public void generatedTest1() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`) VALUES (1, 'String of row 1'), (2, 'String of row 2');", true);
    runSQL("INSERT INTO `products` (`product_name`, `expired`, `expiry_date`) VALUES ('Milk', 0, '2018-03-22 00:00:00'), ('Yogurt', 1, '2018-03-15 00:00:00'), ('Salt', 0, '2025-12-31 23:59:59');", true);
    // Act: run a selection query on the database
    boolean result = runSQL("Select * From table1, products Where column1_2 < 1 And expired = 0;", false);
    // Assert: verify that at least one resulting row was returned
    Assert.assertTrue(result);
  }

  @Test
  public void generatedTest2() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`) VALUES (1, 'String of row 1'), (2, 'String of row 2');", true);
    runSQL("INSERT INTO `products` (`product_name`, `expired`, `expiry_date`) VALUES ('Milk', 0, '2018-03-22 00:00:00'), ('Yogurt', 1, '2018-03-15 00:00:00'), ('Salt', 0, '2025-12-31 23:59:59');", true);
    // Act: run a selection query on the database
    boolean result = runSQL("Select * From table1, products Where column1_2 < 1 And expired = 1;", false);
    // Assert: verify that at least one resulting row was returned
    Assert.assertTrue(result);
  }

  @Test
  public void generatedTest3() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`) VALUES (1, 'String of row 1'), (2, 'String of row 2');", true);
    runSQL("INSERT INTO `products` (`product_name`, `expired`, `expiry_date`) VALUES ('Milk', 0, '2018-03-22 00:00:00'), ('Yogurt', 1, '2018-03-15 00:00:00'), ('Salt', 0, '2025-12-31 23:59:59');", true);
    // Act: run a selection query on the database
    boolean result = runSQL("Select * From table1, products Where column1_2 >= 1 And Expired = 0;", false);
    // Assert: verify that at least one resulting row was returned
    Assert.assertTrue(result);
  }

  @Test
  public void generatedTest4() {
    // Arrange: set up the fixture data
    runSQL("INSERT INTO `table1` (`column1_1`, `column1_2`) VALUES (1, 'String of row 1'), (2, 'String of row 2');", true);
    runSQL("INSERT INTO `products` (`product_name`, `expired`, `expiry_date`) VALUES ('Milk', 0, '2018-03-22 00:00:00'), ('Yogurt', 1, '2018-03-15 00:00:00'), ('Salt', 0, '2025-12-31 23:59:59');", true);
    // Act: run a selection query on the database
    boolean result = runSQL("Select * From table1, products Where column1_2 >= 1 And Expired = 1;", false);
    // Assert: verify that at least one resulting row was returned
    Assert.assertTrue(result);
  }
}

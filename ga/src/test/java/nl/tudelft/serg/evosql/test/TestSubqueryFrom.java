package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * FROM subquery tests, note that GROUP BY's are necessary as otherwise the HSQLDB parser will optimise by combining the queries.
 *
 */
public class TestSubqueryFrom extends TestBase {

	/**
	 * Simple subquery no WHERE
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products GROUP BY Product, Price) t"));
	}
	
	/**
	 * WHERE in subquery
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products WHERE Product = 'A' GROUP BY Product, Price) t"));
	}
	
	/**
	 * WHERE in outer query
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products GROUP BY Product, Price) t WHERE Price > 5 AND Price < 20"));
	}
	
	/**
	 * WHEREs in sub and outer query
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products WHERE Product = 'A' GROUP BY Product, Price) t WHERE Price > 5 AND Price < 20"));
	}
	
	/**
	 * 2 nested subqueries in FROM with 3 WHERE's
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT * FROM (SELECT Product, Price FROM products WHERE Product = 'A' GROUP BY Product, Price) t WHERE Price > 5 GROUP BY Product, Price) t WHERE Price < 20"));
	}
	
	/**
	 * Subquery inner having
	 */
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products GROUP BY Product, Price HAVING SUM(Price) > 4) t WHERE Product = 'A'"));
	}
	
	/**
	 * Subquery outer having
	 */
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT Product FROM (SELECT Product, Price FROM products GROUP BY Product, Price) t GROUP BY Product HAVING SUM(Price) > 4"));
	}
	
	/**
	 * Subquery inner & outer having
	 */
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT Product FROM (SELECT Product, Price FROM products GROUP BY Product, Price HAVING SUM(Price) < 10) t GROUP BY Product HAVING SUM(Price) > 4"));
	}
}

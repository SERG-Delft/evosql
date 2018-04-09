package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * FROM subquery tests, note that GROUP BY's are necessary as otherwise the HSQLDB parser will optimise by combining the queries.
 *
 */
public class SubqueryFromTest extends TestBase {

	/**
	 * Simple subquery no WHERE
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS GROUP BY PRODUCT, PRICE) T"));
	}
	
	/**
	 * WHERE in subquery
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT = 'A' GROUP BY PRODUCT, PRICE) T"));
	}
	
	/**
	 * WHERE in outer query
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS GROUP BY PRODUCT, PRICE) T WHERE PRICE > 5 AND PRICE < 20"));
	}
	
	/**
	 * WHEREs in sub and outer query
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT = 'A' GROUP BY PRODUCT, PRICE) T WHERE PRICE > 5 AND PRICE < 20"));
	}
	
	/**
	 * 2 nested subqueries in FROM with 3 WHERE's
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT = 'A' GROUP BY PRODUCT, PRICE) T WHERE PRICE > 5 GROUP BY PRODUCT, PRICE) T WHERE PRICE < 20"));
	}
	
	/**
	 * Subquery inner having
	 */
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS GROUP BY PRODUCT, PRICE HAVING SUM(PRICE) > 4) T WHERE PRODUCT = 'A'"));
	}
	
	/**
	 * Subquery outer having
	 */
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM (SELECT PRODUCT, PRICE FROM PRODUCTS GROUP BY PRODUCT, PRICE) T GROUP BY PRODUCT HAVING SUM(PRICE) > 4"));
	}
	
	/**
	 * Subquery inner & outer having
	 */
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM (SELECT PRODUCT, PRICE FROM PRODUCTS GROUP BY PRODUCT, PRICE HAVING SUM(PRICE) < 10) T GROUP BY PRODUCT HAVING SUM(PRICE) > 4"));
	}
}

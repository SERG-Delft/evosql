package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class HavingTest extends TestBase {
	/**
	 * Having without WHERE
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT HAVING AVG(PRICE) > 5 AND AVG(PRICE) < 10"));
	}
	
	/**
	 * Having with where
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS WHERE LENGTH(PRODUCT) = 5 GROUP BY PRODUCT HAVING AVG(PRICE) > 0 AND AVG(PRICE) < 10"));
	}
	
	/**
	 * Having without aggregate
	 */
	@Test
	public void testHavingExists() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T GROUP BY PRODUCT HAVING EXISTS (SELECT * FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	/**
	 * Having without aggregate
	 */
	@Test
	public void testHavingExistsAndSome() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T GROUP BY PRODUCT HAVING EXISTS (SELECT * FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME) AND SUM(T.PRICE) > 50"));
	}
}

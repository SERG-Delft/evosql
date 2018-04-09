package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * Tests with subqueries in the SELECT/WHERE's
 *
 */
public class SubquerySelectWhereTest extends TestBase {

	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE LENGTH(T.PRODUCT) = 1 AND T.PRICE = (SELECT MAX(PRICE) FROM PRODUCTS)"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS T WHERE LENGTH(T.PRODUCT) = 1 GROUP BY PRODUCT, PRICE) T WHERE T.PRICE = (SELECT MAX(PRICE) FROM PRODUCTS)"));
	}

	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS T WHERE LENGTH(T.PRODUCT) = 1 GROUP BY PRODUCT, PRICE) T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME)"));
	}

	/**
	 * Subquery in SELECT, which does not affect the query
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT (SELECT MAX(TYPE) FROM PRODUCT_DETAIL WHERE NAME = 'A') SUBINFO, PRODUCT FROM PRODUCTS"));
	}
	
	/**
	 * Subquery in SELECT, which does affect the query
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT (SELECT MAX(TYPE) FROM PRODUCT_DETAIL WHERE NAME = 'A') SUBINFO, PRODUCT FROM PRODUCTS) T WHERE SUBINFO > 10 AND SUBINFO < 20"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	/**
	 * Subquery in the subquery, HSQLDB processes the two expressions at the same time
	 */
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM (SELECT NAME, TYPE FROM PRODUCT_DETAIL WHERE LENGTH(NAME) = 2) T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM (SELECT NAME, TYPE FROM PRODUCT_DETAIL T3 WHERE LENGTH(NAME) < T.ID) T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	@Test
	public void test9() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE LENGTH(T.PRODUCT) = (SELECT MIN(T3.ID) FROM PRODUCTS T3 WHERE T3.ID >= 0))"));
	}
	
	/**
	 * Nested subqueries, takes a long time
	 */
	@Test
	public void test10() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE LENGTH(T.PRODUCT) = (SELECT MIN(T3.ID) FROM PRODUCTS T3 WHERE T3.ID >= 0 AND T3.PRODUCT = T2.NAME))"));
	}
	
	/**
	 * Two of the same subqueries next to eachother
	 */
	@Test
	public void test11() { 
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME) AND T.PRICE > (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME) - 10"));
	}
}

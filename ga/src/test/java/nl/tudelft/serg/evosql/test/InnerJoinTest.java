package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class InnerJoinTest extends TestBase {
	/**
	 * Inner join test, succeeds when both tables share an ID
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID"));
	}
	
	/**
	 * Inner join test, succeeds when both tables share an ID
	 */
	@Test
	public void testJoinString() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.PRODUCT = T2.NAME"));
	}

	/**
	 * Inner join with WHERE
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T2.TYPE = 10"));
	}

	/**
	 * Inner join with WHERE & HAVING
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T2.TYPE = 10 GROUP BY PRODUCT HAVING AVG(PRICE) > 5 AND AVG(PRICE) < 10"));
	}
	
	/**
	 * Inner join with WHERE on first table
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T1.PRICE > 10"));
	}
	
	/**
	 * Inner join with two WHERE conditions on first and second table
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T1.PRICE > 10 AND T2.TYPE = 10"));
	}
	
	/**
	 * Inner join with one WHERE conditions between first and second table
	 */
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T1.PRICE > T2.TYPE - 10 AND T1.PRICE < T2.TYPE + 10"));
	}
	
	/**
	 * Two Inner joins
	 */
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT PRODUCT FROM PRODUCTS T1 INNER JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID INNER JOIN PRODUCT_DETAIL T3 ON T1.ID = T3.ID - 10"));
	}
}

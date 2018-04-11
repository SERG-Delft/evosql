package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class LeftJoinTest extends TestBase {
	
	/**
	 * Left join with WHERE on the joined table to be a value, which is not possible in our GA
	 *//*
	@Test
	public void test1() {
		assertFalse(testExecutePath("SELECT * FROM Products t1 LEFT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.TYPE = 10"));
	}*/
	
	/**
	 * Left join with WHERE on the joined table to be null
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T1 LEFT JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T2.TYPE IS NULL"));
	}
	
	/**
	 * Left join with WHERE on the first table
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T1 LEFT JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE T1.PRICE > 10 AND T1.PRICE < 20"));
	} 
	
	/**
	 * Left join with WHERE with nulls and condition on the first table
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T1 LEFT JOIN PRODUCT_DETAIL T2 ON T1.ID = T2.ID WHERE ((T1.ID IS NULL) AND (T2.ID IS NULL)) AND (T1.PRICE > 10 AND T1.PRICE < 20)"));
	} 
}

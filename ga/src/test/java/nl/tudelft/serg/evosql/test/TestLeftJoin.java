package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestLeftJoin extends TestBase {
	
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
		assertTrue(testExecutePath("SELECT * FROM Products t1 LEFT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.TYPE IS NULL"));
	}
	
	/**
	 * Left join with WHERE on the first table
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 LEFT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t1.Price > 10 AND t1.Price < 20"));
	} 
	
	/**
	 * Left join with WHERE with nulls and condition on the first table
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 LEFT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE ((t1.ID IS NULL) AND (t2.ID IS NULL)) AND (t1.Price > 10 AND t1.Price < 20)"));
	} 
}

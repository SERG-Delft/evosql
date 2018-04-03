package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class InTest extends TestBase {
	
	/**
	 * IN hardcoded list
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT IN ('HI', 'BYE')"));
	}
	
	/**
	 * IN subquery
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT IN (SELECT NAME FROM PRODUCT_DETAIL)"));
	}
	
	/**
	 * IN subquery names at least 2 characters
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT IN (SELECT NAME FROM PRODUCT_DETAIL WHERE LENGTH(NAME) > 1)"));
	}
	
	/**
	 * IN subquery with where in subquery
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT PRODUCT, PRICE FROM PRODUCTS WHERE PRODUCT IN (SELECT NAME FROM PRODUCT_DETAIL WHERE TYPE = 10)"));
	}
}

package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class InTest extends TestBase {
	
	/**
	 * IN hardcoded list
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE Product IN ('HI', 'BYE')"));
	}
	
	/**
	 * IN subquery
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE Product IN (SELECT Name FROM Product_Detail)"));
	}
	
	/**
	 * IN subquery names at least 2 characters
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE Product IN (SELECT Name FROM Product_Detail WHERE LENGTH(Name) > 1)"));
	}
	
	/**
	 * IN subquery with where in subquery
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE Product IN (SELECT Name FROM Product_Detail WHERE Type = 10)"));
	}
}

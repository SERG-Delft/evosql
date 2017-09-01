package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestLimit extends TestBase {
	
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Product LIMIT 2"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE Price > 100 AND Price < 150 LIMIT 2"));
	}
	
	/**
	 * This requires at least 21 rows to be present in the fixture
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products LIMIT 2 OFFSET 20"));
	}

}

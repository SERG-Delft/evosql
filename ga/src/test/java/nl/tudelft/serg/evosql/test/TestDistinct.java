package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestDistinct extends TestBase {
	
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT DISTINCT Product FROM Products"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT DISTINCT Product FROM Products WHERE Price > 50 AND Price < 75"));
	}

	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT DISTINCT Product FROM Products GROUP BY Product HAVING SUM(Price) > 50 AND SUM(Price) < 75"));
	}

}

package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestExists extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE EXISTS (SELECT ID FROM Product_detail WHERE Type = 10)"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products pr WHERE EXISTS (SELECT ID FROM Product_detail WHERE Type = pr.ID)"));
	}
}

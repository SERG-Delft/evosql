package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestSelect extends TestBase {
	
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products"));
	}
}

package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestNull extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product IS NULL"));
	}

}

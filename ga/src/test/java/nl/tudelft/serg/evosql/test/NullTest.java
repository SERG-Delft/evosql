package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class NullTest extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT IS NULL"));
	}

}

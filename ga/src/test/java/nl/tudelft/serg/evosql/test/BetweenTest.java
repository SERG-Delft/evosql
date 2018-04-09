package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class BetweenTest extends TestBase {

	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRICE BETWEEN 0 AND 100"));
	}
}

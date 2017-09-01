package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestGroupBy extends TestBase {
	
	/**
	 * GROUP BY without WHERE
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product"));
	}
	
	/**
	 * GROUP BY with simple WHERE
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products WHERE Price > 4 GROUP BY Product"));
	}

	/**
	 * GROUP BY with complex WHERE
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products WHERE (Price > 4 AND Product = 'BINGO') OR (Product = 'TEST') GROUP BY Product"));
	}
}

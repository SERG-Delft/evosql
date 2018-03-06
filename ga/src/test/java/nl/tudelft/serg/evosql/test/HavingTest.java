package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class HavingTest extends TestBase {
	/**
	 * Having without WHERE
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product HAVING AVG(Price) > 5 AND AVG(Price) < 10"));
	}
	
	/**
	 * Having with where
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products WHERE LENGTH(Product) = 5 GROUP BY Product HAVING AVG(Price) > 0 AND AVG(Price) < 10"));
	}
	
	/**
	 * Having without aggregate
	 */
	@Test
	public void testHavingExists() {
		assertTrue(testExecutePath("SELECT Product FROM products t GROUP BY Product HAVING EXISTS (SELECT * FROM Product_Detail t2 WHERE t.Product = t2.Name)"));
	}
	
	/**
	 * Having without aggregate
	 */
	@Test
	public void testHavingExistsAndSome() {
		assertTrue(testExecutePath("SELECT Product FROM products t GROUP BY Product HAVING EXISTS (SELECT * FROM Product_Detail t2 WHERE t.Product = t2.Name) AND SUM(t.Price) > 50"));
	}
}

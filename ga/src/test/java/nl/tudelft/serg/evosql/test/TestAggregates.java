package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * Test all aggregate functions in a having
 *
 */
public class TestAggregates extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product HAVING AVG(Price) = 15"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product HAVING MIN(Price) < 10 AND MAX(Price) BETWEEN 20 AND 30"));
	}
	
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product HAVING SUM(Price) BETWEEN 2 and 3"));
	}
	
	/** Special case where Product has to be null **/
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product HAVING COUNT(Product) = 0"));
	}
	
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT Product, AVG(Price) FROM products GROUP BY Product HAVING COUNT(Product) = 3"));
	}
}

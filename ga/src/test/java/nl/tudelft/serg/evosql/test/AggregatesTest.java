package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * Test all aggregate functions in a having
 *
 */
public class AggregatesTest extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT HAVING AVG(PRICE) = 15"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT HAVING MIN(PRICE) < 10 AND MAX(PRICE) BETWEEN 20 AND 30"));
	}
	
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT HAVING SUM(PRICE) BETWEEN 2 AND 3"));
	}
	
	/** Special case where Product has to be null **/
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT HAVING COUNT(PRODUCT) = 0"));
	}
	
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT HAVING COUNT(PRODUCT) = 3"));
	}
}

package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class DistinctTest extends TestBase {
	
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT DISTINCT PRODUCT FROM PRODUCTS"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT DISTINCT PRODUCT FROM PRODUCTS WHERE PRICE > 50 AND PRICE < 75"));
	}

	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT DISTINCT PRODUCT FROM PRODUCTS GROUP BY PRODUCT HAVING SUM(PRICE) > 50 AND SUM(PRICE) < 75"));
	}

}

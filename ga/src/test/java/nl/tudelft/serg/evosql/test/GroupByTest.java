package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class GroupByTest extends TestBase {
	
	/**
	 * GROUP BY without WHERE
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS GROUP BY PRODUCT"));
	}
	
	/**
	 * GROUP BY with simple WHERE
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS WHERE PRICE > 4 GROUP BY PRODUCT"));
	}

	/**
	 * GROUP BY with complex WHERE
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT PRODUCT, AVG(PRICE) FROM PRODUCTS WHERE (PRICE > 4 AND PRODUCT = 'BINGO') OR (PRODUCT = 'TEST') GROUP BY PRODUCT"));
	}
}

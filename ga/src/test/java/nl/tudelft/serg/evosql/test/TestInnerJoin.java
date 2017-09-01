package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestInnerJoin extends TestBase {
	/**
	 * Inner join test, succeeds when both tables share an ID
	 */
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID"));
	}
	
	/**
	 * Inner join test, succeeds when both tables share an ID
	 */
	@Test
	public void testJoinString() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.PRoduct = t2.Name"));
	}

	/**
	 * Inner join with WHERE
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.TYPE = 10"));
	}

	/**
	 * Inner join with WHERE & HAVING
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.TYPE = 10 GROUP BY Product HAVING AVG(Price) > 5 AND AVG(Price) < 10"));
	}
	
	/**
	 * Inner join with WHERE on first table
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t1.Price > 10"));
	}
	
	/**
	 * Inner join with two WHERE conditions on first and second table
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t1.Price > 10 AND t2.TYPE = 10"));
	}
	
	/**
	 * Inner join with one WHERE conditions between first and second table
	 */
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t1.Price > t2.TYPE - 10 AND t1.Price < t2.TYPE + 10"));
	}
	
	/**
	 * Two Inner joins
	 */
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID INNER JOIN PRODUCT_DETAIL t3 ON t1.ID = t3.ID - 10"));
	}
}

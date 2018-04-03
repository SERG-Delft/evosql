package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class WhereTest extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Price > 10"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE (PRICE > 10 AND LENGTH(PRODUCT) = 1) OR (PRICE < 8 AND PRODUCT = 'A')-- OR (PRICE < 4 AND PRICE > 1)"));
	}
	
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE NOT (PRICE > 1 OR PRICE < -1)"));
	}
	
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE LCASE(PRODUCT) = 'tv'"));
	}

	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRICE > 10 AND PRICE < 20"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT = 'TV'"));
	}
	
	/** Test Double equals **/
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRICE = 10"));
	}
	
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRICE = 10.59"));
	}
}

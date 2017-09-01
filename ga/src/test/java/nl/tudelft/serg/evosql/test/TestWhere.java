package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestWhere extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Price > 10"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM products WHERE (Price > 10 AND LENGTH(Product) = 1) OR (Price < 8 AND Product = 'A')-- OR (Price < 4 AND Price > 1)"));
	}
	
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE NOT (Price > 1 OR Price < -1)"));
	}
	
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE LCASE(Product) = 'tv'"));
	}

	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Price > 10 AND Price < 20"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product = 'tv'"));
	}
	
	/** Test Double equals **/
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Price = 10"));
	}
	
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Price = 10.59"));
	}
}

package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestLike extends TestBase {

	/** Converts to an EQUAL operation **/
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE 'A'"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE 'A_'"));
	}
	
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE '%_A'"));
	}
	
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE '%A'"));
	}
	
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE '%A%'"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE 'A%'"));
	}
	
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT * FROM Products WHERE Product LIKE 'WEST%'"));
	}

}

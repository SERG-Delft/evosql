package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class LikeTest extends TestBase {

	/** Converts to an EQUAL operation **/
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE 'A'"));
	}
	
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE 'A_'"));
	}
	
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE '%_A'"));
	}
	
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE '%A'"));
	}
	
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE '%A%'"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE 'A%'"));
	}
	
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS WHERE PRODUCT LIKE 'WEST%'"));
	}

}

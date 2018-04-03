package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class ExistsTest extends TestBase {
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT PRODUCT, PRICE FROM PRODUCTS WHERE EXISTS (SELECT ID FROM PRODUCT_DETAIL WHERE TYPE = 10)"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT PRODUCT, PRICE FROM PRODUCTS PR WHERE EXISTS (SELECT ID FROM PRODUCT_DETAIL WHERE TYPE = PR.ID)"));
	}
}

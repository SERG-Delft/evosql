package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Ignore;
import org.junit.Test;

/**
 * Tests with subqueries in the SELECT/WHERE's
 *
 */
public class TestSubquerySelectWhere extends TestBase {

	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM products t WHERE LENGTH(t.Product) = 1 AND t.Price = (SELECT MAX(Price) FROM products)"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products t WHERE LENGTH(t.Product) = 1 GROUP BY Product, Price) t WHERE t.Price = (SELECT MAX(Price) FROM products)"));
	}

	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT Product, Price FROM products t WHERE LENGTH(t.Product) = 1 GROUP BY Product, Price) t WHERE t.Price < (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name)"));
	}

	/**
	 * Subquery in SELECT, which does not affect the query
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT (SELECT MAX(Type) FROM Product_Detail WHERE Name = 'A') Subinfo, Product FROM Products"));
	}
	
	/**
	 * Subquery in SELECT, which does affect the query
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT (SELECT MAX(Type) FROM Product_Detail WHERE Name = 'A') Subinfo, Product FROM Products) t WHERE SubInfo > 10 AND SubInfo < 20"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name)"));
	}
	
	/**
	 * Subquery in the subquery, HSQLDB processes the two expressions at the same time
	 */
	@Test
	public void test7() {
		assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM (SELECT Name, Type FROM Product_Detail WHERE LENGTH(Name) = 2) t2 WHERE t.Product = t2.Name)"));
	}
	
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM (SELECT Name, Type FROM Product_Detail t3 WHERE LENGTH(Name) < t.ID) t2 WHERE t.Product = t2.Name)"));
	}
	
	@Test
	public void test9() {
		assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM Product_Detail t2 WHERE LENGTH(t.Product) = (SELECT MIN(t3.ID) FROM Products t3 WHERE t3.ID >= 0))"));
	}
	
	/**
	 * Nested subqueries, takes a long time
	 */
	@Test
	public void test10() {
		assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM Product_Detail t2 WHERE LENGTH(t.Product) = (SELECT MIN(t3.ID) FROM Products t3 WHERE t3.ID >= 0 AND t3.Product = t2.Name))"));
	}
	
	/**
	 * Two of the same subqueries next to eachother
	 */
	@Test
	public void test11() { 
		assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name) AND t.Price > (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name) - 10"));
	}
}

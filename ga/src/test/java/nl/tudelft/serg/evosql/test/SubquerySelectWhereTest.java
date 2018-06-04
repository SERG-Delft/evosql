package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.sql.TableSchema;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Tests with subqueries in the SELECT/WHERE's
 *
 */
public class SubquerySelectWhereTest extends TestBase {

	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE LENGTH(T.PRODUCT) = 1 AND T.PRICE = (SELECT MAX(PRICE) FROM PRODUCTS)"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS T WHERE LENGTH(T.PRODUCT) = 1 GROUP BY PRODUCT, PRICE) T WHERE T.PRICE = (SELECT MAX(PRICE) FROM PRODUCTS)"));
	}

	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT PRODUCT, PRICE FROM PRODUCTS T WHERE LENGTH(T.PRODUCT) = 1 GROUP BY PRODUCT, PRICE) T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME)"));
	}

	/**
	 * Subquery in SELECT, which does not affect the query
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT (SELECT MAX(TYPE) FROM PRODUCT_DETAIL WHERE NAME = 'A') SUBINFO, PRODUCT FROM PRODUCTS"));
	}
	
	/**
	 * Subquery in SELECT, which does affect the query
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM (SELECT (SELECT MAX(TYPE) FROM PRODUCT_DETAIL WHERE NAME = 'A') SUBINFO, PRODUCT FROM PRODUCTS) T WHERE SUBINFO > 10 AND SUBINFO < 20"));
	}
	
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	/**
	 * Subquery in the subquery, HSQLDB processes the two expressions at the same time
	 */
	@Test
	public void test7() {

        SchemaExtractor se = new SchemaExtractor(jdbcUrl, database, user, pwd);
        TableSchema productsSchema = se.extract("PRODUCTS");
        TableSchema productDetailSchema = se.extract("PRODUCT_DETAIL");

        List<FixtureTable> tables = new ArrayList<>();
        Fixture fixture = new Fixture(tables);

        List<FixtureRow> productRows = new ArrayList<>();
        FixtureRow row1 = new FixtureRow("PRODUCTS", productsSchema);
        row1.set("ID", "1");
        row1.set("PRODUCT", "PS");
        row1.set("PRICE", "4");
        productRows.add(row1);
        FixtureTable productsTable = new FixtureTable(productsSchema, productRows);
        tables.add(productsTable);


        List<FixtureRow> productDetailsRows = new ArrayList<>();
        FixtureRow row2 = new FixtureRow("PRODUCT_DETAIL", productDetailSchema);
        row2.set("ID", "1");
        row2.set("NAME", "PS");
        row2.set("TYPE", "3");
        productDetailsRows.add(row2);
        FixtureTable productDetailsTable = new FixtureTable(productDetailSchema, productDetailsRows);
        tables.add(productDetailsTable);

        population = Arrays.asList(fixture);
        maxGenerations = 500;

		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM (SELECT NAME, TYPE FROM PRODUCT_DETAIL WHERE LENGTH(NAME) = 2) T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	@Test
	public void test8() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM (SELECT NAME, TYPE FROM PRODUCT_DETAIL T3 WHERE LENGTH(NAME) < T.ID) T2 WHERE T.PRODUCT = T2.NAME)"));
	}
	
	@Test
	public void test9() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE LENGTH(T.PRODUCT) = (SELECT MIN(T3.ID) FROM PRODUCTS T3 WHERE T3.ID >= 0))"));
	}
	
	/**
	 * Nested subqueries, takes a long time
	 */
	@Test
	public void test10() {
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE LENGTH(T.PRODUCT) = (SELECT MIN(T3.ID) FROM PRODUCTS T3 WHERE T3.ID >= 0 AND T3.PRODUCT = T2.NAME))"));
	}
	
	/**
	 * Two of the same subqueries next to eachother
	 */
	@Test
	public void test11() { 
		assertTrue(testExecutePath("SELECT * FROM PRODUCTS T WHERE T.PRICE < (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME) AND T.PRICE > (SELECT MAX(TYPE) FROM PRODUCT_DETAIL T2 WHERE T.PRODUCT = T2.NAME) - 10"));
	}
}

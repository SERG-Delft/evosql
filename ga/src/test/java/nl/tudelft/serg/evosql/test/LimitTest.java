package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import org.junit.Ignore;
import org.junit.Test;

public class LimitTest extends TestBase {
	
	@Test
	public void test1() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products LIMIT 2"));
	}

	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products WHERE Price > 100 AND Price < 150 LIMIT 2"));
	}
	
	/**
	 * This requires at least 21 rows to be present in the fixture
	 * This currently **does not work** in EvoSQL. We should somehow improve our FF to take the offset into account.
	 */
	@Test @Ignore
	public void test3() {
		assertTrue(testExecutePath("SELECT Product, Price FROM Products LIMIT 2 OFFSET 20"));
	}

}

package nl.tudelft.serg.evosql.sql.parser;

import java.util.Map;
import java.util.Set;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.mock.TableSchemaMocks;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

/**
 * NOTE: The current version of the used column extractor should extract all columns that are used except for in the outer most select.
 *
 */
public class UsedColumnExtractorTest {
	private SchemaExtractor extractor;
	
	@Before
	public void setUp() {
		this.extractor = Mockito.mock(SchemaExtractor.class);
		
		Mockito.when(extractor.extract("T1")).thenReturn(TableSchemaMocks.T1());
		Mockito.when(extractor.extract("T2")).thenReturn(TableSchemaMocks.T2());
		Mockito.when(extractor.getTablesFromQuery(Mockito.anyString())).thenCallRealMethod();
	}
	
	private Set<ColumnSchema> executeExtractor(String sql) {
		// Extract the table schemas
		sql = new SqlSecurer(sql).getSecureSql();
		Map<String, TableSchema> schemas = extractor.getTablesFromQuery(sql);
		return new UsedColumnExtractor(sql, schemas).extract();
	}
	
	private boolean contains(Set<ColumnSchema> columns, String tableName, String columnName) {
		String uTableName = tableName.toUpperCase();
		String uColumnName = columnName.toUpperCase();
		return columns.stream()
				.filter(cs -> cs.getName().equals(uColumnName) && cs.getTable().getName().equals(uTableName))
				.findAny()
				.isPresent();
	}
	
	// Assumes both column schemas are present
	private boolean areLinked(Set<ColumnSchema> columns, String table1Name, String column1Name, String table2Name, String column2Name) {
		String uTable1Name = table1Name.toUpperCase();
		String uColumn1Name = column1Name.toUpperCase();
		String uTable2Name = table2Name.toUpperCase();
		String uColumn2Name = column2Name.toUpperCase();
		
		ColumnSchema cs1 = columns.stream()
				.filter(cs -> cs.getName().equals(uColumn1Name) && cs.getTable().getName().equals(uTable1Name))
				.findFirst().get();
		
		ColumnSchema cs2 = columns.stream()
				.filter(cs -> cs.getName().equals(uColumn2Name) && cs.getTable().getName().equals(uTable2Name))
				.findFirst().get();
		
		Set<ColumnSchema> colSet = cs1.getSeedSourceColumns();
		if (!contains(colSet, table2Name, column2Name))
			return false;
		
		colSet = cs2.getSeedSourceColumns();
		if (!contains(colSet, table1Name, column1Name))
			return false;
		
		return true;
	}
	
	@Test
	public void testNoColumns() {
		String sql = "SELECT a, b, c FROM t1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// none
		Assert.assertEquals(0, columns.size());
	}
	
	@Test
	public void testSimpleWhereConditions() {
		String sql = "SELECT a, b, c FROM t1 WHERE a = 1 AND t1.b = 2";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}
	
	@Test
	public void testHavingConditions() {
		String sql = "SELECT a, b, c FROM t1 HAVING t1.a = 1 AND b = 2";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}
	
	@Test
	public void testAggregrate() {
		String sql = "SELECT a, b, c FROM t1 HAVING SUM(a) < 50";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a
		Assert.assertEquals(1, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
	}
	
	@Test
	public void testSimpleSubqueryFrom() {
		String sql = "SELECT a, b, c FROM (SELECT a FROM t1) AS t2 WHERE t2.a = 1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a
		Assert.assertEquals(1, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
	}
	
	@Test
	public void testDoubleSubqueryFrom() {
		String sql = "SELECT a, b, c FROM (SELECT * FROM (SELECT a, b FROM t1) AS t2) AS t1 WHERE t1.a = 1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}
	
	@Test
	public void testDoubleSubqueryFrom2() {
		String sql = "SELECT a, b, c FROM (SELECT t2.* FROM (SELECT a FROM t1) AS t2) AS t3 WHERE t3.a = 1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a
		Assert.assertEquals(1, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
	}
	
	@Test
	public void testJoin() {
		String sql = "SELECT t1.a, t1.b, t1.c FROM t1 JOIN t2 ON d = t2.b WHERE t1.a = 1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b, t2.b
		Assert.assertEquals(3, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "d"));
		Assert.assertTrue(contains(columns, "t2", "b"));
		// Column equals check
		Assert.assertTrue(areLinked(columns, "t1", "d", "t2", "b"));
	}
	
	@Test
	public void testWhereSubqueryFrom() {
		String sql = "SELECT a, b, c FROM (SELECT a FROM t1 WHERE b = 5) AS t2";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.b, t1.a
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}
	
	@Test
	public void testWhereSubqueryFrom2() {
		String sql = "SELECT a, b, c FROM (SELECT a FROM t1 WHERE b = 5) AS t2 WHERE t2.a = 3";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}

	@Test
	public void testSubquerySelect() {
		String sql = "SELECT a, (SELECT MAX(c) FROM t2 WHERE b = 5) maxc FROM t1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t2.b, t2.c
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t2", "b"));
		Assert.assertTrue(contains(columns, "t2", "c"));
	}

	@Test
	public void testSubquerySelect2() { 
		String sql = "SELECT a FROM (SELECT a, (SELECT MAX(c) FROM t2 WHERE b = 5) maxc FROM t1) as t3 WHERE t3.maxc > 50";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t2.b, t2.c, t1.a
		Assert.assertEquals(3, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t2", "b"));
		Assert.assertTrue(contains(columns, "t2", "c"));
	}

	@Test
	public void testSubsubquerySelect() { 
		String sql = "SELECT a, (SELECT MAX(c) FROM (SELECT * FROM t2 WHERE b = t1.b) t2 WHERE t2.a = 3) FROM t1";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.b, t2.b, t2.a, t2.c
		Assert.assertEquals(4, columns.size());
		Assert.assertTrue(contains(columns, "t1", "b"));
		Assert.assertTrue(contains(columns, "t2", "b"));
		Assert.assertTrue(contains(columns, "t2", "a"));
		Assert.assertTrue(contains(columns, "t2", "c"));
		// Column equals check
		Assert.assertTrue(areLinked(columns, "t1", "b", "t2", "b"));
	}

	@Test
	public void testSubqueryWhere() { 
		String sql = "SELECT a FROM t1 WHERE (SELECT MAX(c) FROM t2 WHERE b = 5) = d";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t2.b, t2.c
		Assert.assertEquals(3, columns.size());
		Assert.assertTrue(contains(columns, "t1", "d"));
		Assert.assertTrue(contains(columns, "t2", "b"));
		Assert.assertTrue(contains(columns, "t2", "c"));
	}
	
	@Test
	public void testFunctionLength() {
		String sql = "SELECT a, b, c FROM t1 WHERE LENGTH(a) = 10";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a
		Assert.assertEquals(1, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
	}

	@Test
	public void testFunctionLength2() {
		String sql = "SELECT b FROM (SELECT LENGTH(a) len, b FROM t1) AS t2 WHERE len = 10";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}
	
	@Test
	public void testArithmeticDependency() {
		String sql = "SELECT b FROM (SELECT a + c result, b FROM t1) AS t2 WHERE result = 10";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.c, t1.b
		Assert.assertEquals(3, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "c"));
		Assert.assertTrue(contains(columns, "t1", "b"));
	}
	
	@Test
	public void testArithmeticSubqueryDependency() {
		String sql = "SELECT b FROM (SELECT a + (SELECT MAX(c) FROM t2 WHERE b = 10) result, b FROM t1) AS t2 WHERE result = 10";
		Set<ColumnSchema> columns = executeExtractor(sql);
		// t1.a, t1.b, t2.b, t2.c
		Assert.assertEquals(4, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
		Assert.assertTrue(contains(columns, "t2", "b"));
		Assert.assertTrue(contains(columns, "t2", "c"));
	}
	
	@Test
	public void testCountAll() { 
		//TODO do we want a & b to be mutable columns now? This query would be solved by simply duplicating rows.. However a and b are important in it
		//String sql = "SELECT a, b FROM t1 GROUP BY a, b HAVING COUNT(*) > 1";
		//Set<ColumnSchema> columns = executeExtractor(sql);
		/*
		// t1.a, t1.b, t2.b
		Assert.assertEquals(2, columns.size());
		Assert.assertTrue(contains(columns, "t1", "a"));
		Assert.assertTrue(contains(columns, "t1", "b"));
		*/
	}
}

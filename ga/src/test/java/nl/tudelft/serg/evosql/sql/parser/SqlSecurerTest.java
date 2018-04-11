package nl.tudelft.serg.evosql.sql.parser;

import org.junit.Test;
import org.junit.Assert;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class SqlSecurerTest {

	@Test
	public void secureSelectAllQuery() {
		String sql = new SqlSecurer("SELECT * FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT * FROM \"Table\"");
	}

	@Test
	public void secureSelectColumnsQuery() {
		String sql = new SqlSecurer("SELECT Column1, Column2, Column3 FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\", \"Column2\", \"Column3\" FROM \"Table\"");
	}

	@Test
	public void secureColumnAliasQuery() {
		String sql = new SqlSecurer("SELECT Column1 AS col1, Column2 AS col2, Column3 FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"col1\", \"Column2\" AS \"col2\", \"Column3\" FROM \"Table\"");
	}

	@Test
	public void secureSelectTableColumnsQuery() {
		String sql = new SqlSecurer("SELECT Table.Column1, Table.Column2, Table.Column3 FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Table\".\"Column1\", \"Table\".\"Column2\", \"Table\".\"Column3\" FROM \"Table\"");
	}

	@Test
	public void secureSelectTableAllColumnsQuery() {
		String sql = new SqlSecurer("SELECT Table.* FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Table\".* FROM \"Table\"");
	}

	@Test
	public void secureSelectTableAliasColumnsQuery() {
		String sql = new SqlSecurer("SELECT t1.Column1, t1.Column2, t1.Column3 FROM Table AS t1").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"t1\".\"Column1\", \"t1\".\"Column2\", \"t1\".\"Column3\" FROM \"Table\" AS \"t1\"");
	}

	@Test
	public void secureSecureQuery() {
		String sql = new SqlSecurer("SELECT \"COLUMN1\", \"COLUMN2\", \"COLUMN3\" FROM \"Table\"").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"COLUMN1\", \"COLUMN2\", \"COLUMN3\" FROM \"Table\"");
	}

	@Test
	public void secureWhereColumnsQuery() {
		String sql = new SqlSecurer("SELECT Column1 FROM Table WHERE Column2 = 10 AND 'Column3' = column3").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" FROM \"Table\" WHERE \"Column2\" = 10 AND 'Column3' = \"column3\"");
	}

	@Test
	public void secureAggregateColumnsQuery() {
		String sql = new SqlSecurer("SELECT SUM(column1) FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT SUM(\"column1\") FROM \"Table\"");
	}

	@Test
	public void secureAggregateHavingColumnsQuery() {
		String sql = new SqlSecurer("SELECT SUM(column1) FROM Table HAVING AVG(column2) > 50").getSecureSql();
		Assert.assertEquals(sql, "SELECT SUM(\"column1\") FROM \"Table\" HAVING AVG(\"column2\") > 50");
	}

	@Test
	public void secureSubqueryColumnsQuery() {
		String sql = new SqlSecurer("SELECT * FROM (SELECT column1, Column2 FROM Table) t1").getSecureSql();
		Assert.assertEquals(sql, "SELECT * FROM (SELECT \"column1\", \"Column2\" FROM \"Table\") \"t1\"");
	}
	
	@Test
	public void secureBackticksKeywordQuery() {
		String sql = new SqlSecurer("SELECT `Column1`, `primary` FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\", \"primary\" FROM \"Table\"");
	}
	
	@Test
	public void securePrimaryNoBackticksQuery() {
		String sql = new SqlSecurer("SELECT table.primary FROM table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"table\".\"primary\" FROM \"table\"");
	}
	
	@Test
	public void securePrimaryPartOfWordQuery() {
		String sql = new SqlSecurer("SELECT primary_word FROM table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"primary_word\" FROM \"table\"");
	}
	
	@Test
	public void securePrimaryPartOfWord2Query() {
		String sql = new SqlSecurer("SELECT the_primary_word FROM table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"the_primary_word\" FROM \"table\"");
	}
	
	@Test
	public void secureRemoveOrderBy() {
		String sql = new SqlSecurer("SELECT Column1 FROM Table ORDER BY column1").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" FROM \"Table\"");
	}
	
	@Test
	public void leaveInnerOrderBy() {
		String sql = new SqlSecurer("SELECT Column1 FROM Table WHERE column2 = (SELECT c FROM t ORDER BY c) ORDER BY Column1").getSecureSql();
		Assert.assertEquals("SELECT \"Column1\" FROM \"Table\" WHERE \"column2\" = (SELECT \"c\" FROM \"t\" ORDER BY \"c\")", sql);
	}
	
	@Test
	public void secureAliasSingleQuotes() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column' FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\" FROM \"Table\"");
	}
	
	@Test
	public void secureAliasSingleQuotesTwice() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\"");
	}
	
	@Test
	public void secureExists() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table WHERE EXISTS (SELECT col FROM tab)").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" WHERE EXISTS (SELECT \"col\" FROM \"tab\")");
	}
	
	@Test
	public void secureColumnCondition() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table WHERE Column1").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" WHERE \"Column1\" = 1");
	}
	
	@Test
	public void secureColumnCondition2() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table WHERE Column1 = 2 AND Column1 OR Column3").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" WHERE \"Column1\" = 2 AND \"Column1\" = 1 OR \"Column3\" = 1");
	}
	
	@Test
	public void secureGroupBy() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table GROUP BY Column1, Column2").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" GROUP BY \"Column1\", \"Column2\"");
	}
	
	@Test
	public void secureDatefunction() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table WHERE date(column1) <= date('2015-02-01')").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" WHERE TIMESTAMP(\"column1\") <= TIMESTAMP('2015-02-01')");
	}
	
	@Test
	public void secureDatefunction2() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table WHERE (date(column1) <= date('2015-02-01'))").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" WHERE (TIMESTAMP(\"column1\") <= TIMESTAMP('2015-02-01'))");
	}
	
	@Test
	public void secureCurdatefunction() {
		String sql = new SqlSecurer("SELECT Column1 AS 'Column', Column2 AS 'ColumnTwo' FROM Table WHERE date(column1) <= CURDATE()").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"Column1\" AS \"Column\", \"Column2\" AS \"ColumnTwo\" FROM \"Table\" WHERE TIMESTAMP(\"column1\") <= CURDATE()");
	}
	
	@Test
	public void secureForUpdate() {
		String sql = new SqlSecurer("SELECT column1 FROM table FOR UPDATE").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"column1\" FROM \"table\"");
	}

	@Test
	public void secureEqualsNull() {
		String sql = new SqlSecurer("SELECT column1 FROM table WHERE column2 = NULL").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"column1\" FROM \"table\" WHERE \"column2\" IS NULL");
	}
	
	@Test
	public void secureNotEqualsNull() {
		String sql = new SqlSecurer("SELECT column1 FROM table WHERE column2 != NULL").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"column1\" FROM \"table\" WHERE \"column2\" IS NOT NULL");
	}
	
	@Test
	public void secureNotEqualsNull2() {
		String sql = new SqlSecurer("SELECT column1 FROM table WHERE column2 <> NULL").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"column1\" FROM \"table\" WHERE \"column2\" IS NOT NULL");
	}
	
	@Test
	public void leaveBinaryOpNull() {
		String sql = new SqlSecurer("SELECT column1 FROM table WHERE column2 >= NULL").getSecureSql();
		Assert.assertEquals(sql, "SELECT \"column1\" FROM \"table\" WHERE \"column2\" >= NULL");
	}
}

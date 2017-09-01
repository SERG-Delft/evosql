package nl.tudelft.serg.evosql.evaluation.tools;

import org.junit.Assert;
import org.junit.Test;

public class QueryStripperTest {
	@Test
	public void stripSelectAllQuery() {
		String sql = new QueryStripper("SELECT * FROM Table").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\"");
	}
	
	@Test
	public void stripInteger() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = 10").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = 0");
	}

	@Test
	public void stripString() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = 'test'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = ''");
	}

	@Test
	public void stripDouble() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = 50.1234").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = 0");
	}

	@Test
	public void stripDate() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = '1999-03-04'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = '2000-01-01'");
	}

	@Test
	public void stripDate2() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = '1999-3-4'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = '2000-01-01'");
	}

	@Test
	public void stripTime() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = '1:13:56'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = '12:00:00'");
	}

	@Test
	public void stripTime2() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = '14:13:56'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = '12:00:00'");
	}

	@Test
	public void stripTimestamp() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = '1999-03-04 01:13:56'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = '2000-01-01 12:00:00'");
	}

	@Test
	public void stripTimestamp2() {
		String sql = new QueryStripper("SELECT * FROM Table WHERE col = '1999-3-4 13:13:56.100'").getStrippedSql();
		Assert.assertEquals(sql, "SELECT * FROM \"TABLE\" WHERE \"COL\" = '2000-01-01 12:00:00'");
	}
}

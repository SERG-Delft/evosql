package nl.tudelft.serg.evosql.sql.parser;


import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;

/**
 * This class takes a SQL select statement and capitalizes and enquotes all column names and table names
 * So that the queries are runnable on HSQLDB.
 *
 */
public class SqlSecurer {
	private String sql;
	
	public SqlSecurer(String sql) {
		this.sql = sql;
	}
	
	public String getSecureSql() {
		// Prepare the SQL to be used for JSqlParser
		// All occurences of primary need to be enclosed by backticks, because otherwise JSqlParser is confused. MYSQL is fine with this
		// ex. SELECT table.primary FROM table => SELECT table.`primary` FROM table
		sql = sql.replaceAll("(?i)(?!`)([\\s\\.]?)primary([\\s\\.?])(?!`)", "$1`primary`$2");
		// Same for single quoted aliases
		sql = sql.replaceAll("(?i)AS '(.*?)'", "AS \"$1\"");
		// Replace all occurrences of date(.*) -> TIMESTAMP(.*)
		sql = sql.replaceAll("(?i)([\\s(])DATE\\((.*?)\\)", "$1TIMESTAMP($2)");
		// Replace all occurrences of FOR UPDATE
		sql = sql.replaceAll("(?i)\\sFOR UPDATE", "");
		
		// (Not) equals NULL fixes
		sql = sql.replaceAll("(?i)\\s=\\sNULL", " IS NULL");
		sql = sql.replaceAll("(?i)\\s!=\\sNULL", " IS NOT NULL");
		sql = sql.replaceAll("(?i)\\s<>\\sNULL", " IS NOT NULL");
		
		// Use the visitor to make all column and table names upper case and quoted
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(sql);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		stmt.getSelectBody().accept(new SqlSecurerVisitor());

		return stmt.toString();
	}
}

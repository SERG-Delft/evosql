package nl.tudelft.serg.evosql.evaluation.tools;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

public class QueryStripper {
	private String sql;
	
	public QueryStripper(String sql) {
		this.sql = sql;
	}
	
	public String getStrippedSql() {
		String secureQuery = new SqlSecurer(sql).getSecureSql();
		
		// Use the visitor to strip the sql
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(secureQuery);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		stmt.getSelectBody().accept(new QueryStripperVisitor());

		return stmt.toString();
	}

}

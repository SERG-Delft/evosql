package nl.tudelft.serg.evosql.sql.parser;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class UsedColumnExtractor {
	String sql;
	Map<String, TableSchema> tableSchemas;
	public int stringEqs, dateEqs;
	
	public UsedColumnExtractor(String sql, Map<String, TableSchema> tableSchemasInput) {
		this.sql = sql;
		this.tableSchemas = new HashMap<String, TableSchema>();
		this.stringEqs = 0;
		this.dateEqs = 0;
		tableSchemasInput.forEach((str, ts) -> tableSchemas.put(str, ts));
	}
	
	public Set<ColumnSchema> extract() {
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(sql);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		Set<ColumnSchema> outputColumns = new HashSet<ColumnSchema>();
		UsedColumnExtractorVisitor ucev = new UsedColumnExtractorVisitor(tableSchemas, outputColumns);
		stmt.getSelectBody().accept(ucev);
		this.stringEqs = ucev.stringEqs;
		this.dateEqs = ucev.dateEqs;
		
		return outputColumns;
	}
}

package nl.tudelft.serg.evosql.evaluation.query;

import java.io.IOException;
import java.io.PrintStream;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.evaluation.Evaluation;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

/**
 * Takes a set of queries, parses them
 *
 */
public class FunctionClassification {
	private static Logger log = LogManager.getLogger(Evaluation.class);
	private Map<String, Integer> functionMap;
	
	private List<String> queries;
	private PrintStream output;

	public FunctionClassification(List<String> queries, PrintStream output) {
		this.queries = queries;
		this.output = output;
		this.functionMap = new HashMap<String, Integer>();
	}
	
	public void perform() throws IOException, SQLException {
		perform(0);
	}
	
	public void perform(int skip) throws IOException, SQLException {
		// Print CSV header
		output.println("queryNo|aggregrateFunctions|otherFunctions");
		
		int queryNo = 0;
		for (String query : queries) {
			queryNo++;
			if (skip > 0) {
				skip--;
				continue;
			}
			if (query.trim().startsWith("--")) continue;
			if (query.trim().startsWith("STOP")) break;
			
			classifyQuery(query, queryNo);
		}
		
		// Print the map to standard output
		for (Entry<String, Integer> kv : functionMap.entrySet()) {
			System.out.println(kv.getKey() + " - " + kv.getValue());
		}
	}
	
	private QueryMetrics classifyQuery(String query, int queryNo) {
		log.info("Q: {}", query);
		QueryMetrics metrics = new QueryMetrics(query);

		// Secure it for JSqlParser
		query = new SqlSecurer(query).getSecureSql();
		
		// Get the rest of the metrics from a visitor
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(query);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		FunctionClassifierVisitor fcv = new FunctionClassifierVisitor();
		
		stmt.getSelectBody().accept(fcv);
		
		// Add data to the map
		for (Entry<String, Integer> kv : fcv.functionMap.entrySet()) {
			functionMap.put(kv.getKey(), kv.getValue() + functionMap.getOrDefault(kv.getKey(), 0));
		}
		
		output.printf("%d|%d|%d\n", queryNo, fcv.aggregateFunctions, fcv.otherFunctions);

		return metrics;
	}
}

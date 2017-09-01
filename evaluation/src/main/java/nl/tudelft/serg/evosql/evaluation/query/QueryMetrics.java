package nl.tudelft.serg.evosql.evaluation.query;

import java.util.ArrayList;
import java.util.List;

/** Class to store metrics for a query **/
public class QueryMetrics {

	public int paths;
	public int tables;
	public int conditions;
	public int joins;
	public int subqueries;
	public int functions;
	public int totalColumns;
	public int usedColumns;
	public List<String> pathList;

	public QueryMetrics(String query) {
		init();
	}
	
	public void init() {
		tables = 0;
		conditions = 0;
		paths = 0;
		joins = 0;
		subqueries = 0;
		functions = 0;
		totalColumns = 0;
		usedColumns = 0;
		pathList = null;
	}

}

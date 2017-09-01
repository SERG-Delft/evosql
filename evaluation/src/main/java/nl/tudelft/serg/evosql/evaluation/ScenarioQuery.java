package nl.tudelft.serg.evosql.evaluation;

public class ScenarioQuery {
	private int queryNo;
	private String query;
	
	public ScenarioQuery(int queryNo, String query) {
		this.queryNo = queryNo;
		this.query = query;
	}
	
	public int getQueryNo() { return queryNo; }
	
	public String getQuery() { return query; }
}

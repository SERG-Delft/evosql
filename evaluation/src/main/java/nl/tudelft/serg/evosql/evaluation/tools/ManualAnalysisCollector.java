package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.IOException;
import java.io.PrintStream;
import java.net.URISyntaxException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.hibernate.engine.jdbc.internal.BasicFormatterImpl;

import nl.tudelft.serg.evosql.evaluation.query.QueryPathList;
import nl.tudelft.serg.evosql.evaluation.query.Runner;

public class ManualAnalysisCollector {
	String outputPrefix;
	int queriesExists = 0;
	int pathsExists = 0;
	
	private String user;
	private String pwd;
	private String connectionString;

	private String database;
	private String schema;
	
	private Connection conn;
	
	ManualAnalysisCollector(String outputPrefix, String connectionString, String database, String schema, String user, String pwd) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
		this.outputPrefix = outputPrefix;
	}
	
	// Get all scenarios to collect from
	void collect() throws SQLException, IOException {
		// Open connection to the evaluation db with query classifications
		conn = DriverManager.getConnection(connectionString, user, pwd);
		conn.setCatalog(database);
		
		/*
SELECT DISTINCT system, processNo
FROM evaluationAverage
WHERE algorithm = 'evosql' AND coverage < 1
		 */
		PreparedStatement stmt = conn.prepareStatement("SELECT DISTINCT system, processNo FROM evaluationAverage WHERE algorithm = 'evosql' AND coverage < 1");
		ResultSet result = stmt.executeQuery();
		
		String lastSystem = "";
		PrintStream output = null;
		while (result.next()) {
			String system = result.getString(1);
			int processNo = result.getInt(2);
			
			if (!system.equals(lastSystem)) {
				if (output != null) output.close();
				output = new PrintStream(outputPrefix + system + ".sql");
				lastSystem = system;
			}
			collectScenario(system, processNo, output);
		}
		output.close();
		
		conn.close();
		
		System.out.println(queriesExists);
		System.out.println(pathsExists);
	}
	
	// Collect the queries from the scenarios
	void collectScenario(String system, int processNo, PrintStream output) throws SQLException {
		String scenario = system + "-process" + processNo;
		String path = null;
		try {
			path = Paths.get(Runner.class.getResource("/").toURI()).toString() + "/../../scenarios/";
		} catch (URISyntaxException e) {
			e.printStackTrace();
			System.out.println("Failed for scenario " + scenario + ".");
			return;
		}
		
		String projectPath = path + scenario + "/";

		
		// open query path reader
		QueryPathReader qpr = new QueryPathReader(projectPath);
		try {
			qpr.init();	
			
			/* 
SELECT DISTINCT qm.processQueryNo, qc.queryString
FROM queryclassification qc
INNER JOIN querymapping qm 
	ON qm.system = qc.system
		AND qm.queryNo = qc.queryNo
INNER JOIN evaluationAverage ea
	ON coverage < 1 
		AND ea.system = qm.system
        AND ea.processNo = qm.processNo
		AND ea.queryNo = qm.processQueryNo
WHERE ea.algorithm = 'evosql' AND qm.system = {system} AND qm.processNo = {processNo}
ORDER BY qm.processQueryNo;
			 */
			String sql = "SELECT DISTINCT qm.processQueryNo, qc.queryString, ea.coverage, qc.paths \r\n" + 
					"FROM queryclassification qc\r\n" + 
					"INNER JOIN querymapping qm \r\n" + 
					"	ON qm.system = qc.system\r\n" + 
					"		AND qm.queryNo = qc.queryNo\r\n" + 
					"INNER JOIN evaluationAverage ea\r\n" + 
					"	ON coverage < 1 \r\n" + 
					"		AND ea.system = qm.system\r\n" + 
					"        AND ea.processNo = qm.processNo\r\n" + 
					"		AND ea.queryNo = qm.processQueryNo\r\n" + 
					"WHERE ea.algorithm = 'evosql' AND qm.system = ? AND qm.processNo = ?\r\n" + 
					"ORDER BY qm.processQueryNo"; 
					
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, system);
			stmt.setInt(2, processNo);
			ResultSet result = stmt.executeQuery();
		
			// Get all queries to collect
			int queryCount = 0;
			if (result.last()) {
				queryCount = result.getRow();
				result.beforeFirst();
			}
			int[] queryNumbers = new int[queryCount];
			String[] queryStrings = new String[queryCount];
			double[] queryCoverages = new double[queryCount];
			int[] pathCounts = new int[queryCount];
			int i = 0;
			while (result.next()) {
				queryNumbers[i] = result.getInt(1);
				queryStrings[i] = result.getString(2);
				queryCoverages[i] = result.getDouble(3);
				pathCounts[i] = result.getInt(4);
				i++;
			}
			
			// For each query collect the information needed and store it 
			for (int j = 0; j < queryCount; j++) {
				int processQueryNo = queryNumbers[j];
				String query = queryStrings[j];
				double coverage = queryCoverages[j];
				QueryPathList qpl = qpr.read(processQueryNo);
				collectQuery(system, processNo, processQueryNo, query, coverage, pathCounts[j], qpl, output);
			}
			
			qpr.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Failed for scenario " + scenario + ".");
			return;
		}
	}
	
	// Collect all the paths, and print out information for each path
	void collectQuery(String system, int processNo, int processQueryNo, String query, double coverage, int pathCount, QueryPathList qpl, PrintStream output) throws SQLException {
		// Get all paths to print
		/*
SELECT DISTINCT pathNo
FROM evaluation
WHERE algorithm = 'evosql' 
	AND system = {system} AND processNo = {processNo} and queryNo = {processQueryNo}
	AND success = 0 
		 */
		String sql = "SELECT pathNo, SUM(success) success, SUM(1 - success) failures, GROUP_CONCAT(message SEPARATOR ' | ') messages \r\n" + 
				"FROM evaluation\r\n" + 
				"WHERE algorithm = 'evosql'\r\n" + 
				"	AND system = ? AND processNo = ? and queryNo = ?\r\n" + 
				"GROUP BY pathNo\r\n" + 
				"HAVING SUM(1 - success) > 0\r\n" + 
				"ORDER BY pathNo";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, system);
		stmt.setInt(2, processNo);
		stmt.setInt(3, processQueryNo);
		ResultSet result = stmt.executeQuery();
		/*
		// Print query info
		output.print("\n===================================\n");
		output.print("Query: " + system + " - Process " + processNo + " query " + processQueryNo + "\n");
		output.print("Coverage: " + String.format("%.2f", coverage) + "\n");
		output.print(getBeautifulSql(query));
		output.print("\n===================================\n");
*/
		if (query.contains("EXISTS") || query.contains("exists"))
			this.queriesExists += 1;
		
		while (result.next()) {
			int pathNo = result.getInt(1);
			String pathSql = qpl.pathList.get(pathNo - 1);
			int successes = result.getInt(2);
			int failures = result.getInt(3);
			String messages = result.getString(4);
			if (successes > 0) continue;
			// Print Path info
			output.print("\n-----------------------------------\n");
			output.print("Query: " + system + "-process" + processNo + ", query " + processQueryNo + "\n");
			output.print("Path " + pathNo + "/" + pathCount + " - " + successes + " successes, " + failures + " failures\n");
			output.print("Failure messages: " + messages + "\n");
			output.print(getBeautifulSql(pathSql));
			output.print("\n-----------------------------------\n");

			System.out.println(system + "\t" + processNo + "\t" + processQueryNo + "\t" + pathNo);
			
			if (pathSql.contains("EXISTS") || pathSql.contains("exists"))
				this.pathsExists += 1;
		}
	}
	
	public static void main(String[] args) {
		try {
			new ManualAnalysisCollector(
					"manualData"
				,  "jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false"
				, "evaluationdata", "public", "evosql", "evosql").collect();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	BasicFormatterImpl formatter = new BasicFormatterImpl();
	String getBeautifulSql(String uglySql) {
		return formatter.format(uglySql);
	}
}

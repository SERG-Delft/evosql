package nl.tudelft.serg.evosql.evaluation.query;

import java.io.IOException;
import java.io.PrintStream;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.evaluation.ScriptRunner;
import nl.tudelft.serg.evosql.evaluation.tools.QueryPathReader;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.UsedColumnExtractor;

/**
 * Analyze rules from the evaluation that are not 100% covered by EvoSQL
 * 
 * @author Jeroen Castelein
 *
 */
public class DetailedClassification {
	private String user;
	private String pwd;
	private String connectionString;

	private SchemaExtractor extractor;
	private String database;
	private PrintStream output;

	private String loadDatabase = "DetailedClassification";
	
	public final static String
		TABLES = "tables",
		PREDICATES = "pred",
		JOINS = "joins",
		LEFTJ = "leftj",
		RIGHTJ = "rightj",
		INNERJ = "innerj",
		SUBQUERIES = "subqueries",
		EXISTS = "exists",
		LIKES = "likes",
		AGGFUNCTIONS = "aggfunctions",
		OTHFUNCTIONS = "othfunctions",
		CASES = "cases",
		IFNULLS = "ifnull",
		GROUPBY = "groupby",
		WHERE = "where",
		HAVING = "having",
		CDGTx = "cdgtx",
		xGTCD = "xgtcd"
		;
	
	DetailedClassification(PrintStream output, String connectionString, String database, String user, String pwd) {
		this.connectionString = connectionString;
		this.database = database;
		this.user = user;
		this.pwd = pwd;
		this.output = output;
	}
	
	void classify() throws Exception {
		String scenarioPath = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/scenariosRQ1evaluation/";
		
		// Connect to the evaluation database
		Connection conn = DriverManager.getConnection(connectionString, user, pwd);
		conn.setCatalog(database);
		
		// Collect the rules to analyze
		List<String> rulesList = collectRules(conn, scenarioPath);
		
		classifyRules(rulesList, scenarioPath);
	}
	
	void classifyRules(List<String> rulesList, String scenarioPath) throws Exception {
		output.println("System|ProcessNo|QueryNo|PathNo|Success|Runtime|Individuals|Tables|Predicates|Joins|LeftJoins|RightJoins|OuterJoins|InnerJoins|"
					+ "Subqueries|AggFunctions|OthFunctions|Functions|Exists|Likes|Cases|IFNULL|StringEQ|DateEQ|UsedColumns|TotalColumns|"
					+ "Where|GroupBy|Having|CDGTx|xGTCD");
		String currentSystem = "";
		for (String rule : rulesList) {
			// Split rule info and rule query
			String[] ruleSplit = rule.split("\n", 2);
			
			// Extract system
			String system = ruleSplit[0].split("\\|", 2)[0];
			
			if (!currentSystem.equals(system)) {
				String processPath = scenarioPath + system + "/";
				System.out.println("Loading schema: " + system);

				// Load system schema
				loadSchema(getSchema(processPath));
				
				currentSystem = system;
			}
			
			Select stmt = null;
			try {
				stmt = (Select) CCJSqlParserUtil.parse(ruleSplit[1]);
			} catch (JSQLParserException e) {
				throw new RuntimeException(e);
			}

			Map<String, TableSchema> schemas = extractor.getTablesFromQuery(ruleSplit[1]);
			Map<String, Integer> dict = new HashMap<String, Integer>();
			stmt.getSelectBody().accept(new DetailedClassifierVisitor(dict));
			
			// Measure the columns used and total columns available
			int totalColumns = 0;
			for (TableSchema ts : schemas.values()) {
				totalColumns += ts.getColumns().size();
			}
			
			UsedColumnExtractor uce = new UsedColumnExtractor(ruleSplit[1], schemas);
			int usedColumns = uce.extract().size();
			int stringEqs = uce.stringEqs;
			int dateEqs = uce.dateEqs;
			
			
			// Print out data
			output.println(ruleSplit[0] 
					+ "|" +	dict.get(TABLES)
					+ "|" +	dict.get(PREDICATES)
					+ "|" +	dict.get(JOINS)
					+ "|" +	dict.get(LEFTJ)
					+ "|" +	dict.get(RIGHTJ)
					+ "|" +	(dict.get(LEFTJ) + dict.get(RIGHTJ))
					+ "|" +	dict.get(INNERJ)
					+ "|" +	dict.get(SUBQUERIES)
					+ "|" +	dict.get(AGGFUNCTIONS)
					+ "|" +	dict.get(OTHFUNCTIONS)
					+ "|" +	(dict.get(AGGFUNCTIONS) + dict.get(OTHFUNCTIONS))
					+ "|" +	dict.get(EXISTS)
					+ "|" +	dict.get(LIKES)
					+ "|" +	dict.get(CASES)
					+ "|" +	dict.get(IFNULLS)
					+ "|" +	stringEqs
					+ "|" +	dateEqs
					+ "|" +	usedColumns
					+ "|" +	totalColumns
					+ "|" +	dict.get(WHERE)
					+ "|" +	dict.get(GROUPBY)
					+ "|" +	dict.get(HAVING)
					+ "|" +	dict.get(CDGTx)
					+ "|" +	dict.get(xGTCD)
					
					);
		}
	}
	
	List<String> collectRules(Connection conn, String scenarioPath) throws Exception {
		List<String> rulesList = new ArrayList<String>();
		
		// For each system, processNo, collect the rules to analyze
		ResultSet result = conn.createStatement().executeQuery("SELECT DISTINCT System, ProcessNo FROM EvaluationAverage WHERE Algorithm = 'evosql'");
		
		while (result.next()) {
			String system = result.getString(1);
			int processNo = result.getInt(2);
			collectProcessRules(rulesList, system, processNo, conn, scenarioPath);
		}
		
		return rulesList;
	}
	
	/**
	 * Collects the rules that have failed at least once for a system, processNo
	 */
	String pathsCollectSql = "SELECT t.PathNo\r\n"
			+ ", CASE WHEN SUM(1 - success) > 0 THEN 0 ELSE 1 END success\r\n"
			+ ", CAST(AVG(Runtime) AS UNSIGNED), CAST(AVG(Individuals) AS Unsigned)\r\n" + 
			"FROM evaluation t\r\n" + 
			"LEFT JOIN infeasibility i\r\n" + 
			"	ON t.system = i.system\r\n" + 
			"		AND t.processNo = i.processNo\r\n" + 
			"        AND t.queryNo = i.queryNo\r\n" + 
			"        AND t.pathNo = i.pathNo\r\n" + 
			"WHERE t.System = ? AND t.processNo = ? AND t.queryNo = ? AND algorithm = 'evosql'\r\n" + 
			"	AND (i.infeasible = 0 OR i.infeasible IS NULL)\r\n" + 
			"GROUP BY t.PathNo\r\n" +
			"ORDER BY t.PathNo";
	
	void collectProcessRules(List<String> rulesList, String system, int processNo, Connection conn, String scenarioPath) throws Exception {
		String processPath = scenarioPath + system + "-process" + processNo + "/";
		
		// Open the path reader
		QueryPathReader pathReader = new QueryPathReader(processPath);
		pathReader.init();
		
		// Get the query numbers
		PreparedStatement stmt = conn.prepareStatement("SELECT DISTINCT QueryNo FROM EvaluationAverage WHERE Algorithm = 'evosql' AND System = ? AND ProcessNo = ?");
		stmt.setString(1, system);
		stmt.setInt(2, processNo);
		ResultSet queriesResult = stmt.executeQuery();
		
		String systemProcessInfo  = system + "|" + processNo;
		
		while (queriesResult.next()) {
			int queryNo = queriesResult.getInt(1);
			List<String> pathList = pathReader.read(queryNo).pathList;

			PreparedStatement pathStmt = conn.prepareStatement(pathsCollectSql);
			pathStmt.setString(1, system);
			pathStmt.setInt(2, processNo);
			pathStmt.setInt(3, queryNo);
			ResultSet pathsResult = pathStmt.executeQuery();
			
			String queryInfo = systemProcessInfo + "|" + queryNo;

			while (pathsResult.next()) {
				int pathNo = pathsResult.getInt(1);
				int success = pathsResult.getInt(2);
				int runtime = pathsResult.getInt(3);
				int individuals = pathsResult.getInt(4);
				
				String pathInfo = queryInfo + "|" + pathNo + "|" + success + "|" + runtime + "|" + individuals;
				
				// Get pathNo - 1 because the list starts at index 0, while pathNo starts at index 1
				rulesList.add(pathInfo + "\n" + pathList.get(pathNo - 1));
			}
		}
	}
	
	private void loadSchema(String schemaSql) throws SQLException, IOException {
		Connection conn = DriverManager.getConnection(connectionString, user, pwd);
		
		// Delete all tables
		conn.createStatement().execute("DROP DATABASE IF EXISTS " + loadDatabase);
		conn.createStatement().execute("CREATE DATABASE " + loadDatabase);

		conn.setCatalog(loadDatabase);
		
		// Create schema
		ScriptRunner runner = new ScriptRunner(conn, false, true);
		runner.runScript(new StringReader(schemaSql));
		conn.close();

		extractor = new SchemaExtractor(connectionString, loadDatabase, user, pwd);
	}

	public static void main(String[] args) {
		try {
			PrintStream output = new PrintStream("detailedClassification.psv");
			
			new DetailedClassification(
					output,
				 "jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false"
				, "evaluationdata", "evosql", "evosql").classify();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static String getSchema(String scenario) throws IOException {
		return new String(Files.readAllBytes(Paths.get(scenario + "schema.sql")), StandardCharsets.UTF_8);
	}

}

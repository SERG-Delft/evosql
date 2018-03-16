package nl.tudelft.serg.evosql.evaluation;

import java.io.IOException;
import java.io.PrintStream;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import nl.tudelft.serg.evosql.sql.TableSchema;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.engine.jdbc.internal.BasicFormatterImpl;
import org.mockito.Mockito;

import nl.tudelft.serg.evosql.EvoSQL;
import nl.tudelft.serg.evosql.PathResult;
import nl.tudelft.serg.evosql.Result;
import nl.tudelft.serg.evosql.evaluation.tools.QueryPathReader;
import nl.tudelft.serg.evosql.path.PathExtractor;

public class Evaluation {

	private static Logger log = LogManager.getLogger(Evaluation.class);

	private List<ScenarioQuery> queries;
	private PrintStream output, coverageOutput;
	private PrintStream testDataOutput;
	private String testDataFolder;
	private QueryPathReader pathReader;
	
	private boolean inclBaseline;
	private boolean inclEvosql;
	
	private String user;
	private String pwd;
	private String connectionString;

	private String schemaSql;

	private String database;
	private String schema;
	private Map<String, TableSchema> schemas;

	public Evaluation(String connectionString, String database, String schema, String user, String pwd,
			String schemaSql, List<ScenarioQuery> queries, PrintStream output, PrintStream coverageOutput, 
			String testDataFolder, QueryPathReader pathReader,
			String algorithm
			) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
		this.schemaSql = schemaSql;
		this.queries = queries;
		this.output = output;
		this.coverageOutput = coverageOutput;
		this.testDataFolder = testDataFolder;
		this.pathReader = pathReader;
		this.inclBaseline = false;
		this.inclEvosql = false;
		checkAlgorithm(algorithm);
	}

	public Evaluation(Map<String, TableSchema> schemas, List<ScenarioQuery> queries, 
					PrintStream output, PrintStream coverageOutput, 
					String testDataFolder, QueryPathReader pathReader,
					  String algorithm) {

		this.schemas = schemas;
		this.queries = queries;
		this.output = output;
		this.coverageOutput = coverageOutput;
		this.pathReader = pathReader;
		this.testDataFolder = testDataFolder;
		checkAlgorithm(algorithm);
	}

	private void checkAlgorithm(String algorithm) {
		if (algorithm.equals("baseline") || algorithm.equals("both"))
			this.inclBaseline = true;
		if (algorithm.equals("evosql") || algorithm.equals("both"))
			this.inclEvosql = true;

	}


	public void perform() {
		perform(true, 0,0);
	}
	
	public void perform(int queryNo, int pathNo) {
		perform(false, queryNo, pathNo);
	}

	private void perform(boolean everything, int queryNo, int pathNo) {
		List<String> paths;
		try {
			if(!schemaIsMocked()) resetDB();
			pathReader.init();

			// Print output header lines
			output.println("Query Number|Algorithm|Path Number|Success Y/N|Runtime|Generations|Number Individual|Message|Exceptions");
			coverageOutput.println("Query Number|Algorithm|Coverage %|Query Time Passed");
			
			int internalQueryNo = 0;
			for (ScenarioQuery scenarioQuery : queries) {
				String query = scenarioQuery.getQuery();
				int scenarioQueryNo = scenarioQuery.getQueryNo();
				
				internalQueryNo++;
				
				if(!everything) {
					queryNo--;
					if (queryNo > 0) {
						continue;
					}
					if(queryNo < 0) break;
				}
				
				if (query.trim().startsWith("--")) continue;
				if (query.trim().startsWith("STOP")) break;
				
				log.info("query: " + internalQueryNo + ":" + query);
				
				// Open test data output file
				testDataOutput = new PrintStream(testDataFolder + "Q" + scenarioQueryNo + ".txt");
				
				// Get paths
				try {
					paths = pathReader.read(internalQueryNo).pathList;
					
					if(!everything && pathNo > 0) {
						paths = Arrays.asList(paths.get(pathNo - 1));
						log.debug("Path to test: " + paths.get(0));
					}
				} catch (NullPointerException e) {
					paths = null;
				}

				if (inclBaseline) {
					log.info("executing baseline");
					execute(scenarioQueryNo, internalQueryNo, query, true, paths);
				}

				if (inclEvosql) {
					log.info("executing evosql");
					execute(scenarioQueryNo, internalQueryNo, query, false, paths);
				}
			}
			if(!schemaIsMocked()) clearDB();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (testDataOutput != null)
				testDataOutput.close();
		}

	}

	private boolean schemaIsMocked() {
		return schemas != null;
	}

	private void execute(int scenarioQueryNo, int internalQueryNo, String query, boolean baseline, List<String> paths) throws SQLException, IOException {
		long start = System.currentTimeMillis();
		Result result = exerciseQuery(query, baseline, paths);
		long end = System.currentTimeMillis();
		
		// Print test data output
		testDataOutput.print("Query " + scenarioQueryNo + "\n"
				+ getBeautifulSql(query) 
				+ "\n\n");
		

		if (result != null) {
			long successes = result.qtyOfSuccesses();
			long failures = result.qtyOfFailures();
			List<PathResult> pathResults = result.getPathResults();
			PathResult pr;
			log.info("success: {}, failures: {}", successes, failures);
			for (int i = 0; i < pathResults.size(); i++) {
				pr = pathResults.get(i);
				output.println(scenarioQueryNo + "|" + (baseline?"baseline":"evosql") + "|" + pr.getPathNo() 
						+ "|" + (pr.isSuccess() ? "1" : "0") + "|" + pr.getRuntime() + "|" + pr.getGenerations() + "|"
						+ pr.getIndividualCount() + "|" + pr.getMessage() + "|" + pr.getExceptions());
				
				// Store the generated test data as text if success
				if (pr.isSuccess()) {
					String data = pr.getFixture().prettyPrint();
					testDataOutput.print("------------\nCoverage Target " + pr.getPathNo() + "\n"
							+ getBeautifulSql(pr.getPathSql())
							+ "\n\n"
							+ data
							+ "\n\n");
				}
			}
			List<Double> covPerc = result.getCoveragePercentages();
			List<Long> covTimes = result.getCoverageTimes();
			for (int i = 0; i < covPerc.size(); i++) {
				coverageOutput.println(scenarioQueryNo + "|" + (baseline?"baseline":"evosql") + "|"
						+ String.format("%.2f", covPerc.get(i)) + "|" 
						+ covTimes.get(i)
						);
			}
			
			//output.println(queryNo + "," + (baseline?"baseline":"evosql") + "," + successes + "," + failures + "," + (end - start));
		} else {
			output.println(scenarioQueryNo + "|" + (baseline?"baseline":"evosql") + "|-1|-1|" + (end - start) + "|-1|-1|-1|-1");
			coverageOutput.println(scenarioQueryNo + "|" + (baseline?"baseline":"evosql") + "|-1|-1");
		}
	}

	private void resetDB() throws SQLException, IOException {
		Connection conn = DriverManager.getConnection(connectionString, user, pwd);

		// Delete all tables
		conn.createStatement().execute("DROP DATABASE IF EXISTS " + this.database);
		conn.createStatement().execute("CREATE DATABASE " + this.database);

		conn.setCatalog(this.database);

		// Create schema
		ScriptRunner runner = new ScriptRunner(conn, false, true);
		runner.runScript(new StringReader(schemaSql));
		conn.close();
	}
	
	/** Remove the database **/
	private void clearDB() throws SQLException {
		Connection conn = DriverManager.getConnection(connectionString, user, pwd);
		conn.createStatement().execute("DROP DATABASE IF EXISTS " + this.database);
		conn.close();
	}

	private Result exerciseQuery(String query, boolean baseline, List<String> paths) {
		try {
			EvoSQL evoSQL;

			if(!schemaIsMocked()) evoSQL = new EvoSQL(connectionString, database, user, pwd, baseline);
			else evoSQL = new EvoSQL(new MockedSchemaExtractor(schemas), baseline);

			if (paths != null) {
				// Mock path extractor
				PathExtractor pe = Mockito.mock(PathExtractor.class);

				Mockito.when(pe.getPaths(Mockito.anyString())).thenReturn(paths);
				
				evoSQL.setPathExtractor(pe);
			}
			return evoSQL.execute(query);
		} catch (Exception e) {
			log.error("query {} failed", query, e);
			return null;
		}
	}
	
	private BasicFormatterImpl formatter = new BasicFormatterImpl();
	private String getBeautifulSql(String uglySql) {
		return formatter.format(uglySql);
	}
}

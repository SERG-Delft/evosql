package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.StringReader;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import nl.tudelft.serg.evosql.evaluation.Evaluation;
import nl.tudelft.serg.evosql.evaluation.Runner;
import nl.tudelft.serg.evosql.evaluation.ScriptRunner;

/**
 * This class tests a projects queries and stored paths to see if it is all executable on our instrumented database.
 *
 */
public class QueryTester {
	private static Logger log = LogManager.getLogger(QueryTester.class);

	private List<String> queries;
	private String user;
	private String pwd;
	private String connectionString;

	private String schemaSql;

	private String database;
	private String schema;
	
	QueryTester(String connectionString, String database, String schema, String user, String pwd,
			String schemaSql, List<String> queries) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
		this.schemaSql = schemaSql;
		this.queries = queries;
	}
	
	void test() throws Exception {
		// Create schema on the MySQL DB
		resetDB();
		
		// For each query
		for (String query : queries) {
			// Start the instrumented DB
			// Get the paths
			
		}
	}


	private void resetDB() throws SQLException, IOException {
		Connection conn = DriverManager.getConnection(connectionString, user, pwd);

		// Delete all tables
		conn.createStatement().execute("DROP DATABASE IF EXISTS " + this.database);
		conn.createStatement().execute("CREATE DATABASE " + this.database);
		conn.close();

		conn = DriverManager.getConnection(connectionString, user, pwd);
		
		// Create schema
		ScriptRunner runner = new ScriptRunner(conn, false, true);
		runner.runScript(new StringReader(schemaSql));
		conn.close();
	}
	
	public static void main(String[] args) {
		try {
			// Set the project to evaluate. That's the only config you need.
			String projectName = "espocrm";
			
			// You can ignore from here!
			String path = null;
			try {
				path = Paths.get(Runner.class.getResource("/").toURI()).toString() + "/../../scenarios/";
			} catch (URISyntaxException e) {
				e.printStackTrace();
			}
			
			String projectPath = path + projectName + "/";
			
			Properties props = new Properties();
			props.load(new FileInputStream(projectPath + "config.properties"));
			
			List<String> queries = getQueries(projectPath);
			String schema = getSchema(projectPath);
			
			new QueryTester(
					props.getProperty("url"), 
					props.getProperty("database"), 
					props.getProperty("schema"),
					props.getProperty("user"), 
					props.getProperty("pwd"), 
					schema, 
					queries).test();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static String getSchema(String scenario) throws IOException {
		return new String(Files.readAllBytes(Paths.get(scenario + "schema.sql")), StandardCharsets.UTF_8);
	}

	private static List<String> getQueries(String scenario) throws IOException {
		return Files.readAllLines(Paths.get(scenario + "queries.sql"), StandardCharsets.UTF_8);
	}
}

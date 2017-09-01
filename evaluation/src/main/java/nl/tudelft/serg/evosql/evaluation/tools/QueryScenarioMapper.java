package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Oops, we need to get back the information which query in a process is which query in the original scenario
 * 
 * System, Process, QueryNo -> System, QueryNo
 *
 */
public class QueryScenarioMapper {
	String outputFile;
	
	private String user;
	private String pwd;
	private String connectionString;

	private String database;
	private String schema;
	
	QueryScenarioMapper(String outputFile, String connectionString, String database, String schema, String user, String pwd) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
		this.outputFile = outputFile;
		
	}
	
	void execute() {
		String scenarioPath = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/";
		
		// Open output file
		try {
			PrintStream output = new PrintStream(scenarioPath + outputFile);
			output.println("System, ProcessNo, ProcessQueryNo, QueryNo");
			// Open connection to the evaluation db with query classifications
			Connection conn = DriverManager.getConnection(connectionString, user, pwd);
			conn.setCatalog(database);
			
			// For each folder in scenarioPath
			File scenarioDir = new File(scenarioPath);
			String[] subFiles = scenarioDir.list();
			for (String folder : subFiles) {
				// Only if it contains process
				if (!folder.contains("process"))
					continue;
				
				String system = folder.substring(0, folder.indexOf("-"));
				int processNo = Integer.parseInt(folder.substring(folder.indexOf("process") + 7));
				
				// Open queries.sql
				List<String> queries = Files.readAllLines(Paths.get(scenarioPath + folder + "/queries.sql"));				
				for (int processQueryNo = 1; processQueryNo <= queries.size(); processQueryNo++) {
					String query = queries.get(processQueryNo - 1);
					PreparedStatement stmt = conn.prepareStatement("SELECT queryNo FROM queryclassification WHERE System = ? AND queryString = ?");
					stmt.setString(1, system);
					stmt.setString(2, query);
					ResultSet result = stmt.executeQuery();
								
					if (result.next()) {
						int queryNo = result.getInt(1);
						output.println(system + "," + processNo + "," + processQueryNo + "," + queryNo);
					} else {
						System.out.println("COULD NOT FIND: (" + system + ", " + processNo + ", " + query + ")");
					}
				}
				
			}
			conn.close();
			output.close();
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new QueryScenarioMapper(
			"queryMapRQ2.csv"
			,  "jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false"
			, "evaluationdata", "public", "evosql", "evosql").execute();
	}

}

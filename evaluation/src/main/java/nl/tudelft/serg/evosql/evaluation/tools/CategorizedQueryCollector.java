package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import nl.tudelft.serg.evosql.util.random.Randomness;

public class CategorizedQueryCollector {
	static final int SYSTEMS = 4;
	static final int ESPOCRM = 0, SUITECRM = 1, ALURA = 2, ERPNEXT = 3;
	static final String[] systemFolders = {
			"espocrm",
			"suitecrm",
			"alura",
			"erpnext"
	};
	static final int QUERIES_PER_CATEGORY = 50;
	
	PrintStream[] outputs;
	String[] categories;

	private String user;
	private String pwd;
	private String connectionString;

	private String database;
	private String schema;
	
	DateTimeFormatter timeStampPattern = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

	private class SystemQuery {
		String system;
		String query;
		
		SystemQuery (String system, String query) {
			this.system = system;
			this.query = query;
		}
	}
	
	CategorizedQueryCollector(String connectionString, String database, String schema, String user, String pwd,
			String[] categories) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
		
		this.categories = categories;
	}
	
	void collect() {
		// Open the queries.sql files
		try {
			open();
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
		
		try {
			Connection conn = DriverManager.getConnection(connectionString, user, pwd);
			conn.setCatalog(database);
		
			for (String category : categories) {
				int queriesCollected = 0;
				
				// Get all system, queryNo's for this category
				ResultSet result = conn.createStatement()
					.executeQuery("SELECT system, queryNo, queryString FROM QueriesCategorized WHERE Category = '" + category + "'");
				
				String system, query;
				List<SystemQuery> queries = new ArrayList<SystemQuery>();
				
				while (result.next()) {
					system = result.getString(1);
					query = result.getString(3);
					queries.add(new SystemQuery(system, query));
				}
				
				Randomness rnd = new Randomness();
				// Randomly select up to QUERIES_PER_CATEGORY queries
				while (queries.size() > 0 && queriesCollected < QUERIES_PER_CATEGORY) {
					// Get and remove random query
					int index = rnd.nextInt(queries.size());
					SystemQuery chosen = queries.remove(index);
					
					// Write to correct queries.sql
					PrintStream output;
					switch (chosen.system.toLowerCase()) {
						case "espocrm":
							output = outputs[ESPOCRM];
							break;
						case "suitecrm":
							output = outputs[SUITECRM];
							break;
						case "alura":
							output = outputs[ALURA];
							break;
						case "erpnext":
							output = outputs[ERPNEXT];
							break;
						default:
							throw new Exception("Unknown system '" + chosen.system +"'");
					}
					output.println(chosen.query);
					
					queriesCollected++;
				}
				System.out.println("Collected " + queriesCollected + " queries for category " + category);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
	}
	
	void open() throws IOException {
		outputs = new PrintStream[SYSTEMS];
		String scenarioPath = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/";
		// For each system, 
		for (int i = 0; i < SYSTEMS; i++) {
			String path = scenarioPath + systemFolders[i] + "-sampled/";
			// rename queries.sql if it exists
			if (Files.exists(Paths.get(path + "queries.sql"))) {
				Files.move(Paths.get(path + "queries.sql")
						, Paths.get(path + "queries-" + timeStampPattern.format(java.time.LocalDateTime.now()) + ".sql")
						, StandardCopyOption.REPLACE_EXISTING);
			}
			
			// Create new queries.sql
			outputs[i] = new PrintStream(path + "queries.sql");
		}
	}

	public static void main(String[] args) {
		String[] categories = new String[] {
				"Simple",
				"Heavy Conditions",
				"Light Joins",
				"Heavy Joins",
				"Subquery"
		};
		
		CategorizedQueryCollector cqd = new CategorizedQueryCollector(
				  "jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false"
				, "evaluationdata", "public", "evosql", "evosql"
				, categories);
		
		cqd.collect();
	}

}

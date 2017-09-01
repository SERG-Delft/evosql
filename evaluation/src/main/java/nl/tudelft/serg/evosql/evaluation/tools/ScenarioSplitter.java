package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import nl.tudelft.serg.evosql.evaluation.query.QueryPathList;

/**
 * Splits the load up into PROCESSES processes.
 * Takes all queries per system, categorizes them and divides them fairly per category on the amount of processes it gets
 */
public class ScenarioSplitter {	
	static final int SYSTEMS = 4;
	static final int ESPOCRM = 0, SUITECRM = 1, ALURA = 2, ERPNEXT = 3;
	static final String[] systemFolders = {
			"espocrm",
			"suitecrm",
			"alura",
			"erpnext"
	};
	static final int[] systemProcesses = {
			2,
			10,
			10,
			10,
	};
	
	private String user;
	private String pwd;
	private String connectionString;

	private String database;
	private String schema;
	
	private final String failedRQ2query = "SELECT failed.queryNo, queryString \r\n" + 
			"FROM QueriesCategorized qc\r\n" + 
			"INNER JOIN (\r\n" + 
			"	SELECT DISTINCT t2.system, t2.queryNo\r\n" + 
			"	FROM (\r\n" + 
			"		SELECT DISTINCT System, ProcessNo, QueryNo\r\n" + 
			"		FROM evaluationAverage\r\n" + 
			"		WHERE algorithm = 'evosql' and coverage < 1 and system = ?\r\n" + 
			"	) t\r\n" + 
			"	LEFT JOIN \r\n" + 
			"		querymapping t2\r\n" + 
			"			ON t.system = t2.system AND t.processNo = t2.processNo AND t.queryNo = t2.processQueryNo\r\n" + 
			") failed\r\n" + 
			"	ON qc.system = failed.system AND qc.queryNo = failed.queryNo\r\n" + 
			"ORDER BY failed.queryNo";
	
	// To store a Query + Paths
	class QueryPaths {
		int queryNo;
		String query;
		List<String> paths;
		
		QueryPaths(int queryNo, String query, List<String> paths) {
			this.queryNo = queryNo;
			this.query = query;
			this.paths = paths;
		}
	}
	
	ScenarioSplitter(String connectionString, String database, String schema, String user, String pwd) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
	}
	
	void split() {
		String scenarioPath = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/";
		
		try {
			// Open connection to the evaluation db with query classifications
			Connection conn = DriverManager.getConnection(connectionString, user, pwd);
			conn.setCatalog(database);
			
			// Get total amount of paths
			ResultSet result = conn.createStatement()
					.executeQuery("SELECT COUNT(*) FROM QueriesCategorized");
			
			result.next();
			int totalQueries = result.getInt(1);
			
			// Loop through the systems
			for (int systemIdx = 0; systemIdx < systemFolders.length; systemIdx++) {
			//for (String system : systemFolders) {
				String system = systemFolders[systemIdx];
				String systemPath = scenarioPath + system + "/";
				// Get all Queries for this system, ordered by query no for the pathReader
				result = conn.createStatement()
					.executeQuery("SELECT queryNo, queryString FROM QueriesCategorized WHERE System = '" + system + "' ORDER BY queryNo");
				//PreparedStatement stmt = conn.prepareStatement(failedRQ2query);
				//stmt.setString(1, system);
				//result = stmt.executeQuery();
				
				// Open query path reader
				QueryPathReader pathReader = new QueryPathReader(systemPath);
				pathReader.init();
				
				Map<Integer, List<QueryPaths>> pathCountQueries = new HashMap<Integer, List<QueryPaths>>();
				String query;
				List<String> paths;
				int queryNo;
				int queryCount = 0;
				while (result.next()) {
					queryNo = result.getInt(1);
					query = result.getString(2);
					
					System.out.println(system + " " + queryNo);
					
					paths = pathReader.read(queryNo).pathList;
					queryCount++;
					
					// Add this query to the map of lists
					if (pathCountQueries.containsKey(paths.size())) {
						pathCountQueries.get(paths.size()).add(new QueryPaths(queryNo, query, paths));
					} else {
						List<QueryPaths> newList = new ArrayList<QueryPaths>();
						newList.add(new QueryPaths(queryNo, query, paths));
						pathCountQueries.put(paths.size(), newList);
					}
				}
				
				pathReader.close();

				// Put the query paths in an ordered list
				List<QueryPaths> orderedQPList = new ArrayList<QueryPaths>();
				List<Integer> pathCounts = asSortedList(pathCountQueries.keySet());
				
				for (int i : pathCounts) {
					orderedQPList.addAll(pathCountQueries.get(i));
				}
				
				// Calculate how many processes we get, at least 1
				int processes = systemProcesses[systemIdx]; //Math.max(1, (int)(PROCESSES * (queryCount * 1.0f / totalQueries)));
				PrintStream[] outputs = new PrintStream[processes];
				FileOutputStream[] fouts = new FileOutputStream[processes];
				ObjectOutputStream[] objOutputs = new ObjectOutputStream[processes];
				
				// Create the process folders
				for (int i = 0; i < processes; i++) {
					String processPath = scenarioPath + system + "-process" + i + "/";
					// Delete folder if exists
					Path dir = Paths.get(processPath);
					if (Files.exists(dir)) {
						Files.walkFileTree(dir, new SimpleFileVisitor<Path>() {
						   @Override
						   public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
						       Files.delete(file);
						       return FileVisitResult.CONTINUE;
						   }
	
						   @Override
						   public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
						       Files.delete(dir);
						       return FileVisitResult.CONTINUE;
						   }
						});
					}
					
					// Create folder
					Files.createDirectory(dir);
					
					// Copy schema.sql
					Files.copy(Paths.get(systemPath + "schema.sql"), 
							Paths.get(processPath + "schema.sql" ));
					
					// Create config.properties
					createConfig(processPath + "config.properties", system, i);
					
					// Copy serialized database schema
					Files.copy(Paths.get(systemPath + "database_schema.ser"), 
							Paths.get(processPath + "database_schema.ser"));
					
					// Open queries.sql
					outputs[i] = new PrintStream(processPath + "queries.sql");

					// Open object output
					fouts[i] = new FileOutputStream(processPath + "query_paths.ser");
					objOutputs[i] = new ObjectOutputStream(fouts[i]);
				}
				// Store query no per process
				int[] processQueryNo = new int[processes];
				// Current process index
				int processIndex = 0;
				
				// Add all query paths
				for (QueryPaths queryPaths : orderedQPList) {
					// Increment query no (first query is queryNo 1)
					processQueryNo[processIndex]++;
					
					// Write query
					outputs[processIndex].println(queryPaths.queryNo + "," + queryPaths.query);
					
					// Write serialized QueryPathList
					objOutputs[processIndex].writeObject(
							new QueryPathList(processQueryNo[processIndex], queryPaths.paths));
					
					// Move to next process
					processIndex = (processIndex + 1) % processes;
				}
				
				for (int i = 0; i < processes; i++) {
					objOutputs[i].close();
					fouts[i].close();
					outputs[i].close();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void createConfig(String configPath, String system, int process) throws IOException {
		Properties props = new Properties();
		props.setProperty("url", "jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false");
		props.setProperty("database", "evosqlevaluation" + system + process);
		props.setProperty("schema", "public");
		props.setProperty("user", "mauricio");
		props.setProperty("pwd", "mauricio");
		OutputStream out = new FileOutputStream(configPath);
		props.store(out, "Config for system '" + system + "', process " + process);
	}
	
	public static void main(String[] args) {
		ScenarioSplitter sp = new ScenarioSplitter(
				  "jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false"
				, "evaluationdata", "public", "evosql", "evosql");
		
		sp.split();
	}
	

	private static
	<T extends Comparable<? super T>> List<T> asSortedList(Collection<T> c) {
	  List<T> list = new ArrayList<T>(c);
	  Collections.sort(list);
	  return list;
	}
}

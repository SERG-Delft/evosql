package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.IOException;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;
import nl.tudelft.serg.evosql.util.random.Randomness;

/**
 * Takes a scenario's queries and filter equivalent queries
 * Queries are equivalent if their structure is exactly the same, and only constants (Strings, Dates, Numbers etc) are different.
 *
 */
public class EquivalentQueryFilter {
	private List<String> queries;
	private PrintStream output;
	private Map<String, List<String>> queryMap;
	private Randomness random;
	
	EquivalentQueryFilter(List<String> queries,
			PrintStream output) {
		this.queries = queries;
		this.output = output;
		random = new Randomness();
		queryMap = new HashMap<String, List<String>>();
	}
	
	void filter() {
		// Strip each query and add them to the map
		for (String query : queries) {
			if (query.trim().startsWith("--")) continue;
			if (query.trim().startsWith("STOP")) break;
			
			String strippedQuery = new QueryStripper(query).getStrippedSql();
			
			// Add the query to the map
			if (queryMap.containsKey(strippedQuery)) {
				queryMap.get(strippedQuery).add(query);
			} else {
				System.out.println(strippedQuery);
				List<String> queryList = new ArrayList<String>();
				queryList.add(query);
				queryMap.put(strippedQuery, queryList);
			}
		}
		
		// For each query equivalent add one random query
		for (List<String> queryList : queryMap.values()) {
			int index = random.nextInt(queryList.size());
			
			output.println(queryList.get(index));
		}
	}
	
	public static void main(String[] args) throws IOException {
		String projectName = "alura";
		
		String path = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/";
		
		String projectPath = path + projectName + "/";
		
		List<String> queries = getQueries(projectPath + "all_queries.sql");
		
		PrintStream output = new PrintStream(projectPath + "filtered_queries.sql");
		
		EquivalentQueryFilter eqf = new EquivalentQueryFilter(queries, output);
		
		eqf.filter();
	}

	private static List<String> getQueries(String path) throws IOException {
		return Files.readAllLines(Paths.get(path), StandardCharsets.UTF_8);
	}
}

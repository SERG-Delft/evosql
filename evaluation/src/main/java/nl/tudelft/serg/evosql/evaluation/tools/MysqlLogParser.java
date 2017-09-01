package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import nl.tudelft.serg.evosql.evaluation.Runner;

public class MysqlLogParser {
	Set<String> queries;
	String currentQuery;
	boolean isSelect;
	String fileLocation;
	
	public MysqlLogParser(String fileLocation) {
		this.fileLocation = fileLocation;
		isSelect = false;
		currentQuery = null;
	}
	
	private void handleNewLine(String line) {
		if (isSelect && currentQuery != null) {
			queries.add(currentQuery.trim().replaceAll("\\s+", " "));
		}
		isSelect = false;
		currentQuery = "";
		
		if (line.isEmpty()) return;
		
		// Read away the timestamp
		line = line.substring(line.indexOf('\t') + 1); 
		
		// Get the log code
		String logCode = line.substring(0, line.indexOf('\t'));
		line = line.substring(line.indexOf('\t') + 1); 
		
		if (logCode.contains("Query") && line.startsWith("SELECT")) {
			isSelect = true;
			currentQuery = line;
		}
		
	}
	
	private void handleExtendedLine(String line) {
		if (currentQuery == null)
			throw new RuntimeException("Received line '" + line + "' as extension with no current line.");
		
		currentQuery += line;
	}
	
	public Set<String> parse() throws IOException {
		this.queries = new HashSet<String>();
		// Open a filestream
		BufferedReader br = new BufferedReader(new FileReader(fileLocation));  
		String line; 
		
		// Go through the lines
		int i = 0;
		while ((line = br.readLine()) != null) {
			System.out.println(i++);
			if (line.isEmpty()) {
				continue;
			} else if (line.startsWith("2017")) { // Start of a new line
				handleNewLine(line);
			} else {
				handleExtendedLine(line);
			}
		}
		// So that last line is handled
		handleNewLine("");
		
		return queries;
	}
	
	/**
	 * Assumes queries have no new lines in them.
	 * @param path
	 * @param queries
	 * @throws IOException
	 */
	public static void storeQueries(String path, Set<String> queries) throws IOException {
		FileWriter fw = new FileWriter(path);
		
		for (String query : queries) {
			fw.write(query + "\n");
		}
		
		fw.close();
	}

	public static void main(String[] args) {
		try {// You can ignore from here!
			String path = Paths.get(MysqlLogParser.class.getResource("/").toURI()).toString() + "/../../scenarios/espocrm/";
			Set<String> queries = new MysqlLogParser(path + "sql.log").parse();
			Set<String> infschemaless_queries = new HashSet<String>();
			
			for (String str : queries) {
				System.out.println("\nQ: " + str + "\n");
			}
			System.out.println(queries.size());
			int cnt = 0;
			for (String str : queries) {
				if (!str.contains("information_schema")) {
					cnt++;
					infschemaless_queries.add(str);
				}
			}
			System.out.println(cnt);
			storeQueries(path + "queries.sql", infschemaless_queries);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

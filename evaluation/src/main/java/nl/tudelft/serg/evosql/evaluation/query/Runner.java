package nl.tudelft.serg.evosql.evaluation.query;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintStream;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;


/**
 * Get all queries and classify them using the classifier
 *
 */
public class Runner {
	public static void main(String[] args) throws IOException, ClassNotFoundException, SQLException {
		// Set the project to evaluate. That's the only config you need.
		String projectName = "alura";
		boolean useSQLFpc = true;
		
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
		
		PrintStream output = new PrintStream(projectPath + "query_classifications.csv");
		// Get object output
		FileOutputStream fout = new FileOutputStream(projectPath + "query_paths.ser");
		ObjectOutputStream objOut = new ObjectOutputStream(fout);
		
		Classification c = new Classification(
				props.getProperty("url"), 
				props.getProperty("database"), 
				props.getProperty("schema"),
				props.getProperty("user"), 
				props.getProperty("pwd"), 
				schema, 
				queries, 
				output,
				objOut);
		
		c.perform(useSQLFpc);

		objOut.close();
		fout.close();
		output.close();
	}
	

	
	private static String getSchema(String scenario) throws IOException {
		return new String(Files.readAllBytes(Paths.get(scenario + "schema.sql")), StandardCharsets.UTF_8);
	}

	private static List<String> getQueries(String scenario) throws IOException {
		return Files.readAllLines(Paths.get(scenario + "queries.sql"), StandardCharsets.UTF_8);
	}
}

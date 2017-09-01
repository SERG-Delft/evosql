package nl.tudelft.serg.evosql.evaluation;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.mysql.cj.core.util.StringUtils;

import nl.tudelft.serg.evosql.evaluation.tools.QueryPathReader;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class Runner {

	public static void main(String[] args) throws IOException, ClassNotFoundException {
		
		System.out.println("Evaluation for ICSE 2018");
		
		// Set the project to evaluate. That's the only config you need.
		String projectName, algorithm;
		if (args.length == 2) {
			projectName = args[0];
			algorithm = args[1];
		} else {
			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			System.out.print("Which project do you wish to evaluate?: ");
			projectName = br.readLine().trim();
			System.out.print("Which algorithm (evosql/baseline/both): ");
			algorithm = br.readLine().trim();
		}
		
		evaluateProject(projectName, algorithm);
	}
	
	public static void evaluateProject(String projectName, String algorithm) throws IOException, ClassNotFoundException {
		// Either find the project's path, or you are already in the project's path
		Path basePath = Paths.get(System.getProperty("user.dir"));
		String projectPath;
		if (basePath.getName(basePath.getNameCount() - 2).toString().contains("scenarios")) {
			projectPath = basePath.toString() + "/";
		} else {
			String path = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/";
			projectPath = path + projectName + "/";
		}
		
		Properties props = new Properties();
		props.load(new FileInputStream(projectPath + "config.properties"));
		
		List<ScenarioQuery> queries = getQueries(projectPath);
		String schema = getSchema(projectPath);
		
		String resultsPath = projectPath + "results-" + new SimpleDateFormat("yyyyMMdd-HHmmss").format(new java.util.Date()) + "/";

		String testDataFolder = resultsPath + "testdata/";
		Files.createDirectories(Paths.get(testDataFolder));
		
		PrintStream output = new PrintStream(resultsPath + "results.csv");
		PrintStream coverageOutput = new PrintStream(resultsPath + "coverageResults.csv");
		
		QueryPathReader pathReader = new QueryPathReader(projectPath);

		Evaluation eval = null;

		Map<String, TableSchema> schemas = getMockedSchemas(projectPath);

		if(schemas == null) {
			eval = new Evaluation(
					props.getProperty("url"),
					props.getProperty("database"),
					props.getProperty("schema"),
					props.getProperty("user"),
					props.getProperty("pwd"),
					schema,
					queries,
					output,
					coverageOutput,
					testDataFolder,
					pathReader,
					algorithm);
		} else {
			eval = new Evaluation(schemas, queries, output, coverageOutput, testDataFolder, pathReader, algorithm);
		}

//		eval.perform(1016, 19);
		eval.perform();

		coverageOutput.close();
		output.close();
		
		// Remove mem directory if exists
		Path directory = Paths.get(projectPath + "mem");
		if (Files.exists(directory)) {
			Files.walkFileTree(directory, new SimpleFileVisitor<Path>() {
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
	}

	@SuppressWarnings("unchecked")
	private static Map<String,TableSchema> getMockedSchemas(String projectPath) {
		try {
			File file = Paths.get(projectPath + "database_schema.ser").toFile();
			if(!file.exists()) {
				System.out.println("mocked schema not found!");
				return null;
			}

			FileInputStream fileIn = new FileInputStream(file);
			ObjectInputStream in = new ObjectInputStream(fileIn);
			Map<String,TableSchema> schemas = (Map<String,TableSchema>) in.readObject();
			in.close();
			fileIn.close();

			return schemas;
		}catch(IOException i) {
			i.printStackTrace();
			System.exit(-1);
			return null;
		}catch(ClassNotFoundException c) {
			c.printStackTrace();
			System.exit(-1);
			return null;
		}

	}

	private static String getSchema(String scenario) throws IOException {
		return new String(Files.readAllBytes(Paths.get(scenario + "schema.sql")), StandardCharsets.UTF_8);
	}

	private static List<ScenarioQuery> getQueries(String scenario) throws IOException {
		List<ScenarioQuery> result = new ArrayList<ScenarioQuery>();
		List<String> lines = Files.readAllLines(Paths.get(scenario + "queries.sql"), StandardCharsets.UTF_8);
		
		int queryNo = 0;
		ScenarioQuery sq;
		for (String line : lines) {
			queryNo++;
			String[] parts = line.split(",", 2);
			if (parts.length == 2 && StringUtils.isStrictlyNumeric(parts[0])) { // If line as: "<nr>,<query>"
				sq = new ScenarioQuery(Integer.parseInt(parts[0]), parts[1]);
			} else { // If line as: "<query>"
				sq = new ScenarioQuery(queryNo, line);
			}
			result.add(sq);
		}
		
		return result;
	}
}

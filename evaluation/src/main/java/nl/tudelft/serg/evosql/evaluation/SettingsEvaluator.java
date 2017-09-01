package nl.tudelft.serg.evosql.evaluation;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.mysql.cj.core.util.StringUtils;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.EvoSQLConfiguration.MutationType;
import nl.tudelft.serg.evosql.evaluation.tools.QueryPathReader;

public class SettingsEvaluator {

	public static void main(String[] args) throws Exception {
		String projectName = "settings";
		
		String path = Paths.get(System.getProperty("user.dir")).toString() + "/scenarios/";
		
		String projectPath = path + projectName + "/";
		
		Properties props = new Properties();
		props.load(new FileInputStream(projectPath + "config.properties"));
		
		List<ScenarioQuery> queries = getQueries(projectPath);
		String schema = getSchema(projectPath);
		
		QueryPathReader pathReader = new QueryPathReader(projectPath);
		
		// Get all settings files
		List<String> settingList = new ArrayList<String>();
		File[] settingFiles = new File(projectPath + "settings").listFiles();
		for (File f : settingFiles) {
			settingList.add(f.getName());
		}
		
		for (String settingFile : settingList) {
			PrintStream output = new PrintStream(projectPath + "results/" + settingFile.replace(".properties", "") + "_results.csv");
			PrintStream coverageOutput = new PrintStream(projectPath + "results/" + settingFile.replace(".properties", "") + "_coverageResults.csv");
			String testDataFolder = projectPath + "results/" + settingFile.replace(".properties", "") + "_testdata/";
			
			// Load Settings
			Properties settings = new Properties();
			settings.load(new FileInputStream(projectPath + "settings/" + settingFile));
			
			loadSettings(settings);
			
			new Evaluation(
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
					"evosql").perform();
			
			output.close();
		}
	}

	private static void loadSettings(Properties settings) {
		EvoSQLConfiguration.POPULATION_SIZE = Integer.parseInt(settings.getProperty("population_size"));
		EvoSQLConfiguration.MIN_ROW_QTY = Integer.parseInt(settings.getProperty("min_row_qty"));
		EvoSQLConfiguration.MAX_ROW_QTY = Integer.parseInt(settings.getProperty("max_row_qty"));
		
		EvoSQLConfiguration.NULL_PROBABIBLITY = Double.parseDouble(settings.getProperty("null_probability"));
		EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY = Double.parseDouble(settings.getProperty("mutate_null_probability"));
		EvoSQLConfiguration.SEED_INSERT_PROBABIBLITY = Double.parseDouble(settings.getProperty("seed_insert_probability"));
		EvoSQLConfiguration.SEED_CHANGE_PROBABIBLITY = Double.parseDouble(settings.getProperty("seed_change_probability"));
		EvoSQLConfiguration.P_CROSSOVER = Double.parseDouble(settings.getProperty("crossover_probability"));
		EvoSQLConfiguration.P_MUTATION = Double.parseDouble(settings.getProperty("mutation_probability"));
		
		String mutationType = settings.getProperty("mutation_type");
		if (mutationType.equals("LENGTH"))
			EvoSQLConfiguration.MUTATION = MutationType.LENGTH;
		else
			EvoSQLConfiguration.MUTATION = MutationType.PERCENTAGE;
			
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

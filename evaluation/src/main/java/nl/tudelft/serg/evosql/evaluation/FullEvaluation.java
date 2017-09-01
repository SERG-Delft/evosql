package nl.tudelft.serg.evosql.evaluation;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Properties;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.EvoSQLConfiguration.MutationType;

public class FullEvaluation {

	public static void main(String[] args) throws IOException, ClassNotFoundException {
		// Load Settings 6
		Properties settings = new Properties();
		settings.load(new FileInputStream(Paths.get(System.getProperty("user.dir")).toString() 
				+ "/scenarios/settings/settings/settings6.properties"));
		loadSettings(settings);
		
		// Evaluate the projects
		Runner.evaluateProject("espocrm", "evosql");
		System.gc();
		Runner.evaluateProject("suitecrm", "evosql");
		System.gc();
		Runner.evaluateProject("alura", "evosql");
		System.gc();
		Runner.evaluateProject("erpnext", "evosql");
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
}

package nl.tudelft.serg.evosql.metaheuristics;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureRowFactory;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.metaheuristics.operators.*;
import nl.tudelft.serg.evosql.querydepth.QueryDepthExtractor;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;
import nl.tudelft.serg.evosql.util.random.Randomness;

import java.sql.SQLException;
import java.util.*;

public class GAApproach extends Approach {
	private boolean isInitialized;

	/** Current Population **/
	private List<Fixture> population;

	/** Selection operator **/
	private TournamentSelection selection = new TournamentSelection();

	/** Row Factory **/
	private FixtureRowFactory rowFactory = new FixtureRowFactory();
	
	/** Mutation operator **/
	private FixtureMutation mutation;
	
	/** Comparator **/
	private FixtureComparator fc = new FixtureComparator();

	/** Crossover operator **/
	private FixtureCrossover crossover = new FixtureCrossover(new Randomness());

	/** Seeds store **/
	private Seeds seeds;

	/** QueryDepthExtractor **/
	private QueryDepthExtractor depthExtractor;

	private int populationSize;
	private int maxGenerations;
	private boolean skipInitialGeneration;

	public GAApproach(List<Fixture> population, Map<String, TableSchema> pTableSchemas, String pPathToBeTested, Seeds seeds){
		this(population, pTableSchemas, pPathToBeTested, seeds, Integer.MAX_VALUE, false);
	}

	public GAApproach(List<Fixture> population, Map<String, TableSchema> pTableSchemas, String pPathToBeTested, Seeds seeds, int maxGenerations, boolean skipInitialGeneration){
		super(pTableSchemas, pPathToBeTested);

		this.depthExtractor = new QueryDepthExtractor(new SqlSecurer(pPathToBeTested).getSecureSql());
		this.seeds = seeds;

		this.mutation = new FixtureMutation(rowFactory, seeds);
		this.population = population;
		this.maxGenerations = maxGenerations;
		this.skipInitialGeneration = skipInitialGeneration;
		this.isInitialized = false;

		// if it's baseline, there will be only a single generation, and population will be larger
		populationSize = EvoSQLConfiguration.POPULATION_SIZE; // * (baseline ? 2 : 1);

	}

	private void initialize() throws SQLException {
		//1. Initial population
		if(!skipInitialGeneration)
			generateInitialPopulation();
		
		calculateFitness(population);
		
		// 2. sort population by Fitness Function
		Collections.sort(population, fc);
		log.debug("Best Fitness Function in the generated population = {}, {}", population.get(0).getFitness(), population.get((0)));
		
		isInitialized = true;
	}

	@Override
	public Fixture execute(long pathTime) throws SQLException {
		long startTime = System.currentTimeMillis();

		// Initialize first
		if (!isInitialized) {
			initialize();
		}
		//3. Main Loop
		while (population.get(0).getFitness().getDistance() > 0
				&& System.currentTimeMillis() - startTime < pathTime
				&& generations < maxGenerations
		){
			List<Fixture> offsprings = new ArrayList<Fixture>(populationSize);
			for (int index=0; index < populationSize; index += 2){
				// Get two parents through selection operator
				Fixture parent1 = selection.getFixture(population);
				Fixture parent2 = selection.getFixture(population);

				Fixture offspring1;
				Fixture offspring2;
				boolean o1Changed = false, o2Changed = false;
				
				// Use the crossover operator
			    if (crossover.canBeDone(parent1, parent2) && random.nextDouble() < EvoSQLConfiguration.P_CROSSOVER) {

					List<Fixture> generatedOffsprings = this.crossover.crossover(parent1, parent2);
					offspring1 = generatedOffsprings.get(0);
					offspring2 = generatedOffsprings.get(1);

			        //log.debug("Crossover applied");
			        o1Changed = true;
			        o2Changed = true;
			    } else {
					offspring1 = parent1.copy();
					offspring2 = parent2.copy();
				}
			    
			    // Mutate
			    if(mutation.mutate(offspring1))
			    	o1Changed = true;

			    if(mutation.mutate(offspring2))
			    	o2Changed = true;
			    
			    // Calculate fitness if needed
			    if (o1Changed) {
			    	calculateFitness(offspring1);
					//log.debug("Fitness = {} {}", offspring1.getFitness(), offspring1.getFitness().getFitnessValue());
			    }
			    if (o2Changed) {
			    	calculateFitness(offspring2);
					//log.debug("Fitness = {} {}", offspring2.getFitness(), offspring2.getFitness().getFitnessValue());
			    }
			    
			    // add offsprings to the offspring_population
			    offsprings.add(offspring1);
			    offsprings.add(offspring2);
			}
			
			// Combine original and offspring population
			List<Fixture> union = new ArrayList<Fixture>();
			union.addAll(population);
			union.addAll(offsprings);

			// Order by fitness
			Collections.sort(union, fc);

			// Set the new population as the POPULATION_SIZE best
			population = union.subList(0, populationSize);

			log.debug("Generation = {}, best Fitness Function = {}", generations, population.get(0).getFitness());// + " for fixture: " + population.get(0));
			generations++;
		}
		/*
		if (population.get(0).getFitness().getDistance() == 0
				&& !hasOutput(population.get(0))) {
			// This is bad
			calculateFitness(population.get(0));
		}
		*/
		log.info("Total generations: {}", generations);
		log.info("Best Fitness Function = {}", population.get(0).getFitness());
		return minimize(population.get(0));

	}

	private void generateInitialPopulation() {
		int currentPopulationSize = 0;
		Random rand = new Random();
		List<Fixture> newPopulation = new ArrayList<>();
		// If we have a previous population fed by EvoSQL, clone some of these
		if (population != null && !population.isEmpty()) {
			// Order by fitness (the previous population should have fitness values)
			Collections.sort(population, new FixtureComparator());
			
			// Select random individuals
			boolean includesSolution = false;
			for (int i = 0; i < population.size(); i++){
				Fixture fixture = population.get(i);
				if ((fixture.getFitness() != null && fixture.getFitness().getDistance() == 0 && !includesSolution) || // Always add one solution if there is one
						rand.nextDouble() <= EvoSQLConfiguration.P_CLONE_POPULATION) {
					if (fixture.getFitness() != null && fixture.getFitness().getDistance() == 0) includesSolution = true;
					// Get a copy of this fixture that matches the current path
					Fixture newFixture = fixture.copy();
					newFixture.setFitness(null); // make sure fitness is gone
					fixFixture(newFixture); // make sure all tables are present in the individual, and no more
					newPopulation.add(newFixture);
					currentPopulationSize++;
				}
			}
		}

		log.debug("Generating random initial population...");

		for(; currentPopulationSize < populationSize; currentPopulationSize++) {
			List<FixtureTable> tables = new ArrayList<FixtureTable>();
			for (TableSchema tableSchema : tableSchemas.values()) {
				tables.add(createFixtureTable(tableSchema, tables));
			}

			Fixture fixture = new Fixture(tables);
			log.debug("Fixture created: {}", fixture);
			newPopulation.add(fixture);
		}
		log.debug("Generated random population with {} fixtures", newPopulation.size());

		// Store the new population in the list given by EvoSQL
		population.clear();
		population.addAll(newPopulation);
	}

	public void calculateFitness(List<Fixture> solutions) throws SQLException{
		for(Fixture fixture : population) {
			calculateFitness(fixture);
		}
	}
	
	public void calculateFitness(Fixture fixture) throws SQLException {
		individualCount++;
		
		// Truncate tables in Instrumented DB
		for (TableSchema tableSchema : tableSchemas.values()) {
			genetic.Instrumenter.execute(tableSchema.getTruncateSQL());
		}
		
		// Insert population
		for (String sqlStatement : fixture.getInsertStatements()) {
			genetic.Instrumenter.execute(sqlStatement);
		}
		
		// Start instrumenter
		genetic.Instrumenter.startInstrumenting();
		
		// Execute the path
		genetic.Instrumenter.execute(pathToTest);
		
		FixtureFitness ff = new FixtureFitness(genetic.Instrumenter.getFitness(), depthExtractor);
		fixture.setFitness(ff);
		
		// Store exceptions
		if (!genetic.Instrumenter.getException().isEmpty() && !exceptions.contains(genetic.Instrumenter.getException())) {
			exceptions += ", " + genetic.Instrumenter.getException();
		}
		
		// Stop instrumenter
		genetic.Instrumenter.stopInstrumenting();
	}
	
	private FixtureTable createFixtureTable(TableSchema tableSchema, List<FixtureTable> tables) {
		List<FixtureRow> rows = new ArrayList<FixtureRow>();
		int numberOfRows = EvoSQLConfiguration.MIN_ROW_QTY;
		if (EvoSQLConfiguration.MAX_ROW_QTY > EvoSQLConfiguration.MIN_ROW_QTY)
			numberOfRows += random.nextInt(EvoSQLConfiguration.MAX_ROW_QTY - EvoSQLConfiguration.MIN_ROW_QTY);
		for(int j=0; j < numberOfRows; j++) {
			FixtureRow row = rowFactory.create(tableSchema, tables, seeds);
			rows.add(row);
			//log.debug("Row created: {}", row);
		}
		return new FixtureTable(tableSchema, rows);
	}
	
	// Takes a fixture and removes all tables that are not in the current problem
	// Adds new FixtureTables for tables that are in the problem but not in the given fixture
	private void fixFixture(Fixture fixture) {
		List<FixtureTable> tables = fixture.getTables();
		int tableCount = tables.size();
		
		for (int i = 0; i < tables.size(); i++) {
			// Remove table if not in tableSchemas
			if (!tableSchemas.containsKey(tables.get(i).getName())) {
				fixture.removeTable(i);
				tableCount--;
			}
		}
		
		// If we have too few tables now, we need to add the missing ones
		if (tableCount < tableSchemas.size()) {
			for (TableSchema ts : tableSchemas.values()) {
				boolean present = false;
				for (FixtureTable ft : tables) {
					if (ft.getSchema().equals(ts)) {
						present = true;
						break;
					}
				}
				// Create a new fixture table if this schema is not present
				if (!present) {
					fixture.addTable(createFixtureTable(ts, tables));
				}
			}
		}
	}
}

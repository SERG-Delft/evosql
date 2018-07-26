package nl.tudelft.serg.evosql.metaheuristics.operators;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureRowFactory;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.fixture.type.DBType;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class FixtureMutation {

	private static Logger log = LogManager.getLogger(FixtureMutation.class);
	
	public static Randomness random = new Randomness();
	private FixtureRowFactory rowFactory;
	private Seeds seeds;

	public FixtureMutation(FixtureRowFactory rowFactory, Seeds seeds) {
		this.rowFactory = rowFactory;
		this.seeds = seeds;	
	}

	/**
	 * Mutate without knowledge of conditions
	 * @param solution
	 */
	public void mutate(Fixture solution) {
		double mutation_prob = 0.0;
		boolean didMutate = false;

		if (EvoSQLConfiguration.MUTATION == EvoSQLConfiguration.MutationType.LENGTH)
			// we mutate only one Table (on average)
			mutation_prob = 1d / solution.getTables().size();
		else if (EvoSQLConfiguration.MUTATION == EvoSQLConfiguration.MutationType.PERCENTAGE)
			// otherwise, the number of Table to mutate is given by EvoSQLConfiguration.P_MUTATION
			mutation_prob = EvoSQLConfiguration.P_MUTATION;

		for (FixtureTable table : solution.getTables()) {
			if (random.nextDouble() < mutation_prob) {
				// 1. Delete a row (leave at least 1 row in the table)
				if (table.getRowCount() > 1 && table.getRowCount() > EvoSQLConfiguration.MIN_ROW_QTY 
						&& random.nextDouble() <= EvoSQLConfiguration.P_DELETE_PROBABILITY) {
					table.remove(random.nextInt(table.getRowCount()));
					didMutate = true;
				}
				// 2. Duplicate an existing row (up to max rows)
				if (table.getRowCount() < EvoSQLConfiguration.MAX_ROW_QTY 
						&& random.nextDouble() <= EvoSQLConfiguration.P_INSERT_DUPLICATE_PROBABILITY) {
					table.duplicateRow(random.nextInt(table.getRowCount()));
					didMutate = true;
				}		
				// 3. Change a row (one of the remaining one, only if it has mutable columns)
				if (table.getSchema().hasUsedColumns()) {
					double rowMutationProbability = EvoSQLConfiguration.MUTATION == EvoSQLConfiguration.MutationType.LENGTH ?
							1d / table.getRowCount() : // we mutate only one row (on average)
							EvoSQLConfiguration.P_CHANGE_PROBABILITY;

					for (FixtureRow row : table.getRows()) {
						if (!EvoSQLConfiguration.MUTATION_PROBABILITY_FOR_EACH_ROW || (EvoSQLConfiguration.MUTATION_PROBABILITY_FOR_EACH_ROW && random.nextDouble() <= rowMutationProbability)) {
							if (mutateRow(row, solution))
								didMutate = true;
						}
					}
				}
				// 4. We add a new row
				if (table.getRowCount() < EvoSQLConfiguration.MAX_ROW_QTY 
						&& random.nextDouble() <= EvoSQLConfiguration.P_INSERT_PROBABILITY) {
					table.addRow(rowFactory.create(table.getSchema(), solution.getTables(), seeds));
					didMutate = true;
				}	
			}
		}
		
		if(didMutate)
			solution.setChanged(true);
	}

	public boolean mutateRow(FixtureRow row, Fixture solution) {
		double probability = 0.0;
		boolean didMutate = false;
		
		if (EvoSQLConfiguration.MUTATION == EvoSQLConfiguration.MutationType.LENGTH)
			// we mutate only one field of the row (on average)
			probability = 1d / row.getTableSchema().getUsedColumnCount();
		else if (EvoSQLConfiguration.MUTATION == EvoSQLConfiguration.MutationType.PERCENTAGE)
			// otherwise, the number of fields to mutate is given by EvoSQLConfiguration.P_MUTATION
			probability = EvoSQLConfiguration.P_MUTATION;

		for (Map.Entry<String, String> entry : row.getValues().entrySet()) {
			String columnName = entry.getKey();
			ColumnSchema cs = row.getColumnSchema(columnName);

			if (cs.isUsedColumn() && random.nextDouble() <= probability){
				String currentValue = entry.getValue();
				DBType type = cs.getType();
				boolean nullable = cs.isNullable();
				
				if (seeds != null && (type.hasSeed(seeds) || cs.getSeedSourceColumns() != null) 
						&& random.nextDouble() <= EvoSQLConfiguration.SEED_CHANGE_PROBABIBLITY) {
					// Dynamic seeding
					if (EvoSQLConfiguration.USE_DYNAMIC_JOIN_SEEDING && cs.getSeedSourceColumns() != null) {
						for (ColumnSchema seedCS : cs.getSeedSourceColumns()) {
							// Get FixtureTable
							FixtureTable ft = solution.getTable(seedCS.getTable());
							seeds.addToTemp(ft.getColumnValues(seedCS));
						}
					}
					
					// Only use seeded value if not null
					String seedValue = type.generateFromSeed(seeds);
					seeds.unsetTemp();
					if (seedValue != null) {
						log.debug("seeding " + seedValue + " to " + columnName);
						row.set(columnName, seedValue);
						didMutate = true;
						continue;
					}
				}

				row.set(columnName, type.mutate(currentValue, nullable));
				didMutate = true;
			}
		}
		
		return didMutate;
	}
}

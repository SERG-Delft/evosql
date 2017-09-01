package nl.tudelft.serg.evosql.metaheuristics.operators;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.util.random.Randomness;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FixtureCrossover {
	private Randomness random;

	public FixtureCrossover(Randomness random) {
		this.random = random;
	}

	/**
	 * Performs scattered crossover
	 * @return a list with the two new offsprings
	 */
	public List<Fixture> crossover(Fixture parent1, Fixture parent2) {

		assert canBeDone(parent1, parent2) : "crossover can only happen if both parents have more than a single table";

		List<FixtureTable> offspring1Tables = new ArrayList<>();
		List<FixtureTable> offspring2Tables = new ArrayList<>();

		// probability to send it to left or right is also random
		double probability = random.nextDouble();

		for(FixtureTable tableFromP1 : parent1.getTables()) {
			// i do not trust on the unordered list, so that's why i' using table name and not indexes
			FixtureTable tableFromP2 = parent2.getTable(tableFromP1.getName());

			boolean left = random.nextDouble() < probability;
			offspring1Tables.add(left ? tableFromP1.copy() : tableFromP2.copy());
			offspring2Tables.add(left ? tableFromP2.copy() : tableFromP1.copy());
		}

		return Arrays.asList(
				new Fixture(offspring1Tables),
				new Fixture(offspring2Tables));

	}

	public boolean canBeDone(Fixture parent1, Fixture parent2) {
		boolean parent1HasASingleTable = parent1.getTables().size() == 1;
		boolean parent2HasASingleTable = parent2.getTables().size() == 1;

		return !(parent1HasASingleTable || parent2HasASingleTable);

	}
}

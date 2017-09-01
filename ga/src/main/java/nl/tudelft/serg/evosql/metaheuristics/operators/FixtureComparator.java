package nl.tudelft.serg.evosql.metaheuristics.operators;

import java.util.Comparator;

import genetic.QueryLevelData;
import nl.tudelft.serg.evosql.fixture.Fixture;

public class FixtureComparator implements Comparator<Fixture>{

	@Override
	/**
	 * Important to note that smaller is better.
	 */
	public int compare(Fixture o1, Fixture o2) {		
		FixtureFitness f1 = o1.getFitness();
		FixtureFitness f2 = o2.getFitness();
		
		// Check nulls
		if (f1 == null && f2 == null)
			return 0;
		else if (f1 == null)
			return 1;
		else if (f2 == null)
			return -1;
		
		// Compare max query levels, higher is better
		if (f1.getMaxQueryLevel() < f2.getMaxQueryLevel())
			return 1;
		else if (f1.getMaxQueryLevel() > f2.getMaxQueryLevel())
			return -1;
		
		// From max query level downwards check for differences
		for (int queryLevel = f1.getMaxQueryLevel(); queryLevel >= 0; queryLevel--) {
			QueryLevelData qld1 = f1.getQueryLevelData(queryLevel);
			QueryLevelData qld2 = f2.getQueryLevelData(queryLevel);

			int comp = qld1.compare(qld1, qld2);
			if (comp != 0)
				return comp;
		}
		
		return 0;

	}
}

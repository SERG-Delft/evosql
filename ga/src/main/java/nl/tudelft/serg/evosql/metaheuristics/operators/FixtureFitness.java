package nl.tudelft.serg.evosql.metaheuristics.operators;

import genetic.QueryLevelData;
import nl.tudelft.serg.evosql.fixture.Fixture;

/**
 * Fitness of one fixture
 *
 */
public class FixtureFitness {
	
	QueryLevelData lastLevelData;
	
	public FixtureFitness(QueryLevelData lastLevelData) {
		this.lastLevelData = lastLevelData;
	}

	public QueryLevelData getQueryLevelData(int queryLevel) {
		if (queryLevel > lastLevelData.getQueryLevel() || queryLevel < 0)
			throw new IndexOutOfBoundsException();
		
		QueryLevelData qld = lastLevelData;
		while (qld != null && qld.getQueryLevel() > queryLevel) {
			qld = qld.getPrevLevelData();
		}

		return qld;
	}
	
	public int getMaxQueryLevel() {
		return lastLevelData.getQueryLevel();
	}

	public int getMaxRangeVariableIndex(int i) {
		if (i > lastLevelData.getQueryLevel() || i < 0)
			throw new IndexOutOfBoundsException();
		
		QueryLevelData qld = lastLevelData;
		while (qld != null && qld.getQueryLevel() > i) {
			qld = qld.getPrevLevelData();
		}
		if (qld == null)
			return 0;
		return qld.getMaxRangeVariableIndex();
	}

	public double getDistance(int i) {
		if (i > lastLevelData.getQueryLevel() || i < 0)
			throw new IndexOutOfBoundsException();
		
		QueryLevelData qld = lastLevelData;
		while (qld != null && qld.getQueryLevel() > i) {
			qld = qld.getPrevLevelData();
		}
		if (qld == null)
			return 0;
		return qld.getDistance();
	}
	
	// Returns the last distance, which can be checked to see if this is a solution
	public double getDistance() {
		if (lastLevelData == null)
			return 0;
		
		return lastLevelData.getDistance();
	}
	
	public FixtureFitness copy() {
		FixtureFitness copy = new FixtureFitness(lastLevelData.copy());
		
		return copy;
	}
	
	@Override
	public String toString() {
		String result = "{";
		QueryLevelData qld = lastLevelData;
		while (qld != null) {
			result += qld.toString();
			qld = qld.getPrevLevelData();
			if (qld != null)
				result += ", ";
		}
		result += "}";
		return result;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		FixtureFitness that = (FixtureFitness) o;

		return lastLevelData != null ? lastLevelData.equals(that.lastLevelData) : that.lastLevelData == null;
	}

	@Override
	public int hashCode() {
		return lastLevelData != null ? lastLevelData.hashCode() : 0;
	}
}


package nl.tudelft.serg.evosql.metaheuristics.operators;

import genetic.QueryLevelData;
import nl.tudelft.serg.evosql.EvoSQLException;
import nl.tudelft.serg.evosql.querydepth.QueryDepthExtractor;

/**
 * Fitness of one fixture
 *
 */
public class FixtureFitness {

	private QueryDepthExtractor depthExtractor;

	QueryLevelData lastLevelData;
	
	public FixtureFitness(QueryLevelData lastLevelData, QueryDepthExtractor depthExtractor) {
		this.lastLevelData = lastLevelData;
		this.depthExtractor = depthExtractor;
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

	/**
	 * Returns the fitness as an integer value. Fitness is defined as sum of the step distance
	 * (the amount of levels not executed in the query) and the branch distance on the last level
	 * (the distance to executing the last level).
	 * @return fitness value.
	 */
	public int getFitness() {
		int fitness = Integer.MAX_VALUE;
		int step_distance = depthExtractor.getQueryDepth() - getQueryLevel();
		if(step_distance < 0) {
			throw new EvoSQLException("Error in fitness function (negative step_distance: " + step_distance + ")");
		}
		int branch_distance = (int) lastLevelData.getDistance();
		fitness = step_distance + branch_distance;

		return fitness;
	}
	
	public int getQueryLevel() {
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
		FixtureFitness copy = new FixtureFitness(lastLevelData.copy(), depthExtractor);
		
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


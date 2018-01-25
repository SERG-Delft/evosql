package nl.tudelft.serg.evosql.metaheuristics.operators;

import genetic.QueryLevelData;
import nl.tudelft.serg.evosql.EvoSQLException;
import nl.tudelft.serg.evosql.fixture.Fixture;

/**
 * Fitness of one fixture
 *
 */
public class FixtureFitness {

	private String sqlQuery;

	QueryLevelData lastLevelData;
	
	public FixtureFitness(QueryLevelData lastLevelData, String sqlQuery) {
		this.lastLevelData = lastLevelData;
		this.sqlQuery = sqlQuery;
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
	 * Finds the amount of levels based on the string of the query.
	 * @return amount of query levels.
	 */
	public int getDeepestQueryLevel() {
		String normalised = sqlQuery.toLowerCase();
		int level = 1;
		String[] statements = normalised.split(" ");
		for (String statement : statements) {
			switch(statement) {
				//TODO: insert keywords to check for to increase query levels.
				case "select":
					level++;
				case "having":
					level++;
				case "join":
					level++;
			}
		}
		return level;
	}

	/**
	 * Returns the fitness as an integer value. Fitness is defined as sum of the step distance
	 * (the amount of levels not executed in the query) and the branch distance on the last level
	 * (the distance to executing the last level).
	 * @return fitness value.
	 */
	public int getFitness() {
		int fitness = Integer.MAX_VALUE;
		int step_distance = getDeepestQueryLevel() - getQueryLevel();
		if(step_distance < 0) {
			throw new EvoSQLException("Error in fitness function (negative step_distance)");
		}
		int branch_distance = (int) lastLevelData.getDistance();
		fitness = step_distance + branch_distance;

		assert fitness >= 0;
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
		FixtureFitness copy = new FixtureFitness(lastLevelData.copy(), sqlQuery);
		
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


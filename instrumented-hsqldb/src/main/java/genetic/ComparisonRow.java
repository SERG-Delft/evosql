package genetic;

import java.util.ArrayList;
import java.util.List;

import javax.naming.OperationNotSupportedException;

class ComparisonRow {
	List<List<Comparison>> comparisons;
	int maxIndex;
	private Double distance = null;
	
	ComparisonRow () {
		comparisons = new ArrayList<List<Comparison>>();
		maxIndex = 0;
	}
	
	ComparisonRow (ComparisonRow row, int upToRangeVariableIndex) {
		comparisons = new ArrayList<List<Comparison>>();
		
		for (int i = 0 ; i <= upToRangeVariableIndex; i++) {
			if (row != null && row.maxIndex >= i)
				comparisons.add(row.comparisons.get(i));
			else
				comparisons.add(new ArrayList<Comparison>());
		}
		maxIndex = upToRangeVariableIndex;
	}
	
	void add(Comparison c, int rangeVariableIndex) {
		while (rangeVariableIndex > comparisons.size() - 1) {
			comparisons.add(new ArrayList<Comparison>());
			maxIndex = rangeVariableIndex;
		}
		comparisons.get(rangeVariableIndex).add(c);
	}

	List<Comparison> getComparisons(int currentIndex) {
		if (currentIndex < comparisons.size()) {
			return comparisons.get(currentIndex);
		} else {
			return new ArrayList<Comparison>();
		}
	}
	
	double getDistance() throws OperationNotSupportedException {
		if (distance == null)
			distance = calculateDistance();
		
		return distance;
	}
	
	void addDistance(double distance) {
		this.distance += distance;
	}
	
	private double calculateDistance() throws OperationNotSupportedException {
		double distance = 0;
		
		for (int i = maxIndex; i <= maxIndex; i++) {
			double currentDistance;
			for (Comparison c : comparisons.get(i)) {
				if (c.expressionInfo.number == 0) { // Take top level comparison
					currentDistance = c.getDistance();
					currentDistance = currentDistance < 0 ? 0 : currentDistance; // If top level is lower than 0 the distance is 0 (conditions met)
					distance += currentDistance;
				}
			}
		}
		
		return distance;
	}

	public boolean isEmpty() {
		for (int i = 0; i < comparisons.size(); i++) {
			if (comparisons.get(i).size() > 0)
				return false;
		}
		return true;
	}
}

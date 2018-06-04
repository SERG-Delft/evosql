package genetic;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class QueryLevelData implements Comparator<QueryLevelData> {
	private QueryLevelData prevLevelData;
	private List<QueryLevelData> subLevelData;
	private int queryLevel;
	private int maxRangeVariableIndex;
	private double distance;
	
	public QueryLevelData(int pQueryLevel, QueryLevelData prev) {
		queryLevel = pQueryLevel;
		maxRangeVariableIndex = 0;
		distance = 0;
		
		// Fill up missing query levels if needed
		if (prev == null) {
			if (queryLevel > 0)
				prevLevelData = new QueryLevelData(0, null).expandToQueryLevel(queryLevel - 1);
		} else {
			prevLevelData = prev.expandToQueryLevel(queryLevel - 1);
		}
	}

	public List<QueryLevelData> getSubLevelData() {
		return subLevelData;
	}

	public QueryLevelData expandToQueryLevel(int queryLevel) {
		QueryLevelData currentQFD = this;
		while (currentQFD.queryLevel < queryLevel) {
			currentQFD = new QueryLevelData(currentQFD.queryLevel + 1, currentQFD);
		}
		return currentQFD;
	}
	
	public static QueryLevelData ERROR() {
		QueryLevelData qld = new QueryLevelData(0, null);
		qld.setDistance(Double.MAX_VALUE);
		return qld;
	}

	public void addSubData(int i, QueryLevelData qld) {
		if (subLevelData == null)
			subLevelData = new ArrayList<QueryLevelData>();
		
		while (i >= subLevelData.size()) {
			subLevelData.add(new QueryLevelData(0, null));
		}
		subLevelData.set(i, qld);
		
	}
	
	public int getQueryLevel() {
		return queryLevel;
	}
	
	public void setMaxRangeVariableIndex(int maxRangeVariableIndex) {
		this.maxRangeVariableIndex = maxRangeVariableIndex;
	}
	
	public int getMaxRangeVariableIndex() {
		return this.maxRangeVariableIndex;
	}
	
	public void setDistance(double distance) {
		this.distance = distance;
	}
	
	public double getDistance() {
		return this.distance;
	}

	public QueryLevelData copy() {
		QueryLevelData copy = new QueryLevelData(this.queryLevel, this.prevLevelData == null ? null : this.prevLevelData.copy());
		copy.setDistance(this.getDistance());
		copy.setMaxRangeVariableIndex(this.getMaxRangeVariableIndex());
		
		if (subLevelData != null) {
			for (int i = 0; i < this.subLevelData.size(); i++) {
				copy.addSubData(i, this.subLevelData.get(i).copy());
			}
		}
		
		return copy;
	}

	public QueryLevelData getPrevLevelData() {
		return prevLevelData;
	}

	@Override
	/**
	 * Returns -1 if qld1 is better, 1 if qld2 is better, 0 if equal
	 */
	public int compare(QueryLevelData qld1, QueryLevelData qld2) {
		// Compare rangeVariable levels, higher is better
		if (qld1.getMaxRangeVariableIndex() < qld2.getMaxRangeVariableIndex())
			return 1;
		else if (qld1.getMaxRangeVariableIndex() > qld2.getMaxRangeVariableIndex())
			return -1;
		
		// Compare distances, lower is better
		if (qld1.getDistance() < qld2.getDistance())
			return -1;
		else if (qld1.getDistance() > qld2.getDistance())
			return 1;

		// Compare subleveldata from LTR, if one is null and the other is not it is worse
		if (qld1.subLevelData != null && qld2.subLevelData != null) {
			// Compare sizes, bigger is better
			if (qld1.subLevelData.size() > qld2.subLevelData.size())
				return -1;
			else if (qld1.subLevelData.size() < qld2.subLevelData.size())
				return 1;
			
			// If equal size subleveldata
			for (int i = 0; i < qld1.subLevelData.size(); i++) {
				QueryLevelData sub1 = qld1.subLevelData.get(i);
				QueryLevelData sub2 = qld2.subLevelData.get(i);
				
				if (sub1 == null && sub2 == null) {
					continue;
				} else if (sub1 == null) {
					return 1;
				} else if (sub2 == null) {
					return -1;
				} else {
					int comp = compare(sub1, sub2);
					if (comp != 0)
						return comp;
				}
			}
		} else if (qld1.subLevelData != null) {
			// QLD2 has no subleveldata, QLD1 does, qld1 is better
			return -1;
		} else if (qld2.subLevelData != null) {
			// QLD1 has no subleveldata, QLD2 does, qld2 is better
			return 1;
		}
		
		return 0;
	}
	
	public String toString() {
		String result = "{Level: " + getQueryLevel() + ", MaxRangeVariableIndex: " + getMaxRangeVariableIndex() + ", Distance: " + getDistance();
		
		if (this.subLevelData != null) {
			result +=  ", Subdata: [";
			boolean first = true;
			for (QueryLevelData qld : this.subLevelData) {
				if (!first) {
					result += ", ";
				} else first = false;
				result += qld.toString();
			}
			result += "]";
		}
		
		result += "}";
		
		return result;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		QueryLevelData that = (QueryLevelData) o;

		if (queryLevel != that.queryLevel) return false;
		if (maxRangeVariableIndex != that.maxRangeVariableIndex) return false;
		if (Double.compare(that.distance, distance) != 0) return false;
		if (prevLevelData != null ? !prevLevelData.equals(that.prevLevelData) : that.prevLevelData != null)
			return false;
		return subLevelData != null ? subLevelData.equals(that.subLevelData) : that.subLevelData == null;
	}

	@Override
	public int hashCode() {
		int result;
		long temp;
		result = prevLevelData != null ? prevLevelData.hashCode() : 0;
		result = 31 * result + (subLevelData != null ? subLevelData.hashCode() : 0);
		result = 31 * result + queryLevel;
		result = 31 * result + maxRangeVariableIndex;
		temp = Double.doubleToLongBits(distance);
		result = 31 * result + (int) (temp ^ (temp >>> 32));
		return result;
	}
}

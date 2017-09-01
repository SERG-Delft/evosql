package genetic;

import java.util.Calendar;

import javax.naming.OperationNotSupportedException;

import org.hsqldb.Expression;

public class Comparison {
	// Very large number but not max value so that improvements can still be seen if one of the comparisons improve
	private final static double MAX_DISTANCE_VALUE = Double.MAX_VALUE / 100; 
	
	public Expression expression;
	public String operation;
	public String leftSql;
	public Object leftData;
	public String leftType;
	public String rightSql;
	public Object rightData;
	public String rightType;
	public Boolean result;
	public ExpressionInfo expressionInfo;
	public Double distance;
	public Comparison leftChild;
	public Comparison rightChild;
	
	public Comparison (Expression exp, String operation, String leftSql, Object leftData, String leftType,
			String rightSql, Object rightData, String rightType, Boolean result) {
		if (!genetic.Instrumenter.running)
			return;
		this.expression = exp;
		this.operation = operation;
		this.leftSql = leftSql;
		this.leftData = getData(leftData, leftType);
		this.leftType = leftType;
		this.rightSql = rightSql;
		this.rightData = getData(rightData, rightType);
		this.rightType = rightType;
		this.result = result;
		this.distance = null;
		if (genetic.Instrumenter.isInstrumenting())
			expressionInfo = genetic.Instrumenter.getExpressionInfo(exp);
	}
	
	/** Converts given data to a String or String array **/
	private Object getData(Object obj, String type) {
		if (obj == null) return null;
		
		// If it is an array
		if (obj.getClass().isArray()) {
			Object[] arr = (Object[]) obj;
			Object[] output = new Object[arr.length];
			for (int i = 0; i < arr.length; i++) {
				output[i] = getData(arr[i], type);
			}
			return output;
		}
		
		if (type.contains("DateTimeType")) {
			if (obj instanceof org.hsqldb.types.TimestampData) {
				org.hsqldb.types.TimestampData data = (org.hsqldb.types.TimestampData) obj; 
				return String.valueOf(data.getSeconds() * 1000 + data.getNanos() / 1000000);
			} else {
				org.hsqldb.types.TimeData data = (org.hsqldb.types.TimeData) obj;
				return String.valueOf(data.getSeconds() * 1000 + data.getNanos() / 1000000);
			}
		}
		
		// Default case toString
		return obj.toString();
	}
	
	public double getDistance() throws OperationNotSupportedException {
		if (this.distance == null) {
			calculateDistance();
		}
		
		return this.distance;
	}
	
	/**
	 * Calculates the distance, sets it 
	 * If distance is a negative number, it means the condition is true, and it is the distance to being false
	 */
	public void calculateDistance() throws OperationNotSupportedException {
		distance = 0d;
		 
		// If the result is null (instead of true/false), distance is always max value
		if (result == null) {
			distance = MAX_DISTANCE_VALUE;

			// Check the invert boolean
			if (this.expression.invertDistance)
				this.distance *= -1;
			return;
		}
		
		switch (operation) {
		case "OR": {
			double ld = 0, rd = 0;
			if (leftChild != null) {
				ld = leftChild.getDistance();
			} else {
				Boolean l = leftData == null ? null : Boolean.parseBoolean((String)leftData);
				if (l == null || !l)
					ld = 1;
				else 
					ld = -1;
			}
			if (rightChild != null) {
				rd = rightChild.getDistance();
			} else {
				Boolean r = rightData == null ? null : Boolean.parseBoolean((String)rightData);
				if (r == null || !r) 
					rd = 1;
				else
					rd = -1;
			}
			distance += (this.result != null && this.result) ? 
					(ld < 0 ? ld : 0) + (rd < 0 ? rd : 0) : // If true, at least one of them is < 0, distance is the sum of negative distance
					Math.min(ld, rd); // If false, both will be > 0
			break;
		}
		case "AND": {
			double ld = 0, rd = 0;
			if (leftChild != null) {
				ld = leftChild.getDistance();
			} else {
				Boolean l = leftData == null ? null : Boolean.parseBoolean((String)leftData);
				if (l == null || !l)
					ld = 1;
				else
					ld = -1;
			}
			if (rightChild != null) {
				rd = rightChild.getDistance();
			} else {
				Boolean r = rightData == null ? null : Boolean.parseBoolean((String)rightData);
				if (r == null || !r) 
					rd = 1;
				else
					rd = -1;
			}
			distance += (this.result != null && this.result) ?
					Math.max(ld, rd) : // If true, both will be < 0 one of them needs to be made false to switch result
					(ld > 0 ? ld : 0) + (rd > 0 ? rd : 0); // If false, at least one of them will be > 0
			break;
		}
		case "NOT": {
			double ld = 0;
			if (leftChild != null) {
				ld = leftChild.getDistance();
			} else {
				Boolean l = leftData == null ? null : Boolean.parseBoolean((String)leftData);
				if (l == null || !l)
					ld = 1;
				else
					ld = -1;
			}
			if (leftData == null) {
				// Was null, so remains null, distance is the distance of the child
				distance += ld;
			} else {
				distance += -ld; // Negate the child distance
			}
			break;
		}
		case "EQUAL/ANY_QUANTIFIED": {// IN
			double min = MAX_DISTANCE_VALUE;
			Object[] ld = (Object[]) leftData;
			Object[] rd = (Object[]) rightData;
			for (Object rstr : rd) {
				Object[] rArr = (Object[]) rstr;
				double difference = getDifference(leftType, (String)ld[0], (String)rArr[0]);
				
				if (difference == 0) {
					min = -1d;
					break;
				} else {
					min = Math.min(min, Math.abs(difference));
				}
			}
			distance += min;
			break;
		}
		case "LIKE":
			if (leftData == null || rightData == null) {
				distance += MAX_DISTANCE_VALUE;
				break;
			}
			
			distance += org.hsqldb.Like.distance(leftData, rightData);
			break;
		case "IS_NULL":
			if (leftData == null)
				distance -= 1;
			else
				distance += 1;
			break;
		case "EXISTS":
			if (result == null || !result) { // Exists is false
				distance += MAX_DISTANCE_VALUE;
			} else { // Exists is true
				distance -= 1;
			}
			break;
		case "EQUAL":
        case "NOT_EQUAL" :
		case "GREATER":
        case "GREATER_EQUAL" :
        case "GREATER_EQUAL_PRE" :
		case "SMALLER":
        case "SMALLER_EQUAL" : {
    		double difference = getDifference(leftType, (String) leftData, (String) rightData);
        	
        	switch (operation) {
        	case "EQUAL":
        		if (difference == 0) distance += -1;
        		else distance += Math.abs(difference);
        		break;
            case "NOT_EQUAL" :
            	if (difference == 0) distance += 1;
            	else distance = -Math.abs(difference);
            	break;
    		case "GREATER":
    			if (difference <= 0) distance += Math.abs(difference) + 1;
    			else distance += -Math.abs(difference);
    			break;
            case "GREATER_EQUAL" :
            case "GREATER_EQUAL_PRE" :
    			if (difference < 0) distance += Math.abs(difference);
    			else distance += -(Math.abs(difference) + 1);
    			break;
    		case "SMALLER":
    			if (difference >= 0) distance += Math.abs(difference) + 1;
    			else distance += -Math.abs(difference);
    			break;
            case "SMALLER_EQUAL" :
    			if (difference > 0) distance += Math.abs(difference);
    			else distance += -(Math.abs(difference) + 1);
    			break;
        	} // End inner switch(operation)
        	break;
        }
        default:
        	throw new OperationNotSupportedException("Operation: " + operation + " not supported.");
		} // End outer switch(operation)
		
		// Check the invert boolean
		if (this.expression.invertDistance)
			this.distance *= -1;
	}
	
	public double getDifference(String type, String leftData, String rightData) throws OperationNotSupportedException {
		double difference = 0;
		
		if(leftData == null || rightData == null) {
			difference = MAX_DISTANCE_VALUE;
		} else if (type.contains("NumberType")) {
    		Double l = Double.parseDouble(leftData);
    		Double r = Double.parseDouble(rightData);
			difference = l - r;
    	} else if (type.contains("CharacterType")) {
    		int comp = leftData.compareTo(rightData);
    		if (comp == 0) return 0;

    		// Add distance difference
    		difference += (comp < 0 ? -1 : 1) * levenshteinDistance(leftData, rightData);
    				
    	} else if (type.contains("BitType")) {
    		return leftData.compareTo(rightData); // Can only be "0" or "1" , so string compare is fine
    	} else if (type.contains("DateTimeType")) {
    		long lLong = Long.parseLong(leftData);
    		long rLong = Long.parseLong(rightData);
    		int comp = Long.compare(lLong, rLong);
    		if (comp == 0) return 0;
    		
    		Calendar l = Calendar.getInstance();
    		Calendar r = Calendar.getInstance();
			l.setTimeInMillis(lLong);
			r.setTimeInMillis(rLong);
    		
    		for (int i : Instrumenter.DATETIME_CONSTANTS) {
				switch (i) {
					case Calendar.YEAR: difference += Math.abs(l.get(Calendar.YEAR) - r.get(Calendar.YEAR)); break;
					case Calendar.MONTH: difference += Math.abs(l.get(Calendar.MONTH) - r.get(Calendar.MONTH)); break;
					case Calendar.DAY_OF_MONTH: difference += Math.abs(l.get(Calendar.DAY_OF_MONTH) - r.get(Calendar.DAY_OF_MONTH)); break;
					case Calendar.HOUR_OF_DAY: difference += Math.abs(l.get(Calendar.HOUR_OF_DAY) - r.get(Calendar.HOUR_OF_DAY)); break;
					case Calendar.MINUTE: difference += Math.abs(l.get(Calendar.MINUTE) - r.get(Calendar.MINUTE)); break;
					case Calendar.SECOND: difference += Math.abs(l.get(Calendar.SECOND) - r.get(Calendar.SECOND)); break;
					case Calendar.MILLISECOND: difference += Math.abs(l.get(Calendar.MILLISECOND) - r.get(Calendar.MILLISECOND)); break;			
					default: throw new RuntimeException("Impossible value " + i);
				}
    		}
    		
    		// For the smaller/greater than
    		difference *= comp;
    	} else {
    		throw new OperationNotSupportedException("Type: " + type + " not supported.");
    	}
		return difference;
	}
	
	public String toString() {
		return "[Comparison {"
				+ "Expression (" + expressionInfo.number + "), Level: " + expressionInfo.level + ", "
				+ "Negative effect: " + expressionInfo.isNegative + ", "
				+ "Operation: " + operation + ", "
				+ "Left: { SQL: " + leftSql + ", data: " + leftData + ", type: " + leftType + " }, "
				+ "Right: { SQL: " + rightSql + ", data: " + rightData + ", type: " + rightType + " }, "
				+ "Result: " + result + ", "
				+ "Distance: " + distance
				+ "}]";
	}
	
	public static double levenshteinDistance(String string1, String string2) {
		int length1 = string1.length();
		int length2 = string2.length();
	 
		double[][] distances = new double[length1 + 1][length2 + 1];
	 
		for (int i = 0; i <= length1; i++) {
			distances[i][0] = i;
		}
	 
		for (int j = 0; j <= length2; j++) {
			distances[0][j] = j;
		}
	 
		//iterate and checking the distance for the last character
		for (int i = 0; i < length1; i++) {
			char c1 = string1.charAt(i);
			
			for (int j = 0; j < length2; j++) {
				char c2 = string2.charAt(j);
				//if last two chars equal
				if (c1 == c2) {
					//distance is unchanged
					distances[i + 1][j + 1] = distances[i][j];
				} else {
					// otherwise the distance have to be update
					double char_dist = Math.abs(c1 - c2);
					double replace = distances[i][j] + char_dist/(char_dist+1);
					double insert = distances[i][j + 1] + 1;
					double delete = distances[i + 1][j] + 1;
	 
					double min = Math.min(replace, insert);
					min = Math.min(min, delete);
					distances[i + 1][j + 1] = min;
				}
			}
		}
	 
		return distances[length1][length2];
	}
}

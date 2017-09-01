package nl.tudelft.serg.evosql.sql;

public enum ComparisonOperator {
	SMALLER_THAN("<"),
	SMALLER_OR_EQUALS_THAN("<="),
	GREATER_THAN(">"),
	GREATER_OR_EQUALS_THAN(">="),
	EQUALS("=");
	
	private String operator;

	ComparisonOperator(String operator) {
		this.operator = operator;
	}

	public static ComparisonOperator convert(String str) {
		
		for(ComparisonOperator c : ComparisonOperator.values()) {
			if(c.getOperator().equals(str)) return c;
		}
		return null;
	}
	
	public String getOperator() {
		return operator;
	}
}

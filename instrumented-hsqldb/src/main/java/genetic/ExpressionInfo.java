package genetic;

public class ExpressionInfo {
	public int number;
	public int level;
	public boolean isNegative;
	public boolean fromJoin;
	
	public ExpressionInfo(int number, int level, boolean isNegative) {
		this.number = number;
		this.level = level;
		this.isNegative = isNegative;
	}
}

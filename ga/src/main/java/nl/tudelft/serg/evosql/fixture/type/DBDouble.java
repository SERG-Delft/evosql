package nl.tudelft.serg.evosql.fixture.type;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.List;
import java.util.Locale;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class DBDouble implements DBType {

	private static Randomness random = new Randomness();
	private static final DecimalFormatSymbols defaultDecimalFormatSymbols;

	static {
		defaultDecimalFormatSymbols = new DecimalFormatSymbols(Locale.US);
	}
	
	@Override
	public String generateRandom(boolean nullable) {
		if(nullable && random.nextDouble() < EvoSQLConfiguration.NULL_PROBABIBLITY)
			return null;
		
		return 
				String.valueOf(random.nextDouble() * (EvoSQLConfiguration.ABS_INT_RANGE * 2) - EvoSQLConfiguration.ABS_INT_RANGE);
	}

	@Override
	public String mutate(String currentValue, boolean nullable) {
		// If null, generate a new value that is not null, if not null generate null with probability
		if(currentValue == null)
			return generateRandom(false);
		else if(nullable && random.nextDouble() < EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY)
			return null;
		
		double oldValue = Double.parseDouble(currentValue);
		
		double newValue = polynomialMutation(oldValue);
		
		// Get truncation decimals
		int decimals = random.nextInt(16);
		
		return truncateDecimals(newValue, decimals);
	}
	
	static String truncateDecimals(double value, int decimals) {
		StringBuilder builder = new StringBuilder("0");
		if (decimals > 0) builder.append('.');
		for (int i = 0; i < decimals; i++) 
			builder.append('#');
		DecimalFormat df = new DecimalFormat(builder.toString(), defaultDecimalFormatSymbols);
		df.setRoundingMode(RoundingMode.FLOOR);
		
		return df.format(value);
	}

	@Override
	public boolean hasSeed(Seeds seeds) {
		return seeds.hasDoubles() || seeds.hasLongs();
	}

	@Override
	public String generateFromSeed(Seeds seeds) {
		List<String> source = seeds.getLongsAndDoubles();

		if (source.size() == 0) return null;
		return source.get(random.nextInt(source.size()));
	}
	
	public String getTypeString() {
		return "DOUBLE";
	}
	
	protected static double polynomialMutation(double oldValue){
		double distributionIndex = 20;
		double lowerBound = -EvoSQLConfiguration.ABS_DOUBLE_RANGE/2;
		double upperBound = EvoSQLConfiguration.ABS_DOUBLE_RANGE/2;
		double delta1 = (oldValue - lowerBound) / (upperBound - lowerBound);
		double delta2 = (upperBound - oldValue) / (upperBound - lowerBound);
        double r = random.nextDouble();
        double power = 1.0 / (distributionIndex + 1.0);
        double delta = 0;
        if (r <= 0.5) {
          double xy = 1.0 - delta1;
          double val = 2.0 * r + (1.0 - 2.0 * r) * (Math.pow(xy, distributionIndex + 1.0));
          delta = Math.pow(val, power) - 1.0;
        } else {
          double xy = 1.0 - delta2;
          double val = 2.0 * (1.0 - r) + 2.0 * (r - 0.5) * (Math.pow(xy, distributionIndex + 1.0));
          delta = 1.0 - Math.pow(val, power);
        }
        if (Math.abs(delta) > 0)
        	return oldValue + delta * (upperBound - lowerBound);
        else
        	return oldValue + (random.nextDouble() * 2) - 1;
	}
	
	protected static double gaussianMutation(double oldValue){
		return oldValue + random.nextGaussian() * oldValue/2;
        
	}

}

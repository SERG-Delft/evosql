package nl.tudelft.serg.evosql.fixture.type;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class DBTime implements DBType {
	private static final double probability = 1d/5d;
	private static Randomness random = new Randomness();
	private static SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss.SSS");
	private static long offset = Timestamp.valueOf("1980-01-01 00:00:00.000").getTime();
	private static long diff = Timestamp.valueOf("1980-01-02 00:00:00.000").getTime() - offset + 1;
	
	@Override
	public String generateRandom(boolean nullable) {
		if(nullable && random.nextDouble() < EvoSQLConfiguration.NULL_PROBABIBLITY)
			return null;
		
		long value = (long)(random.nextDouble() * diff);

		return format.format(new Timestamp(value));
	}

	@Override
	public String mutate(String currentValue, boolean nullable) {
		// If null, generate a new value that is not null, if not null generate null with probability
		if(currentValue == null)
			return generateRandom(false);
		else if(nullable && random.nextDouble() < EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY)
			return null;
		
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTimeInMillis(format.parse(currentValue).getTime());
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}

		for (int i : genetic.Instrumenter.TIME_CONSTANTS) {
			if (random.nextDouble() <= probability) {
				int val;
				switch (i) {
					case Calendar.HOUR_OF_DAY: val = cal.get(Calendar.HOUR_OF_DAY); break;
					case Calendar.MINUTE: val = cal.get(Calendar.MINUTE); break;
					case Calendar.SECOND: val = cal.get(Calendar.SECOND); break;
					case Calendar.MILLISECOND: val = cal.get(Calendar.MILLISECOND); break;			
					default: throw new RuntimeException("Impossible value " + i);
				}
				val = (int)(val + (random.nextSignedDouble() * 10));
				switch (i) {
					case Calendar.HOUR_OF_DAY: cal.set(Calendar.HOUR_OF_DAY, val); break;
					case Calendar.MINUTE: cal.set(Calendar.MINUTE, val); break;
					case Calendar.SECOND: cal.set(Calendar.SECOND, val); break;
					case Calendar.MILLISECOND: cal.set(Calendar.MILLISECOND, val); break;			
				}
			}
		}
		
		return format.format(cal.getTime());
	}
	
	@Override
	public boolean hasSeed(Seeds seeds) {
		return false;
	}

	@Override
	public String generateFromSeed(Seeds seeds) {
		return generateRandom(false);
	}
	
	public String getTypeString() {
		return "TIME";
	}

}

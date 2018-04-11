package nl.tudelft.serg.evosql.fixture.type;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class DBDate implements DBType{

	private static final String DEFAULT_TYPE_STRING = "DATE";

	private static final double probability = 1d/5d;
	private static Randomness random = new Randomness();
	private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	private static long offset = Timestamp.valueOf(EvoSQLConfiguration.MIN_DATE).getTime();
	private static long diff = Timestamp.valueOf(EvoSQLConfiguration.MAX_DATE).getTime() - offset + 1;

	private final String typeString;

	public DBDate() {
	    this(DEFAULT_TYPE_STRING);
    }

	public DBDate(String typeString) {
	    this.typeString = typeString;
    }
	
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

		for (int i : genetic.Instrumenter.DATE_CONSTANTS) {
			if (random.nextDouble() <= probability) {
				int val;
				switch (i) {
					case Calendar.YEAR: val = cal.get(Calendar.YEAR); break;
					case Calendar.MONTH: val = cal.get(Calendar.MONTH); break;
					case Calendar.DAY_OF_MONTH: val = cal.get(Calendar.DAY_OF_MONTH); break;		
					default: throw new RuntimeException("Impossible value " + i);
				}
				val = (int)(val + (random.nextSignedDouble() * 10));
				switch (i) {
					case Calendar.YEAR: cal.set(Calendar.YEAR, val); break;
					case Calendar.MONTH: cal.set(Calendar.MONTH, val); break;
					case Calendar.DAY_OF_MONTH: cal.set(Calendar.DAY_OF_MONTH, val); break;		
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

	@Override
	public String getTypeString() {
		return typeString;
	}

    @Override
    public String getNormalizedTypeString() {
        return DEFAULT_TYPE_STRING;
    }

}

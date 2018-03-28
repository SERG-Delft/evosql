package nl.tudelft.serg.evosql.fixture.type;

import java.util.List;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class DBInteger implements DBType {

	private static final String DEFAULT_TYPE_STRING = "INTEGER";

	private static Randomness random = new Randomness();

	private final String typeString;

	public DBInteger() {
        this(DEFAULT_TYPE_STRING);
    }

	public DBInteger(String typeString) {
        this.typeString = typeString;
    }

	@Override
	public String generateRandom(boolean nullable) {
		if(nullable && random.nextDouble() < EvoSQLConfiguration.NULL_PROBABIBLITY)
			return null;

		return
			String.valueOf(random.nextInt(EvoSQLConfiguration.ABS_INT_RANGE * 2) - EvoSQLConfiguration.ABS_INT_RANGE);
	}

	@Override
	public String mutate(String currentValue, boolean nullable) {
		// If null, generate a new value that is not null, if not null generate null with probability
		if(currentValue == null)
			return generateRandom(false);
		else if(nullable && random.nextDouble() < EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY)
			return null;

		// mutate integer
		int oldValue = Integer.parseInt(currentValue);
		int newValue = (int) (oldValue + (random.nextSignedDouble() * 10));

		return String.valueOf(newValue);
	}

	public String getTypeString() {
		return typeString;
	}

	@Override
	public boolean hasSeed(Seeds seeds) {
		return seeds.hasLongs();
	}

	@Override
	public String generateFromSeed(Seeds seeds) {
		List<String> source = seeds.getLongs();

		if (source.size() == 0) return null;
		return source.get(random.nextInt(source.size()));
	}
}

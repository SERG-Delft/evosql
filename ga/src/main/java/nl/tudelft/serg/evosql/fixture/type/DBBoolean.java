package nl.tudelft.serg.evosql.fixture.type;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class DBBoolean implements DBType {

	private static final String DEFAULT_TYPE_STRING = "BIT";

	private static Randomness random = new Randomness();

	private final String typeString;

	public DBBoolean() {
	    this(DEFAULT_TYPE_STRING);
    }

	public DBBoolean(String typeString) {
	    this.typeString = typeString;
    }

	@Override
	public String generateRandom(boolean nullable) {
		if(nullable && random.nextDouble() < EvoSQLConfiguration.NULL_PROBABIBLITY)
			return null;
		
		return random.nextBoolean() ? "1" : "0";
	}

	@Override
	public String mutate(String currentValue, boolean nullable) {
		// If null, generate a new value that is not null, if not null generate null with probability
		if(currentValue == null)
			return generateRandom(false);
		else if(nullable && random.nextDouble() < EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY)
			return null;
		
		boolean converted = currentValue.equals("1") ? true : false;
		return converted ? "0" : "1";
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

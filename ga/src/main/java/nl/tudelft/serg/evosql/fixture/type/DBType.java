package nl.tudelft.serg.evosql.fixture.type;

import nl.tudelft.serg.evosql.db.Seeds;

import java.io.Serializable;

public interface DBType extends Serializable {
	String generateRandom(boolean nullable);
	String generateFromSeed(Seeds seeds);
	String mutate(String currentValue, boolean nullable);
	String getTypeString();
	boolean hasSeed(Seeds seeds);
}

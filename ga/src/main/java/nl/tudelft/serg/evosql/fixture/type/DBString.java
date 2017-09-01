package nl.tudelft.serg.evosql.fixture.type;

import java.util.List;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.util.random.Randomness;

public class DBString implements DBType {

	private static Randomness random = new Randomness();
	private int length;
	
	public DBString(int length) {
		this.length = length;
	}
	
	@Override
	public String generateRandom(boolean nullable) {
		if(nullable && random.nextDouble() < EvoSQLConfiguration.NULL_PROBABIBLITY)
			return null;
		
		StringBuilder builder = new StringBuilder();
		
		int nChar = random.nextInt(Math.max(Math.min(length, EvoSQLConfiguration.MAX_STRING_LENGTH), 6) - 5) + 5;

		for (int i=0; i<nChar; i++){
			builder.append(getRandomCharacter());
		}
		
		return builder.toString();
	}

	@Override
	public String mutate(String currentValue, boolean nullable) {
		// If null, generate a new value that is not null, if not null generate null with probability
		if(currentValue == null)
			return generateRandom(false);
		else if(nullable && random.nextDouble() < EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY)
			return null;

		String newString = "";
		char[] character = currentValue.toCharArray();

		for (int i = 0; i<character.length; i++){
			String newChar = ""+character[i];
			if (random.nextDouble() <= 1d/currentValue.length()){
				double r = random.nextDouble();
				if (r <= 1d/3d) {
					// insert a random character
					newChar = newChar + getRandomCharacter();
				} else if (r <= 2d/3d){
					//remove the current character
					newChar = "";
				} else {
					// change the current character
					// mutate integer value of char
					int oldValue = (int)character[i];
					int delta = (int) (random.nextSignedDouble() * 10);
					if (delta == 0)
						delta = random.nextBoolean() ? +1 : -1;
					int newValue = oldValue + delta;
					newValue = Math.min(EvoSQLConfiguration.MAX_CHAR_ORD, Math.max(EvoSQLConfiguration.MIN_CHAR_ORD, newValue));
					newChar = ""+(char)newValue;
				}
			}
			newString += newChar;
		}
		return newString;
	}
	
	@Override
	public boolean hasSeed(Seeds seeds) {
		return seeds.hasStrings();
	}

	@Override
	public String generateFromSeed(Seeds seeds) {
		List<String> source = seeds.getStrings();

		if (source.size() == 0) return null;
		return source.get(random.nextInt(source.size()));
	}

	/**
	 * This method return a character using the ASCII code.
	 * @return a random character
	 */
	public char getRandomCharacter(){
		int character = random.nextInt(EvoSQLConfiguration.MAX_CHAR_ORD + 1 - EvoSQLConfiguration.MIN_CHAR_ORD);
		return (char) (character+EvoSQLConfiguration.MIN_CHAR_ORD);
	}
	
	public String getTypeString() {
		//TODO Add size of field
		return "VARCHAR(500)";
	}
}

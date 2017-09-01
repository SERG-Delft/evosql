package nl.tudelft.serg.evosql.util.random;

import java.util.Random;

public class Randomness {

	private static Random random;
	
	static {
		random = new Random();
	}
	
	public boolean nextBoolean() {
		return random.nextBoolean();
	}
	
	public double nextDouble() {
		return random.nextDouble();
	}
	
	/**
	 * 
	 * @return Random double between -1 inclusive and +1 exclusive
	 */
	public double nextSignedDouble() {
		return random.nextDouble() * 2 - 1;
	}

	public double nextGaussian() {
		return random.nextGaussian();
	}

	public int nextInt(int bound) {
		return random.nextInt(bound);
	}
}

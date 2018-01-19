package nl.tudelft.serg.evosql.metaheuristics.operators;

import java.util.List;
import java.util.Random;
import nl.tudelft.serg.evosql.fixture.Fixture;

public class TournamentSelection {

	public static Random random = new Random();

	public static int ROUNDS = 4;

	/** 
	 * This method compute the tournament winner (tournament with n.rounds = ROUNDS)
	 * @param population from which to select the winner
	 * @return index of the winner in the current population
	 */
	public int getIndex(List<Fixture> population) {
		int new_num = random.nextInt(population.size());
		int winner = new_num;
		
		FixtureComparator fc = new FixtureComparator();

		int round = 0;

		while (round < ROUNDS - 1) {
			new_num = random.nextInt(population.size());
			Fixture selected = population.get(new_num);
			FixtureFitness f1 = population.get(winner).getFitness();
			FixtureFitness f2 = selected.getFitness();
			//TODO: Find a way to pass the sql query.
			if(f2.getFitness("") < f1.getFitness("")) {
				winner = new_num;
			}
			/*if (fc.compare(selected, population.get(winner)) == -1) {
				winner = new_num;
			}*/
			round++;
		}

		return winner;
	}
	
	public Fixture getFixture(List<Fixture> population) {
		return population.get(getIndex(population));
	}
}

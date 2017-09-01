package nl.tudelft.serg.evosql;

public class EvoSQLConfiguration {

	public static int MAX_ROW_QTY = 4;
	public static int MIN_ROW_QTY = 1;
	
	public static int MAX_STRING_LENGTH = 50;
	public static int MIN_CHAR_ORD = (int)' ';
	public static int MAX_CHAR_ORD = (int)'~';
	
	public static int ABS_INT_RANGE = 1000;
	public static int ABS_DOUBLE_RANGE = 1000;
	
	public static String MIN_DATE = "1980-01-01 00:00:00.000";
	public static String MAX_DATE = "2070-01-01 00:00:00.000";
	
	public static double NULL_PROBABIBLITY = 0.1;
	public static double MUTATE_NULL_PROBABIBLITY = 0.1; 

	public static double SEED_INSERT_PROBABIBLITY = 0.5;
	public static double SEED_CHANGE_PROBABIBLITY = 0.5;

	public static int POPULATION_SIZE = 50;
	public static double P_CLONE_POPULATION = 0.6;

	/** Probability to insert a new row in a Table **/
	public static double P_INSERT_PROBABILITY = 1d/3d;
	
	/** Probability to duplicate a row in a Table **/
	public static double P_INSERT_DUPLICATE_PROBABILITY = 1d/3d;

	/** Probability to delete a row in a Table **/
	public static double P_DELETE_PROBABILITY = 1d/3d;

	/** Probability to change a row in a Table **/
	public static double P_CHANGE_PROBABILITY = 1d/2d;
	
	/** Probability to crossover **/
	public static double P_CROSSOVER = 3d/4d;

	/** Probability to mutation **/
	public static double P_MUTATION = 3d/4d;
	
	public static enum MutationType {
		PERCENTAGE, // in the mutation probability is a user-provided percentage
					// (See P_MUTATION)
		
		LENGTH,		// in the case the mutation probability is equal to 1/LENGTH 
					// (where LENGTH either the number of Tables and/or Rows)
		};
	
	public static MutationType MUTATION = MutationType.LENGTH;
	
	/** Feature config **/
	public static boolean USE_LITERAL_SEEDING = true;
	public static boolean USE_DYNAMIC_JOIN_SEEDING = true;
	public static boolean USE_USED_COLUMN_EXTRACTION = true;
	
	public static boolean MUTATION_PROBABILITY_FOR_EACH_ROW = false;

	public static boolean USE_SEEDED_RANDOM_BASELINE = true;
	
	/** Evaluation time **/
	public static long MS_EXECUTION_TIME = 1800000; // Half an hour = 1800000 ms
	
	/** Testing, should this be moved to special testing classes? **/
	public static int TEST_MAX_ITERATIONS = 5;

}

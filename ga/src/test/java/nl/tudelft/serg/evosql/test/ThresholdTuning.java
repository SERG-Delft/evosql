package nl.tudelft.serg.evosql.test;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import org.junit.runner.JUnitCore;
import org.junit.runner.Result;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;

public class ThresholdTuning {
	
	public static void main(String[] args) throws FileNotFoundException {
		
		List<List<Double>> allLists = new ArrayList<>();
		allLists.add(Arrays.asList(0.01, 0.10, 0.50)); // MUTATE_NULL_PROBABIBLITY, NULL_PROBABIBLITY
		allLists.add(Arrays.asList(0.01, 0.10, 0.50)); // SEED_CHANGE_PROBABIBLITY, SEED_INSERT_PROBABIBLITY
		allLists.add(Arrays.asList(1d/3d, 1d/6d)); // P_INSERT_PROBABILITY, DELETE, DUPLICATE
		allLists.add(Arrays.asList(0d, 1d)); // mutating every row or single row
		allLists.add(Arrays.asList(0d, 0.6, 3d/4d)); // crossover
		
		List<List<Double>> results = new ArrayList<>();
		generateCombinations(allLists, 0, new ArrayList<Double>(), results);
		
		List<List<List<Double>>> partitioned = batches(results, results.size() / 5 + 1).collect(Collectors.toList());
		List<List<Double>> partition = partitioned.get(Integer.parseInt(args[0]));
		
		PrintStream ps = new PrintStream("results.csv");
		for(List<Double> current : partition) {
			
			EvoSQLConfiguration.MUTATE_NULL_PROBABIBLITY = current.get(0);
			EvoSQLConfiguration.NULL_PROBABIBLITY = current.get(0);
			
			EvoSQLConfiguration.SEED_CHANGE_PROBABIBLITY = current.get(1);
			EvoSQLConfiguration.SEED_INSERT_PROBABIBLITY = current.get(1);
			
			EvoSQLConfiguration.P_INSERT_PROBABILITY = current.get(2);
			EvoSQLConfiguration.P_DELETE_PROBABILITY = current.get(2);
			EvoSQLConfiguration.P_INSERT_DUPLICATE_PROBABILITY = current.get(2);
			
			EvoSQLConfiguration.MUTATION_PROBABILITY_FOR_EACH_ROW = current.get(3) == 0 ? false : true;
			
			EvoSQLConfiguration.P_CROSSOVER = current.get(4);
			
			List<Long> executions = new ArrayList<>();
			for(int i = 0; i < 10; i++) {
				JUnitCore junit = new JUnitCore();
				Result result = junit.run(AllTestsSuite.class);
				executions.add(result.getRunTime());
			}

			ps.print(current.toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(" ", "") + ",");
			executions.stream().forEach(x -> ps.print(x + ","));
			ps.println(executions.stream().mapToLong(a -> a).average().getAsDouble());
			ps.flush();
		}
		
		ps.close();
		

	}

	public static void generateCombinations(List<List<Double>> values, int depth, List<Double> current, List<List<Double>> results) {
		if (depth == values.size()) {
			results.add(current);
			return;
		}

		for (int i = 0; i < values.get(depth).size(); ++i) {
			List<Double> newCurrent = new ArrayList<Double>(current);
			newCurrent.add(values.get(depth).get(i));
			generateCombinations(values, depth + 1, newCurrent, results);
		}
	}
	
	// https://stackoverflow.com/questions/12026885/common-util-to-break-a-list-into-batch
	public static <T> Stream<List<T>> batches(List<T> source, int length) {
	    if (length <= 0)
	        throw new IllegalArgumentException("length = " + length);
	    int size = source.size();
	    if (size <= 0)
	        return Stream.empty();
	    int fullChunks = (size - 1) / length;
	    return IntStream.range(0, fullChunks + 1).mapToObj(
	        n -> source.subList(n * length, n == fullChunks ? size : (n + 1) * length));
	}
}

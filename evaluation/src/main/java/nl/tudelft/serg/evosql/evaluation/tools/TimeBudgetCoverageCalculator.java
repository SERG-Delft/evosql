package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class TimeBudgetCoverageCalculator {
	private int minTimeBudget, maxTimeBudget, interval;
	private PrintStream output;
	private String user;
	private String pwd;
	private String connectionString;
	private String database;
	
	private List<List<Integer>> queryRuleBudgets;
	
	private final int UNSOLVABLE_BUDGET = 1000000000; // Larger than 2 hours in ms.
	
	public TimeBudgetCoverageCalculator(int minTimeBudget, int maxTimeBudget, int interval
			, String connectionString, String database, String user, String pwd, PrintStream output) {
		this.minTimeBudget = minTimeBudget;
		this.maxTimeBudget = maxTimeBudget;
		this.interval = interval;
		this.output = output;
		this.connectionString = connectionString;
		this.database = database;
		this.user = user;
		this.pwd = pwd;
	}
	
	/**
	 * Collect for each query, for each path if they can succeed, and if so how much time they need on average.
	 * This is stored in table `evaluationRQ5`
	 */
	private void init() {
		// Init query list
		queryRuleBudgets = new LinkedList<List<Integer>>();
		output.println("Budget, Query, Rules, Coverage");
		
		// Get the data
		try {
			// Connect to the evaluation database
			Connection conn = DriverManager.getConnection(connectionString, user, pwd);
			conn.setCatalog(database);
			
			ResultSet result = conn.createStatement().executeQuery("SELECT System, QueryNo, Solvable, Runtime FROM evaluationRQ5");
			String currentSystem = "";
			int currentQueryNo = -1;
			List<Integer> currentRuleList = null;
			while (result.next()) {
				String system = result.getString(1);
				int queryNo = result.getInt(2);
				int solvable = result.getInt(3);
				int runtime = result.getInt(4);
				
				if (!system.equals(currentSystem) || queryNo != currentQueryNo) {
					currentSystem = system;
					currentQueryNo = queryNo;
					
					// Set new list for coverage rules
					currentRuleList = new LinkedList<Integer>();
					queryRuleBudgets.add(currentRuleList);
				}
				
				// Add this coverage rule's time budget
				if (solvable == 0) {
					currentRuleList.add(UNSOLVABLE_BUDGET);
				} else {
					currentRuleList.add(runtime);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private List<Double> deepCopyConvert(List<Integer> origList) {
		List<Double> newList = new ArrayList<Double>();
		
		// Add primitive value to unlink
		for (Integer i : origList) {
			newList.add((double)i.intValue());
		}
		
		return newList;
	}
	
	/** For budget in milliseconds, calculate query coverages and write to output **/
	private void calculateForBudget(int budget) {
		/* For each query, calculate coverage */
		int query = 0;
		for (List<Integer> ruleBudgets : queryRuleBudgets) {
			double queryBudget = (double)budget;
			query++;
			List<Double> budgets = deepCopyConvert(ruleBudgets);
			int totalRules = budgets.size();
			int rulesLeft = totalRules;
			int rulesCovered = 0;
			
			while (queryBudget > 0 && rulesLeft > 0) {
				double ruleBudget = queryBudget / rulesLeft;
				// Empty query budget
				queryBudget = 0;
				
				for (int i = 0; i < totalRules; i++) {
					double runtimeLeft = budgets.get(i);
					// Check if not already done
					if (runtimeLeft <= 0) continue;
					
					// Subtract budget from runtime
					runtimeLeft -= ruleBudget;
					budgets.set(i, runtimeLeft);
					
					// Check if done
					if (runtimeLeft <= 0) {
						rulesCovered++;
						rulesLeft--;
						
						// Add leftover budget back to the pile
						queryBudget += 0 - runtimeLeft;
					}
				}
			}
			
			// Budget is all depleted now, calculate query coverage
			double coverage = (double)rulesCovered / totalRules;
			output.println(String.format("%d,%d,%d,%.4f", budget, query, totalRules, coverage));
		}
	}
	
	public void calculate() {
		init();
		
		for (int budget = minTimeBudget; budget <= maxTimeBudget; budget += interval) {
			calculateForBudget(budget);
		}
	}
	
	public static void main(String[] args) {
		int minTimeBudget = 60000
				, maxTimeBudget = 7200000
				, interval = 60000;
		
		PrintStream output;
		try {
			output = new PrintStream("rq5.csv"); //System.out;
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		//output = System.out;
		
		TimeBudgetCoverageCalculator calc = new TimeBudgetCoverageCalculator(minTimeBudget, maxTimeBudget, interval,
				"jdbc:mysql://localhost:3306/?nullNamePatternMatchesAll=true&useSSL=false"
				, "evaluationdata", "evosql", "evosql"
				, output);
		
		calc.calculate();
	}

}

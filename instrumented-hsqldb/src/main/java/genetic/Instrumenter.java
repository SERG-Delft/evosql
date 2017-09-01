package genetic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.OperationNotSupportedException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hsqldb.Expression;
import org.hsqldb.OpTypes;

public class Instrumenter {
	public static int[] DATETIME_CONSTANTS = new int[]{Calendar.YEAR, Calendar.MONTH, Calendar.DAY_OF_MONTH, Calendar.HOUR_OF_DAY, Calendar.MINUTE, Calendar.SECOND, Calendar.MILLISECOND};
	public static int[] DATE_CONSTANTS = new int[]{Calendar.YEAR, Calendar.MONTH, Calendar.DAY_OF_MONTH};
	public static int[] TIME_CONSTANTS = new int[]{Calendar.HOUR_OF_DAY, Calendar.MINUTE, Calendar.SECOND, Calendar.MILLISECOND};
	
	private static Logger log = LogManager.getLogger(Instrumenter.class);
	
	static boolean running;
	static boolean instrumenting;
	private static boolean didError;
	private static String exception;
	
	static Connection c;
	static Statement st;

	
	static class RootNode {
		Expression root;
		RootNode prev;
		
		RootNode (Expression root, RootNode prev) {
			this.root = root;
			this.prev = prev;
		}
	}
	
	static class InstrumenterState {
		int queryLevel;
		int currentRVIndex;
		ComparisonRow currentRow;
		ComparisonDataStore currentLevelStore;
		InstrumenterState parent;
		List<InstrumenterState> subStates;
		boolean isNextRowInvalid;
		
		// Conditions
		RootNode currentConditionNode;
		Expression whereCondition;
		
		int subIndex;
		// Map that links range variable indexes to current sub index
		Map<Integer, Integer> subIndices;
		
		InstrumenterState() {
			this(null, 0);
		}
		
		InstrumenterState(InstrumenterState parent, int sourceSubIndex) {
			queryLevel = 0;
			subIndex = 0;
			currentRVIndex = -1;
			currentRow = new ComparisonRow();
			subStates = new ArrayList<InstrumenterState>();
			subIndices = new HashMap<Integer, Integer>();
			isNextRowInvalid = false;
			this.parent = parent;
			
			currentConditionNode = null;
			whereCondition = null;
			
			// Get the correct store
			if (parent == null)
				currentLevelStore = new ComparisonDataStore(queryLevel, null);
			else
				currentLevelStore = parent.getStore(sourceSubIndex);
		}

		private ComparisonDataStore getStore(int subIndex) {
			return currentLevelStore.getSubStore(subIndex);
		}

		/** Get the correct sub state according to the sub index **/
		public InstrumenterState getSubState() {
			InstrumenterState subState;
			// Get or create the substate
			if (subIndex < subStates.size()) {
				subState = subStates.get(subIndex);
			} else {
				subState = new InstrumenterState(this, subIndex);
				subStates.add(subState);
			}
			subIndex++;
			// Store the highest subIndex for this RV index.
			subIndices.put(currentRVIndex, subIndex);
			return subState;
		}

		/** Get the Sub index for the last RV index **/
		public int getLastSubIndex() {
			int maxRVI = 0, subIndex = 0;
			for (Map.Entry<Integer, Integer> entry : subIndices.entrySet()) {
				if (entry.getKey() < currentRVIndex) {
					if (entry.getKey() > maxRVI) {
						maxRVI = entry.getKey();
						subIndex = entry.getValue();
					}
				}
			}
			return subIndex;
		}
	}
	static InstrumenterState state = new InstrumenterState();
	
	static ComparisonDataStore firstLevelStore = state.currentLevelStore;
	
	public static void startDatabase() {
		if (c != null) {
			try {
				c.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return;
			}
			c = null;
		}
		st = null;
		try {
		     Class.forName("org.hsqldb.jdbc.JDBCDriver" );
		} catch (Exception e) {
		     System.err.println("ERROR: failed to load HSQLDB JDBC driver.");
		     e.printStackTrace();
		     return;
		}
		try {
			c = DriverManager.getConnection("jdbc:hsqldb:mem/instrumentb", "SA", "");
			st = c.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		log.info("Instrumented database started.");
	}
	
	public static void stopDatabase() {
		if (c != null) {
			try {
				c.close();
			} catch (SQLException e) {
				e.printStackTrace();
				return;
			}
			c = null;
		}
		st = null;
		
		log.info("Instrumented database stopped.");
	}
	
	public static Statement getStatement() {
		return st;
	}
	
	public static void printWarnings() {
		if (st == null) return;
		
		SQLWarning w = null;
		try {
			w = st.getWarnings();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		while (w != null) {
			System.out.println(w.getMessage());
			w = w.getNextWarning();
		}
	}
	
	public static void execute(String sql) throws SQLException {
		log.info("Executing SQL for Instrumenter: " + sql.replace("\n", ""));
		if (st == null) return;
		try {
			st.execute(sql);
		} catch (SQLException e) {
			// Catch errors that happen on the individual level ( so query runs but this individual is bad )
			if (e.getMessage().equals("cardinality violation") || // Cardinality violation is a subquery returning too many results
					e.getMessage().equals("data exception: division by zero")
					) { 
				didError = true;
				exception = e.getMessage();
			} else {
				throw e;
			}
		}
	}
	
	/**
	 * Reset the data to start instrumenting
	 */
	public static void startInstrumenting() {
		state = new InstrumenterState();
		firstLevelStore = state.currentLevelStore;
		
		didError = false;
		exception = "";
		instrumenting = true;
		running = false;
	}
	
	public static void stopInstrumenting() {
		instrumenting = false;
		running = false;
		didError = false;
		exception = "";
	}
	
	public static boolean isInstrumenting() {
		return instrumenting;
	}

	/** This signal needs to come from HSQLDB **/
	public static void signalStart() {
		if (!instrumenting) return;
		
		running = true;
	}
	
	/**
	 * Add data
	 */
	public static void add(Comparison c) {
		if (!running) return;
		
		state.currentRow.add(c, state.currentRVIndex);
	}
	
	/**
	 * Sets the expression tree by the highest node, this tree can be used to find the level of an expression
	 * @param exp Root expression node
	 */
	public static void setCondition(Expression exp) {
		if (!running) return;
		state.currentConditionNode = new RootNode(exp, state.currentConditionNode);
	}
	
	public static void setWhereCondition(Expression exp) {
		if (!running) return;
		state.whereCondition = exp;
	}
	
	public static void removeCondition() {
		if (state.currentConditionNode != null)
			state.currentConditionNode = state.currentConditionNode.prev;
	}
	
	/**
	 * Get the info of the expression in the current condition tree
	 * @param exp
	 * @return The info: level, where 0 is top level, and -1 is unknown
	 */
	public static ExpressionInfo getExpressionInfo(Expression exp) {
		if (state.currentConditionNode == null)
			return new ExpressionInfo(-1, -1, false);
		
		ExpressionInfo info = walkAndSearchInfo(state.currentConditionNode.root, exp, new ExpressionInfo(0, 0, false));
		info.fromJoin = true;
		// Try to search in the WHERE if not in the currentconditionnode.root
		if (state.whereCondition != null && info.level == -1) {
			info = walkAndSearchInfo(state.whereCondition, exp, new ExpressionInfo(0, 0, false));
			info.fromJoin = false;
		}
		
		return info;
	}
	
	private static ExpressionInfo walkAndSearchInfo(Expression currentNode, Expression searchNode, ExpressionInfo currentInfo) {
		if (currentNode == null || currentInfo.level == -1) {
			return new ExpressionInfo(currentInfo.number - 1, -1, false);
		}
		if (currentNode == searchNode) {
			return currentInfo;
		}
		
		// Go down left tree
		ExpressionInfo childInfo = new ExpressionInfo(currentInfo.number + 1, currentInfo.level + 1, currentInfo.isNegative);
		if ( currentNode.getType() == OpTypes.NOT) {// NOT inverts negative
			childInfo.isNegative = !childInfo.isNegative;
		} else if (	(currentNode.getType() == OpTypes.AND || currentNode.getType() == OpTypes.OR) // If they are both AND or both OR don't increase level 
						&& currentNode.getLeftNode() != null 
						&& currentNode.getType() == currentNode.getLeftNode().getType()
		){ 
			childInfo.level -= 1;
		}
		childInfo = walkAndSearchInfo(currentNode.getLeftNode(), searchNode, childInfo);
		if (childInfo.level != -1) { // If node is found
			return childInfo;
		}
		
		// Go down right tree
		childInfo = new ExpressionInfo(childInfo.number + 1, currentInfo.level + 1, currentInfo.isNegative);
		if ( currentNode.getType() == OpTypes.NOT) {// NOT inverts negative
			childInfo.isNegative = !childInfo.isNegative;
		} else if (	(currentNode.getType() == OpTypes.AND || currentNode.getType() == OpTypes.OR) // If they are both AND or both OR don't increase level 
						&& currentNode.getRightNode() != null 
						&& currentNode.getType() == currentNode.getRightNode().getType()
		){ 
			childInfo.level -= 1;
		}
		childInfo = walkAndSearchInfo(currentNode.getRightNode(), searchNode, childInfo);
		if (childInfo.level != -1) { // If node is found
			return childInfo;
		}

		return new ExpressionInfo(childInfo.number, -1, false); // Not found in this subtree
	}
	
	/**
	 * Of all comparisons in Row, add their children by going through the tree
	 */
	private static void linkComparisons() {
		if (state.currentConditionNode == null || state.currentRVIndex == -1) return;
		
		linkComparisonNode(state.currentConditionNode.root);
		if (state.whereCondition != null)
			linkComparisonNode(state.whereCondition);
	}
	
	private static Comparison linkComparisonNode(Expression currentNode) {
		if (currentNode == null) return null;
		
		// Find corresponding comparison
		Comparison currentComparison = null;
		for (Comparison c : state.currentRow.getComparisons(state.currentRVIndex)) {
			if (c.expression == currentNode) {
				currentComparison = c;
				break;
			}
		}
		if (currentComparison == null) return null;
		
		// Find the left child
		currentComparison.leftChild = linkComparisonNode(currentNode.getLeftNode());
		
		// Find the right child
		currentComparison.rightChild = linkComparisonNode(currentNode.getRightNode());
		
		return currentComparison;
	}
	
	/**
	 * 
	 * @return Array of arrays, inner array contains queryLevel, maxRangeVariableIndex, distance
	 */
	public static QueryLevelData getFitness() {
		// Check if there was an individual error, causing the distance to be max
		if (didError) {
			return QueryLevelData.ERROR();
		}
		
		// Edge case no comparisons
		for (ComparisonDataStore iterStore : firstLevelStore) {
			if (iterStore.hasComparisons())
				break;

			// Reached the end, no comparisons throughout
			if (!iterStore.hasNextLevel()) {
				return new QueryLevelData(0, null).expandToQueryLevel(iterStore.getQueryLevel());
			}
		}

		return getFitness(firstLevelStore);
	}
	
	/** For a store recursively get the fitness values **/
	private static QueryLevelData getFitness(ComparisonDataStore store) {
		QueryLevelData result = null;

		// Loop through the levels
		double distance = 0;
		int maxRangeVariableIndex = -1;

		for (ComparisonDataStore iterStore : store) {
			// If no comparisons, skip
			if (!iterStore.hasComparisons()) {
				continue;
			}
			
			// Handle this store
			
			// Reset distance as it will be set again for this query level
			distance = 0;

			double currentDistance;
			maxRangeVariableIndex = -1;
			
			for (ComparisonRow c : iterStore.getRows()) {
				try {
					currentDistance = c.getDistance();
					/*if (currentDistance == 0) {
						c.getDistance();
					}*/
				} catch (OperationNotSupportedException e) {
					log.error(e);
					currentDistance = Double.MAX_VALUE;
				}
				
				if (c.maxIndex > maxRangeVariableIndex) {
					maxRangeVariableIndex = c.maxIndex;
					distance = currentDistance;
				} else if (c.maxIndex == maxRangeVariableIndex) {
					distance = Math.min(distance, currentDistance);
				}
			}
			
			// Store data
			result = new QueryLevelData(iterStore.getQueryLevel(), result);
			result.setMaxRangeVariableIndex(maxRangeVariableIndex);
			result.setDistance(distance);
			
			// Handle this store's substores
			List<ComparisonDataStore> subStores = iterStore.getSubStores();
			for (int i = 0; i < subStores.size(); i++) {
				QueryLevelData qld = getFitness(subStores.get(i));
				if (qld != null) {
					result.addSubData(i, qld);
				}
			}
		}

		return result;
	}
	
	/** Printing methods **/
	public static void printData() {
		printStoreData(firstLevelStore);
	}
	
	private static void printStoreData(ComparisonDataStore cds) {
		while(true) {
			System.out.println("Level " + cds.getQueryLevel());
			// Print sub stores
			List<ComparisonDataStore> subStores = cds.getSubStores();
			for (int i = 0; i < subStores.size(); i++) {
				System.out.println("Substore " + i);
				printStoreData(subStores.get(i));
			}
			
			// Print this store
			for (ComparisonRow cr : cds.getRows()) {
				System.out.println("Store");
				printRowData(cr);
			}
			
			// To next level
			if (cds.hasNextLevel())
				cds = cds.getNextLevel();
			else
				break;
		}
	}
	
	private static void printRowData(ComparisonRow cr) {
		for (int i = 0; i < cr.maxIndex; i++) {
			for (Comparison c : cr.getComparisons(i)) {
				System.out.println(c.toString());
			}
		}
	}

	/**
	 * Method that increases the internal query level. The higher the level, the later the conditions are evaluated.
	 */
	public static void increaseQueryLevel() {
		if (!running) return;
		
		state.queryLevel++;
		state.currentLevelStore = state.currentLevelStore.getNextLevel();
	}
	
	public static void decreaseQueryLevel() {
		if (!running) return;
		
		if (state.queryLevel > 0) {
			state.queryLevel--;
			state.currentLevelStore = state.currentLevelStore.getPrevLevel();
		}
	}
	
	/** Enter the proper substate **/
	public static void enterSubLevel() {
		if (!running) return;
		
		state = state.getSubState();
	}
	
	/** Go back to the parent state **/
	public static void exitSubLevel() {
		if (!running) return;
		
		if (state.parent != null) {
			state = state.parent;
		}
	}

	public static void updateRangeVariableIndex(int newIndex) {
		if (!running) return;
		
		// If it increases, a condition was true and a row is not ended
		if (newIndex > state.currentRVIndex) {
			linkComparisons(); // Link the last comparisons to each other
			state.currentRVIndex = newIndex;
			return;
		}
		
		// Row has ended
		endRow(newIndex);
	}
	
	public static void endRow() {
		endRow(state.currentRVIndex);
	}
	
	/** A row has ended, proceed and store if necessary **/
	public static void endRow(int newIndex) {
		if (!running) return;
		
		// Store if not empty
		if (!state.currentRow.isEmpty() && !state.isNextRowInvalid) {
			state.currentLevelStore.add(state.currentRow);
			linkComparisons(); // Link the last comparisons to each other
		}

		state.isNextRowInvalid = false;
		
		// The new row copies data from the previous row up to the new index - 1
		state.currentRow = new ComparisonRow(state.currentRow, newIndex - 1);
		
		// Update RangeVariable Index
		state.currentRVIndex = newIndex;
		
		// Update state's subindex
		if (newIndex == 0) { // If RV index is 0, subIndex should be as well
			state.subIndex = 0;
			state.subIndices.clear();
			state.subIndices.put(0, 0);
		} else { // Otherwise get the highest subIndex of the last RV index
			state.subIndex = state.getLastSubIndex();
		}
	}
	
	public static String getException() {
		return exception;
	}
	
	public static void clearRow() {
		if (!running) return;
		
		state.isNextRowInvalid = true;
	}
	
	public static void unclearRow() {
		if (!running) return;
		
		state.isNextRowInvalid = false;
	}
}

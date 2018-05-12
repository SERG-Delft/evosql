package nl.tudelft.serg.evosql;

import java.util.ArrayList;
import java.util.List;

import nl.tudelft.serg.evosql.fixture.Fixture;

public class Result {
	private String inputQuery;
	private List<PathResult> pathResults;
	private List<Long> coverageTimes;
	private List<Double> coveragePerc;
	private long startTime;
	
	public Result(String query, long startTime) {
		this.startTime = startTime;
		this.inputQuery = query;
		this.pathResults = new ArrayList<PathResult>();
		this.coverageTimes = new ArrayList<Long>();
		this.coveragePerc = new ArrayList<Double>();
	}
	
	public void addPathSuccess(int pathNo, String pathSql, long runtime, Fixture data, boolean productionSuccess, int generations, int individualCount, String exceptions) {
		int idx = pathNo - 1;
		while (idx >= pathResults.size()) {
			pathResults.add(null);
		}
		pathResults.set(idx, new PathResult(pathNo, pathSql, runtime, data, productionSuccess, generations, individualCount, exceptions));
	}
	
	public void addPathFailure(int pathNo, String pathSql, long runtime, String message, int generations, int individualCount, String exceptions) {
		int idx = pathNo - 1;
		while (idx >= pathResults.size()) {
			pathResults.add(null);
		}
		pathResults.set(idx, new PathResult(pathNo, pathSql, runtime, message, generations, individualCount, exceptions));
	}
	
	public void addCoveragePercentage(double newPercentage) {
		coverageTimes.add(System.currentTimeMillis() - this.startTime);
		coveragePerc.add(newPercentage);
	}
	
	public String toString() {
		StringBuilder builder = new StringBuilder();
		
		builder.append("Result for query:\n");
		builder.append(inputQuery.trim());
		builder.append("\n\n");
		
		for (PathResult pr : pathResults) {
			builder.append("Path: ");
			builder.append(pr.getPathSql());
			builder.append("\n");
			builder.append(pr.isSuccess() ? "Success\n" : "Failure\n");
			
			if (pr.isSuccess()) {
				builder.append(pr.getData());
			} else {
				builder.append("Message: ");
				builder.append(pr.getMessage());
			}
			
			builder.append("\n\n");
		}
		
		return builder.toString();
	}

	public String getInputQuery() {
		return inputQuery;
	}
	
	public List<PathResult> getPathResults() {
		return pathResults;
	}
	
	public List<Long> getCoverageTimes() {
		return coverageTimes;
	}
	
	public List<Double> getCoveragePercentages() {
		return coveragePerc;
	}

	public long qtyOfSuccesses() {
		return this.pathResults.stream().filter(x -> x.isSuccess()).count();
	}

	public long qtyOfFailures() {
		return this.pathResults.stream().filter(x -> !x.isSuccess()).count();
	}
	
	public boolean betterThan(Result result) {
		return qtyOfSuccesses() > result.qtyOfSuccesses();
	}
}

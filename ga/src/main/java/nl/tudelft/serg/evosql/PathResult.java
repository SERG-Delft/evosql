package nl.tudelft.serg.evosql;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.metaheuristics.DatabaseOutput;

public class PathResult {
	private int pathNo;
	private String pathSql;
	private Fixture data;
	private boolean success;
	private DatabaseOutput productionOutput;
	private String message;
	private long runtime;
	private int generations;
	private int individualCount;
	private String exceptions;
	
	public PathResult(int pathNo, String pathSql, long runtime, Fixture data, DatabaseOutput productionOutput, int generations, int individualCount, String exceptions) {
		this.pathNo = pathNo;
		this.pathSql = pathSql;
		this.data = data;
		this.success = true;
		this.productionOutput = productionOutput;
		this.runtime = runtime;
		this.message = "";
		this.generations = generations;
		this.individualCount = individualCount;
		this.exceptions = exceptions;
	}
	
	public PathResult(int pathNo, String pathSql, long runtime, String message, int generations, int individualCount, String exceptions) {
		this.pathNo = pathNo;
		this.pathSql = pathSql;
		this.success = false;
		this.productionOutput = null;
		this.message = message;
		this.runtime = runtime;
		this.generations = generations;
		this.individualCount = individualCount;
		this.exceptions = exceptions;
	}
	
	public int getPathNo() {
		return pathNo;
	}

	public String getPathSql() {
		return pathSql;
	}

	public Fixture getData() {
		return data;
	}

	public boolean isSuccess() {
		return success;
	}

	public boolean isProductionSuccess() {
		return productionOutput != null;
	}

	public DatabaseOutput getProductionOutput() {
		return productionOutput;
	}

	public String getMessage() {
		return message;
	}
	
	public long getRuntime() {
		return runtime;
	}
	
	public int getGenerations() {
		return generations;
	}
	
	public int getIndividualCount() {
		return individualCount;
	}
	
	public String getExceptions() {
		return exceptions;
	}
	
	public Fixture getFixture() {
		return data;
	}
	
}
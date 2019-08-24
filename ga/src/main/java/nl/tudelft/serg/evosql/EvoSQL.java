package nl.tudelft.serg.evosql;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

import com.github.sergdelft.sqlcorgi.SQLCorgi;
import com.github.sergdelft.sqlcorgi.schema.Schema;
import nl.tudelft.serg.evosql.db.ISchemaExtractor;
import nl.tudelft.serg.evosql.db.SchemaConverter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.db.SeedExtractor;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.metaheuristics.Approach;
import nl.tudelft.serg.evosql.metaheuristics.StandardGA;
import nl.tudelft.serg.evosql.metaheuristics.RandomApproach;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;
import nl.tudelft.serg.evosql.sql.parser.UsedColumnExtractor;

public class EvoSQL {

	private static Logger log = LogManager.getLogger(EvoSQL.class);
	
	private class PathState {
		int pathNo;
		String path;
		Approach approach;
		long timePassed;
		long timeBudget;
		List<Fixture> population;
		Set<ColumnSchema> usedColumns;
		
		PathState(int pathNo, String path, Approach approach, long timePassed, List<Fixture> population, long timeBudget) {
			this.pathNo = pathNo;
			this.path = path;
			this.approach = approach;
			this.timePassed = timePassed;
			this.timeBudget = timeBudget;
			this.population = population;
			usedColumns = null;
		}
	}
	
	private ISchemaExtractor schemaExtractor;

	private boolean baseline;
	
	public EvoSQL(String jdbcString, String dbDatabase, String dbUser, String dbPwd, boolean baseline) {
		this(new SchemaExtractor(jdbcString, dbDatabase, dbUser, dbPwd), baseline);
	}

	public EvoSQL(ISchemaExtractor se, boolean baseline) {
		this.schemaExtractor = se;
		this.baseline = baseline;
	}

	public Result execute(String sqlToBeTested) {
		String originalQuery = sqlToBeTested;
		genetic.Instrumenter.startDatabase();

		registerDrivers();

		// Check if query can be parsed
		try {
			// Make sql safe
			sqlToBeTested = new SqlSecurer(sqlToBeTested).getSecureSql();
		} catch (RuntimeException e) {
			log.error("Could not parse input query.");
			e.printStackTrace();
			return null;
		}

		log.info("SQL to be tested: " + sqlToBeTested);

		SchemaConverter schemaConverter = new SchemaConverter(schemaExtractor, originalQuery);
		Schema schema = schemaConverter.getSchema();

		// A path is a SQL query that only passes a certain condition set.
		List<String> allPaths = new ArrayList<>(SQLCorgi.generateRules(originalQuery, schema));

		log.info("Found " + allPaths.size() + " paths");
		allPaths.stream().forEach(path -> log.info(path));

		Map<String, TableSchema> tableSchemas;
		Seeds seeds;

		long start, end = -1;

		int   pathNo
			, totalPaths = allPaths.size()
			, coveredPaths = 0;

		long eachPathTime = (long)( EvoSQLConfiguration.MS_EXECUTION_TIME / (double)totalPaths );

		Result result = new Result(originalQuery, System.currentTimeMillis());

		List<Fixture> population = new ArrayList<Fixture>();

		// Holds all paths not yet solved and not tried in the current cycle
		Queue<PathState> unattemptedPaths = new LinkedList<PathState>();

		for (int iPathNo = 1; iPathNo <= allPaths.size(); iPathNo++) {
			String path = allPaths.get(iPathNo - 1);
			unattemptedPaths.add(new PathState(iPathNo, path, null, 0, null, eachPathTime));
		}

		// Holds all paths that have been attempted but are not yet solved
		List<PathState> attemptedPaths = new ArrayList<PathState>();

		while(!unattemptedPaths.isEmpty()) {
			PathState pathState = unattemptedPaths.poll();

			// Check if there is time budget right now
			if (pathState.timeBudget <= 0) {
				attemptedPaths.add(pathState);
				continue;
			}

			String pathSql = pathState.path;
			pathNo = pathState.pathNo;
			log.info("Testing " + pathSql);

			start = System.currentTimeMillis();

			// Secure sql
			pathSql = new SqlSecurer(pathSql).getSecureSql();

			try {
				if (pathState.approach == null) {
					// Get all table schema's for current path
					tableSchemas = schemaExtractor.getTablesFromQuery(pathSql);

					if (EvoSQLConfiguration.USE_LITERAL_SEEDING || (baseline && EvoSQLConfiguration.USE_SEEDED_RANDOM_BASELINE)) {
						// Get the seeds for the current path
						seeds = new SeedExtractor(pathSql).extract();
					} else {
						// Use no seeds
						seeds = Seeds.emptySeed();
					}
					if (baseline)
						pathState.approach = new RandomApproach(tableSchemas, pathSql, seeds);
					else
						pathState.approach = new StandardGA(population, tableSchemas, pathSql, seeds);
				} else {
					// Find table schemas from approach
					tableSchemas = pathState.approach.getTableSchemas();

					// Set the current population to where it left off
					population = pathState.population;
				}


				// Reset table schema usedness
				tableSchemas.forEach((name, ts) -> ts.resetUsed());

				// Set used columns
				if (EvoSQLConfiguration.USE_USED_COLUMN_EXTRACTION) {
					// Get the used columns in the current path
					pathState.usedColumns = new UsedColumnExtractor(pathSql, tableSchemas).extract();
					if (pathState.usedColumns != null) {
						 for (ColumnSchema col : pathState.usedColumns) {
							 col.setUsedColumn();
							 col.getTable().addUsedColumn();
						 }
					}
				} else {
					// Use all columns
					for (TableSchema ts : tableSchemas.values()) {
						for (ColumnSchema cs : ts.getColumns()) {
							cs.setUsedColumn();
							ts.addUsedColumn();
						}
					}
				}

				// Create schema on instrumenter
				for (TableSchema ts : tableSchemas.values()) {
					genetic.Instrumenter.execute(ts.getDropSQL());
					genetic.Instrumenter.execute(ts.getCreateSQL());
				}

				Fixture generatedFixture = pathState.approach.execute(pathState.timeBudget);

				// Store some vars
				end = System.currentTimeMillis();
				pathState.timePassed += (end - start);

				log.debug("Generated fixture for this path: {}", generatedFixture);

				// Done with path
				if (pathState.approach.hasOutput(generatedFixture)) {
					log.info("Generated fixture: " + generatedFixture.getInsertStatements());

					// Add success
					result.addPathSuccess(pathNo, pathSql, pathState.timePassed, generatedFixture
							, pathState.approach.fetchOutput(generatedFixture, sqlToBeTested)
							, pathState.approach.getGenerations(), pathState.approach.getIndividualCount()
							, pathState.approach.getExceptions());

					// Update coverage
					coveredPaths++;
					result.addCoveragePercentage(100 * ((double)coveredPaths) / totalPaths);
				} else {
					log.info("Could not find a solution for this path.");

					// Check if it didn't think it was a solution (because then there is no point to keep trying
					if (generatedFixture.getFitness() != null && generatedFixture.getFitness().getDistance() != 0) {
						// Add this path to the attemptedPaths
						pathState.population = new ArrayList<Fixture>(population); // new list pointing to the last population
						attemptedPaths.add(pathState);
					}

					String msg = "Has no output, distance is ";
					if (generatedFixture.getFitness() != null)
						msg += generatedFixture.getFitness().getDistance();
					else
						msg += "unknown!";
					result.addPathFailure(pathNo, pathSql, pathState.timePassed, msg
							, pathState.approach.getGenerations(), pathState.approach.getIndividualCount()
							, pathState.approach.getExceptions());
				}
			} catch (Exception e) {
				if (end < start) {
					end = System.currentTimeMillis();
					pathState.timePassed += (end - start);
				}
				e.printStackTrace();
				StackTraceElement[] st = e.getStackTrace();
				String stackStr = "";
				for (StackTraceElement s : st)
					stackStr += s.toString() + '\t';
				result.addPathFailure(pathNo, pathSql, pathState.timePassed, e.getMessage() + "\t" + stackStr
						, pathState.approach.getGenerations(), pathState.approach.getIndividualCount()
						, pathState.approach.getExceptions());
			}

			// If it took shorter than given time budget, redistribute the time accordingly
			long timediff = (end - start);
			if (timediff < pathState.timeBudget) {
				int statesLeft = unattemptedPaths.size() + attemptedPaths.size();
				if (statesLeft > 0) {
					long spareTime = pathState.timeBudget - timediff;
					// Get time per path state
					long timeInc = (long)(spareTime / (double)statesLeft);
					// Increase budgets
					unattemptedPaths.forEach(ps -> ps.timeBudget += timeInc);
					attemptedPaths.forEach(ps -> ps.timeBudget += timeInc);
				}
			}
			pathState.timeBudget -= timediff;

			// If all paths are done, there are unsolved paths and we have time left, add the unsolved paths back in
			if (unattemptedPaths.size() == 0 && !attemptedPaths.isEmpty()) {
				// Check if any attempted paths have time left, if not stop
				boolean timeLeft = false;
				for (PathState ps : attemptedPaths) {
					if (ps.timeBudget > 0)
						timeLeft = true;
				}

				if (timeLeft)
					unattemptedPaths.addAll(attemptedPaths);
				attemptedPaths.clear();
			}
		}

		genetic.Instrumenter.stopDatabase();

		return result;
	}

	/**
	 * Registers JDBC drivers for the following database systems:
	 * <ul>
	 * 	<li>PostgreSQL</li>
	 * 	<li>MySQL</li>
	 * </ul>
	 */
	private void registerDrivers() {
		try {
			Class.forName("org.postgresql.Driver");
			Class.forName("com.mysql.cj.jdbc.Driver");
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Class.forName("com.ibm.db2.jcc.DB2Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}

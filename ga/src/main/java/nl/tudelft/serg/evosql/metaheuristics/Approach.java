package nl.tudelft.serg.evosql.metaheuristics;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.util.random.Randomness;

public abstract class Approach {
	protected static Logger log = LogManager.getLogger(Approach.class);
	protected static Randomness random = new Randomness();

	protected int generations = 0;
	protected int individualCount = 0;


	/** Path under test**/
	protected String pathToTest;

	protected Map<String, TableSchema> tableSchemas;

	protected String exceptions;

	public Approach(Map<String, TableSchema> pTableSchemas, String pPathToBeTested) {
		this.tableSchemas = pTableSchemas;
		this.pathToTest = pPathToBeTested;
		this.exceptions = "";
	}

	public Fixture execute(long pathTime) throws SQLException {
		throw new RuntimeException("Approach did not implement execute.");
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

	public Map<String, TableSchema> getTableSchemas() {
		return tableSchemas;
	}

	protected Fixture minimize (Fixture fixture) throws SQLException {
		Fixture minimizedFixture = fixture.copy();

		if (!hasOutput(minimizedFixture))
			return minimizedFixture;

		// Loop over all tables
		for (FixtureTable ft : minimizedFixture.getTables()) {
			// Go over all rows, test them without this row and if hasOutput becomes true remove row
			for (int i = 0; i < ft.getRowCount() && ft.getRowCount() > 1 /*At least 1 row per table remains*/; i++) {
				if (hasOutput(minimizedFixture, ft.getName(), i)) {
					minimizedFixture.remove(ft.getName(), i);
					i--;
				}
			}
		}

		return minimizedFixture;
	}

	public DatabaseOutput generateOutput(Fixture fixture, String sql) throws SQLException {
		insertData(fixture, "", -1);
		Statement st = genetic.Instrumenter.getStatement();

		// Initialize ResultSet
		ResultSet res = st.executeQuery(sql);
		DatabaseOutput dbOutput = new DatabaseOutput();
        ResultSetMetaData meta = res.getMetaData();

        // Extract column names
        List<String> columns = new ArrayList<>();
        for (int i = 0; i < meta.getColumnCount(); i++) {
            columns.add(meta.getColumnName(i));
        }

        // For each row we make a map of values for each column
        while(res.next()) {
            Map<String, String> values = new HashMap<>();
            for (String column : columns) {
                values.put(column, res.getObject(column).toString());
            }
            dbOutput.add(values);
        }

		return dbOutput;
	}

	public boolean hasOutput(Fixture fixture) throws SQLException {
		return hasOutput(fixture, "", -1);
	}

	protected boolean hasOutput (Fixture fixture, String excludeTableName, int excludeIndex) throws SQLException {
		return hasOutput(fixture, pathToTest, excludeTableName, excludeIndex);
	}

	protected boolean hasOutput (Fixture fixture, String sql, String excludeTableName, int excludeIndex) throws SQLException {
		insertData(fixture, excludeTableName, excludeIndex);

		Statement st = genetic.Instrumenter.getStatement();

		try {
			ResultSet res = st.executeQuery(sql);
			// If next returns true there is at least one row.
			return res.next();
		} catch (SQLException e) {
			if (!exceptions.contains(e.getMessage())) {
				exceptions += ", " + e.getMessage();
			}
			log.error(e.toString());
			return false;
		}
	}

	private void insertData(Fixture fixture, String excludeTableName, int excludeIndex) throws SQLException {
		// Truncate tables in Instrumented DB
		for (TableSchema tableSchema : tableSchemas.values()) {
			genetic.Instrumenter.execute(tableSchema.getTruncateSQL());
		}

		// Insert population
		for (String sqlStatement : fixture.getInsertStatements(excludeTableName, excludeIndex)) {
			genetic.Instrumenter.execute(sqlStatement);
		}
	}
}

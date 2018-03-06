package nl.tudelft.serg.evosql.brew.db;

import nl.tudelft.serg.evosql.Result;

/**
 * An interface for obtaining test fixtures from a database.
 */
public interface QueryRunner {
    /**
     * Returns test data fixtures for the given SQL query.
     * @param sqlQuery The SQL query to generate fixtures for.
     * @param connectionData The database connection data.
     * @return A list of fixtures for the given SQL query.
     */
    Result runQuery(String sqlQuery, ConnectionData connectionData);
}

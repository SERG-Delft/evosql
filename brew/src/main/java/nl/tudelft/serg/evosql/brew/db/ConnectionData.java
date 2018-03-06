package nl.tudelft.serg.evosql.brew.db;

import lombok.Data;

/**
 * A class for database connectivity data.
 */
@Data
public class ConnectionData {
    /**
     * The JDBC connection string.
     */
    private final String connectionString;
    /**
     * The database instance to connect to.
     */
    private final String database;
    /**
     * The database username.
     */
    private final String username;
    /**
     * The database password.
     */
    private final String password;
}

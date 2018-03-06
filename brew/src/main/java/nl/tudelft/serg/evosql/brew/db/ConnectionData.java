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
    private final String dbConnectionString;
    /**
     * The database username.
     */
    private final String dbUsername;
    /**
     * The database password.
     */
    private final String dbPassword;
}

package nl.tudelft.serg.evosql.brew.db;

import lombok.Data;
import lombok.NonNull;

/**
 * A class for database connectivity data.
 */
@Data
public class ConnectionData {
    /**
     * The JDBC connection string.
     */
    @NonNull private final String connectionString;
    /**
     * The database instance to connect to.
     */
    @NonNull private final String database;
    /**
     * The database username.
     */
    @NonNull private final String username;
    /**
     * The database password.
     */
    @NonNull private final String password;
}

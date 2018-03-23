package nl.tudelft.serg.evosql.brew.generator;

import lombok.Data;
import lombok.NonNull;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;

/**
 * Represents settings for a unit test generator.
 */
@Data
public class TestGeneratorSettings {
    /**
     * The connection data for the database.
     */
    @NonNull private final ConnectionData connectionData;
    /**
     * The package the file is in.
     */
    @NonNull private final String filePackage;
    /**
     * Whether an implementation of a method for executing
     * SQL statements should be fully implemented.
     */
    private final boolean generateSqlExecutorImplementation;
    /**
     * Whether the database tables should be created before
     * running any unit tests.
     */
    private final boolean createTablesBeforeRunning;
    /**
     * Whether the database tables should be truncated
     * before each unit test run.
     */
    private final boolean cleanTablesBeforeEachRun;
    /**
     * Whether the database tables should be truncated
     * after each unit test run.
     */
    private final boolean cleanTableAfterEachRun;
    /**
     * Whether the database tables should be dropped
     * after running all unit tests.
     */
    private final boolean dropTablesAfterRunning;
}

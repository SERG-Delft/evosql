package nl.tudelft.serg.evosql.brew.generator.junit;

import lombok.Data;
import lombok.NonNull;
import lombok.Value;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;

/**
 * Represents settings for a unit test generator.
 */
@Value
public class JUnitGeneratorSettings {
    /**
     * The connection data for the database.
     */
    @NonNull ConnectionData connectionData;
    /**
     * The package the file is in.
     */
    @NonNull String filePackage;
    /**
     * The name of the test class.
     */
    @NonNull String className;
    /**
     * Whether an implementation of a method for executing
     * SQL statements should be fully implemented.
     */
    boolean generateSqlExecutorImplementation;
    /**
     * Whether the database tables should be created before
     * running any unit tests.
     */
    boolean createTablesBeforeRunning;
    /**
     * Whether the database tables should be truncated
     * before each unit test run.
     */
    boolean cleanTablesBeforeEachRun;
    /**
     * Whether the database tables should be truncated
     * after each unit test run.
     */
    boolean cleanTableAfterEachRun;
    /**
     * Whether the database tables should be dropped
     * after running all unit tests.
     */
    boolean dropTablesAfterRunning;
}

package nl.tudelft.serg.evosql.brew.db;

import nl.tudelft.serg.evosql.EvoSQL;

/**
 * A class for creating instances of EvoSQL classes.
 */
public class EvoSQLFactory {
    /**
     * Creates a new instance of the EvoSQL class.
     * @param connectionData The connection data to use.
     * @return A new instance of the EvoSQL class.
     */
    public EvoSQL createEvoSQL(ConnectionData connectionData) {
        return new EvoSQL(
                connectionData.getConnectionString(),
                connectionData.getDatabase(),
                connectionData.getUsername(),
                connectionData.getPassword(),
                false);
    }
}

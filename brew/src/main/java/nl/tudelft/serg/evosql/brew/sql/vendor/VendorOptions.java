package nl.tudelft.serg.evosql.brew.sql.vendor;

/**
 * An interface for obtaining vendor-specific SQL syntax.
 */
public interface VendorOptions {

    /**
     * Escapes a table name for the correct vendor.
     *
     * @param tableName The name of the table.
     * @return An escaped version of the table name.
     */
    String escapeIdentifier(String tableName);
}

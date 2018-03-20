package nl.tudelft.serg.evosql.brew.sql.vendor;

public class PostgreSQLOptions implements VendorOptions {
    @Override
    public String escapeTableName(String tableName) {
        return escapeIdentifier(tableName);
    }

    @Override
    public String escapeColumnName(String columnName) {
        return escapeIdentifier(columnName);
    }

    private String escapeIdentifier(String id) {
        return "\"" + id + "\"";
    }
}

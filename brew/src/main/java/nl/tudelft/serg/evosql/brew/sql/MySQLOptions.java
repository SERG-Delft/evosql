package nl.tudelft.serg.evosql.brew.sql;

public class MySQLOptions implements VendorOptions {
    @Override
    public String escapeTableName(String tableName) {
        return escapeIdentifier(tableName);
    }

    @Override
    public String escapeColumnName(String columnName) {
        return escapeIdentifier(columnName);
    }

    private String escapeIdentifier(String id) {
        return "`" + id + "`";
    }
}

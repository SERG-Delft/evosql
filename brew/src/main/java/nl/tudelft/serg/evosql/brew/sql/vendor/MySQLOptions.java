package nl.tudelft.serg.evosql.brew.sql.vendor;

public class MySQLOptions implements VendorOptions {
    @Override
    public String escapeIdentifier(String id) {
        return "`" + id + "`";
    }
}

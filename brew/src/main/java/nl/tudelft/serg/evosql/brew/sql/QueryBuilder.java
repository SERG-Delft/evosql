package nl.tudelft.serg.evosql.brew.sql;

import lombok.Data;
import lombok.NonNull;
import nl.tudelft.serg.evosql.brew.data.FixtureColumn;
import nl.tudelft.serg.evosql.brew.data.FixtureRow;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;


import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * An abstract class for transforming data into SQL queries.
 */
@Data
public abstract class QueryBuilder {

    private static final List<String> numericSqlTypes =
            Collections.unmodifiableList(Arrays.asList("BIT", "INTEGER", "DOUBLE"));

    /**
     * The vendor options used for SQL generation.
     */
    @NonNull
    private final VendorOptions vendorOptions;

    /**
     * Builds a list of SQL queries using result data.
     *
     * @param path The result data to use for SQL generation.
     * @return A list of SQL queries.
     */
    public abstract List<String> buildQueries(Path path);


    protected String getEscapedValue(FixtureColumn fixtureColumn, FixtureRow fixtureRow) {
        String value = fixtureRow.getValues().get(fixtureColumn.getName());
        if (value == null || "NULL".equals(value)) {
            return "NULL";
        }

        if (!numericSqlTypes.contains(fixtureColumn.getType())) {
            return "'" + value.replaceAll("'", "''") + "'";
        }

        return value;
    }
}

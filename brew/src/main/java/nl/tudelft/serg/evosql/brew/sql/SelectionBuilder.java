package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.Collections;
import java.util.List;

/**
 * A query builder class for building data selection SQL statements.
 */
@EqualsAndHashCode
public class SelectionBuilder extends QueryBuilder {
    public SelectionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    /**
     * Builds selection statements for the given path fixture.
     * @param path The result data to use for SQL generation.
     * @return The original select statement wrapped in a list.
     */
    @Override
    public List<String> buildQueries(Path path) {
        return Collections.singletonList(path.getPathSql());
    }
}

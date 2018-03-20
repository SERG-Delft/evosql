package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.Arrays;
import java.util.List;

@EqualsAndHashCode
public class SelectionBuilder extends QueryBuilder {
    public SelectionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        return Arrays.asList(path.getPathSql());
    }

    @Override
    public String buildAggregateQuery(Path path) {
        throw new UnsupportedOperationException("This operation is not supported on selection queries, " +
                "use the buildQueries method instead.");
    }
}

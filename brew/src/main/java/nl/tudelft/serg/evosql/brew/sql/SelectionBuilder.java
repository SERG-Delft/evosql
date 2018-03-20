package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;

import java.util.List;
import java.util.stream.Collectors;

@EqualsAndHashCode
public class SelectionBuilder extends QueryBuilder {
    public SelectionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Result result) {
        return result.getPaths().stream().map(Path::getPathSql).collect(Collectors.toList());
    }

    @Override
    public String buildAggregateQuery(Result result) {
        throw new UnsupportedOperationException("This operation is not supported on selection queries, " +
                "use the buildQueries method instead.");
    }
}

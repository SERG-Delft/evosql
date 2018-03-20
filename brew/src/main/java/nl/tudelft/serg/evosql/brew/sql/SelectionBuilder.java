package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Result;

import java.util.List;

@EqualsAndHashCode
public class SelectionBuilder extends QueryBuilder {
    public SelectionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Result result) {
        return null;
    }

    @Override
    public String buildAggregateQuery(Result result) {
        return null;
    }
}

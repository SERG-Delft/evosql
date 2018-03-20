package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;

import java.util.ArrayList;
import java.util.List;

@EqualsAndHashCode
public class InsertionBuilder extends QueryBuilder {
    public InsertionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        List<String> queries = new ArrayList<>();

        return null;
    }

    @Override
    public String buildAggregateQuery(Path path) {
        return null;
    }
}

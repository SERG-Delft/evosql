package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.ArrayList;
import java.util.List;

@EqualsAndHashCode
public class TableCreationBuilder extends QueryBuilder {
    public TableCreationBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        List<String> queries = new ArrayList<>();
        return queries;
    }

    @Override
    public String buildAggregateQuery(Path path) {
        return null;
    }
}

package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;

@EqualsAndHashCode
public class CleaningBuilder extends QueryBuilder {
    public CleaningBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        return null;
    }

    @Override
    public String buildAggregateQuery(Path path) {
        return null;
    }
}

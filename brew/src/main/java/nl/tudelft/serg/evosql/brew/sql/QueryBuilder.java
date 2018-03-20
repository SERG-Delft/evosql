package nl.tudelft.serg.evosql.brew.sql;

import lombok.Data;
import lombok.NonNull;
import nl.tudelft.serg.evosql.brew.data.Result;


import java.util.List;

@Data
public abstract class QueryBuilder {

    @NonNull
    private final VendorOptions vendorOptions;

    public abstract List<String> buildQueries(Result result);

    public abstract String buildAggregateQuery(Result result);

}

package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;
import java.util.stream.Collectors;

/**
 * A query builder class for building table truncation SQL statements.
 */
@EqualsAndHashCode
public class CleaningBuilder extends QueryBuilder {
    public CleaningBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    /**
     * Builds truncate statements for all tables in the given path fixture.
     *
     * @param path The result data to use for SQL generation.
     * @return A list of truncate statements for the given data.
     */
    @Override
    public List<String> buildQueries(Path path) {
        return path.getFixture().getTables().stream().map(table -> {
            StringBuilder truncateBuilder = new StringBuilder();
            truncateBuilder.append("TRUNCATE TABLE ");
            truncateBuilder.append(getVendorOptions().escapeIdentifier(table.getSchema().getName()));
            truncateBuilder.append(";");
            return truncateBuilder.toString();
        }).collect(Collectors.toList());
    }

}

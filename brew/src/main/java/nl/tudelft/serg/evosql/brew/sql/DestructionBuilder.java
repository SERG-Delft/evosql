package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;
import java.util.stream.Collectors;

/**
 * A query builder class for building table dropping SQL statements.
 */
@EqualsAndHashCode
public class DestructionBuilder extends QueryBuilder {
    public DestructionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    /**
     * Builds drop statements for all tables in the given path fixture.
     *
     * @param path The result data to use for SQL generation.
     * @return A list of drop statements for the given data.
     */
    @Override
    public List<String> buildQueries(Path path) {
        return path.getFixture().getTables().stream().map(table -> {
            StringBuilder destructionBuilder = new StringBuilder();
            destructionBuilder.append("DROP TABLE ");
            destructionBuilder.append(getVendorOptions().escapeIdentifier(table.getSchema().getName()));
            destructionBuilder.append(";");
            return destructionBuilder.toString();
        }).collect(Collectors.toList());
    }
}

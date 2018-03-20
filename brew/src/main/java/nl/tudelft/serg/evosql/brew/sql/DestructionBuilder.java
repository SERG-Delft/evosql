package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;
import java.util.stream.Collectors;

@EqualsAndHashCode
public class DestructionBuilder extends QueryBuilder {
    public DestructionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        return path.getFixture().getTables().stream().map(table -> {
            StringBuilder cleanBuilder = new StringBuilder();
            cleanBuilder.append("DROP TABLE ");
            cleanBuilder.append(getVendorOptions().escapeTableName(table.getSchema().getName()));
            cleanBuilder.append(";");
            return cleanBuilder.toString();
        }).collect(Collectors.toList());
    }
}

package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;
import java.util.stream.Collectors;

@EqualsAndHashCode
public class TableCreationBuilder extends QueryBuilder {
    public TableCreationBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        return path.getFixture().getTables().stream().map(table -> {
            StringBuilder createBuilder = new StringBuilder();
            createBuilder.append("CREATE TABLE ");
            createBuilder.append(getVendorOptions().escapeTableName(table.getSchema().getName()));
            createBuilder.append(" (");
            List<String> columnsWithTypes = table.getSchema().getColumns().stream()
                    .map(c -> getVendorOptions().escapeColumnName(c.getName()) + " " + c.getType())
                    .collect(Collectors.toList());
            createBuilder.append(String.join(", ", columnsWithTypes));
            createBuilder.append(");");
            return createBuilder.toString();
        }).collect(Collectors.toList());
    }
}

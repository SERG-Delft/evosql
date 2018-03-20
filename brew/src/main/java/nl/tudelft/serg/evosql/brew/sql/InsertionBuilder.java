package nl.tudelft.serg.evosql.brew.sql;

import lombok.EqualsAndHashCode;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;
import java.util.stream.Collectors;

@EqualsAndHashCode
public class InsertionBuilder extends QueryBuilder {
    public InsertionBuilder(VendorOptions vendorOptions) {
        super(vendorOptions);
    }

    @Override
    public List<String> buildQueries(Path path) {
        return path.getFixture().getTables().stream().map(table -> {
            StringBuilder insertBuilder = new StringBuilder();
            insertBuilder.append("INSERT INTO ");
            insertBuilder.append(getVendorOptions().escapeTableName(table.getSchema().getName()));

            insertBuilder.append(" (");
            List<String> escapedColumnNames = table.getSchema().getColumns().stream()
                    .map(getVendorOptions()::escapeColumnName)
                    .collect(Collectors.toList());
            insertBuilder.append(String.join(", ", escapedColumnNames));
            insertBuilder.append(") VALUES ");

            List<String> valueStrings = table.getRows().stream().map(row -> {
                StringBuilder valueBuilder = new StringBuilder();
                valueBuilder.append("(");

                List<String> values = row.getTableSchema().getColumns().stream()
                        .map(c -> row.getValues().get(c))
                        .collect(Collectors.toList());
                valueBuilder.append(String.join(", ", values));

                valueBuilder.append(")");
                return valueBuilder.toString();
            }).collect(Collectors.toList());

            insertBuilder.append(String.join(", ", valueStrings));
            insertBuilder.append(";");

            return insertBuilder.toString();
        }).collect(Collectors.toList());
    }

    @Override
    public String buildAggregateQuery(Path path) {
        return null;
    }
}

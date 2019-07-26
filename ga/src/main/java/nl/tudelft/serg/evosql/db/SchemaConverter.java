package nl.tudelft.serg.evosql.db;

import com.github.sergdelft.sqlcorgi.schema.Column;
import com.github.sergdelft.sqlcorgi.schema.Column.DataType;
import com.github.sergdelft.sqlcorgi.schema.Schema;
import com.github.sergdelft.sqlcorgi.schema.Table;
import nl.tudelft.serg.evosql.fixture.type.DBDouble;
import nl.tudelft.serg.evosql.fixture.type.DBInteger;
import nl.tudelft.serg.evosql.fixture.type.DBType;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This class is used to convert a {@link TableSchema} to a {@link Schema} using the input query.
 * Conversion is needed to allow SQLCoRGi to use the Schema.
 */
public class SchemaConverter {
    private ISchemaExtractor schemaExtractor;
    private String query;

    /**
     * The constructor for the schema converter.
     *
     * @param schemaExtractor The schema extractor used.
     * @param query The input query.
     */
    public SchemaConverter(ISchemaExtractor schemaExtractor, String query) {
        this.schemaExtractor = schemaExtractor;
        this.query = query;
    }

    /**
     * Retrieves the {@link Schema} from the input query using the {@link SchemaExtractor}.
     * @return The schema obtained from the {@code query}.
     */
    public Schema getSchema() {
        Map<String, TableSchema> tableSchemas = schemaExtractor.getTablesFromQuery(query);
        Schema schema = new Schema();
        for (TableSchema tableSchema : tableSchemas.values()) {
            schema.addTable(new Table(tableSchema.getName(), convertColumns(tableSchema.getColumns())));
        }

        return schema;
    }

    /**
     * Converts a list of ColumnSchemas to a list of Columns.
     *
     * @param columnSchemas The list of column schemas to be converted.
     * @return A list of Columns obtained from the column schemas.
     */
    private List<Column> convertColumns(List<ColumnSchema> columnSchemas) {
        List<Column> columns = new ArrayList<>();
        for (ColumnSchema columnSchema : columnSchemas) {
            columns.add(new Column(columnSchema.getName(), columnSchema.isNullable(),
                    false, convertType(columnSchema.getType())));
        }

        return columns;
    }

    /**
     * Returns the correct DataType corresponding to the DBType.
     * @param type The type to be converted.
     * @return The correct DataType based on the DBType.
     */
    private DataType convertType(DBType type) {
        if (type instanceof DBInteger || type instanceof DBDouble) {
            return DataType.NUM;
        } else {
            return DataType.STRING;
        }
    }
}

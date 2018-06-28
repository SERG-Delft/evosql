package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import nl.tudelft.serg.evosql.db.ISchemaExtractor;
import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.fixture.type.DBType;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

import java.util.Map;

@AllArgsConstructor
public class SchemaXMLBuilder {
    private String query;
    private ISchemaExtractor schemaExtractor;


    /**
     * Builds the schema XML
     * @return
     */
    protected String getSchemaXml() {
        String result= "<schema>";

        Map<String, TableSchema> tableSchemas = schemaExtractor.getTablesFromQuery(query);

        for (TableSchema tableSchema : tableSchemas.values()) {
            result += getTableSchemaXml(tableSchema);
        }

        result += "</schema>";

        return result;
    }

    protected String getTableSchemaXml(TableSchema tableSchema) {
        String result = "<table name=\"" + tableSchema.getName() + "\">";

        for (ColumnSchema columnSchema : tableSchema.getColumns()) {
            result += getColumnSchemaXml(columnSchema);
        }

        result += "</table>";

        return result;
    }

    protected String getColumnSchemaXml(ColumnSchema columnSchema) {
        String result = "<column ";

        result += "name=\"" + columnSchema.getName() + "\" ";
        result += "type=\"" + getTypeXml(columnSchema.getType()) + "\" ";
        //TODO if we use primary keys
		/*
		if (columnSchema.isPrimaryKey()) {
			result += "key=\"true\"";
		}
		*/
        if (!columnSchema.isNullable()) {
            result += "notnull=\"true\"";
        }

        result += "/>";

        return result;
    }

    /**
     * Converts evosql types to the correct string for SQLFpc
     * @param type
     * @return
     */
    protected String getTypeXml(DBType type) {
        String result = type.getNormalizedTypeString().toLowerCase();

        if (type instanceof DBString)
            result = "varchar";

        return result;
    }
}

package nl.tudelft.serg.evosql.db;

import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.fixture.type.DBType;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

import java.util.Map;

/**
 * This class finds all the tables in a query and converts it into XML format compatible with
 * SQLFpc and SQLMutation.
 */
public class TableXMLFormatter {
    private ISchemaExtractor schemaExtractor;
    private String query;

    public TableXMLFormatter(ISchemaExtractor schemaExtractor, String query) {
        this.schemaExtractor = schemaExtractor;
        this.query = query;
    }

    /**
     * Builds the schema XML
     * @return tables from query in XML format.
     */
    public String getSchemaXml() {
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

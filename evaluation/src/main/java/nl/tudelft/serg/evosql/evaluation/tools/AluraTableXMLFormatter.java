package nl.tudelft.serg.evosql.evaluation.tools;

import nl.tudelft.serg.evosql.db.ISchemaExtractor;
import nl.tudelft.serg.evosql.db.TableXMLFormatter;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class AluraTableXMLFormatter extends TableXMLFormatter {
    private Crypto crypto;

    public AluraTableXMLFormatter(ISchemaExtractor schemaExtractor, String query, Crypto crypto) {
        super(schemaExtractor, query);
        this.crypto = crypto;
    }

    @Override
    protected String getTableSchemaXml(TableSchema tableSchema) {
        String result = "<table name=\"" + crypto.encryptName(tableSchema.getName().toUpperCase()) + "\">";

        for (ColumnSchema columnSchema : tableSchema.getColumns()) {
            result += getColumnSchemaXml(columnSchema);
        }

        result += "</table>";

        return result;
    }

    @Override
    protected String getColumnSchemaXml(ColumnSchema columnSchema) {
        String result = "<column ";

        result += "name=\"" + crypto.encryptName(columnSchema.getName().toUpperCase()) + "\" ";
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
}

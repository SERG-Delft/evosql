package nl.tudelft.serg.evosql.evaluation.tools;

import java.util.ArrayList;
import java.util.List;

import in2test.application.services.SQLFpcWSFacade;
import nl.tudelft.serg.evosql.EvoSQLException;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.path.PathExtractor;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class AluraPathExtractor extends PathExtractor {
	
	private Crypto crypto;

	public AluraPathExtractor(SchemaExtractor schemaExtractor, Crypto crypto) {
		super(schemaExtractor);
		this.crypto = crypto;
	}

	@Override
	public List<String> getPaths(String query) throws Exception {
		if (!configured) throw new EvoSQLException("Path extractor has not been initialized");
		
		List<String> encryptedPaths = new ArrayList<String>();
		
		String encryptedSchemaXml;
		try {
			encryptedSchemaXml = getSchemaXml(query, schemaExtractor);
		} catch (Exception e) {
			throw new Exception("Failed to extract the schema from the running database.", e);
		}
		String sqlfpcXml ="";
		SQLFpcWSFacade wsFpc=new SQLFpcWSFacade();
		
		String encryptedQuery = crypto.encryptSQLSelect(query);
		
		sqlfpcXml=wsFpc.getRules(encryptedQuery, encryptedSchemaXml, ""); 
		
		extractPaths(sqlfpcXml, encryptedPaths);
		
		List<String> paths = new ArrayList<String>();
		// Decrypt the paths
		for (String path : encryptedPaths) {
			paths.add(crypto.decryptSQLSelect(path));
		}
		
		return paths;
	}

	@Override
	protected String getTableSchemaXml(TableSchema tableSchema) {
		String result = "<table name=\"" + crypto.encryptName(tableSchema.getName().toUpperCase()) + "\">";
		
		for (ColumnSchema columnSchema : tableSchema.getColumns()) {
			result += getColumnSchemaXml(columnSchema);
		}
		
		result += "</table>";
		
		log.debug("xml to sqlfpc: " + result);
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

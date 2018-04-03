package nl.tudelft.serg.evosql.path;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import nl.tudelft.serg.evosql.db.ISchemaExtractor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import in2test.application.common.SQLToolsConfig;
import in2test.application.services.SQLFpcWSFacade;
import nl.tudelft.serg.evosql.EvoSQLException;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.fixture.type.DBType;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

public class PathExtractor {
	protected boolean configured = false;
	
	protected static Logger log = LogManager.getLogger(PathExtractor.class);
	
	protected ISchemaExtractor schemaExtractor;
	
	public PathExtractor(ISchemaExtractor schemaExtractor) {
		this.schemaExtractor = schemaExtractor;
	}
	
	public void initialize() {
		SQLToolsConfig.configure(); //this is required to use the SQLFpc web service Facade
		configured = true;
	}
	
	public List<String> getPaths(String query) throws Exception {
		if (!configured) throw new EvoSQLException("Path extractor has not been initialized");
		
		List<String> paths = new ArrayList<String>();
		
		String schemaXml;
		try {
			schemaXml = getSchemaXml(query, schemaExtractor);
		} catch (Exception e) {
			throw new Exception("Failed to extract the schema from the running database.", e);
		}
		String sqlfpcXml ="";
		SQLFpcWSFacade wsFpc=new SQLFpcWSFacade();
		sqlfpcXml=wsFpc.getRules(query, schemaXml, ""); 
		
		extractPaths(sqlfpcXml, paths);
		
		return paths;
	}
	
	/**
	 * Builds the schema XML
	 * @param query
	 * @param schemaExtractor
	 * @return
	 */
	protected String getSchemaXml(String query, ISchemaExtractor schemaExtractor) {
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
		
		log.debug("xml to sqlfpc: " + result);
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
	
	/**
	 * Extracts all SQL paths into list
	 * @param sqlfpcXml XML from the web service
	 * @param intoList list to put the SQL paths in
	 * @return true if successful, false if any error
	 */
	protected boolean extractPaths(String sqlfpcXml, List<String> intoList) throws Exception {
		InputStream stream = new ByteArrayInputStream(sqlfpcXml.getBytes("UTF-8"));
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = dbFactory.newDocumentBuilder();
		Document doc = builder.parse(stream);
		doc.getDocumentElement().normalize();
		
		if (doc.getElementsByTagName("error").getLength() > 0) {
			System.err.println(doc.getElementsByTagName("error").item(0).getTextContent());
			return false;
		}
		
		NodeList rules = doc.getElementsByTagName("fpcrule");
		for (int i = 0; i < rules.getLength(); i++) {
			Node n = rules.item(i);
			if (n.getNodeType() == Node.ELEMENT_NODE) {
				Element eNode = (Element) n;
				String sql = eNode.getElementsByTagName("sql").item(0).getTextContent();
				// Secure the sql in case SQLFpc messed it up
				sql = new SqlSecurer(sql).getSecureSql();
				intoList.add(sql);
			}
		}
		
		return true;
	}
	
	
}

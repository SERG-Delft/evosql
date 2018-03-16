package nl.tudelft.serg.evosql.db;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.fixture.type.*;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.TablesNamesFinder;

public class SchemaExtractor implements ISchemaExtractor {

	private static Logger log = LogManager.getLogger(SchemaExtractor.class);
	
	private Map<String, TableSchema> knownTables;
	
	private String jdbc;
	private String user;
	private String pwd;

	private String database;

	public SchemaExtractor(String jdbc, String database, String user, String pwd) {
		this.jdbc = jdbc;
		this.database = database;
		this.user = user;
		this.pwd = pwd;
		
		knownTables = new HashMap<String, TableSchema>();
	}
	
	@Override
	public TableSchema extract(String table) {
		if (knownTables.containsKey(table)) {
			return knownTables.get(table);
		}
		
		Connection con=null;
		log.debug("Extracting schema from table: " + table);
		try {
			con = DriverManager.getConnection(jdbc, user, pwd);
			
			DatabaseMetaData metaData = con.getMetaData();

			ResultSet result = metaData.getTables(database, null, "%", new String[] { "TABLE" });
			while (result.next()) {
				String tableName = result.getString(3);
				if(!tableName.toUpperCase().equals(table.toUpperCase())) continue;
				
				ResultSet columns = metaData.getColumns(database, null, tableName, null);

				List<ColumnSchema> parsedColumns = new ArrayList<>();		
				TableSchema ts = new TableSchema(tableName, parsedColumns);		
				
				while (columns.next()) {
					String columnName = columns.getString(4);
					int dataType = columns.getInt(5);
					int length = columns.getInt(7);
					int nullable = columns.getInt(11);
					String autoIncrement = columns.getString(23);

					DBType dbDataType = createDBType(dataType, length);
					
					log.debug("Field {}={}", columnName, dbDataType.getClass().getSimpleName());

					parsedColumns.add(new ColumnSchema(ts, columnName, dbDataType, nullable==1?true:false, autoIncrement.toLowerCase().equals("yes")?true:false));
				}
				
				log.debug("Columns found: " + parsedColumns.size());
				log.debug("Table schema: " + parsedColumns);
				knownTables.put(table, ts);
				return ts;
			}
			
			throw new RuntimeException("table " + table + " doesn't exist");

		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			try {
				if(con!=null) con.close();
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	private DBType createDBType(int dataType, int length) {
		DBType dbDataType = null;
		if(dataType == Types.DOUBLE) dbDataType= new DBDouble();
		else if(dataType == Types.REAL) dbDataType = new DBDouble();
		else if(dataType == Types.DECIMAL) dbDataType = new DBDouble();
		else if(dataType == Types.INTEGER) dbDataType = new DBInteger();
		else if(dataType == Types.SMALLINT) dbDataType = new DBInteger();
		else if(dataType == Types.VARCHAR) dbDataType = new DBString(length);
		else if(dataType == Types.LONGVARCHAR) dbDataType = new DBString(EvoSQLConfiguration.MAX_STRING_LENGTH);
		else if(dataType == Types.CHAR)	dbDataType = new DBString(length);
		else if(dataType == Types.BOOLEAN) dbDataType = new DBBoolean();
		else if(dataType == Types.DATE) dbDataType = new DBDate();
		else if(dataType == Types.TIME) dbDataType = new DBTime();
		else if(dataType == Types.TIMESTAMP) dbDataType = new DBDateTime(); //datetime
		else if(dataType == Types.TINYINT) dbDataType = new DBInteger(); // HSQLDB doesnt support tinyint
		else if(dataType == Types.BIT) dbDataType = new DBBoolean(); // HSQLDB doesnt support bit
		else if(dataType == Types.BIGINT) dbDataType = new DBInteger(); // we dont need bigint in our evaluations
		else if(dataType == Types.ARRAY) throw new RuntimeException("EvoSQL lacks a ARRAY implementation");
		else throw new RuntimeException("DB type not supported: " + dataType);
		
		return dbDataType;
	}

	@Override
	public Map<String, TableSchema> getTablesFromQuery(String pathToBeTested) {
		Map<String, TableSchema> tableSchemas = new HashMap<String, TableSchema>();
		
		// Get a list of table names from the query
		Statement stmt;
		try {
			stmt = CCJSqlParserUtil.parse(pathToBeTested);
		} catch (JSQLParserException e) {
			e.printStackTrace();
			return null;
		}
		
		if (!(stmt instanceof Select)) {
			return null;
		}
		List<String> tableList = new TablesNamesFinder().getTableList(stmt);
		
		for (String tableName : tableList) {
			tableName = tableName.replaceAll("^\"|\"$", ""); // Remove quotes around tablenames
			tableSchemas.put(tableName,	this.extract(tableName));
		}
		
		return tableSchemas;
	}
}

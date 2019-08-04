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
    private final DBTypeSelector dbTypeSelector;

    private String jdbc;
    private String user;
    private String pwd;

    private String database;

    public SchemaExtractor(String jdbc, String database, String user, String pwd) {
        this.jdbc = jdbc;
        this.database = database;
        this.user = user;
        this.pwd = pwd;

        knownTables = new HashMap<>();
        dbTypeSelector = new DBTypeSelector();
    }

    @Override
    public TableSchema extract(String table) {
        if (knownTables.containsKey(table)) {
            return knownTables.get(table);
        }

        Connection con = null;
        log.debug("Extracting schema from table: " + table);
        try {
            con = DriverManager.getConnection(jdbc, user, pwd);

            DatabaseMetaData metaData = con.getMetaData();

            ResultSet result = metaData.getTables(null, null, "%", new String[]{"TABLE"});
            while (result.next()) {
                String tableName = result.getString(3);
                if (!tableName.toUpperCase().equals(table.toUpperCase())) continue;

                ResultSet columns = metaData.getColumns(null, null, tableName, null);

                List<ColumnSchema> parsedColumns = new ArrayList<>();
                TableSchema ts = new TableSchema(tableName, parsedColumns);

                while (columns.next()) {
                    String columnName = columns.getString(4);
                    int dataType = columns.getInt(5);
                    int length = columns.getInt(7);
                    int nullable = columns.getInt(11);
                    String autoIncrement = columns.getString(23);

                    DBType dbDataType = dbTypeSelector.create(dataType, length);

                    log.debug("Field {}={}", columnName, dbDataType.getClass().getSimpleName());

                    parsedColumns.add(new ColumnSchema(ts, columnName, dbDataType, nullable == 1 ? true : false, autoIncrement.toLowerCase().equals("yes") ? true : false));
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
                if (con != null) con.close();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public Map<String, TableSchema> getTablesFromQuery(String pathToBeTested) {
        Map<String, TableSchema> tableSchemas = new HashMap<>();

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
            tableSchemas.put(tableName, this.extract(tableName));
        }

        return tableSchemas;
    }
}

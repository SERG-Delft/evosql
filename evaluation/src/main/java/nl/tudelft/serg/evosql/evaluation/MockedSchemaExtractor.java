package nl.tudelft.serg.evosql.evaluation;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.db.ISchemaExtractor;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.TablesNamesFinder;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by mauricioaniche on 31/07/2017.
 */
public class MockedSchemaExtractor implements ISchemaExtractor {

    private Map<String, TableSchema> tables;

    public MockedSchemaExtractor(Map<String, TableSchema> tables) {

        this.tables = tables.entrySet().stream()
                .collect(Collectors.toMap(entry -> entry.getKey().toUpperCase(), entry -> entry.getValue()));

    }

    @Override
    public TableSchema extract(String table) {
        return tables.get(table.toUpperCase());
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

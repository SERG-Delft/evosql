package nl.tudelft.serg.evosql.db;

import nl.tudelft.serg.evosql.sql.TableSchema;

import java.util.Map;

/**
 * Created by mauricioaniche on 31/07/2017.
 */
public interface ISchemaExtractor {
    TableSchema extract(String table);

    Map<String, TableSchema> getTablesFromQuery(String pathToBeTested);
}

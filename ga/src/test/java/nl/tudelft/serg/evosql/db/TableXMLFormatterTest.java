package nl.tudelft.serg.evosql.db;

import nl.tudelft.serg.evosql.sql.TableSchema;
import org.junit.jupiter.api.BeforeAll;
import org.mockito.Mock;
import org.mockito.Mockito;

import java.util.HashMap;
import java.util.Map;

import static org.mockito.ArgumentMatchers.any;

public class TableXMLFormatterTest {
    @Mock
    private ISchemaExtractor schemaExtractor;
    private TableXMLFormatter tableXMLFormatter;

    @BeforeAll
    public void setup() {
        Map<String, TableSchema> schemaMap = new HashMap<>();
        Mockito.when(schemaExtractor.getTablesFromQuery(any(String.class))).thenReturn(schemaMap);
    }
}

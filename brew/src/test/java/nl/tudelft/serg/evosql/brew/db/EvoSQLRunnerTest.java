package nl.tudelft.serg.evosql.brew.db;

import nl.tudelft.serg.evosql.EvoSQL;
import nl.tudelft.serg.evosql.PathResult;
import nl.tudelft.serg.evosql.Result;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.fixture.type.DBInteger;
import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class EvoSQLRunnerTest {
    @Test
    void testRunQueryFail() {
        assertThatNullPointerException().isThrownBy(() -> {
            new EvoSQLRunner().runQuery(null, Mockito.mock(ConnectionData.class));
        });
        assertThatNullPointerException().isThrownBy(() -> {
            new EvoSQLRunner().runQuery("Select * From all", null);
        });
    }

    /**
     * Tests the conversion from EvoSQL to Brew.
     */
    @Test
    void conversionTest() {
        Result result = new Result("Select * From table", 0);
        result.getPathResults().add(buildPathResult(1));
        result.getPathResults().add(buildPathResult(2));

        EvoSQLRunner evoSQLRunner = new EvoSQLRunner();
        nl.tudelft.serg.evosql.brew.data.Result brewResult = evoSQLRunner.convertResult(result);

        assertThat(brewResult.getInputQuery()).isEqualTo("Select * From table");
        assertThat(brewResult.getPaths().size()).isEqualTo(2);
        assertThat(brewResult.getPaths().get(0).getFixture().getTables().size()).isEqualTo(3);

        assertThat(brewResult.getPaths().get(0).getPathSql()).isEqualTo("Select * From table1");
        assertThat(brewResult.getPaths().get(1).getFixture().getTables().get(1).getSchema().getName())
                .isEqualTo("testTable2");
        // GA capitalizes column names
        assertThat(brewResult.getPaths().get(0).getFixture().getTables().get(0).getRows().get(0).getValues().get("testColumn1_1"))
                .isEqualTo("'string1'");
        assertThat(brewResult.getPaths().get(0).getFixture().getTables().get(2).getRows().get(1).getValues().get("testColumn3_2"))
                .isEqualTo("20");
    }

    @Test
    void runQueryTest() {
        EvoSQL evoSQL = Mockito.mock(EvoSQL.class);
        EvoSQLFactory evoSQLFactory = Mockito.mock(EvoSQLFactory.class);
        Mockito.when(evoSQLFactory.createEvoSQL(Mockito.any())).thenReturn(evoSQL);
        Result result = new Result("Select * From all;", 0);
        Mockito.when(evoSQL.execute(Mockito.anyString())).thenReturn(result);
        ConnectionData connectionData = new ConnectionData("cs", "db", "user", "pass");

        EvoSQLRunner evoSQLRunner = new EvoSQLRunner();
        evoSQLRunner.setEvoSQLFactory(evoSQLFactory);
        evoSQLRunner.runQuery("Select * From all;", connectionData);

        Mockito.verify(evoSQLFactory, Mockito.times(1)).createEvoSQL(connectionData);
        Mockito.verify(evoSQL, Mockito.times(1)).execute("Select * From all;");
    }

    /** Builds a new EvoSQL path result object. */
    private PathResult buildPathResult(int n) {
        List<FixtureTable> tables = new ArrayList<>();
        tables.add(buildFixtureTable(1));
        tables.add(buildFixtureTable(2));
        tables.add(buildFixtureTable(3));

        Fixture evoSQLFixture = new Fixture(tables);

        PathResult pathResult = new PathResult(
                n,
                "Select * From table" + n,
                0,
                evoSQLFixture,
                true,
                0,
                1,
                ""
        );

        return pathResult;
    }

    /** Builds a new EvoSQL fixture table. */
    private FixtureTable buildFixtureTable(int n) {
        String tableName = "testTable" + n,
               firstColumn = "testColumn" + n + "_1",
               secondColumn = "testColumn" + n + "_2";

        List<ColumnSchema> columnSchemas = new ArrayList<>();
        TableSchema tableSchema = new TableSchema(tableName, columnSchemas);
        columnSchemas.add(new ColumnSchema(tableSchema, firstColumn, new DBString(10), false, false));
        columnSchemas.add(new ColumnSchema(tableSchema, secondColumn, new DBInteger(), false, false));

        List<FixtureRow> rows = new ArrayList<>();
        FixtureRow row1 = new FixtureRow(tableName, tableSchema);
        row1.set(firstColumn, "'string1'");
        row1.set(secondColumn, "10");
        FixtureRow row2 = new FixtureRow(tableName, tableSchema);
        row2.set(firstColumn, "'string2'");
        row2.set(secondColumn, "20");
        rows.add(row1);
        rows.add(row2);

        return new FixtureTable(tableSchema, rows);
    }
}

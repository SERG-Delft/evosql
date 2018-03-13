package nl.tudelft.serg.evosql.brew.db;

import lombok.NonNull;
import nl.tudelft.serg.evosql.EvoSQL;
import nl.tudelft.serg.evosql.PathResult;
import nl.tudelft.serg.evosql.brew.data.*;
import nl.tudelft.serg.evosql.sql.ColumnSchema;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;

public class EvoSQLRunner implements QueryRunner {
    @Override
    public Result runQuery(@NonNull String sqlQuery, @NonNull ConnectionData connectionData) {
        EvoSQL evoSQL = new EvoSQL(
                connectionData.getConnectionString(),
                connectionData.getDatabase(),
                connectionData.getUsername(),
                connectionData.getPassword(),
                false);

        nl.tudelft.serg.evosql.Result evoSQLResult = evoSQL.execute(sqlQuery);
        return convertResult(evoSQLResult);
    }

    private Result convertResult(nl.tudelft.serg.evosql.Result evoSqlResult) {
        return new Result(
                evoSqlResult.getInputQuery(),
                evoSqlResult.getPathResults().stream().map(this::convertPathResult).collect(Collectors.toList())
        );
    }

    private Path convertPathResult(PathResult pathResult) {
        return new Path(
                convertFixture(pathResult.getFixture()),
                pathResult.getPathSql()
        );
    }

    private Fixture convertFixture(nl.tudelft.serg.evosql.fixture.Fixture evoSqlFixture) {
        return new Fixture(
                evoSqlFixture.getTables().stream().map(this::convertFixtureTable).collect(Collectors.toList())
        );
    }

    private FixtureTable convertFixtureTable(nl.tudelft.serg.evosql.fixture.FixtureTable fixtureTable) {
        final TableSchema schema = convertTableSchema(fixtureTable.getSchema());
        return new FixtureTable(
                schema,
                fixtureTable.getRows().stream().map(r -> convertFixtureRow(r, schema)).collect(Collectors.toList())
        );
    }

    private TableSchema convertTableSchema(nl.tudelft.serg.evosql.sql.TableSchema tableSchema) {
        return new TableSchema(
                tableSchema.getName(),
                tableSchema.getColumns().stream().map(ColumnSchema::getName).collect(Collectors.toList())
        );
    }

    private FixtureRow convertFixtureRow(nl.tudelft.serg.evosql.fixture.FixtureRow fixtureRow, TableSchema schema) {
        return new FixtureRow(
                new HashMap<>(fixtureRow.getValues()),
                schema
        );
    }
}

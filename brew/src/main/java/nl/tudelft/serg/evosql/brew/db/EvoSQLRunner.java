package nl.tudelft.serg.evosql.brew.db;

import lombok.NonNull;
import nl.tudelft.serg.evosql.EvoSQL;
import nl.tudelft.serg.evosql.PathResult;
import nl.tudelft.serg.evosql.brew.data.Fixture;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;

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
        return toBrewResult(evoSQLResult);
    }

    private Result toBrewResult(nl.tudelft.serg.evosql.Result evoSqlResult) {
        return new Result(
                evoSqlResult.getInputQuery(),
                evoSqlResult.getPathResults().stream().map(this::pathResultToPath).collect(Collectors.toList())
        );
    }

    private Path pathResultToPath(PathResult pathResult) {
        return new Path(
                evoSqlFixtureToFixture(pathResult.getFixture()),
                pathResult.getPathSql()
        );
    }

    private Fixture evoSqlFixtureToFixture(nl.tudelft.serg.evosql.fixture.Fixture evoSqlFixture) {
        return new Fixture();
    }
}

package nl.tudelft.serg.evosql.brew.db;

import lombok.Getter;
import nl.tudelft.serg.evosql.fixture.Fixture;

import java.util.List;

public abstract class QueryRunner {
    protected abstract List<Fixture> runQuery(String query);

    @Getter private static String bla = "Currently running a query...";
}

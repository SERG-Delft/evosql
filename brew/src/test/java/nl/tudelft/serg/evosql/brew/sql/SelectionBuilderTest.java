package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;

public class SelectionBuilderTest extends QueryBuilderTest {
    @Test
    void selectionBuilderTestSmall() {
        // it should only wrap the query in a singleton list
        SelectionBuilder selectionBuilder = new SelectionBuilder(new MySQLOptions());
        Result result1 = DataGenerator.makeResult1();

        assertThat(selectionBuilder.buildQueries(result1.getPaths().get(0)))
                .isEqualTo(Collections.singletonList(result1.getPaths().get(0).getPathSql()));
    }

    @Test
    void selectionBuilderTestMedium() {
        // it should only wrap the query in a singleton list
        SelectionBuilder selectionBuilder = new SelectionBuilder(new MySQLOptions());
        Result result2 = DataGenerator.makeResult2();

        assertThat(selectionBuilder.buildQueries(result2.getPaths().get(2)))
                .isEqualTo(Collections.singletonList(result2.getPaths().get(2).getPathSql()));
    }

    @Override
    protected QueryBuilder getQueryBuilder() {
        return new SelectionBuilder(new MySQLOptions());
    }
}

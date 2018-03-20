package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;

public class SelectionBuilderTest {
    @Test
    void selectionBuilderTest() {
        // it should only wrap the query in a singleton list
        SelectionBuilder selectionBuilder = new SelectionBuilder(new MySQLOptions());
        Result result1 = new DataGenerator().makeResult1();

        assertThat(selectionBuilder.buildQueries(result1.getPaths().get(0)))
                .isEqualTo(Collections.singletonList(result1.getPaths().get(0).getPathSql()));
    }
}

package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.data.TableSchema;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class InsertionBuilderTest {
    @Test
    void result1Test() {
        Result result1 = new DataGenerator().makeResult1();
        InsertionBuilder insertionBuilder = new InsertionBuilder(new MySQLOptions());

        List<String> insertionQueries = insertionBuilder.buildQueries(result1.getPaths().get(0));

        List<String> expectedQueries = Arrays.asList(
                "INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');"
        );

        assertThat(insertionQueries).isEqualTo(expectedQueries);
    }
}

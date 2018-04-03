package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.data.TableSchema;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static org.assertj.core.api.Assertions.assertThat;

public class InsertionBuilderTest extends QueryBuilderTest {
    @Test
    void result1Test() {
        Result result1 = DataGenerator.makeResult1();
        InsertionBuilder insertionBuilder = new InsertionBuilder(new MySQLOptions());

        List<String> insertionQueries = insertionBuilder.buildQueries(result1.getPaths().get(0));

        List<String> expectedQueries = Arrays.asList(
                "INSERT INTO `table1` (`column1_1`, `column1_2`, `column1_3`) VALUES (1, 0.5, 'The first row of table 1.'), (2, 1.5, 'The second row.');"
        );

        assertThat(insertionQueries).isEqualTo(expectedQueries);
    }

    @Test
    void result2Test() {
        Result result2 = DataGenerator.makeResult2();
        InsertionBuilder insertionBuilder = new InsertionBuilder(new MySQLOptions());

        List<List<String>> pathsQueries = result2.getPaths().stream()
                .map(insertionBuilder::buildQueries)
                .collect(Collectors.toList());

        // All paths use the same data so the SQL should be the same
        List<String> expectedQueries = Arrays.asList(
                "INSERT INTO `table1` (`column1_1`, `column1_2`) VALUES (1, 'String of row 1'), (2, 'String of row 2');",
                "INSERT INTO `products` (`product_name`, `expired`, `expiry_date`) VALUES ('Milk', 0, '2018-03-22 00:00:00'), ('Yogurt', 1, '2018-03-15 00:00:00'), ('Salt', 0, '2025-12-31 23:59:59');");

        for (List<String> pathQuery : pathsQueries) {
            assertThat(pathQuery).isEqualTo(expectedQueries);
        }
    }

    @Override
    protected QueryBuilder getQueryBuilder() {
        return new InsertionBuilder(new MySQLOptions());
    }
}

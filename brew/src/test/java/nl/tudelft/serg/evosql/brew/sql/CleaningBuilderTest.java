package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class CleaningBuilderTest extends QueryBuilderTest {
    private List<Path> pathsSmall;
    private List<Path> pathsMedium;

    @BeforeEach
    void pathSetup() {
        pathsSmall = DataGenerator.makeResult1().getPaths();
        pathsMedium = DataGenerator.makeResult2().getPaths();
    }


    @Test
    void truncateTableMySQLStringTest() {
        String expected = "TRUNCATE TABLE `table1`;";
        CleaningBuilder cleaningBuilder = new CleaningBuilder(new MySQLOptions());
        assertThat(cleaningBuilder.buildQueries(pathsSmall.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    void truncateTablePostgreSQLTest() {
        String expected = "TRUNCATE TABLE \"table1\";";
        CleaningBuilder cleaningBuilder = new CleaningBuilder(new PostgreSQLOptions());
        assertThat(cleaningBuilder.buildQueries(pathsSmall.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    void dropTableMySQLStringTestMedium() {
        List<String> expected = Arrays.asList("TRUNCATE TABLE `table1`;", "TRUNCATE TABLE `products`;");
        CleaningBuilder cleaningBuilder = new CleaningBuilder(new MySQLOptions());
        assertThat(cleaningBuilder.buildQueries(pathsMedium.get(2))).isEqualTo(expected);
    }

    @Override
    protected QueryBuilder getQueryBuilder() {
        return new CleaningBuilder(new MySQLOptions());
    }
}

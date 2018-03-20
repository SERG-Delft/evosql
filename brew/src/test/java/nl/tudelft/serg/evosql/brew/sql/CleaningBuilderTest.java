package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class CleaningBuilderTest {
    private List<Path> paths;

    @BeforeEach
    public void pathSetup() {
        DataGenerator generator = new DataGenerator();
        paths = generator.makeResult1().getPaths();
    }


    @Test
    public void createTableMySQLStringTest() {
        String expected = "TRUNCATE TABLE `table1`;";
        CleaningBuilder cleaningBuilder = new CleaningBuilder(new MySQLOptions());
        assertThat(cleaningBuilder.buildQueries(paths.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    public void createTablePostgreSQLTest() {
        String expected = "TRUNCATE TABLE \"table1\";";
        CleaningBuilder cleaningBuilder = new CleaningBuilder(new PostgreSQLOptions());
        assertThat(cleaningBuilder.buildQueries(paths.get(0)).get(0)).isEqualTo(expected);
    }
}

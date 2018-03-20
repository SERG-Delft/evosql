package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class DestructionBuilderTest {
    private List<Path> paths;

    @BeforeEach
    public void pathSetup() {
        DataGenerator generator = new DataGenerator();
        paths = generator.makeResult1().getPaths();
    }


    @Test
    public void createTableMySQLStringTest() {
        String expected = "DROP TABLE `table1`;";
        DestructionBuilder destructionBuilder = new DestructionBuilder(new MySQLOptions());
        assertThat(destructionBuilder.buildQueries(paths.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    public void createTablePostgreSQLTest() {
        String expected = "DROP TABLE \"table1\";";
        DestructionBuilder destructionBuilder = new DestructionBuilder(new PostgreSQLOptions());
        assertThat(destructionBuilder.buildQueries(paths.get(0)).get(0)).isEqualTo(expected);
    }
}

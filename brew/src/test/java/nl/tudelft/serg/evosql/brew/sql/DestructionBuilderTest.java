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

public class DestructionBuilderTest {
    private List<Path> pathsSmall;
    private List<Path> pathsMedium;

    @BeforeEach
    void pathSetup() {
        DataGenerator generator = new DataGenerator();
        pathsSmall = generator.makeResult1().getPaths();
        pathsMedium = generator.makeResult2().getPaths();
    }


    @Test
    void dropTableMySQLStringTestSmall() {
        String expected = "DROP TABLE `table1`;";
        DestructionBuilder destructionBuilder = new DestructionBuilder(new MySQLOptions());
        assertThat(destructionBuilder.buildQueries(pathsSmall.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    void dropTablePostgreSQLTestSmall() {
        String expected = "DROP TABLE \"table1\";";
        DestructionBuilder destructionBuilder = new DestructionBuilder(new PostgreSQLOptions());
        assertThat(destructionBuilder.buildQueries(pathsSmall.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    void dropTableMySQLStringTestMedium() {
        List<String> expected = Arrays.asList("DROP TABLE `table1`;", "DROP TABLE `products`;");
        DestructionBuilder destructionBuilder = new DestructionBuilder(new MySQLOptions());
        assertThat(destructionBuilder.buildQueries(pathsMedium.get(2))).isEqualTo(expected);
    }
}

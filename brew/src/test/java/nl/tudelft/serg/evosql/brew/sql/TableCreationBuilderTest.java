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

public class TableCreationBuilderTest {
    private List<Path> pathsSmall;
    private List<Path> pathsMedium;

    @BeforeEach
    void pathSetup() {
        pathsSmall = DataGenerator.makeResult1().getPaths();
        pathsMedium = DataGenerator.makeResult2().getPaths();
    }


    @Test
    void createTableMySQLStringTestSmall() {
        String expected = "CREATE TABLE `table1` (`column1_1` INTEGER, `column1_2` DOUBLE, `column1_3` VARCHAR(100));";
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(new MySQLOptions());
        assertThat(tableCreationBuilder.buildQueries(pathsSmall.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    void createTablePostgreSQLTestSmall() {
        String expected = "CREATE TABLE \"table1\" (\"column1_1\" INTEGER, \"column1_2\" DOUBLE, \"column1_3\" VARCHAR(100));";
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(new PostgreSQLOptions());
        assertThat(tableCreationBuilder.buildQueries(pathsSmall.get(0)).get(0)).isEqualTo(expected);
    }

    @Test
    void createTableMySQLStringTestMedium() {
        List<String> expected = Arrays.asList(
                "CREATE TABLE `table1` (`column1_1` INTEGER, `column1_2` VARCHAR(100));",
                "CREATE TABLE `products` (`product_name` VARCHAR(100), `expired` BIT, `expiry_date` DATETIME);");
        TableCreationBuilder tableCreationBuilder = new TableCreationBuilder(new MySQLOptions());
        assertThat(tableCreationBuilder.buildQueries(pathsMedium.get(3))).isEqualTo(expected);
    }
}

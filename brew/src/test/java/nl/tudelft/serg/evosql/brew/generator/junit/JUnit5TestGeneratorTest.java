package nl.tudelft.serg.evosql.brew.generator.junit;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class JUnit5TestGeneratorTest extends JUnitGeneratorTest {
    private Result resultSmall = DataGenerator.makeResult1();
    private Result resultMedium = DataGenerator.makeResult2();

    @Test
    public void testMethodgenerationSmall() {
        ConnectionData connectionData = new ConnectionData(
                TEST_DATABASE_JDBC_URL,
                "db",
                TEST_DATABASE_USER,
                TEST_DATABASE_PASSWORD
        );
        JUnitGeneratorSettings JUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionData,
                "brew.test.generated",
                "JUnit5SmallTest",
                true,
                true,
                true,
                false,
                false
        );
        JUnit5TestGenerator jUnit5TestGenerator = new JUnit5TestGenerator(JUnitGeneratorSettings);
        assertThat(jUnit5TestGenerator.generate(resultSmall, new MySQLOptions()))
                .isEqualTo(getExpected("JUnit5Small.txt"));
    }

    @Test
    public void testMethodgenerationMedium() {
        ConnectionData connectionData = new ConnectionData(
                "connection string",
                "db",
                "user",
                "password"
        );
        JUnitGeneratorSettings JUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionData,
                "brew.test.generated",
                "JUnit5MediumTest",
                false,
                false,
                false,
                true,
                true
        );
        JUnit5TestGenerator jUnit4TestGenerator = new JUnit5TestGenerator(JUnitGeneratorSettings);
        assertThat(jUnit4TestGenerator.generate(resultMedium, new MySQLOptions()))
                .isEqualTo(getExpected("JUnit5Medium.txt"));
    }
}

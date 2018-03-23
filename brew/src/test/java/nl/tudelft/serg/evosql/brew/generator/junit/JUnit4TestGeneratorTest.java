package nl.tudelft.serg.evosql.brew.generator.junit;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class JUnit4TestGeneratorTest extends JUnitGeneratorTest {
    private Result resultSmall = DataGenerator.makeResult1();
    private Result resultMedium = DataGenerator.makeResult2();

    @Test
    public void testMethodGenerationSmall() {
        ConnectionData connectionData = new ConnectionData(
                "connection string",
                "db",
                "user",
                "password"
        );
        JUnitGeneratorSettings JUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionData,
                "brew.test.generated",
                "JUnit4SmallTest",
                true,
                true,
                true,
                true,
                true
        );
        JUnit4TestGenerator jUnit4TestGenerator = new JUnit4TestGenerator(JUnitGeneratorSettings);
        assertThat(jUnit4TestGenerator.generate(resultSmall, new MySQLOptions()))
                .isEqualTo(getExpected("JUnit4Small.txt"));
    }

    @Test
    public void testMethodGenerationMedium() {
        ConnectionData connectionData = new ConnectionData(
                "connection string",
                "db",
                "user",
                "password"
        );
        JUnitGeneratorSettings JUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionData,
                "brew.test.generated",
                "JUnit4MediumTest",
                true,
                true,
                true,
                true,
                true
        );
        JUnit4TestGenerator jUnit4TestGenerator = new JUnit4TestGenerator(JUnitGeneratorSettings);
        assertThat(jUnit4TestGenerator.generate(resultMedium, new MySQLOptions()))
                .isEqualTo(getExpected("JUnit4Medium.txt"));
    }
}

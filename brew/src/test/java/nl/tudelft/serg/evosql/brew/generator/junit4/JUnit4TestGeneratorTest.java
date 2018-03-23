package nl.tudelft.serg.evosql.brew.generator.junit4;

import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.generator.TestGeneratorSettings;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.jupiter.api.Test;

public class JUnit4TestGeneratorTest {
    private Result resultSmall = DataGenerator.makeResult1();
    private Result resultMedium = DataGenerator.makeResult2();

    @Test
    public void testMethodgenerationSmall() {
        ConnectionData connectionData = new ConnectionData(
                "connection string",
                "db",
                "user",
                "password"
        );
        TestGeneratorSettings testGeneratorSettings = new TestGeneratorSettings(
                connectionData,
                "brew.test.package",
                true,
                true,
                true,
                true,
                true
        );
        JUnit4TestGenerator jUnit4TestGenerator = new JUnit4TestGenerator(testGeneratorSettings);
        System.out.println(jUnit4TestGenerator.generate(resultSmall, new MySQLOptions()));
    }

    @Test
    public void testMethodgenerationMedium() {
        ConnectionData connectionData = new ConnectionData(
                "connection string",
                "db",
                "user",
                "password"
        );
        TestGeneratorSettings testGeneratorSettings = new TestGeneratorSettings(
                connectionData,
                "brew.test.package",
                true,
                true,
                true,
                true,
                true
        );
        JUnit4TestGenerator jUnit4TestGenerator = new JUnit4TestGenerator(testGeneratorSettings);
        System.out.println(jUnit4TestGenerator.generate(resultMedium, new MySQLOptions()));
    }
}

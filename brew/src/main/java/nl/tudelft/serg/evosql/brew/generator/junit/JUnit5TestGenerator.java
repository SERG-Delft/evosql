package nl.tudelft.serg.evosql.brew.generator.junit;

import org.junit.jupiter.api.*;

public class JUnit5TestGenerator extends JUnitGenerator {

    public JUnit5TestGenerator(JUnitGeneratorSettings jUnitGeneratorSettings) {
        super(
                jUnitGeneratorSettings,
                false,
                Test.class,
                BeforeAll.class,
                AfterAll.class,
                BeforeEach.class,
                AfterEach.class,
                Assertions.class
        );
    }
}

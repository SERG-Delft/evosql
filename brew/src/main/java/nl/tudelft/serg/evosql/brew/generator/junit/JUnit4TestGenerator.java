package nl.tudelft.serg.evosql.brew.generator.junit;

import org.junit.*;

public class JUnit4TestGenerator extends JUnitGenerator {

    /**
     * Initializes a new instance of the JUnit4TestGenerator class.
     *
     * @param jUnitgeneratorsettings The settings used for this generator.
     */
    public JUnit4TestGenerator(JUnitGeneratorSettings jUnitgeneratorsettings) {
        super(
                jUnitgeneratorsettings,
                true,
                Test.class,
                BeforeClass.class,
                AfterClass.class,
                Before.class,
                After.class,
                Assert.class
        );
    }
}

package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.*;
import nl.tudelft.serg.evosql.brew.data.Path;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.sql.*;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;
import org.junit.jupiter.api.*;

import javax.annotation.Generated;
import javax.lang.model.element.Modifier;
import java.util.HashSet;
import java.util.Set;

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

package nl.tudelft.serg.evosql.brew.generator.junit4;

import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.TypeSpec;
import nl.tudelft.serg.evosql.brew.DataGenerator;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.sql.vendor.MySQLOptions;
import org.junit.Test;

import java.io.IOException;

public class JUnit4TestGeneratorTest {
    private Result result = DataGenerator.makeResult1();


    @Test
    public void testMethodgeneration() {
        JUnit4TestGenerator jUnit4TestGenerator = new JUnit4TestGenerator();
        System.out.println(jUnit4TestGenerator.generate(result,new MySQLOptions()));
    }
}

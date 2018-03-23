package nl.tudelft.serg.evosql.brew.generator.junit;

import java.util.Scanner;

public abstract class JUnitGeneratorTest {
    String getExpected(String filename) {
        String raw = new Scanner(
                getClass().getClassLoader().getResourceAsStream("java/jUnitGenerator/" + filename),
                "UTF-8").useDelimiter("\\A").next();

        return normalizeLineEndings(raw);
    }

    private String normalizeLineEndings(String string) {
        return string.replaceAll("\r\n", "\n");
    }
}

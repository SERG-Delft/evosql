package nl.tudelft.serg.evosql.brew.generator.junit;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class JUnitGeneratorHelperTest {
    @Test
    void mapMakerTest() {
        JUnitGeneratorHelper helper = new JUnitGeneratorHelper();
        String expected = "/**\n" +
                " * Generates a string map from a list of strings.\n" +
                " */\n" +
                "private java.util.Map<java.lang.String, java.lang.String> makeMap(java.lang.String... strings) {\n" +
                "  java.util.Map<java.lang.String, java.lang.String> result = new java.util.HashMap<>();\n" +
                "  for(int i = 0; i < strings.length; i += 2) {\n" +
                "    result.put(strings[i], strings[i + 1]);\n" +
                "  }\n" +
                "  return result;\n" +
                "}\n";
        assertThat(helper.buildMapMaker().toString()).isEqualTo(expected);
    }
}

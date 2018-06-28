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


    @Test
    void getResultColumnsTest() {
        JUnitGeneratorHelper helper = new JUnitGeneratorHelper();
        String expected = "/**\n" +
                " * Gets the columns of a statement result set.\n" +
                " */\n" +
                "private java.util.List<java.lang.String> getResultColumns(java.sql.ResultSet result) {\n" +
                "  java.sql.ResultSetMetaData meta = result.getMetaData();\n" +
                "  java.util.List<java.lang.String> columns = new java.util.ArrayList<>();\n" +
                "  for (int i = 0; i <= meta.getColumnCount(); ++i) {\n" +
                "    columns.add(meta.getColumnName(i));\n" +
                "  }\n" +
                "  return columns;\n" +
                "}\n";
        assertThat(helper.buildGetResultColumns().toString()).isEqualTo(expected);
    }
}

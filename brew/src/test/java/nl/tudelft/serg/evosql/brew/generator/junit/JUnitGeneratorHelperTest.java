package nl.tudelft.serg.evosql.brew.generator.junit;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class JUnitGeneratorHelperTest {
    @Test
    void runSqlImplementationTest() {
        JUnitGeneratorHelper helper = new JUnitGeneratorHelper();
        String expected = "/**\n" +
                " * Executes an SQL query on the database.\n" +
                " *\n" +
                " * @param query    The query to execute.\n" +
                " * @param isUpdate Whether the query is a data modification statement.\n" +
                " *\n" +
                " * @returns The resulting table, or null if the query is an update.\n" +
                " */\n" +
                "private java.util.Map<java.lang.String, java.lang.String> runSql(java.lang.String query,\n" +
                "    boolean isUpdate) throws java.sql.SQLException {\n" +
                "  java.sql.Connection connection = java.sql.DriverManager.getConnection(DB_JDBC_URL, DB_USER, DB_PASSWORD);\n" +
                "  java.sql.Statement statement = connection.createStatement();\n" +
                "  if (isUpdate == true) {\n" +
                "    statement.executeUpdate(sql);\n" +
                "    return null;\n" +
                "  } else {\n" +
                "    java.util.List<java.util.Map<java.lang.String, java.lang.String>> tableStructure = new java.util.ArrayList<java.util.HashMap<java.lang.String, java.lang.String>>();\n" +
                "    java.sql.ResultSet resultSet = statement.executeQuery(sql);\n" +
                "    java.util.List<java.lang.String> columns = getResultColumns(resultSet);\n" +
                "    while (resultSet.next()) {\n" +
                "      java.util.Map<java.lang.String, java.lang.String> values = new java.util.HashMap<>();\n" +
                "      for (String column : columns) {\n" +
                "        values.put(column, resultSet.getObject(column).toString());\n" +
                "      }\n" +
                "      tableStructure.add(values);\n" +
                "    }\n" +
                "    return tableStructure;\n" +
                "  }\n" +
                "}\n";
        assertThat(helper.buildRunSqlImplementation().toString()).isEqualTo(expected);
    }

    @Test
    void runSqlEmptyTest() {
        JUnitGeneratorHelper helper = new JUnitGeneratorHelper();
        String expected = "/**\n" +
                " * This method should connect to your database and execute the given query.\n" +
                " * In order for the assertions to work correctly this method must return true in the case\n" +
                " * that the query yields at least one result and false if there is no result.\n" +
                " *\n" +
                " * @param query    The query to execute.\n" +
                " * @param isUpdate Whether the query is a data modification statement.\n" +
                " *\n" +
                " * @returns The resulting table, or null if the query is an update.\n" +
                " */\n" +
                "private java.util.Map<java.lang.String, java.lang.String> runSql(java.lang.String query,\n" +
                "    boolean isUpdate) throws java.sql.SQLException {\n" +
                "  // TODO: implement method stub.\n" +
                "  return null;\n" +
                "}\n";
        assertThat(helper.buildRunSqlEmpty().toString()).isEqualTo(expected);
    }

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

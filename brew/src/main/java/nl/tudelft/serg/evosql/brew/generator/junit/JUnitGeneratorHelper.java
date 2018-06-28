package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.ParameterizedTypeName;
import com.squareup.javapoet.TypeName;

import javax.lang.model.element.Modifier;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Builds helper methods for the JUnit generator.
 */
public class JUnitGeneratorHelper {
    /**
     * The name of the map maker function.
     */
    private static final String RUN_SQL_NAME = "runSql";

    /**
     * The name of the map maker function.
     */
    private static final String MAP_MAKER_NAME = "makeMap";

    /**
     * The name of the result column getter function.
     */
    private static final String GET_RESULT_COLUMNS_NAME = "getResultColumns";

    /**
     * The name of the JDBC URL constant.
     */
    static final String NAME_DB_JDBC_URL = "DB_JDBC_URL";

    /**
     * The name of the database user constant.
     */
    static final String NAME_DB_USER = "DB_USER";

    /**
     * The name of the database password constant.
     */
    static final String NAME_DB_PASSWORD = "DB_PASSWORD";

    /**
     * Builds a runSql implementation specification.
     *
     * @return A runSql specification.
     */
    public MethodSpec buildRunSqlImplementation() {
        MethodSpec.Builder runSql = MethodSpec.methodBuilder(RUN_SQL_NAME)
                .addModifiers(Modifier.PRIVATE)
                .returns(ParameterizedTypeName.get(Map.class, String.class, String.class))
                .addParameter(String.class, "query")
                .addParameter(TypeName.BOOLEAN, "isUpdate")
                .addException(SQLException.class)
                .addJavadoc("Executes an SQL query on the database.\n\n" +
                        "@param query    The query to execute.\n" +
                        "@param isUpdate Whether the query is a data modification statement.\n\n" +
                        "@returns The resulting table, or null if the query is an update.\n");

        runSql.addStatement(
                "$T connection = $T.getConnection($L, $L, $L)",
                Connection.class, DriverManager.class,
                NAME_DB_JDBC_URL, NAME_DB_USER, NAME_DB_PASSWORD)
                .addStatement("$T statement = connection.createStatement()", Statement.class)
                .beginControlFlow("if (isUpdate == true)")
                .addStatement("statement.executeUpdate(sql)")
                .addStatement("return null")
                .nextControlFlow("else")
                .addStatement("$T<$T<$T, $T>> tableStructure = new $T<$T<$T, $T>>()",
                        List.class, Map.class, String.class, String.class,
                        ArrayList.class, HashMap.class, String.class, String.class)
                .addStatement("$T resultSet = statement.executeQuery(sql)", ResultSet.class)
                .addStatement("$T<$T> columns = $L(resultSet)",
                        List.class, String.class, GET_RESULT_COLUMNS_NAME)
                .beginControlFlow("while (resultSet.next())")
                .addStatement("$T<$T, $T> values = new $T<>()",
                        Map.class, String.class, String.class, HashMap.class)
                .beginControlFlow("for (String column : columns)")
                .addStatement("values.put(column, resultSet.getObject(column).toString())")
                .endControlFlow()
                .addStatement("tableStructure.add(values)")
                .endControlFlow()
                .addStatement("return tableStructure")
                .endControlFlow();

        return runSql.build();
    }

    /**
     * Builds a runSql implementation specification.
     *
     * @return A runSql specification.
     */
    public MethodSpec buildRunSqlEmpty() {
        MethodSpec.Builder runSql = MethodSpec.methodBuilder(RUN_SQL_NAME)
                .addModifiers(Modifier.PRIVATE)
                .returns(ParameterizedTypeName.get(Map.class, String.class, String.class))
                .addParameter(String.class, "query")
                .addParameter(TypeName.BOOLEAN, "isUpdate")
                .addException(SQLException.class)
                .addJavadoc("This method should connect to your database and execute the given query.\n" +
                        "In order for the assertions to work correctly this method must return true in the case\n" +
                        "that the query yields at least one result and false if there is no result.\n\n" +
                        "@param query    The query to execute.\n" +
                        "@param isUpdate Whether the query is a data modification statement.\n\n" +
                        "@returns The resulting table, or null if the query is an update.\n");

        runSql.addComment("TODO: implement method stub.")
                .addStatement("return null");

        return runSql.build();
    }

    /**
     * Builds a utility function for building a Map from a list of strings.
     *
     * @return An instance of a method specification for mapMaker.
     */
    public MethodSpec buildMapMaker() {
        MethodSpec.Builder mapMaker = MethodSpec.methodBuilder(MAP_MAKER_NAME)
                .addModifiers(Modifier.PRIVATE)
                .returns(ParameterizedTypeName.get(Map.class, String.class, String.class))
                .addParameter(String[].class, "strings")
                .varargs()
                .addJavadoc("Generates a string map from a list of strings.\n");

        mapMaker.addStatement("$T<$T, $T> result = new $T<>()", Map.class, String.class, String.class, HashMap.class);
        mapMaker.beginControlFlow("for(int i = 0; i < strings.length; i += 2)")
                .addStatement("result.put(strings[i], strings[i + 1])")
                .endControlFlow();
        mapMaker.addStatement("return result");
        return mapMaker.build();
    }

    /**
     * Builds a utility function for getting the column names of a ResultSet.
     *
     * @return An instance of a method specification for getResultColumns.
     */
    public MethodSpec buildGetResultColumns() {
        MethodSpec.Builder getResultColumns =
                MethodSpec.methodBuilder(GET_RESULT_COLUMNS_NAME)
                        .addModifiers(Modifier.PRIVATE)
                        .returns(ParameterizedTypeName.get(List.class, String.class))
                        .addParameter(ResultSet.class, "result")
                        .addJavadoc("Gets the columns of a statement result set.\n");

        getResultColumns.addStatement("$T meta = result.getMetaData()", ResultSetMetaData.class);
        getResultColumns.addStatement("$T<$T> columns = new $T<>()", List.class, String.class, ArrayList.class);
        getResultColumns.beginControlFlow("for (int i = 0; i <= meta.getColumnCount(); ++i)");
        getResultColumns.addStatement("columns.add(meta.getColumnName(i))");
        getResultColumns.endControlFlow();
        getResultColumns.addStatement("return columns");

        return getResultColumns.build();
    }
}

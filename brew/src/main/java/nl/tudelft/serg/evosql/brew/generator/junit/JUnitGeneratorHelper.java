package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.ParameterizedTypeName;
import com.squareup.javapoet.TypeName;

import javax.lang.model.element.Modifier;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Builds helper methods for the JUnit generator.
 */
public class JUnitGeneratorHelper {
    /**
     * The name of the map maker function.
     */
    public static final String METHOD_RUN_SQL = "runSql";

    /**
     * The return type of the runSql method.
     */
    public static final ParameterizedTypeName RETURN_TYPE_RUN_SQL;

    /**
     * The name of the map maker function.
     */
    public static final String METHOD_MAP_MAKER = "makeMap";

    /**
     * The name of the result column getter function.
     */
    public static final String METHOD_GET_RESULT_COLUMNS = "getResultColumns";

    /**
     * The name of the JDBC URL constant.
     */
    static final String FIELD_DB_JDBC_URL = "DB_JDBC_URL";

    /**
     * The name of the database user constant.
     */
    static final String FIELD_DB_USER = "DB_USER";

    /**
     * The name of the database password constant.
     */
    static final String FIELD_DB_PASSWORD = "DB_PASSWORD";

    static {
        ParameterizedTypeName map = ParameterizedTypeName.get(HashMap.class,
                String.class,
                String.class);
        RETURN_TYPE_RUN_SQL = ParameterizedTypeName.get(ClassName.get(ArrayList.class), map);
    }

    /**
     * Builds a runSql implementation specification.
     *
     * @return A runSql specification.
     */
    public MethodSpec buildRunSqlImplementation() {
        MethodSpec.Builder runSql = MethodSpec.methodBuilder(METHOD_RUN_SQL)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(RETURN_TYPE_RUN_SQL)
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
                FIELD_DB_JDBC_URL, FIELD_DB_USER, FIELD_DB_PASSWORD)
                .addStatement("$T statement = connection.createStatement()", Statement.class)
                .beginControlFlow("if (isUpdate == true)")
                .addStatement("statement.executeUpdate(query)")
                .addStatement("return null")
                .nextControlFlow("else")
                .addStatement("$T tableStructure = new $T()",
                        RETURN_TYPE_RUN_SQL,
                        RETURN_TYPE_RUN_SQL)
                .addStatement("$T resultSet = statement.executeQuery(query)", ResultSet.class)
                .addStatement("$T columns = $L(resultSet)",
                        ParameterizedTypeName.get(List.class, String.class), METHOD_GET_RESULT_COLUMNS)
                .beginControlFlow("while (resultSet.next())")
                .addStatement("$T values = new $T<>()",
                        ParameterizedTypeName.get(HashMap.class, String.class, String.class), HashMap.class)
                .beginControlFlow("for (String column : columns)")
                .addStatement("Object value = resultSet.getObject(column)")
                .addStatement("values.put(column, value != null ? value.toString() : \"NULL\")")
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
        MethodSpec.Builder runSql = MethodSpec.methodBuilder(METHOD_RUN_SQL)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(RETURN_TYPE_RUN_SQL)
                .addParameter(String.class, "query")
                .addParameter(TypeName.BOOLEAN, "isUpdate")
                .addException(SQLException.class)
                .addJavadoc("This method should connect to your database and execute the given query.\n" +
                        "In order for the assertions to work correctly this method must return a list of maps\n" +
                        "in the case that the query succeeds, or null if the query fails. The tests will assert the results.\n\n" +
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
        MethodSpec.Builder mapMaker = MethodSpec.methodBuilder(METHOD_MAP_MAKER)
                .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                .returns(ParameterizedTypeName.get(HashMap.class, String.class, String.class))
                .addParameter(String[].class, "strings")
                .varargs()
                .addJavadoc("Generates a string map from a list of strings.\n");

        mapMaker.addStatement("$T<$T, $T> result = new $T<>()", HashMap.class, String.class, String.class, HashMap.class)
                .beginControlFlow("for(int i = 0; i < strings.length; i += 2)")
                .addStatement("result.put(strings[i], strings[i + 1])")
                .endControlFlow()
                .addStatement("return result");
        return mapMaker.build();
    }

    /**
     * Builds a utility function for getting the column names of a ResultSet.
     *
     * @return An instance of a method specification for getResultColumns.
     */
    public MethodSpec buildGetResultColumns() {
        MethodSpec.Builder getResultColumns =
                MethodSpec.methodBuilder(METHOD_GET_RESULT_COLUMNS)
                        .addModifiers(Modifier.PRIVATE, Modifier.STATIC)
                        .returns(ParameterizedTypeName.get(List.class, String.class))
                        .addParameter(ResultSet.class, "result")
                        .addException(SQLException.class)
                        .addJavadoc("Gets the columns of a statement result set.\n");

        getResultColumns.addStatement("$T meta = result.getMetaData()", ResultSetMetaData.class)
                .addStatement("$T<$T> columns = new $T<>()", List.class, String.class, ArrayList.class)
                .addComment("Start at one; this is 1-indexed")
                .beginControlFlow("for (int i = 1; i <= meta.getColumnCount(); ++i)")
                .addStatement("columns.add(meta.getColumnLabel(i))")
                .endControlFlow()
                .addStatement("return columns");

        return getResultColumns.build();
    }
}

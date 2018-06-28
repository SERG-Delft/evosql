package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.ParameterizedTypeName;

import javax.lang.model.element.Modifier;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
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
    public static final String MAP_MAKER_NAME = "makeMap";

    /**
     * The name of the result column getter function.
     */
    public static final String GET_RESULT_COLUMNS_NAME = "getResultColumns";

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

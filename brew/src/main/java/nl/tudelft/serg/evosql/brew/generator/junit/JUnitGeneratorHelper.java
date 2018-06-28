package nl.tudelft.serg.evosql.brew.generator.junit;

import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.ParameterizedTypeName;

import javax.lang.model.element.Modifier;
import java.util.HashMap;
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
}

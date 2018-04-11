package nl.tudelft.serg.evosql.brew.generator;

import lombok.Data;

/**
 * A class representing a generator output.
 */
@Data
public class Output {
    /**
     * The name of the generator output.
     */
    private final String name;

    /**
     * The output data of a generator.
     */
    private final String data;
}

package nl.tudelft.serg.evosql.brew.consumer;

import nl.tudelft.serg.evosql.brew.generator.Output;

import java.util.List;

/**
 * An interface for consuming generator outputs.
 */
public interface OutputConsumer {
    /**
     * Consumes the output of a generator.
     *
     * @param outputs The list of output objects to consume.
     */
    void consumeOutput(List<Output> outputs);
}

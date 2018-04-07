package nl.tudelft.serg.evosql.brew.consumer;

import nl.tudelft.serg.evosql.brew.generator.Output;

import java.util.List;

public interface OutputConsumer {
    void consumeOutput(List<Output> outputs);
}

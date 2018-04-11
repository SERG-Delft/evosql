package nl.tudelft.serg.evosql.brew.consumer;

import lombok.NonNull;
import nl.tudelft.serg.evosql.brew.generator.Output;

import java.io.PrintStream;
import java.util.List;

public class PrintConsumer implements OutputConsumer {
    private final PrintStream printStream;

    public PrintConsumer() {
        this(System.out);
    }

    public PrintConsumer(@NonNull PrintStream printStream) {
        this.printStream = printStream;
    }

    @Override
    public void consumeOutput(List<Output> outputs) {
        for (Output output : outputs) {
            printStream.println("# Output name: " + output.getName());
            printStream.println("# Output data size: " + output.getData().length());

            printStream.println(output.getData());
        }
    }
}

package nl.tudelft.serg.evosql.brew.consumer;

import nl.tudelft.serg.evosql.brew.generator.Output;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtensionContext;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.ArgumentsProvider;
import org.junit.jupiter.params.provider.ArgumentsSource;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class PrintConsumerTest {
    @Test
    void nullConstructor() {
        assertThatNullPointerException().isThrownBy(() -> {
            new PrintConsumer(null);
        });
    }

    @ParameterizedTest
    @ArgumentsSource(PrintConsumerArgumentsProvider.class)
    void testSingle(List<Output> in, String expected) {
        OutputStream outStream = new ByteArrayOutputStream();
        PrintStream printStream = new PrintStream(outStream, true);

        PrintConsumer printConsumer = new PrintConsumer(printStream);
        printConsumer.consumeOutput(in);

        String actual = outStream.toString();
        assertThat(actual).isEqualTo(expected);
    }

    @ParameterizedTest
    @ArgumentsSource(PrintConsumerArgumentsProvider.class)
    void testDefault(List<Output> in, String expected) {
        PrintStream stdOut = System.out;
        try {
            OutputStream outStream = new ByteArrayOutputStream();
            PrintStream printStream = new PrintStream(outStream, true);

            System.setOut(printStream);

            // Uses System.out as a default
            PrintConsumer printConsumer = new PrintConsumer();
            printConsumer.consumeOutput(in);

            String actual = outStream.toString();
            assertThat(actual).isEqualTo(expected);
        } finally {
            // ALWAYS restore standard out
            System.setOut(stdOut);
        }
    }

    /**
     * Provides arguments for the tests.
     */
    private static class PrintConsumerArgumentsProvider implements ArgumentsProvider {

        private static final List<Output> in1 = Collections.singletonList(
                new Output("simple", "Simple test")
        );
        private static final String expected1 = "# Output name: simple" + System.lineSeparator() +
                "# Output data size: 11" + System.lineSeparator() +
                "Simple test" + System.lineSeparator();

        private static final List<Output> in2 = Arrays.asList(
                new Output("multi1", "Multiple test 1"),
                new Output("multi2", "Multiple test 2")
        );
        private static final String expected2 = "# Output name: multi1" + System.lineSeparator() +
                "# Output data size: 15" + System.lineSeparator() +
                "Multiple test 1" + System.lineSeparator() +
                "# Output name: multi2" + System.lineSeparator() +
                "# Output data size: 15" + System.lineSeparator() +
                "Multiple test 2" + System.lineSeparator();

        @Override
        public Stream<? extends Arguments> provideArguments(ExtensionContext context) throws Exception {
            return Stream.of(
                    Arguments.of(in1, expected1),
                    Arguments.of(in2, expected2)
            );
        }
    }
}

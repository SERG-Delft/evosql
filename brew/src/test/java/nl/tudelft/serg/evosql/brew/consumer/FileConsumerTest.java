package nl.tudelft.serg.evosql.brew.consumer;


import nl.tudelft.serg.evosql.brew.generator.Output;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class FileConsumerTest {
    private static Path tempDir;

    @BeforeAll
    static void setUp() throws IOException {
        tempDir = Files.createTempDirectory("nl-tudelft-serg-evosql-brew-fileconsumertest");
    }

    @Test
    void nullConstructorTest() {
        assertThatNullPointerException().isThrownBy(() -> {
            new FileConsumer(null);
        });
    }

    @Test
    void simpleCreateTest() throws IOException {
        Output output = new Output("simple", "This is a simple test.");

        FileConsumer fileConsumer = new FileConsumer(tempDir);
        fileConsumer.consumeOutput(Collections.singletonList(output));

        Path expectedFilePath = Paths.get(tempDir.toString(), output.getName());
        assertThat(expectedFilePath.toFile().exists()).isTrue();
        assertThat(Files.readAllLines(expectedFilePath))
                .isEqualTo(Collections.singletonList(output.getData()));
    }

    @Test
    void multipleTest() throws IOException {
        Output output1 = new Output("multiple1.md", "# First multiple test\n\nIf you can read this, the test was probably successful.\n");
        Output output2 = new Output("multiple2", "You may delete these files (but not before the test finishes ;) )");

        FileConsumer fileConsumer = new FileConsumer(tempDir);
        fileConsumer.consumeOutput(Arrays.asList(output1, output2));

        Path expectedFilePath1 = Paths.get(tempDir.toString(), output1.getName());
        assertThat(expectedFilePath1.toFile().exists()).isTrue();
        String file1Content = new String(Files.readAllBytes(expectedFilePath1), StandardCharsets.UTF_8);
        assertThat(file1Content).isEqualTo(output1.getData());

        Path expectedFilePath2 = Paths.get(tempDir.toString(), output2.getName());
        assertThat(expectedFilePath2.toFile().exists()).isTrue();
        String file2Content = new String(Files.readAllBytes(expectedFilePath2), StandardCharsets.UTF_8);
        assertThat(file2Content).isEqualTo(output2.getData());
    }
}

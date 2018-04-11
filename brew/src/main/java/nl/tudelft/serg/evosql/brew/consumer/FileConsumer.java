package nl.tudelft.serg.evosql.brew.consumer;

import lombok.Getter;
import lombok.NonNull;
import nl.tudelft.serg.evosql.brew.generator.Output;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

/**
 * An OutputConsumer that writes the output to files.
 */
public class FileConsumer implements OutputConsumer {
    /**
     * The directory to write to.
     */
    @Getter
    private final Path directory;
    private final FileOutputStreamProvider fileOutputStreamProvider;

    /**
     * Initializes a new instance of the FileConsumer class.
     *
     * @param directory The directory to write to.
     */
    public FileConsumer(Path directory) {
        this(directory, new FileOutputStreamProvider());
    }

    /**
     * Initializes a new instance of the FileConsumer class.
     *
     * @param directory                The directory to write to.
     * @param fileOutputStreamProvider The provider for file output streams.
     */
    public FileConsumer(@NonNull Path directory, FileOutputStreamProvider fileOutputStreamProvider) {
        this.directory = directory;
        this.fileOutputStreamProvider = fileOutputStreamProvider;
    }

    /**
     * Writes the output of a generator to the filesystem.
     *
     * @param outputs The list of output objects to write.
     */
    @Override
    public void consumeOutput(List<Output> outputs) {
        try {
            // Make directory
            Files.createDirectories(directory);

            for (Output output : outputs) {
                File outfile = Paths.get(directory.toString(), output.getName()).toFile();
                FileOutputStream outStream = fileOutputStreamProvider.createStream(outfile);

                OutputStreamWriter writer = new OutputStreamWriter(outStream, StandardCharsets.UTF_8);
                writer.write(output.getData());
                writer.close();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * A helper class for initializing file output streams.
     */
    public static class FileOutputStreamProvider {
        /**
         * Initializes a new instance of a file output stream.
         *
         * @param file The file to create a stream for.
         * @return An output stream for the given file.
         * @throws FileNotFoundException if (part of) the path to the given file does not exist.
         */
        public FileOutputStream createStream(File file) throws FileNotFoundException {
            return new FileOutputStream(file);
        }
    }
}

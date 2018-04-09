package nl.tudelft.serg.evosql.brew.consumer;

import lombok.Getter;
import lombok.NonNull;
import nl.tudelft.serg.evosql.brew.generator.Output;

import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

public class FileConsumer implements OutputConsumer {
    @Getter
    private final Path directory;

    public FileConsumer(@NonNull Path directory) {
        this.directory = directory;
    }

    @Override
    public void consumeOutput(List<Output> outputs) {
        // Make directory
        directory.toFile().mkdirs();

        for (Output output : outputs) {
            try {
                File outfile = Paths.get(directory.toString(), output.getName()).toFile();
                FileOutputStream outStream = new FileOutputStream(outfile);

                OutputStreamWriter writer = new OutputStreamWriter(outStream);
                writer.write(output.getData());
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

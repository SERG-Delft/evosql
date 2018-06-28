package nl.tudelft.serg.evosql.experiment;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * This class can read in queries and return them as a list of Strings.
 */
@Data
public class QueryReader {

    /**
     * Reads all queries in the given files and returns them as a list of strings.
     * Does not read in comment lines.
     *
     * @param streams files to read
     * @return all queries in files.
     */
    @SafeVarargs
    public final List<String> readQueries(Stream<String>... streams) {
        return Arrays.stream(streams)
                .flatMap(i -> i)
                .map(String::trim)
                .filter(q -> !q.startsWith("#"))
                .collect(Collectors.toList());
    }

    /**
     * Reads a single query from a fileStream given by the line number.
     * Takes line numbers counting from zero onwards.
     *
     * @param fileStream   fileStream to read
     * @param lineNo line number to read
     * @return query in fileStream.
     */
    public String readQuery(Stream<String> fileStream, int lineNo) {
        return readQueries(fileStream).get(lineNo);
    }

}

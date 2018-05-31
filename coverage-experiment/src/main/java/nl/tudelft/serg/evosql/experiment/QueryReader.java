package nl.tudelft.serg.evosql.experiment;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.*;
import java.util.List;
import java.util.stream.Collectors;

/**
 * This class can read in queries and return them as a list of Strings.
 */
@Data
public class QueryReader {

    /**
     * Reads all queries in the given file and returns them as a list of strings.
     * Does not read in comment lines.
     *
     * @param file file to read
     * @return all queries in file.
     */
    public List<String> readQueries(File file) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            return br.lines()
                    .map(String::trim)
                    .filter(q -> !q.startsWith("#"))
                    .collect(Collectors.toList());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Reads a single query from a file given by the line number.
     * Takes line numbers counting from zero onwards.
     *
     * @param file   file to read
     * @param lineNo line number to read
     * @return query in file.
     */
    public String readQuery(File file, int lineNo) {
        return readQueries(file).get(lineNo);
    }

}

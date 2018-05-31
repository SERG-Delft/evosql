package nl.tudelft.serg.evosql.experiment;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.*;
import java.nio.Buffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * This class can read in queries and return them as a list of Strings.
 */
@Data
public class QueryReader {

    public List<String> readQueries(File file, int lineNo) {
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

}

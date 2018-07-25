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

    public List<String> readExperimentQueries() {
        BufferedReader reader_erpnext = new BufferedReader(new InputStreamReader(
                Runner.class.getClassLoader().getResourceAsStream("sql/erpnext_queries.sql")));
        Stream<String> erpnext = reader_erpnext.lines();

        BufferedReader reader_espocrm = new BufferedReader(new InputStreamReader(
                Runner.class.getClassLoader().getResourceAsStream("sql/espocrm_queries.sql")));
        Stream<String> espocrm = reader_espocrm.lines();

        BufferedReader reader_suitecrm = new BufferedReader(new InputStreamReader(
                Runner.class.getClassLoader().getResourceAsStream("sql/suitecrm_queries.sql")));
        Stream<String> suitecrm = reader_suitecrm.lines();


        QueryReader queryReader = new QueryReader();
        List<String> allQueries = queryReader.readQueries(erpnext, espocrm, suitecrm);

        try {
            reader_erpnext.close();
            reader_espocrm.close();
            reader_suitecrm.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return allQueries;
    }

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

}

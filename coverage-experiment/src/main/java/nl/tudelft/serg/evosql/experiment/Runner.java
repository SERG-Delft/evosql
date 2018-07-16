package nl.tudelft.serg.evosql.experiment;

import nl.tudelft.serg.evosql.brew.db.ConnectionData;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Stream;

/**
 * Main runner class. Implementation depends on whether it will be used as a client for
 * a web server which hands out jobs or whether it should be autonomous and read a portion
 * of the queries.
 */
public class Runner {

    public static void main(String[] args) {
        int startIndex = Integer.valueOf(args[0]);
        int stepSize = Integer.valueOf(args[1]);
        BufferedReader reader_erpnext = new BufferedReader(new InputStreamReader(
                Runner.class.getResourceAsStream("sql/erpnext_queries.sql")));
        Stream<String> erpnext = reader_erpnext.lines();

        BufferedReader reader_espocrm = new BufferedReader(new InputStreamReader(
                Runner.class.getResourceAsStream("sql/espocrm_queries.sql")));
        Stream<String> espocrm = reader_espocrm.lines();

        BufferedReader reader_suitecrm = new BufferedReader(new InputStreamReader(
                Runner.class.getResourceAsStream("sql/suitecrm_queries.sql")));
        Stream<String> suitecrm = reader_suitecrm.lines();

        try {
            reader_erpnext.close();
            reader_espocrm.close();
            reader_suitecrm.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        QueryReader queryReader = new QueryReader();
        List<String> allQueries = queryReader.readQueries(erpnext, espocrm, suitecrm);

        // TODO: Make connection data for separate databases...
        for (int i = startIndex; i < allQueries.size(); i += stepSize) {
            runForQuery(
                    allQueries.get(i),
                    null,
                    null,
                    String.valueOf(i)
            );
        }

    }

    /**
     * End to end execution of experiment for a single query.
     *
     * @param query              query to execute
     * @param connectionDataProd data of db connection for production database
     * @param connectionDataTest data of db connection for test database
     */
    public static QueryExperimentResult runForQuery(String query,
                                             ConnectionData connectionDataProd,
                                             ConnectionData connectionDataTest,
                                             String packageName) {

        // TODO: Implement method

        Path experimentPath = Paths.get(System.getProperty("user.home"), "experiment-projects", packageName);
        if (!Files.exists(experimentPath)) {
            try {
                Files.createDirectory(experimentPath);
            } catch (IOException e) {
                System.err.println(e);
            }
        }
        URL gradlePath = Runner.class.getResource("gradle/sample_build.gradle");

        try {
            // Copies sample gradle file to new project folder
            Files.copy(Paths.get(gradlePath.toURI().toString()), Paths.get(experimentPath.toUri().toString(), "build.gradle"));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }

        // TODO: Execute brew and output to project folder for original

        // TODO: Create mutants

        // TODO: Execute brew and output to project folder for mutants


        Process proc = null;
        try {

            // TODO: Run tests of original query
            // TODO: Run tests of mutated query

            proc = Runtime.getRuntime().exec("cd " + experimentPath.toAbsolutePath().toString());
            // Run gradle
            String className = "name"; // FIXME: Get right name
            String command = ".\\gradlew test --tests " + className;
            proc = Runtime.getRuntime().exec(command);


            BufferedReader reader =
                    new BufferedReader(new InputStreamReader(proc.getInputStream()));

            String line = "";
            while ((line = reader.readLine()) != null) {}

            // TODO: Find status code somewhere in here

            proc.waitFor();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }



        // TODO: Store results



        return null;
    }


}
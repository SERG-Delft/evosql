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

    static final ConnectionData CONNECTION_DATA_ERPNEXT_PROD = new ConnectionData(
            "jdbc:postgresql://localhost:5432/erpnext_prod",
            "erpnext_prod", "postgres", "");

    static final ConnectionData CONNECTION_DATA_ESPOCRM_PROD = new ConnectionData(
            "jdbc:postgresql://localhost:5432/espocrm_prod",
            "espocrm_prod", "postgres", "");

    static final ConnectionData CONNECTION_DATA_SUITECRM_PROD = new ConnectionData(
            "jdbc:postgresql://localhost:5432/suitecrm_prod",
            "suitecrm_prod", "postgres", "");

    static final ConnectionData CONNECTION_DATA_ERPNEXT_TEST = new ConnectionData(
            "jdbc:postgresql://localhost:5432/erpnext_test",
            "erpnext_test", "postgres", "");

    static final ConnectionData CONNECTION_DATA_ESPOCRM_TEST = new ConnectionData(
            "jdbc:postgresql://localhost:5432/espocrm_test",
            "espocrm_test", "postgres", "");

    static final ConnectionData CONNECTION_DATA_SUITECRM_TEST = new ConnectionData(
            "jdbc:postgresql://localhost:5432/suitecrm_test",
            "suitecrm_test", "postgres", "");


    static final int AMOUNT_QUERIES_ERPNEXT = 1689;
    static final int AMOUNT_QUERIES_ESPOCRM = 40;
    static final int AMOUNT_QUERIES_SUITECRM = 280;

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
        ConnectionData connectionDataProd = CONNECTION_DATA_ERPNEXT_PROD;
        ConnectionData connectionDataTest = CONNECTION_DATA_ERPNEXT_TEST;
        for (int i = startIndex; i < allQueries.size(); i += stepSize) {
            // Sorry for this...
            if (i >= AMOUNT_QUERIES_ERPNEXT && i < AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM) {
                connectionDataProd = CONNECTION_DATA_ESPOCRM_PROD;
                connectionDataTest = CONNECTION_DATA_ESPOCRM_TEST;
            } else if (i >= AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM) {
                connectionDataProd = CONNECTION_DATA_SUITECRM_PROD;
                connectionDataTest = CONNECTION_DATA_SUITECRM_TEST;
            }
            runForQuery(
                    allQueries.get(i),
                    connectionDataProd,
                    connectionDataTest,
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
        try {
            Files.createDirectories(experimentPath);
        } catch (IOException e) {
            System.err.println(e);
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

        // Create a path to output test classes to
        Path testClassPath = Paths.get(experimentPath.toAbsolutePath().toString(), "src", "test", "java", packageName);
        if (!Files.exists(testClassPath)) {
            try {
                Files.createDirectories(testClassPath);
            } catch (IOException e) {
                System.err.println(e);
            }
        }

        // Execute brew and output to project folder for original
        BrewExecutor brewExecutor = new BrewExecutor(connectionDataProd, connectionDataTest, query, packageName);
        brewExecutor.executeBrew(testClassPath, "Original.java");

        // Create mutants
        QueryMutator queryMutator = new QueryMutator(query, connectionDataProd.getDatabase());
        List<String> queryMutants = queryMutator.createMutants();

        // Execute brew and output to project folder for mutants
        for (int i = 0; i < queryMutants.size(); i++) {
            brewExecutor.brewWithMutatedQuery(brewExecutor.getQueryResult(), testClassPath, "Mutated" + i + ".java");
        }

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
            while ((line = reader.readLine()) != null) {
            }

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

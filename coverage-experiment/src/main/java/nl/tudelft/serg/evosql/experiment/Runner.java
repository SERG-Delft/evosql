package nl.tudelft.serg.evosql.experiment;

import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
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
            "jdbc:postgresql://db:5432/erpnext_prod",
            "erpnext", "postgres", "");

    static final ConnectionData CONNECTION_DATA_ESPOCRM_PROD = new ConnectionData(
            "jdbc:postgresql://db:5432/espocrm_prod",
            "espocrm", "postgres", "");

    static final ConnectionData CONNECTION_DATA_SUITECRM_PROD = new ConnectionData(
            "jdbc:postgresql://db:5432/suitecrm_prod",
            "suitecrm", "postgres", "");

    static final ConnectionData CONNECTION_DATA_ERPNEXT_TEST = new ConnectionData(
            "jdbc:postgresql://db:5432/erpnext_test",
            "erpnext", "postgres", "");

    static final ConnectionData CONNECTION_DATA_ESPOCRM_TEST = new ConnectionData(
            "jdbc:postgresql://db:5432/espocrm_test",
            "espocrm", "postgres", "");

    static final ConnectionData CONNECTION_DATA_SUITECRM_TEST = new ConnectionData(
            "jdbc:postgresql://db:5432/suitecrm_test",
            "suitecrm", "postgres", "");

    static final String ORIGINAL_NAME = "Original";
    static final String MUTANT_NAME = "Mutated";

    static final Path EXPERIMENT_PATH = Paths.get(System.getProperty("user.home"), "experiment-projects");

    static final int AMOUNT_QUERIES_ERPNEXT = 1689;
    static final int AMOUNT_QUERIES_ESPOCRM = 40;
    static final int AMOUNT_QUERIES_SUITECRM = 280;

    public static void main(String[] args) {
        int startIndex = Integer.valueOf(args[0]);
        int stepSize = Integer.valueOf(args[1]);

        System.out.printf("Running experiment... starting at %d and stepping %d\n", startIndex, stepSize);

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
                    i
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
                                                    int queryIndex) {

        String packageName = "query" + queryIndex;
        Path projectPath = Paths.get(EXPERIMENT_PATH.toString(), String.valueOf(queryIndex));

        Path testClassPath = null;
        try {
            testClassPath = GradleUtil
                    .setupGradleTestProject(projectPath, packageName);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Execute brew and output to project folder for original
        BrewExecutor brewExecutor = new BrewExecutor(connectionDataProd, connectionDataTest, query, packageName);
        brewExecutor.executeBrew(brewExecutor.getQueryResult(),
                testClassPath, ORIGINAL_NAME);

        // Create mutants
        QueryMutator queryMutator = new QueryMutator(query, connectionDataProd);
        List<String> queryMutants = null;
        try {
            queryMutants = queryMutator.createMutants();
        } catch (MutationException e) {
            e.printStackTrace();
        }

        // Execute brew and output to project folder for mutants
        for (int i = 1; i < queryMutants.size(); i++) {
            Result mutantResult = new Result(queryMutants.get(i),
                    brewExecutor.getQueryResult().getPaths());
            brewExecutor.executeBrew(mutantResult,
                    testClassPath, MUTANT_NAME + i);
        }

        try {

            final int originalExitCode = GradleUtil.runTestClass(projectPath, ORIGINAL_NAME);
            GradleUtil.saveTestResult(projectPath, packageName + "." + ORIGINAL_NAME);

            System.out.printf("Original %d ", queryIndex);
            System.out.println(originalExitCode == 0 ? "yes" : "no");

            // Run tests of mutated query
            for (int i = 1; i < queryMutants.size(); i++) {
                final int mutantExitCode = GradleUtil.runTestClass(projectPath, MUTANT_NAME + i);
                GradleUtil.saveTestResult(projectPath, packageName + "." + MUTANT_NAME + i);

                System.out.printf("Mutant %d ", i);
                System.out.println(mutantExitCode != 0 ? "yes" : "no");
            }

            // FIXME: If exitCode == 0 it worked, otherwise tests failed
            // FIXME: In theory, only the mutated tests should fail

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }


        // TODO: Store results


        return null;
    }


}

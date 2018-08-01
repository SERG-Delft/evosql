package nl.tudelft.serg.evosql.experiment;

import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
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
        if (args.length < 2) return;

        final int startIndex = Integer.valueOf(args[0]);
        final int stepSize = Integer.valueOf(args[1]);
        int stopIndex = Integer.MAX_VALUE;

        if (args.length > 2) stopIndex = Integer.valueOf(args[2]);

        System.out.printf("Running experiment, starting at %d and stepping %d...", startIndex, stepSize);
        System.out.println();

        QueryReader queryReader = new QueryReader();
        List<String> allQueries = queryReader.readExperimentQueries();

        stopIndex = Math.min(stopIndex, allQueries.size());
        System.out.printf("The maximum query that will be executed is %d.", stopIndex - 1);
        System.out.println();

        ConnectionData connectionDataProd;
        ConnectionData connectionDataTest;
        for (int i = startIndex; i < stopIndex; i += stepSize) {
            // Sorry for this...
            connectionDataProd = assignConnectionDataProd(i);
            connectionDataTest = assignConnectionDataTest(i);

            try {
                runForQuery(
                        allQueries.get(i),
                        connectionDataProd,
                        connectionDataTest,
                        i
                );
            } catch (Exception e) {
                try (PrintStream logger = new PrintStream(Paths.get(EXPERIMENT_PATH.toString(), "failure_" + i).toFile())) {
                    logger.printf("Query %d has failed due to an exception. The stack trace is listed below:", i);
                    logger.println();
                    logger.println();
                    e.printStackTrace(logger);
                } catch (FileNotFoundException e2) {
                    e.printStackTrace();
                }
            }
        }

        System.out.println("Experiment run complete.");
    }


    /**
     * End to end execution of experiment for a single query.
     *
     * @param query              query to execute
     * @param connectionDataProd data of db connection for production database
     * @param connectionDataTest data of db connection for test database
     */
    public static void runForQuery(String query,
                                   ConnectionData connectionDataProd,
                                   ConnectionData connectionDataTest,
                                   int queryIndex) throws MutationException {

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
        List<String> queryMutants =  queryMutator.createMutants();

        // Execute brew and output to project folder for mutants
        for (int i = 1; i < queryMutants.size(); i++) {
            Result mutantResult = new Result(queryMutants.get(i),
                    brewExecutor.getQueryResult().getPaths());
            brewExecutor.executeBrew(mutantResult,
                    testClassPath, MUTANT_NAME + i);
        }

        CsvMaker totalResult = new CsvMaker();
        try {

            { // in a block to scope "original" variables
                System.out.printf("Query %d, original... ", queryIndex);
                final int originalExitCode = GradleUtil.runTestClass(projectPath, ORIGINAL_NAME);
                Path original = GradleUtil.saveTestResult(projectPath, packageName + "." + ORIGINAL_NAME);
                totalResult.appendCsvLine(connectionDataProd.getDatabase(),
                        queryIndex, query, 0, query, original);

                System.out.printf("done. Exited with %d.", originalExitCode);
                System.out.println();
            }

            // Run tests of mutated query
            for (int i = 1; i < queryMutants.size(); i++) {
                System.out.printf("Query %d, mutant %d... ", queryIndex, i);
                final int mutantExitCode = GradleUtil.runTestClass(projectPath, MUTANT_NAME + i);
                Path mutant = GradleUtil.saveTestResult(projectPath, packageName + "." + MUTANT_NAME + i);
                totalResult.appendCsvLine(connectionDataProd.getDatabase(),
                        queryIndex, query, i, queryMutants.get(i), mutant);

                System.out.printf("done. Exited with %d", mutantExitCode);
                System.out.println();
            }

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }

        Path storePath = Paths.get(projectPath.toString(), "result", "all.csv");
        try (PrintStream store = new PrintStream(storePath.toFile())) {
            store.print(totalResult.toString());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static ConnectionData assignConnectionDataProd(int i) {
        if (i < AMOUNT_QUERIES_ERPNEXT) {
            return CONNECTION_DATA_ERPNEXT_PROD;
        } else if (i < AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM) {
            return CONNECTION_DATA_ESPOCRM_PROD;
        } else {
            return CONNECTION_DATA_SUITECRM_PROD;
        }
    }

    private static ConnectionData assignConnectionDataTest(int i) {
        if (i < AMOUNT_QUERIES_ERPNEXT) {
            return CONNECTION_DATA_ERPNEXT_TEST;
        } else if (i < AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM) {
            return CONNECTION_DATA_ESPOCRM_TEST;
        } else {
            return CONNECTION_DATA_SUITECRM_TEST;
        }
    }

}

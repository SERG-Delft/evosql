package nl.tudelft.serg.evosql.experiment;

import net.sf.jsqlparser.JSQLParserException;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

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


    // Load cached paths for queries
    static final List<QueryPathList> CACHED_PATHS_ERPNEXT = CacheReader.loadCacheErpNext();
    static final List<QueryPathList> CACHED_PATHS_ESPOCRM = CacheReader.loadCacheEspoCrm();
    static final List<QueryPathList> CACHED_PATHS_SUITECRM = CacheReader.loadCacheSuiteCrm();

    static final String ORIGINAL_NAME = "Original";
    static final String MUTANT_NAME = "Mutated";

    static final Path EXPERIMENT_PATH = Paths.get(System.getProperty("user.home"), "experiment-projects");

    static final int AMOUNT_QUERIES_ERPNEXT = 1689;
    static final int AMOUNT_QUERIES_ESPOCRM = 40;
    static final int AMOUNT_QUERIES_SUITECRM = 280;

    public static void main(String[] args) {
        final int runIndex = Integer.valueOf(args[0]);
        int queryNo = runIndex + 1;
        System.out.printf("Running experiment, executing query %d...", runIndex);
        System.out.println();

        QueryReader queryReader = new QueryReader();
        List<String> allQueries = queryReader.readExperimentQueries();

        List<QueryPathList> cachedPaths = CACHED_PATHS_ERPNEXT;

        ConnectionData connectionDataProd = CONNECTION_DATA_ERPNEXT_PROD;
        ConnectionData connectionDataTest = CONNECTION_DATA_ERPNEXT_TEST;

        // Sorry for this...
        if (runIndex >= AMOUNT_QUERIES_ERPNEXT && runIndex < AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM) {
            queryNo -= AMOUNT_QUERIES_ERPNEXT;
            connectionDataProd = CONNECTION_DATA_ESPOCRM_PROD;
            connectionDataTest = CONNECTION_DATA_ESPOCRM_TEST;
            cachedPaths = CACHED_PATHS_ESPOCRM;
        } else if (runIndex >= AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM) {
            queryNo -= AMOUNT_QUERIES_ERPNEXT + AMOUNT_QUERIES_ESPOCRM;
            connectionDataProd = CONNECTION_DATA_SUITECRM_PROD;
            connectionDataTest = CONNECTION_DATA_SUITECRM_TEST;
            cachedPaths = CACHED_PATHS_SUITECRM;
        }

        // Find matching cache for query
        int finalQueryNo = queryNo;
        List<String> allPaths = cachedPaths.stream()
                .filter(x -> x.queryNo == finalQueryNo)
                .findFirst()
                .orElseThrow(() -> new RuntimeException("No cache found for current query."))
                .pathList;

        try {
            runForQuery(
                    allQueries.get(runIndex),
                    connectionDataProd,
                    connectionDataTest,
                    runIndex,
                    allPaths
            );
        } catch (Exception e) {
            try (PrintStream logger = new PrintStream(Paths.get(EXPERIMENT_PATH.toString(), "failure_" + runIndex).toFile())) {
                logger.printf("Query %d has failed due to an exception. The stack trace is listed below:", runIndex);
                logger.println();
                logger.println();
                e.printStackTrace(logger);
            } catch (FileNotFoundException e2) {
                e.printStackTrace();
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
                                   int queryIndex,
                                   List<String> allPaths) {

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
        BrewExecutor brewExecutor = new BrewExecutor(connectionDataProd, connectionDataTest, query, packageName, allPaths);
        brewExecutor.executeBrew(brewExecutor.getQueryResult(),
                testClassPath, ORIGINAL_NAME);

        // Create mutants
        QueryMutator queryMutator = new QueryMutator(query);
        List<String> queryMutants = new ArrayList<>();
        try {
            queryMutants = queryMutator.createMutants().getMutants();
        } catch (JSQLParserException e) {
            e.printStackTrace();
        }

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

            // FIXME: If exitCode == 0 it worked, otherwise tests failed
            // FIXME: In theory, only the mutated tests should fail

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
}

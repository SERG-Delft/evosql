package nl.tudelft.serg.evosql.experiment;

import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import org.junit.runner.JUnitCore;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Paths;

/**
 * Main runner class. Implementation depends on whether it will be used as a client for
 * a web server which hands out jobs or whether it should be autonomous and read a portion
 * of the queries.
 */
public class Runner {

    public static void main(String[] args) {
        // TODO: Implement pipeline for doing the experiment on multiple queries using input args
        // 1. Read in queries
        // 2. Build schema's for DB
        // 3. For each query (see runForQuery method):
        //     3a. Execute GA on given query
        //     3b. Store fixture that GA outputs
        //     3c. Construct test class with fixture for original query
        //     3d. Mutate query
        //     3e. Construct test class with fixture for mutated query
        //     3f. Execute all tests that should pass and store results
        //     3g. Execute all tests that shouldn't pass and store results
        // 6. Output final results
    }

    /**
     * End to end execution of experiment for a single query.
     *
     * @param filePath           path to file from which to read queries
     * @param lineNo             linenumber of query
     * @param connectionDataProd data of db connection for production database
     * @param connectionDataTest data of db connection for test database
     * @return a datastructure containing results of execution of test  classes for the queries.
     */
    public QueryExperimentResult runForQuery(String filePath,
                                             int lineNo,
                                             ConnectionData connectionDataProd,
                                             ConnectionData connectionDataTest,
                                             String queryClassName) {
        QueryReader queryReader = new QueryReader();
        String query = queryReader.readQuery(new File(filePath), lineNo);
        // TODO: Get file package
        BrewExecutor brewExecutor = new BrewExecutor(connectionDataProd, connectionDataTest, "");
        // TODO: Pass a good folder name which is useable
        Result result = brewExecutor.executeBrew(query, Paths.get("../test"), queryClassName + "_original.java");

        String mutatedQuery = QueryMutator.mutateQuery(query);
        brewExecutor.brewWithMutatedQuery(query, result, Paths.get("../test"), queryClassName + "_mutated.java");

        // TODO: Get right path
        org.junit.runner.Result[] results = testClassRunner(
                Paths.get("../test").toAbsolutePath().toString(),
                queryClassName + "_original.java",
                queryClassName + "_mutated.java"
        );

        QueryExperimentResult experimentResult = new QueryExperimentResult(
                query,
                mutatedQuery,
                filePath,
                lineNo,
                results[0].wasSuccessful(),
                results[1].wasSuccessful()
        );

        return experimentResult;
    }


    /**
     * Runs generated test classes and returns a jUnit result datastructure.
     *
     * @param folderPath             absolute path containing the test classes to run
     * @param originalQueryClassName test class name of the 'correct' query
     * @param mutatedQueryClassName  test class name of the mutated query
     * @return test results, first index is the original query result, second index is the mutated query result.
     */
    public org.junit.runner.Result[] testClassRunner(String folderPath,
                                                     String originalQueryClassName,
                                                     String mutatedQueryClassName) {
        URLClassLoader loader;
        org.junit.runner.Result[] results = new org.junit.runner.Result[2];
        try {
            loader = new URLClassLoader(new URL[]{
                    new URL("file://" + folderPath)
            });
            Class originalQueryTestClass;
            Class mutatedQueryTestClass;
            try {
                originalQueryTestClass = loader.loadClass(originalQueryClassName);
                mutatedQueryTestClass = loader.loadClass(mutatedQueryClassName);
                results[0] = JUnitCore.runClasses(originalQueryTestClass);
                results[1] = JUnitCore.runClasses(mutatedQueryTestClass);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

        return results;
    }

}

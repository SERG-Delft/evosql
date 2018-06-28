package nl.tudelft.serg.evosql.experiment;

import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import org.junit.runner.JUnitCore;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Paths;
import java.util.Arrays;
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


        QueryReader queryReader = new QueryReader();
        List<String> allQueries = queryReader.readQueries(erpnext, espocrm, suitecrm);

        for (int i = startIndex; i < allQueries.size(); i += stepSize) {
            runForQuery(
                    allQueries.get(i),
                    null,
                    null,
                    String.valueOf(i)
            );
        }

        try {
            reader_erpnext.close();
            reader_espocrm.close();
            reader_suitecrm.close();
        } catch (IOException e) {
            e.printStackTrace();
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
                                             String queryClassName) {
        // TODO: Get file package
        BrewExecutor brewExecutor = new BrewExecutor(connectionDataProd, connectionDataTest, "");
        // TODO: Pass a good folder name which is useable
        brewExecutor.executeBrew(query, Paths.get("../test"), queryClassName + "_original.java");

        String mutatedQuery = QueryMutator.mutateQuery(query);
        brewExecutor.brewWithMutatedQuery(query, brewExecutor.getQueryResult(), Paths.get("../test"), queryClassName + "_mutated.java");

        // TODO: Get right path
        org.junit.runner.Result[] results = testClassRunner(
                Paths.get("../test").toAbsolutePath().toString(),
                queryClassName + "_original.java",
                queryClassName + "_mutated.java"
        );

        QueryExperimentResult experimentResult = new QueryExperimentResult(
                query,
                mutatedQuery,
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
    public static org.junit.runner.Result[] testClassRunner(String folderPath,
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

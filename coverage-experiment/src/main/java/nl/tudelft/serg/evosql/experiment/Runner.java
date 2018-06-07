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
        // 1. Read in queries
        // 2. Build schema's for DB
        // 3. For each query:
        //     3a. Execute GA on given query
        //     3b. Store fixture that GA outputs
        //     3c. Construct test class with fixture for original query
        //     3d. Mutate query
        //     3e. Construct test class with fixture for mutated query
        // 4. Execute all tests that should pass and store results
        // 5. Execute all tests that shouldn't pass and store results
        // 6. Output final results
    }

    public QueryExperimentResult runForQuery(String filePath,
                                             int lineNo,
                                             ConnectionData connectionDataProd,
                                             ConnectionData connectionDataTest) {
        QueryReader queryReader = new QueryReader();
        String query = queryReader.readQuery(new File(filePath), lineNo);
        BrewExecutor brewExecutor = new BrewExecutor(connectionDataProd, connectionDataTest);
        Result result = brewExecutor.executeBrew(query, Paths.get("../test"), "query1_original.java");

        String mutatedQuery = QueryMutator.mutateQuery(query);
        brewExecutor.brewWithMutatedQuery(query, result, Paths.get("../test"), "query1_mutated.java");

        org.junit.runner.Result[] results = testClassRunner(
                "../test",
                "query1_original.java",
                "query1_mutated.java"
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

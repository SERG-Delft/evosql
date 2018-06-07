package nl.tudelft.serg.evosql.experiment;

import nl.tudelft.serg.evosql.brew.Pipeline;
import nl.tudelft.serg.evosql.brew.consumer.FileConsumer;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.EvoSQLRunner;
import nl.tudelft.serg.evosql.brew.db.ExistingDataRunner;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnitGeneratorSettings;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;

import java.nio.file.Path;

/**
 * Class responsible for executing brew and generating the test files.
 * We have two cases:
 * - We have a query for which we need to generate a result and thus execute the GA pipeline.
 * - We have a mutated query for which we just need to generate the test file using an old result.
 * <p>
 * This class also requires specified {@link ConnectionData} for both a production and a test database.
 */
public class BrewExecutor {
    //Connection data to production database, this is where the schema is extracted from by the GA
    private ConnectionData connectionDataProd;

    //Connection data to test database, this is where the test cases make a connection to
    private ConnectionData connectionDataTest;

    public BrewExecutor(ConnectionData connectionDataProd, ConnectionData connectionDataTest) {
        this.connectionDataProd = connectionDataProd;
        this.connectionDataTest = connectionDataTest;
    }

    /**
     * Executes brew and the GA pipeline for the query.
     * Outputs results to test class file
     * with junit 5 tests and the given parameters.
     *
     * @param queryToRun   query to run GA on
     * @param pathToOutput path to output test file to
     * @param fileName     name of the test file
     */
    public Result executeBrew(String queryToRun, Path pathToOutput, String fileName) {
        //Configure jUnitGenerator, perhaps remove code duplication with the other method in the future
        JUnitGeneratorSettings jUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionDataTest,
                //TODO: Change the file package
                "nl.tudelft.serg.evosql.experiment.Demo",
                fileName,
                true,
                true,
                true,
                false,
                true);
        //Construct Pipeline
        Pipeline pipeline = Pipeline.builder()
                .queryRunner(new EvoSQLRunner())
                .connectionData(connectionDataProd)
                .sqlQuery(queryToRun)
                //Process result to the given File
                .resultProcessor(new Pipeline.ResultProcessor(
                        new JUnit5TestGenerator(jUnitGeneratorSettings),
                        new PostgreSQLOptions(),
                        new FileConsumer(pathToOutput))
                )
                .build();

        //Execute pipeline
        return pipeline.execute();
    }

    /**
     * This method generates a test class file with a mutated query. It does not run the
     * GA for this query but uses the {@link Result} of the original query and with that
     * information outputs a file consisting of junit 5 tests given the parameters.
     *
     * @param mutatedQuery mutated query string
     * @param result       GA result of original query
     * @param pathToOutput path to output file to
     * @param fileName     name of the test class
     */
    public void brewWithMutatedQuery(String mutatedQuery, Result result, Path pathToOutput, String fileName) {
        //Configure jUnitGenerator, perhaps remove code duplication with the other method in the future
        JUnitGeneratorSettings jUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionDataTest,
                //TODO: Change the file package
                "nl.tudelft.serg.evosql.experiment.Demo",
                fileName,
                true,
                true,
                true,
                false,
                true);
        //Construct Pipeline
        Pipeline pipeline = Pipeline.builder()
                .queryRunner(new ExistingDataRunner(result))
                .connectionData(connectionDataProd)
                .sqlQuery(mutatedQuery)
                .resultProcessor(new Pipeline.ResultProcessor(
                        new JUnit5TestGenerator(jUnitGeneratorSettings),
                        new PostgreSQLOptions(),
                        new FileConsumer(pathToOutput))
                )
                .build();
    }


}

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
    private final ConnectionData connectionDataProd;

    //Connection data to test database, this is where the test cases make a connection to
    private final ConnectionData connectionDataTest;

    private final String filePackage;
    private final Result queryResult;
    private final ExistingDataRunner existingDataRunner;

    public BrewExecutor(ConnectionData connectionDataProd,
                        ConnectionData connectionDataTest,
                        String productionString,
                        String filePackage) {
        this.connectionDataProd = connectionDataProd;
        this.connectionDataTest = connectionDataTest;
        this.filePackage = filePackage;

        EvoSQLRunner evoSQLRunner = new EvoSQLRunner();
        queryResult = evoSQLRunner.runQuery(productionString, connectionDataProd);

        this.existingDataRunner = new ExistingDataRunner(queryResult);
    }

    public Result getQueryResult() {
        return queryResult;
    }

    /**
     * Executes brew and the GA pipeline for the query.
     * Outputs the given result to a test class file
     * with junit 5 tests and the given parameters.
     *
     * @param result       GA result of original query
     * @param pathToOutput path to output test file to
     * @param className    name of the test class
     */
    public void executeBrew(Result result, Path pathToOutput, String className) {
        existingDataRunner.setResult(result);
        //Configure jUnitGenerator, TODO: perhaps remove code duplication with the other method in the future
        JUnitGeneratorSettings jUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionDataTest,
                filePackage,
                className,
                true,
                true,
                true,
                false,
                true);
        //Construct Pipeline
        Pipeline pipeline = Pipeline.builder()
                .queryRunner(existingDataRunner)
                .connectionData(connectionDataProd) // not used by ExistingDataRunner
                .sqlQuery("") // not used by ExistingDataRunner
                //Process result to the given File
                .resultProcessor(new Pipeline.ResultProcessor(
                        new JUnit5TestGenerator(jUnitGeneratorSettings),
                        new PostgreSQLOptions(),
                        new FileConsumer(pathToOutput))
                )
                .build();

        //Execute pipeline
        pipeline.execute();
    }
}

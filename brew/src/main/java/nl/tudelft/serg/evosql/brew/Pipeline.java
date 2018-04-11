package nl.tudelft.serg.evosql.brew;

import lombok.*;
import nl.tudelft.serg.evosql.brew.consumer.OutputConsumer;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.QueryRunner;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.generator.Output;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Represents a Brew pipeline.
 */
@EqualsAndHashCode
@RequiredArgsConstructor
@Builder
public class Pipeline {
    /**
     * The QueryRunner instance used in the pipeline.
     */
    @NonNull
    private final QueryRunner queryRunner;
    /**
     * The SQL query to execute.
     */
    @NonNull
    private final String sqlQuery;
    /**
     * The connection data used to connect to the database.
     */
    @NonNull
    private final ConnectionData connectionData;
    /**
     * The Generator instance used in the pipeline.
     */
    @NonNull @Singular
    private final List<ResultProcessor> resultProcessors;

    /**
     * Executes the pipeline.
     */
    public void execute() {
        Result queryRunnerResult = queryRunner.runQuery(sqlQuery, connectionData);

        Map<Generator, List<Output>> outputCache = new HashMap<>();

        for (ResultProcessor rp : resultProcessors) {
            List<Output> generatedOutputs;

            if (outputCache.containsKey(rp.getGenerator())) {
                generatedOutputs = outputCache.get(rp.getGenerator());
            } else {
                generatedOutputs = rp.getGenerator()
                        .generate(queryRunnerResult, rp.getVendorOptions());
                outputCache.put(rp.getGenerator(), generatedOutputs);
            }

            rp.getOutputConsumer().consumeOutput(generatedOutputs);
        }
    }

    @Value
    public static class ResultProcessor {
        /**
         * The Generator instance used to process the result.
         */
        @NonNull
        private final Generator generator;
        /**
         * The vendor-specific options used in SQL generation.
         */
        @NonNull
        private final VendorOptions vendorOptions;
        /**
         * The OutputConsumer instance used to write the data.
         */
        @NonNull
        private final OutputConsumer outputConsumer;
    }
}

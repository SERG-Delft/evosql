package nl.tudelft.serg.evosql.brew;

import lombok.*;
import nl.tudelft.serg.evosql.brew.consumer.OutputConsumer;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.QueryRunner;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.generator.Output;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

import java.util.List;

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
    @NonNull
    private final Generator generator;
    /**
     * The vendor options used in SQL generation.
     */
    @NonNull
    private final VendorOptions vendorOptions;
    /**
     * The OutputConsumer instance used in the pipeline.
     */
    @NonNull
    private final OutputConsumer outputConsumer;

    /**
     * Executes the pipeline.
     */
    public void execute() {
        Result queryRunnerResult = queryRunner.runQuery(sqlQuery, connectionData);
        List<Output> generatedOutputs = generator.generate(queryRunnerResult, vendorOptions);
        outputConsumer.consumeOutput(generatedOutputs);
    }
}

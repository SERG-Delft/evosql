package nl.tudelft.serg.evosql.brew.db;

import lombok.AllArgsConstructor;
import lombok.Data;
import nl.tudelft.serg.evosql.brew.data.Result;

/**
 * A runner that returns the same data set, regardless of input.
 */
@Data
@AllArgsConstructor
public class ExistingDataRunner implements QueryRunner {

    /**
     * The instance of Result that will always be returned,
     * regardless of input to the runQuery function.
     */
    private Result result;

    @Override
    public Result runQuery(String sqlQuery, ConnectionData connectionData) {
        return result;
    }
}

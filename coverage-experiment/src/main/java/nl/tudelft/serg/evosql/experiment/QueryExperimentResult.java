package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * Object describing the result of executing the experiment for a single query.
 * Contains information about the original query and the mutated query. Also
 * contains information about the file that it originates from.
 * <p>
 * It also defines a boolean if it passed on the test suite for the original query and another
 * boolean if it passed on the same test suite with the mutated query.
 */
@Data
@AllArgsConstructor
public class QueryExperimentResult {
    private String originalQuery;
    private String mutatedQuery;
    private boolean initBrewPass;
    private boolean mutatedBrewPass;
}

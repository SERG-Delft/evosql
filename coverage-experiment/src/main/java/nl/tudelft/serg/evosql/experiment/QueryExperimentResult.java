package nl.tudelft.serg.evosql.experiment;

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
public class QueryExperimentResult {
    private final String originalQuery;
    private final String mutatedQuery;
    private final boolean initBrewPass;
    private final boolean mutatedBrewPass;
}

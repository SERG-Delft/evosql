package nl.tudelft.serg.evosql.experiment;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * Object describing the result of executing the experiment for a single query.
 * Contains information about the original query and the mutated queries. Also
 * contains information about the file that it originates from.
 * <p>
 * It also defines a boolean for the original query if it passed on the test suite for the original query and a
 * map with a boolean for each mutated query if it passed on the same test suite with the mutated query.
 */
@Data
public class QueryExperimentResult {
    private final String originalQuery;
    private final List<String> mutatedQueries;
    private final boolean initBrewPass;
    private final Map<String, Boolean> mutatedBrewPass;
}

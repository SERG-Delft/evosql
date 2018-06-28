package nl.tudelft.serg.evosql.experiment;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Class responsible for mutating the conditions in the query.
 */
// TODO: Implement this mutator
public class QueryMutator {

    public List<String> parseMutations(String xml) {
        return Arrays.stream(xml.split("\n"))
                .filter(x -> x.contains("<sql>"))
                .map(x -> x.replaceAll("<[^>]+>", ""))
                .map(x -> x.trim())
                .collect(Collectors.toList());

    }
}

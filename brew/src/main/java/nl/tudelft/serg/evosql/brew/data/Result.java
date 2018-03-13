package nl.tudelft.serg.evosql.brew.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NonNull;

import java.util.Collections;
import java.util.List;

/**
 * A class representing the result of test data generation.
 */
@EqualsAndHashCode
public class Result {
    /** The original query used for test data generation. */
    @Getter private final String inputQuery;

    /** An unmodifiable list of query paths */
    @Getter private final List<Path> paths;

    /**
     * Initializes a new instance of the Result class.
     * @param inputQuery The original query used for test data generation.
     */
    public Result(@NonNull String inputQuery, @NonNull List<Path> paths) {
        this.inputQuery = inputQuery;
        this.paths = Collections.unmodifiableList(paths);
    }
}

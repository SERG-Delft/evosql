package nl.tudelft.serg.evosql.brew.data;

import lombok.Data;
import lombok.NonNull;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Represents a single test coverage path.
 */
@Data
public class Path {
    /**
     * The fixture of this test path.
     */
    private final Fixture fixture;

    /**
     * The input SQL for this specific path.
     */
    private final String pathSql;

    /**
     * The path number.
     */
    private final int pathNumber;

    /**
     * If path is a success from production query (returns something).
     */
    private final boolean success;

    /**
     * ResultSet from execution of path on database.
     */
    private final List<Map<String, String>> productionOutput;

    /**
     * Initializes a new instance of the Path class.
     *
     * @param fixture          The fixture to use.
     * @param pathSql          The path SQL query that was used.
     * @param pathNumber       The path number.
     * @param success          Whether there was any result using the production query.
     * @param productionOutput The database output when using the production query.
     */
    public Path(@NonNull Fixture fixture, @NonNull String pathSql, int pathNumber, boolean success,
                @NonNull List<Map<String, String>> productionOutput) {
        this.fixture = fixture;
        this.pathSql = pathSql;
        this.pathNumber = pathNumber;
        this.success = success;
        this.productionOutput = Collections.unmodifiableList(
                productionOutput.stream().map(Collections::unmodifiableMap).collect(Collectors.toList())
        );
    }
}

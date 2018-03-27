package nl.tudelft.serg.evosql.brew.data;

import lombok.Data;
import lombok.Getter;

import java.util.List;

/**
 * Represents a single test coverage path.
 */
@Data
public class Path {
    /** The fixture of this test path. */
    private final Fixture fixture;

    /** The input SQL for this specific path. */
    private final String pathSql;

    /** The path number. */
    private final int pathNumber;
}

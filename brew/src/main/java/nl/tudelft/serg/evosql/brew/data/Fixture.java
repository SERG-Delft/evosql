package nl.tudelft.serg.evosql.brew.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NonNull;

import java.util.Collections;
import java.util.List;

/**
 * A fixture of the database state at the end of a test run.
 */
@EqualsAndHashCode
public class Fixture {
    /** The tables in the fixture. */
    @Getter private final List<FixtureTable> tables;

    /**
     * Initializes a new instance of the Fixture class.
     * @param tables The tables in the fixture.
     */
    public Fixture(@NonNull List<FixtureTable> tables) {
        this.tables = Collections.unmodifiableList(tables);
    }
}

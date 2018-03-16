package nl.tudelft.serg.evosql.brew.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NonNull;

import java.util.Collections;
import java.util.List;

/**
 * Represents a single table in the fixture.
 */
@EqualsAndHashCode
public class FixtureTable {
    /** The schema of the fixture table. */
    @Getter private final TableSchema schema;

    /** The rows in this fixture table. */
    @Getter private final List<FixtureRow> rows;

    /**
     * Initializes a new instance of the FixtureTable class.
     * @param rows The rows in this fixture table.
     */
    public FixtureTable(@NonNull TableSchema schema, @NonNull List<FixtureRow> rows) {
        this.schema = schema;
        this.rows = Collections.unmodifiableList(rows);
    }
}

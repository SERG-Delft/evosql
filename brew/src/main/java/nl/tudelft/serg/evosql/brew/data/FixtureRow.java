package nl.tudelft.serg.evosql.brew.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NonNull;

import java.util.Collections;
import java.util.Map;

/**
 * Represents a single row in the fixture.
 */
@EqualsAndHashCode
public class FixtureRow {
    /** The values in the fixture row. */
    @Getter private final Map<String, String> values;

    /** The table schema of the fixture row. */
    @Getter private final TableSchema tableSchema;

    /**
     * Initializes a new instance of the FixtureRow class.
     * @param values The values in the fixture row.
     * @param tableSchema The table schema of the fixture row.
     */
    public FixtureRow(@NonNull Map<String, String> values, @NonNull TableSchema tableSchema) {
        this.values = Collections.unmodifiableMap(values);
        this.tableSchema = tableSchema;
    }
}

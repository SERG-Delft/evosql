package nl.tudelft.serg.evosql.brew.data;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NonNull;

import java.util.Collections;
import java.util.List;

/**
 * Represents a stripped-down table schema of a relational database.
 */
@EqualsAndHashCode
public class TableSchema {
    /** The name of the table. */
    @Getter private final String name;

    /** The columns of the schema. */
    @Getter private final List<String> columns;

    /**
     * Initializes a new instance of the TableSchema class.
     * @param name The name of the table.
     * @param columns The columns of the schema.
     */
    public TableSchema(@NonNull String name, @NonNull List<String> columns) {
        this.name = name;
        this.columns = Collections.unmodifiableList(columns);
    }
}

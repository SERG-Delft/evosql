package nl.tudelft.serg.evosql.brew.data;

import lombok.Data;
import nl.tudelft.serg.evosql.fixture.type.DBType;

/**
 * Represents a single column in the fixture.
 */
@Data
public class FixtureColumn {
    /**
     * Name of the column.
     */
    private final String name;
    /**
     * Name of the type.
     * @see DBType#getTypeString()
     */
    private final String type;
}

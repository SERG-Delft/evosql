package nl.tudelft.serg.evosql.brew.data;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class FixtureRowTest {
    @Test
    void testConstructor() {
        Map<String, String> values = new HashMap<>();
        values.put("key1", "val1");
        values.put("key2", "val2");
        TableSchema tableSchema = Mockito.mock(TableSchema.class);

        FixtureRow fixtureRow = new FixtureRow(
                values,
                tableSchema
        );

        assertThat(fixtureRow.getValues()).isEqualTo(values);
        assertThat(fixtureRow.getTableSchema()).isSameAs(tableSchema);
    }

    @Test
    void testConstructorFail() {
        assertThatNullPointerException().isThrownBy(() -> {
            new FixtureRow(null, Mockito.mock(TableSchema.class));
        });
        assertThatNullPointerException().isThrownBy(() -> {
            new FixtureRow(Collections.emptyMap(), null);
        });
    }
}

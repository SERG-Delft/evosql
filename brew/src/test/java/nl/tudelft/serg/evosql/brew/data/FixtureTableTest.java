package nl.tudelft.serg.evosql.brew.data;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class FixtureTableTest {
    @Test
    void testConstructor() {
        TableSchema schema = Mockito.mock(TableSchema.class);
        List<FixtureRow> rows = new ArrayList<>();
        rows.add(Mockito.mock(FixtureRow.class));

        FixtureTable fixtureTable = new FixtureTable(
            schema,
            rows
        );

        assertThat(fixtureTable.getSchema()).isSameAs(schema);
        assertThat(fixtureTable.getRows().get(0)).isSameAs(rows.get(0));
    }

    @Test
    void testConstructorFail() {
        assertThatNullPointerException().isThrownBy(() -> {
            new FixtureTable(null, Collections.emptyList());
        });
        assertThatNullPointerException().isThrownBy(() -> {
            new FixtureTable(Mockito.mock(TableSchema.class), null);
        });
    }
}

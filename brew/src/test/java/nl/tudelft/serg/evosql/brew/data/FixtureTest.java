package nl.tudelft.serg.evosql.brew.data;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class FixtureTest {
    @Test
    void testConstructor() {
        List<FixtureTable> fixtureTables = new ArrayList<>();
        fixtureTables.add(Mockito.mock(FixtureTable.class));

        Fixture fixture = new Fixture(fixtureTables);

        assertThat(fixture.getTables().get(0)).isSameAs(fixtureTables.get(0));
    }

    @Test
    void testConstructorFail() {
        assertThatNullPointerException().isThrownBy(() -> {
            new Fixture(null);
        });
    }
}

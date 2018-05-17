package nl.tudelft.serg.evosql.brew.data;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class PathTest {
    @Test
    void testConstructor() {
        Fixture fixture = Mockito.mock(Fixture.class);
        List<Map<String, String>> dbOutput = Collections.emptyList();

        Path path = new Path(fixture, "test", 1653, true, dbOutput);

        assertThat(path.getFixture()).isSameAs(fixture);
        assertThat(path.getPathSql()).isEqualTo("test");
        assertThat(path.getPathNumber()).isEqualTo(1653);
        assertThat(path.isSuccess()).isTrue();
        assertThat(path.getProductionOutput()).isEqualTo(dbOutput);
    }

    @Test
    void testConstructorFail() {
        assertThatNullPointerException().isThrownBy(() -> {
            new Path(null, "", 0, true, Collections.emptyList());
        });
        assertThatNullPointerException().isThrownBy(() -> {
            new Path(Mockito.mock(Fixture.class), null, 0, true, Collections.emptyList());
        });
        assertThatNullPointerException().isThrownBy(() -> {
            new Path(Mockito.mock(Fixture.class), "", 0, true, null);
        });
    }
}

package nl.tudelft.serg.evosql.brew.db;

import nl.tudelft.serg.evosql.brew.data.Result;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.assertj.core.api.Java6Assertions.assertThat;

public class ExistingDataRunnerTest {
    @Test
    void testRunQuerySame() {
        final Result expected = Mockito.mock(Result.class);
        Result actual = new ExistingDataRunner(expected).runQuery(null, null);
        assertThat(actual).isSameAs(expected);
    }

    @Test
    void testRunQueryNull() {
        final Result expected = null;
        Result actual = new ExistingDataRunner(expected).runQuery(null, null);
        assertThat(actual).isSameAs(expected);
    }
}

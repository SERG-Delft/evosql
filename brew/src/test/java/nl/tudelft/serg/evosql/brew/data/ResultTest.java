package nl.tudelft.serg.evosql.brew.data;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class ResultTest {
    @Test
    void testConstructor() {
        List<Path> paths = new ArrayList<>();
        paths.add(Mockito.mock(Path.class));

        Result result = new Result(
                "Select * From all",
                paths
        );

        assertThat(result.getInputQuery()).isEqualTo("Select * From all");
        assertThat(result.getPaths().get(0)).isSameAs(paths.get(0));
    }

    @Test
    void testConstructorFail() {
        assertThatNullPointerException().isThrownBy(() ->
                new Result(null, Collections.emptyList())
        );
        assertThatNullPointerException().isThrownBy(() ->
                new Result("Select;", null)
        );
    }
}

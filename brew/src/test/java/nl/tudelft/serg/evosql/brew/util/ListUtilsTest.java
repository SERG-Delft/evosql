package nl.tudelft.serg.evosql.brew.util;

import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Collections;
import java.util.InputMismatchException;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class ListUtilsTest {
    @Test
    void interleaveSameLength_nulls() {
        assertThatNullPointerException().isThrownBy(() -> {
            ListUtils.interleaveSameLength(null, Collections.emptyList());
        });

        assertThatNullPointerException().isThrownBy(() -> {
            ListUtils.interleaveSameLength(Collections.emptyList(), null);
        });
    }

    @Test
    void interleaveSameLength_diffLength() {
        assertThatExceptionOfType(InputMismatchException.class).isThrownBy(() -> {
            ListUtils.interleaveSameLength(
                    Arrays.asList("one", "three"),
                    Collections.singletonList("two")
            );
        });
    }

    @Test
    void interleaveSameLength_ok() {
        List<String> a = Arrays.asList("one", "three");
        List<String> b = Arrays.asList("two", "four");
        List<String> expected = Arrays.asList("one", "two", "three", "four");

        assertThat(ListUtils.interleaveSameLength(a, b)).isEqualTo(expected);
    }

    @Test
    void interleaveSameLength_empty() {
        List<String> a = Collections.emptyList();
        List<String> b = Collections.emptyList();
        List<String> expected = Collections.emptyList();

        assertThat(ListUtils.interleaveSameLength(a, b)).isEqualTo(expected);
    }
}

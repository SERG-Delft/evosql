package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class DBBooleanTest {
    @Test
    void testTypeString() {
        DBBoolean dbBoolean1 = new DBBoolean("TypeString test");
        assertThat(dbBoolean1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbBoolean1.getNormalizedTypeString()).isEqualTo("BIT");

        DBBoolean dbBoolean2 = new DBBoolean();
        assertThat(dbBoolean2.getTypeString()).isEqualTo("BIT");
        assertThat(dbBoolean2.getNormalizedTypeString()).isEqualTo("BIT");
    }
}

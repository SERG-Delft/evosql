package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class DBIntegerTest {
    @Test
    void testTypeString() {
        DBInteger dbInteger1 = new DBInteger("TypeString test");
        assertThat(dbInteger1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbInteger1.getNormalizedTypeString()).isEqualTo("INTEGER");

        DBInteger dbInteger2 = new DBInteger();
        assertThat(dbInteger2.getTypeString()).isEqualTo("INTEGER");
        assertThat(dbInteger2.getNormalizedTypeString()).isEqualTo("INTEGER");
    }
}

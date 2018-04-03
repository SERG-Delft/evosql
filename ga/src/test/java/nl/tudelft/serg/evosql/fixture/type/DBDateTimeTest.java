package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class DBDateTimeTest {
    @Test
    void testTypeString() {
        DBDateTime dbDateTime1 = new DBDateTime("TypeString test");
        assertThat(dbDateTime1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbDateTime1.getNormalizedTypeString()).isEqualTo("DATETIME");

        DBDateTime dbDateTime2 = new DBDateTime();
        assertThat(dbDateTime2.getTypeString()).isEqualTo("DATETIME");
        assertThat(dbDateTime2.getNormalizedTypeString()).isEqualTo("DATETIME");
    }
}

package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class DBTimeTest {
    @Test
    void testTypeString() {
        DBTime dbTime1 = new DBTime("TypeString test");
        assertThat(dbTime1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbTime1.getNormalizedTypeString()).isEqualTo("TIME");

        DBTime dbTime2 = new DBTime();
        assertThat(dbTime2.getTypeString()).isEqualTo("TIME");
        assertThat(dbTime2.getNormalizedTypeString()).isEqualTo("TIME");
    }
}

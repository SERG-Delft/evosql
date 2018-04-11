package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class DBDateTest {
    @Test
    void testTypeString() {
        DBDate dbDate1 = new DBDate("TypeString test");
        assertThat(dbDate1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbDate1.getNormalizedTypeString()).isEqualTo("DATE");

        DBDate dbDate2 = new DBDate();
        assertThat(dbDate2.getTypeString()).isEqualTo("DATE");
        assertThat(dbDate2.getNormalizedTypeString()).isEqualTo("DATE");
    }
}

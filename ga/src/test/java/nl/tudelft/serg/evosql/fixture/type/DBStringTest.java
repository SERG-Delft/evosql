package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class DBStringTest {
    @Test
    void testTypeString() {
        DBString dbString1 = new DBString(50, "TypeString test");
        assertThat(dbString1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbString1.getNormalizedTypeString()).isEqualTo("VARCHAR(500)");

        DBString dbString2 = new DBString(50);
        assertThat(dbString2.getTypeString()).isEqualTo("VARCHAR(500)");
        assertThat(dbString2.getNormalizedTypeString()).isEqualTo("VARCHAR(500)");
    }
}

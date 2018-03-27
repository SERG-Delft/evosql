package nl.tudelft.serg.evosql.brew.sql.vendor;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class PostgreSQLOptionsTest {
    @Test
    void testStandard() {
        VendorOptions postgreSQLOptions = new PostgreSQLOptions();
        assertThat(postgreSQLOptions.escapeIdentifier("table")).isEqualTo("\"table\"");
    }

    @Test
    void testSpace() {
        VendorOptions postgreSQLOptions = new PostgreSQLOptions();
        assertThat(postgreSQLOptions.escapeIdentifier("table space")).isEqualTo("\"table space\"");
    }

    @Test
    void testNumber() {
        VendorOptions postgreSQLOptions = new PostgreSQLOptions();
        assertThat(postgreSQLOptions.escapeIdentifier("table2table")).isEqualTo("\"table2table\"");
    }
}

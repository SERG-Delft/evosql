package nl.tudelft.serg.evosql.brew.sql;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class PostgreSQLOptionsTest {
    @Test
    void escapeTableNameTest() {
        VendorOptions postgreSQLOptions = new PostgreSQLOptions();
        assertThat(postgreSQLOptions.escapeColumnName("table")).isEqualTo("\"table\"");
    }

    @Test
    void escapeColumnNameTest() {
        VendorOptions postgreSQLOptions = new PostgreSQLOptions();
        assertThat(postgreSQLOptions.escapeColumnName("column")).isEqualTo("\"column\"");
    }
}

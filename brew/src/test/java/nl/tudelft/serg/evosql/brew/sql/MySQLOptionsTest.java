package nl.tudelft.serg.evosql.brew.sql;


import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class MySQLOptionsTest {
    @Test
    void escapeTableNameTest() {
        VendorOptions mySQLOptions = new MySQLOptions();
        assertThat(mySQLOptions.escapeColumnName("table")).isEqualTo("`table`");
    }

    @Test
    void escapeColumnNameTest() {
        VendorOptions mySQLOptions = new MySQLOptions();
        assertThat(mySQLOptions.escapeColumnName("column")).isEqualTo("`column`");
    }
}

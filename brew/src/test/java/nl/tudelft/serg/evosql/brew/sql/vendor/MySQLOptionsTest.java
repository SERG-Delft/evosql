package nl.tudelft.serg.evosql.brew.sql.vendor;


import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class MySQLOptionsTest {
    @Test
    void testNormal() {
        VendorOptions mySQLOptions = new MySQLOptions();
        assertThat(mySQLOptions.escapeIdentifier("table")).isEqualTo("`table`");
    }

    @Test
    void testSpace() {
        VendorOptions mySQLOptions = new MySQLOptions();
        assertThat(mySQLOptions.escapeIdentifier("table space")).isEqualTo("`table space`");
    }

    @Test
    void testNumber() {
        VendorOptions mySQLOptions = new MySQLOptions();
        assertThat(mySQLOptions.escapeIdentifier("table2table")).isEqualTo("`table2table`");
    }
}

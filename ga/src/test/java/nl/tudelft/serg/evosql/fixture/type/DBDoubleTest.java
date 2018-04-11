package nl.tudelft.serg.evosql.fixture.type;


import org.junit.jupiter.api.Test;

import java.text.DecimalFormat;
import java.util.Locale;

import static org.assertj.core.api.Assertions.assertThat;

public class DBDoubleTest {
    @Test
    void testTypeString() {
        DBDouble dbDouble1 = new DBDouble("TypeString test");
        assertThat(dbDouble1.getTypeString()).isEqualTo("TypeString test");
        assertThat(dbDouble1.getNormalizedTypeString()).isEqualTo("DOUBLE");

        DBDouble dbDouble2 = new DBDouble();
        assertThat(dbDouble2.getTypeString()).isEqualTo("DOUBLE");
        assertThat(dbDouble2.getNormalizedTypeString()).isEqualTo("DOUBLE");
    }

    @Test
    void truncateDecimals() {
        // Check if integers aren't truncated
        assertThat(DBDouble.truncateDecimals(3, 4)).isEqualTo("3");

        // Check if decimals are truncated, not rounded
        assertThat(DBDouble.truncateDecimals(4.52, 1)).isEqualTo("4.5");
        assertThat(DBDouble.truncateDecimals(4.58, 1)).isEqualTo("4.5");

        // Check if no zeros are added at the end
        assertThat(DBDouble.truncateDecimals(5.1, 3)).isEqualTo("5.1");
    }

    @Test
    void truncateDecimals_locale() {
        // Set locale to one where decimal separator is a comma
        Locale currentLocale = Locale.getDefault();
        Locale.setDefault(Locale.GERMAN);

        // Check if the current locale uses the comma
        // If it does *not*, this test is invalid
        DecimalFormat decimalFormat = new DecimalFormat();
        assertThat(decimalFormat.format(50.4)).isEqualTo("50,4");

        // Check if truncateDecimals still behaves correctly
        assertThat(DBDouble.truncateDecimals(50.4, 4)).isEqualTo("50.4");

        // Restore the locale
        Locale.setDefault(currentLocale);
    }
}

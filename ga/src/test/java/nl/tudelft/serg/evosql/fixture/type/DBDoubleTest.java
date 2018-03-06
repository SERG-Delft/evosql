package nl.tudelft.serg.evosql.fixture.type;

import org.junit.Assert;
import org.junit.Test;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public class DBDoubleTest {
    @Test
    public void truncateDecimals() {
        // Check if integers aren't truncated
        Assert.assertEquals("3", DBDouble.truncateDecimals(3, 4));

        // Check if decimals are truncated, not rounded
        Assert.assertEquals("4.5", DBDouble.truncateDecimals(4.52, 1));
        Assert.assertEquals("4.5", DBDouble.truncateDecimals(4.58, 1));

        // Check if no zeros are added at the end
        Assert.assertEquals("5.1", DBDouble.truncateDecimals(5.1, 3));
    }

    @Test
    public void truncateDecimals_locale() {
        // Set locale to one where decimal separator is a comma
        Locale currentLocale = Locale.getDefault();
        Locale.setDefault(Locale.GERMAN);

        // Check if the current locale uses the comma
        // If it does *not*, this test is invalid
        DecimalFormat decimalFormat = new DecimalFormat();
        Assert.assertEquals("50,4", decimalFormat.format(50.4));

        // Check if truncateDecimals still behaves correctly
        Assert.assertEquals("50.4", DBDouble.truncateDecimals(50.4, 4));

        // Restore the locale
        Locale.setDefault(currentLocale);
    }
}

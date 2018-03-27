package nl.tudelft.serg.evosql.brew.generator;

import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.sql.vendor.VendorOptions;

public interface Generator {

    /**
     * Generate data based on the result.
     *
     * @param result result to generate data from
     * @param vendorOptions VendorOptions of database
     * @return String representation of generated data.
     */
    String generate(Result result, VendorOptions vendorOptions);

}

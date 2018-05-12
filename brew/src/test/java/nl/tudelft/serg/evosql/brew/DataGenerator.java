package nl.tudelft.serg.evosql.brew;

import nl.tudelft.serg.evosql.brew.data.*;
import nl.tudelft.serg.evosql.metaheuristics.DatabaseOutput;

import java.util.*;

/**
 * A class containing functionality to generate test data sets.
 */
public class DataGenerator {
    /**
     * Creates result set 1.
     *
     * @return Result set 1.
     */
    public static Result makeResult1() {
        // Build schema for table 1
        List<FixtureColumn> table1Columns = new ArrayList<>();
        table1Columns.add(new FixtureColumn("column1_1", "INTEGER"));
        table1Columns.add(new FixtureColumn("column1_2", "DOUBLE"));
        table1Columns.add(new FixtureColumn("column1_3", "VARCHAR(100)"));
        TableSchema table1Schema = new TableSchema("table1", table1Columns);

        // Build values for table 1
        Map<String, String> row1_1Data = new HashMap<>();
        row1_1Data.put("column1_1", "1");
        row1_1Data.put("column1_2", "0.5");
        row1_1Data.put("column1_3", "The first row of table 1.");

        Map<String, String> row1_2Data = new HashMap<>();
        row1_2Data.put("column1_1", "2");
        row1_2Data.put("column1_2", "1.5");
        row1_2Data.put("column1_3", "The second row.");
        FixtureTable table1 = new FixtureTable(table1Schema,
                Arrays.asList(new FixtureRow(row1_1Data, table1Schema), new FixtureRow(row1_2Data, table1Schema)));

        // Make output lists
        List<Map<String,String>> output1 = new ArrayList<>();
        output1.add(row1_1Data);
        List<Map<String,String>> output2 = new ArrayList<>();
        output2.add(row1_2Data);

        // Make fixture
        Fixture fixture = new Fixture(Arrays.asList(table1));
        Path path1 = new Path(fixture, "Select * From table1 Where column1_2 < 1;", 1, true, output1);
        Path path2 = new Path(fixture, "Select * From table1 Where column1_2 >= 1;", 2, false, output2);

        return new Result("Select * From table1 Where column1_2 < 1;",
                Arrays.asList(path1, path2));
    }

    /**
     * Creates result set 2.
     *
     * @return Result set 2.
     */
    public static Result makeResult2() {
        // Build schema for table 1
        List<FixtureColumn> table1Columns = new ArrayList<>();
        table1Columns.add(new FixtureColumn("column1_1", "INTEGER"));
        table1Columns.add(new FixtureColumn("column1_2", "VARCHAR(100)"));
        TableSchema table1Schema = new TableSchema("table1", table1Columns);

        // Build values for table 1
        Map<String, String> row1_1Data = new HashMap<>();
        row1_1Data.put("column1_1", "1");
        row1_1Data.put("column1_2", "String of row 1");

        Map<String, String> row1_2Data = new HashMap<>();
        row1_2Data.put("column1_1", "2");
        row1_2Data.put("column1_2", "String of row 2");

        FixtureTable table1 = new FixtureTable(table1Schema,
                Arrays.asList(new FixtureRow(row1_1Data, table1Schema), new FixtureRow(row1_2Data, table1Schema)));

        // Build schema for table 2
        List<FixtureColumn> productColumns = new ArrayList<>();
        productColumns.add(new FixtureColumn("product_name", "VARCHAR(100)"));
        productColumns.add(new FixtureColumn("expired", "BIT"));
        productColumns.add(new FixtureColumn("expiry_date", "DATETIME"));
        TableSchema productsSchema = new TableSchema("products", productColumns);

        // Build values for table 2
        Map<String, String> row2_1Data = new HashMap<>();
        row2_1Data.put("product_name", "Milk");
        row2_1Data.put("expired", "0");
        row2_1Data.put("expiry_date", "2018-03-22 00:00:00");

        Map<String, String> row2_2Data = new HashMap<>();
        row2_2Data.put("product_name", "Yogurt");
        row2_2Data.put("expired", "1");
        row2_2Data.put("expiry_date", "2018-03-15 00:00:00");

        Map<String, String> row2_3Data = new HashMap<>();
        row2_3Data.put("product_name", "Salt");
        row2_3Data.put("expired", "0");
        row2_3Data.put("expiry_date", "2025-12-31 23:59:59");

        FixtureTable productsTable = new FixtureTable(productsSchema,
                Arrays.asList(new FixtureRow(row2_1Data, productsSchema), new FixtureRow(row2_2Data, productsSchema), new FixtureRow(row2_3Data, productsSchema)));


        // TODO: Also pass output to the paths, instead of empty data.
        DatabaseOutput dbOutput1 = new DatabaseOutput();
        dbOutput1.add(new HashMap<>());
        DatabaseOutput dbOutput2 = new DatabaseOutput();


        // Make fixture
        Fixture fixture = new Fixture(Arrays.asList(table1, productsTable));
        Path path1 = new Path(fixture, "Select * From table1, products Where column1_2 < 1 And expired = 0;", 1, true, dbOutput1);
        Path path2 = new Path(fixture, "Select * From table1, products Where column1_2 < 1 And expired = 1;", 2, false, dbOutput2);
        Path path3 = new Path(fixture, "Select * From table1, products Where column1_2 >= 1 And expired = 0;", 3, false, dbOutput2);
        Path path4 = new Path(fixture, "Select * From table1, products Where column1_2 >= 1 And expired = 1;", 4, true, dbOutput1);

        return new Result("Select * From table1, products Where column1_2 < 1 And expired = 0;",
                Arrays.asList(path1, path2, path3, path4));
    }
}

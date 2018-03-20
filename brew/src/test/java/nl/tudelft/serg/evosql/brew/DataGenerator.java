package nl.tudelft.serg.evosql.brew;

import nl.tudelft.serg.evosql.brew.data.*;

import java.util.*;

public class DataGenerator {
    public Result makeResult1() {
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
        row1_1Data.put("column1_3", "'The first row of table 1.'");

        Map<String, String> row1_2Data = new HashMap<>();
        row1_2Data.put("column1_1", "2");
        row1_2Data.put("column1_2", "1.5");
        row1_2Data.put("column1_3", "'The second row.'");
        FixtureTable table1 = new FixtureTable(table1Schema,
                Arrays.asList(new FixtureRow(row1_1Data, table1Schema), new FixtureRow(row1_2Data, table1Schema)));

        // Make fixture
        Fixture fixture = new Fixture(Arrays.asList(table1));
        Path path1 = new Path(fixture, "Select * From table1 Where column1_2 < 1;");
        Path path2 = new Path(fixture, "Select * From table1 Where column1_2 >= 1;");

        return new Result("Select * From table1 Where column1_2 < 1",
                Arrays.asList(path1, path2));
    }
}

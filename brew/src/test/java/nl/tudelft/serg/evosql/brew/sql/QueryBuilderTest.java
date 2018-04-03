package nl.tudelft.serg.evosql.brew.sql;

import nl.tudelft.serg.evosql.brew.data.FixtureColumn;
import nl.tudelft.serg.evosql.brew.data.FixtureRow;
import nl.tudelft.serg.evosql.brew.data.TableSchema;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

public abstract class QueryBuilderTest {

    private static List<FixtureColumn> fixtureColumns;
    private static FixtureRow fixtureRow;

    protected abstract QueryBuilder getQueryBuilder();

    @BeforeAll
    static void setUp() {
        fixtureColumns = new ArrayList<>();
        fixtureColumns.add(new FixtureColumn("int", "INTEGER"));
        fixtureColumns.add(new FixtureColumn("dbl", "DOUBLE"));
        fixtureColumns.add(new FixtureColumn("bool", "BIT"));
        fixtureColumns.add(new FixtureColumn("str", "STRING"));
        fixtureColumns.add(new FixtureColumn("strn", "STRING"));
        fixtureColumns.add(new FixtureColumn("date", "DATE"));
        TableSchema tableSchema = new TableSchema("tbl", fixtureColumns);

        Map<String, String> values = new HashMap<>();
        values.put("int", "42");
        values.put("dbl", "2.5");
        values.put("bool", "1");
        values.put("str", "This is a 'string'.");
        values.put("strn", "NULL");
        values.put("date", "2018-03-27");
        fixtureRow = new FixtureRow(values, tableSchema);
    }

    @Test
    void testGetEscapedValueNull() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(new FixtureColumn("nulltest", "STRING"), fixtureRow))
                .isEqualTo("NULL");
    }

    @Test
    void testInteger() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(fixtureColumns.get(0), fixtureRow)).isEqualTo("42");
    }

    @Test
    void testDouble() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(fixtureColumns.get(1), fixtureRow)).isEqualTo("2.5");
    }

    @Test
    void testBoolean() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(fixtureColumns.get(2), fixtureRow)).isEqualTo("1");
    }

    @Test
    void testString() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(fixtureColumns.get(3), fixtureRow)).isEqualTo("'This is a ''string''.'");
    }

    @Test
    void testGetEscapedValueNullString() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(fixtureColumns.get(4), fixtureRow)).isEqualTo("NULL");
    }

    @Test
    void testDate() {
        QueryBuilder queryBuilder = getQueryBuilder();
        assertThat(queryBuilder.getEscapedValue(fixtureColumns.get(5), fixtureRow)).isEqualTo("'2018-03-27'");
    }

}

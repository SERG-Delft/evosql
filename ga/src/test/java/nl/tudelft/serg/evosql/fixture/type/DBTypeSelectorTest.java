package nl.tudelft.serg.evosql.fixture.type;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.sql.Types;

import static org.assertj.core.api.Assertions.assertThat;

public class DBTypeSelectorTest {
    private static DBTypeSelector dbTypeSelector;

    @BeforeAll
    static void setUp() {
        dbTypeSelector = new DBTypeSelector();
    }

    @Test
    void dbBooleanTest() {
        assertThat(dbTypeSelector.create(Types.BIT, 0)).isInstanceOf(DBBoolean.class);
        assertThat(dbTypeSelector.create(Types.BOOLEAN, 0)).isInstanceOf(DBBoolean.class);
    }

    @Test
    void dbDateTest() {
        assertThat(dbTypeSelector.create(Types.DATE, 0)).isInstanceOf(DBDate.class);
    }

    @Test
    void dbDateTimeTest() {
        assertThat(dbTypeSelector.create(Types.TIMESTAMP, 0)).isInstanceOf(DBDateTime.class);
    }

    @Test
    void dbDoubleTest() {
        assertThat(dbTypeSelector.create(Types.DOUBLE, 0)).isInstanceOf(DBDouble.class);
        assertThat(dbTypeSelector.create(Types.REAL, 0)).isInstanceOf(DBDouble.class);
        assertThat(dbTypeSelector.create(Types.DECIMAL, 0)).isInstanceOf(DBDouble.class);
    }

    @Test
    void dbIntegerTest() {
        assertThat(dbTypeSelector.create(Types.INTEGER, 0)).isInstanceOf(DBInteger.class);
        assertThat(dbTypeSelector.create(Types.SMALLINT, 0)).isInstanceOf(DBInteger.class);
        assertThat(dbTypeSelector.create(Types.TINYINT, 0)).isInstanceOf(DBInteger.class);
        assertThat(dbTypeSelector.create(Types.BIGINT, 0)).isInstanceOf(DBInteger.class);
    }

    @Test
    void dbStringTest() {
        assertThat(dbTypeSelector.create(Types.VARCHAR, 16)).isInstanceOf(DBString.class);
        assertThat(dbTypeSelector.create(Types.LONGVARCHAR, 16)).isInstanceOf(DBString.class);
        assertThat(dbTypeSelector.create(Types.CHAR, 16)).isInstanceOf(DBString.class);
    }

    @Test
    void dbTimeTest() {
        assertThat(dbTypeSelector.create(Types.TIME, 0)).isInstanceOf(DBTime.class);
    }
}

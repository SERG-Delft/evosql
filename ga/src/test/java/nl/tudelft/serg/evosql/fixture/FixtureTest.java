package nl.tudelft.serg.evosql.fixture;

import nl.tudelft.serg.evosql.sql.TableSchema;
import org.junit.Assert;
import org.junit.Test;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.List;

/**
 * Created by mauricioaniche on 04/08/2017.
 */
public class FixtureTest {


    @Test
    public void prettyPrint() {

        TableSchema t1Schema = Mockito.mock(TableSchema.class);
        Mockito.when(t1Schema.getName()).thenReturn("t1");
        FixtureRow r1 = new FixtureRow("t1", t1Schema);
        r1.set("c1", "1");
        r1.set("c2", "Mauricio");
        FixtureRow r2 = new FixtureRow("t1", t1Schema);
        r2.set("c1", "2");
        r2.set("c2", "Jeroen");

        TableSchema t2Schema = Mockito.mock(TableSchema.class);
        Mockito.when(t2Schema.getName()).thenReturn("t2");
        FixtureRow r3 = new FixtureRow("t2", t2Schema);
        r3.set("c3", "10.0");
        r3.set("c4", "Mozhan");
        FixtureRow r4 = new FixtureRow("t2", t2Schema);
        r4.set("c3", "25.5");
        r4.set("c4", "Annibale");

        List<FixtureTable> tables = Arrays.asList(
                new FixtureTable(t1Schema, Arrays.asList(r1, r2)),
                new FixtureTable(t2Schema, Arrays.asList(r3, r4)));

        Fixture fixture = new Fixture(tables);

        Assert.assertEquals(
                "-- Table: t1\n" +
                " Row #1: C1='1',C2='Mauricio',\n" +
                " Row #2: C1='2',C2='Jeroen',\n" +
                "\n" +
                "-- Table: t2\n" +
                " Row #1: C3='10.0',C4='Mozhan',\n" +
                " Row #2: C3='25.5',C4='Annibale',", fixture.prettyPrint());
    }
}

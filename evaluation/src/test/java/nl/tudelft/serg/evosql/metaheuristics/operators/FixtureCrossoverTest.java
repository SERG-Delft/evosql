package nl.tudelft.serg.evosql.metaheuristics.operators;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.util.random.Randomness;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Created by mauricioaniche on 29/07/2017.
 */
public class FixtureCrossoverTest {

    private Randomness randomness;
    private FixtureCrossover crossover;

    @Before
    public void setUp() {
        randomness = Mockito.mock(Randomness.class);
        crossover = new FixtureCrossover(randomness);
    }

    @Test
    public void splitBetweenLeftAndRight() {

        TableSchema schema1 = Mockito.mock(TableSchema.class);
        Mockito.when(schema1.getName()).thenReturn("table1");
        TableSchema schema2 = Mockito.mock(TableSchema.class);
        Mockito.when(schema2.getName()).thenReturn("table2");

        FixtureTable fixtureTable1 = new FixtureTable(schema1, Collections.emptyList());
        FixtureTable fixtureTable2 = new FixtureTable(schema2, Collections.emptyList());

        Fixture parent1 = new Fixture(Arrays.asList(fixtureTable1, fixtureTable2));

        FixtureTable fixtureTable3 = new FixtureTable(schema1, Collections.emptyList());
        FixtureTable fixtureTable4 = new FixtureTable(schema2, Collections.emptyList());

        Fixture parent2 = new Fixture(Arrays.asList(fixtureTable3, fixtureTable4));

        Mockito.when(randomness.nextDouble()).thenReturn(0.5, 0.4, 0.6);

        List<Fixture> offsprings = this.crossover.crossover(parent1, parent2);
        Fixture offspring1 = offsprings.get(0);
        Fixture offspring2 = offsprings.get(1);

        Assert.assertEquals(fixtureTable1, offspring1.getTable(0));
        Assert.assertEquals(fixtureTable4, offspring1.getTable(1));

        Assert.assertEquals(fixtureTable3, offspring2.getTable(0));
        Assert.assertEquals(fixtureTable2, offspring2.getTable(1));

    }

    @Test
    public void cantBeDoneIfSomeParentHasASingleTable() {

        TableSchema schema1 = Mockito.mock(TableSchema.class);
        Mockito.when(schema1.getName()).thenReturn("table1");

        FixtureTable fixtureTable1 = new FixtureTable(schema1, Collections.emptyList());
        Fixture parent1 = new Fixture(Arrays.asList(fixtureTable1));

        FixtureTable fixtureTable2 = new FixtureTable(schema1, Collections.emptyList());
        FixtureTable fixtureTable3 = new FixtureTable(schema1, Collections.emptyList());
        Fixture parent2 = new Fixture(Arrays.asList(fixtureTable2, fixtureTable3));

        boolean canBeDone = this.crossover.canBeDone(parent1, parent2);
        Assert.assertFalse(canBeDone);

        fixtureTable1 = new FixtureTable(schema1, Collections.emptyList());
        parent1 = new Fixture(Arrays.asList(fixtureTable1));

        fixtureTable2 = new FixtureTable(schema1, Collections.emptyList());
        fixtureTable3 = new FixtureTable(schema1, Collections.emptyList());
        parent2 = new Fixture(Arrays.asList(fixtureTable2, fixtureTable3));

        canBeDone = this.crossover.canBeDone(parent2, parent1);
        Assert.assertFalse(canBeDone);

    }

    @Test
    public void canBeDoneIfBothParentsHaveMoreThanOneTable() {

        TableSchema schema1 = Mockito.mock(TableSchema.class);
        Mockito.when(schema1.getName()).thenReturn("table1");

        FixtureTable fixtureTable1 = new FixtureTable(schema1, Collections.emptyList());
        FixtureTable fixtureTable2 = new FixtureTable(schema1, Collections.emptyList());
        Fixture parent1 = new Fixture(Arrays.asList(fixtureTable1, fixtureTable2));

        FixtureTable fixtureTable3 = new FixtureTable(schema1, Collections.emptyList());
        FixtureTable fixtureTable4 = new FixtureTable(schema1, Collections.emptyList());
        Fixture parent2 = new Fixture(Arrays.asList(fixtureTable3, fixtureTable4));

        boolean canBeDone = this.crossover.canBeDone(parent1, parent2);
        Assert.assertTrue(canBeDone);

    }

}

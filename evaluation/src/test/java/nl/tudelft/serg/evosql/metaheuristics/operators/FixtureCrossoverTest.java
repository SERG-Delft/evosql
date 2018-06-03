package nl.tudelft.serg.evosql.metaheuristics.operators;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.util.random.Randomness;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertThrows;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

/**
 * Created by mauricioaniche on 29/07/2017
 * Modified by apanichella on 01/06/2018
 */
public class FixtureCrossoverTest {

    private Randomness randomness;
    private FixtureCrossover crossover;

    @BeforeEach
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

        Fixture[] offspring = this.crossover.crossover(parent1, parent2);
        Fixture offspring1 = offspring[0];
        Fixture offspring2 = offspring[1];

        Assertions.assertEquals(fixtureTable1, offspring1.getTable(0));
        Assertions.assertEquals(fixtureTable4, offspring1.getTable(1));

        Assertions.assertEquals(fixtureTable3, offspring2.getTable(0));
        Assertions.assertEquals(fixtureTable2, offspring2.getTable(1));

        Assertions.assertTrue(offspring1.isChanged());
        Assertions.assertTrue(offspring2.isChanged());
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

        boolean canBeDone = this.crossover.isApplicable(parent1, parent2);
        Assertions.assertFalse(canBeDone);

        Fixture[] offspring = crossover.crossover(parent1, parent2);
        Assertions.assertFalse(offspring[0].isChanged());
        Assertions.assertFalse(offspring[1].isChanged());

        fixtureTable1 = new FixtureTable(schema1, Collections.emptyList());
        parent1 = new Fixture(Arrays.asList(fixtureTable1));

        fixtureTable2 = new FixtureTable(schema1, Collections.emptyList());
        fixtureTable3 = new FixtureTable(schema1, Collections.emptyList());
        parent2 = new Fixture(Arrays.asList(fixtureTable2, fixtureTable3));

        canBeDone = this.crossover.isApplicable(parent2, parent1);
        Assertions.assertFalse(canBeDone);

        offspring = crossover.crossover(parent1, parent2);
        Assertions.assertFalse(offspring[0].isChanged());
        Assertions.assertFalse(offspring[1].isChanged());
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

        boolean canBeDone = this.crossover.isApplicable(parent1, parent2);
        Assertions.assertTrue(canBeDone);

        Fixture[] offspring = crossover.crossover(parent1, parent2);
        Assertions.assertTrue(offspring[0].isChanged());
        Assertions.assertTrue(offspring[1].isChanged());
    }

    @Test
    public void testEmptyFixtures() {
        TableSchema schema1 = Mockito.mock(TableSchema.class);
        Mockito.when(schema1.getName()).thenReturn("table1");

        Fixture parent1 = new Fixture(new ArrayList<>());
        Fixture parent2 = new Fixture(new ArrayList<>());

        boolean canBeDone = this.crossover.isApplicable(parent1, parent2);
        Assertions.assertFalse(canBeDone);
        assertThrows(IllegalArgumentException.class, ()->{crossover.crossover(parent1, parent2);}, "a message");
    }

}

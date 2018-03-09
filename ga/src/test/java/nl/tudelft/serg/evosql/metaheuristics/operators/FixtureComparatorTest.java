package nl.tudelft.serg.evosql.metaheuristics.operators;

import nl.tudelft.serg.evosql.fixture.Fixture;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;

public class FixtureComparatorTest {
    private Fixture f1;
    private Fixture f2;
    private Fixture f3;
    private FixtureFitness ff1;
    private FixtureFitness ff2;
    private FixtureFitness ff3;

    @Before
    public void before() {
        f1 = Mockito.mock(Fixture.class);
        f2 = Mockito.mock(Fixture.class);
        f3 = Mockito.mock(Fixture.class);
        ff1 = Mockito.mock(FixtureFitness.class);
        ff2 = Mockito.mock(FixtureFitness.class);
        ff3 = Mockito.mock(FixtureFitness.class);

        Mockito.when(f1.getFitness()).thenReturn(ff1);
        Mockito.when(f2.getFitness()).thenReturn(ff2);
        Mockito.when(f3.getFitness()).thenReturn(ff3);

        Mockito.when(ff1.getFitnessValue()).thenReturn(1.0);
        Mockito.when(ff2.getFitnessValue()).thenReturn(2.0);
        Mockito.when(ff3.getFitnessValue()).thenReturn(3.0);
    }

    @Test
    public void sortByComparatorTest() {
        ArrayList<Fixture> fixtures = new ArrayList<>();
        fixtures.add(f2);
        fixtures.add(f3);
        fixtures.add(f1);
        FixtureComparator fc = new FixtureComparator();
        Collections.sort(fixtures,fc);
        assertThat(fixtures.indexOf(f1)).isEqualTo(0);
        assertThat(fixtures.indexOf(f3)).isEqualTo(2);
    }

}

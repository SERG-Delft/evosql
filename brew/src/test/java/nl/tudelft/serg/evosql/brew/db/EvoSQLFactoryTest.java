package nl.tudelft.serg.evosql.brew.db;

import nl.tudelft.serg.evosql.EvoSQL;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class EvoSQLFactoryTest {
    @Test
    void createEvoSQLTest() {
        ConnectionData connectionData = new ConnectionData("cs", "db", "user", "pass");

        EvoSQLFactory evoSQLFactory = new EvoSQLFactory();
        evoSQLFactory.createEvoSQL(connectionData);

        // no exceptions occurred, yay
    }
}

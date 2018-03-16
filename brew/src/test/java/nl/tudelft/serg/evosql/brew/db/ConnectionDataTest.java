package nl.tudelft.serg.evosql.brew.db;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

class ConnectionDataTest {
    /**
     * Tests the constructor and getters.
     */
    @Test
    void testConstructor() {
        ConnectionData connectionData = new ConnectionData(
                "connectionString",
                "database",
                "username",
                "password"
        );

        assertThat(connectionData.getConnectionString()).isEqualTo("connectionString");
        assertThat(connectionData.getDatabase()).isEqualTo("database");
        assertThat(connectionData.getUsername()).isEqualTo("username");
        assertThat(connectionData.getPassword()).isEqualTo("password");
    }

    void testConstructorFail() {
        assertThatNullPointerException().isThrownBy(() ->
                new ConnectionData(null, "database", "username", "password")
        );
        assertThatNullPointerException().isThrownBy(() ->
                new ConnectionData("connectionString", null, "username", "password")
        );
        assertThatNullPointerException().isThrownBy(() ->
                new ConnectionData("connectionString", "database", null, "password")
        );
        assertThatNullPointerException().isThrownBy(() ->
                new ConnectionData("connectionString", "database", "username", null)
        );
    }
}

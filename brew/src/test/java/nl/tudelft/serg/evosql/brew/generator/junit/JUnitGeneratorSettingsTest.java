package nl.tudelft.serg.evosql.brew.generator.junit;

import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class JUnitGeneratorSettingsTest {
    @Test
    void staticDefaultMethod() {
        ConnectionData connectionData = new ConnectionData("", "", "", "");
        JUnitGeneratorSettings settings = JUnitGeneratorSettings.getDefault(
                connectionData, "pack", "className");
        assertThat(settings.getConnectionData()).isSameAs(connectionData);
        assertThat(settings.getFilePackage()).isEqualTo("pack");
        assertThat(settings.getClassName()).isEqualTo("className");
    }
}

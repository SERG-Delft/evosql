package nl.tudelft.serg.evosql.brew.data;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNullPointerException;

public class TableSchemaTest {
    @Test
    void constructorTest() {
        List<String> columns = new ArrayList<>();
        columns.add("first");
        columns.add("second");

        TableSchema tableSchema = new TableSchema(
                "schemaName",
                columns
        );

        assertThat(tableSchema.getName()).isEqualTo("schemaName");
        assertThat(tableSchema.getColumns()).isEqualTo(columns);
    }

    @Test
    void constructorFail() {
        assertThatNullPointerException().isThrownBy(() -> {
            new TableSchema(null, Collections.emptyList());
        });
        assertThatNullPointerException().isThrownBy(() -> {
            new TableSchema("schemaName", null);
        });
    }
}

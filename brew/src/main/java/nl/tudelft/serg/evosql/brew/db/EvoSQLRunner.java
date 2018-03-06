package nl.tudelft.serg.evosql.brew.db;

import lombok.NonNull;
import nl.tudelft.serg.evosql.EvoSQL;
import nl.tudelft.serg.evosql.Result;

public class EvoSQLRunner implements QueryRunner {
    @Override
    public Result runQuery(@NonNull String sqlQuery, @NonNull ConnectionData connectionData) {
        EvoSQL evoSQL = new EvoSQL(
                connectionData.getConnectionString(),
                connectionData.getDatabase(),
                connectionData.getUsername(),
                connectionData.getPassword(),
                false);

        return evoSQL.execute(sqlQuery);
    }
}

package nl.tudelft.serg.evosql.brew.demo;

import nl.tudelft.serg.evosql.brew.Pipeline;
import nl.tudelft.serg.evosql.brew.consumer.FileConsumer;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.EvoSQLRunner;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnitGeneratorSettings;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;

import java.nio.file.Path;
import java.nio.file.Paths;

public class Demo {

    final static String QUERY_TO_RUN = "SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name) AND t.Price > (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name) - 10";

    public static void main(String[] args) {
        ConnectionData connectionDataProd = new ConnectionData(
                "jdbc:postgresql://localhost:5432/evosql_brew_prod",
                "evosql_brew_prod", "postgres", "");
//?nullNamePatternMatchesAll=true

        ConnectionData connectionDataTest = new ConnectionData(
                "jdbc:postgresql://localhost:5432/evosql_brew_test",
                "evosql_brew_test", "postgres", "");
        JUnitGeneratorSettings jUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionDataTest,
                "brew.test",
                "DemoTest",
                true,
                true,
                true,
                false,
                true
        );

        Pipeline pipeline = Pipeline.builder()
                .queryRunner(new EvoSQLRunner())
                .connectionData(connectionDataProd)
                .sqlQuery(QUERY_TO_RUN)
                .resultProcessor(new Pipeline.ResultProcessor(
                        new JUnit5TestGenerator(jUnitGeneratorSettings),
                        new PostgreSQLOptions(),
                        new FileConsumer(Paths.get("."))))
                .build();

        pipeline.execute();
    }
}

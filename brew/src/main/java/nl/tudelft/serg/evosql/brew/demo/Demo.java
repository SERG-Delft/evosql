package nl.tudelft.serg.evosql.brew.demo;

import nl.tudelft.serg.evosql.brew.Pipeline;
import nl.tudelft.serg.evosql.brew.consumer.FileConsumer;
import nl.tudelft.serg.evosql.brew.consumer.PrintConsumer;
import nl.tudelft.serg.evosql.brew.data.Result;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.EvoSQLRunner;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnitGeneratorSettings;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;

import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Demo {

    /**
     * This is the query on which we will generate tests.
     */
    final static String QUERY_TO_RUN = "SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM Product_Detail t2 WHERE t.Product = t2.Name) AND t.Price > (SELECT MAX(Type) FROM Product_Detail t2 WHERE t.Product = t2.Name) - 10";
    //final static String QUERY_TO_RUN = "SELECT * FROM Products t WHERE t.Price < 10";
    public static void main(String[] args) {
        //Connection data to production database
        ConnectionData connectionDataProd = new ConnectionData(
                "jdbc:postgresql://localhost:5432/evosql_brew_prod",
                "evosql_brew_prod", "postgres", "");

        //Connection data to test database (this is where the test cases make a connection to
        ConnectionData connectionDataTest = new ConnectionData(
                "jdbc:postgresql://localhost:5432/evosql_brew_test",
                "evosql_brew_test", "postgres", "");

        //Configure jUnitGenerator
        JUnitGeneratorSettings jUnitGeneratorSettings = new JUnitGeneratorSettings(
                connectionDataTest,
                "nl.tudelft.serg.evosql.brew.demo",
                "DemoTest",
                true,
                true,
                true,
                false,
                true);

        //Construct Pipeline
        Pipeline pipeline = Pipeline.builder()
                .queryRunner(new EvoSQLRunner())
                .connectionData(connectionDataProd)
                .sqlQuery(QUERY_TO_RUN)
                //Process result to TestFile
                .resultProcessor(new Pipeline.ResultProcessor(
                        new JUnit5TestGenerator(jUnitGeneratorSettings),
                        new PostgreSQLOptions(),
                        //D:\OneDrive\Documenten\GitHub\evosql\evosql\brew\src\test\java\nl\tudelft\serg\evosql\brew\demo\DemoTest.java
                        new FileConsumer(Paths.get("brew","src","test","java","nl","tudelft","serg","evosql","brew","demo"))))
                //Process result to System.out
                .resultProcessor(new Pipeline.ResultProcessor(
                        new JUnit5TestGenerator(jUnitGeneratorSettings),
                        new PostgreSQLOptions(),
                        new PrintConsumer())
                )
                .build();
        //Execute pipeline
        pipeline.execute();
    }
}

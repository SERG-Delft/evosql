package nl.tudelft.serg.evosql.brew;

import nl.tudelft.serg.evosql.brew.consumer.PrintConsumer;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.EvoSQLRunner;
import nl.tudelft.serg.evosql.brew.db.QueryRunner;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnitGeneratorSettings;
import nl.tudelft.serg.evosql.brew.sql.vendor.PostgreSQLOptions;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class Runner {

    private enum TestFormat {
        JUNIT4,
        JUNIT5,
    }

    private static TestFormat parseTestFormat(String testFormat) {

        switch (testFormat) {
            case "junit5":
                return TestFormat.JUNIT5;
            case "junit4":
            case "junit":
                return TestFormat.JUNIT4;
            default:
                throw new IllegalArgumentException("Invalid test format: " + testFormat);
        }
    }

    private static List<String> readQueries(String file) {

        try {
            List<String> queries = new LinkedList<>();

            Scanner scanner = new Scanner(new BufferedReader(new FileReader(new File(file))));
            while (scanner.hasNextLine()) {
                queries.add(scanner.nextLine());
            }
            scanner.close();

            return queries;

        } catch (FileNotFoundException e) {
            throw new IllegalArgumentException("Cannot find file: " + file);
        }
    }

    private static String parsePassword(String password) {

        if (password.startsWith("pw=")) {
            return password.substring(3);
        }

        throw new IllegalArgumentException("Password should be given as follows (without the quotes): pw=\"my_password\"");
    }

    /**
     * TODO
     * @param args evosql queryfile.sql testformat jdbcString username pwd [output]
     */
    public static void main(String[] args) {

        if (args.length < 5) { //TODO: package and class name
            System.out.println("Usage: evosql queryfile.sql testformat jdbcString username pw=pwd [output]");
        }

        TestFormat testFormat = parseTestFormat(args[0]);
        // check if valid option

        List<String> queries = new ArrayList<>();//readQueries(args[1]);
queries.add("SELECT * FROM PRODUCTS WHERE PRICE > 123");
        String jdbcString = args[2];
        String username = args[3];
        String password = parsePassword(args[4]);

        EvoSQLRunner evoSQLRunner = new EvoSQLRunner();
        ConnectionData connectionData = new ConnectionData(jdbcString, "", username, password);
        List<Pipeline.ResultProcessor> resultProcessors = new ArrayList<>();
        Pipeline.ResultProcessor e = new Pipeline.ResultProcessor(
            new JUnit5TestGenerator(JUnitGeneratorSettings.getDefault(connectionData, "", "SQLTest")),
            new PostgreSQLOptions(),
            new PrintConsumer()
        );
        resultProcessors.add(e);

        Pipeline pipeline = new Pipeline(evoSQLRunner, null, connectionData, resultProcessors);

        // TODO: Prevent overwriting generated classes
        for (String query : queries) {
            pipeline.setSqlQuery(query);
            pipeline.execute();
        }
    }

}

package nl.tudelft.serg.evosql.brew;

import nl.tudelft.serg.evosql.brew.consumer.FileConsumer;
import nl.tudelft.serg.evosql.brew.consumer.OutputConsumer;
import nl.tudelft.serg.evosql.brew.consumer.PrintConsumer;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.brew.db.EvoSQLRunner;
import nl.tudelft.serg.evosql.brew.generator.Generator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnit4TestGenerator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnit5TestGenerator;
import nl.tudelft.serg.evosql.brew.generator.junit.JUnitGenerator;
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

    private static Generator parseTestFormat(String testFormat, ConnectionData conData, String pakkage, String clazz) {

        switch (testFormat) {
            case "junit5":
                return new JUnit5TestGenerator(JUnitGeneratorSettings.getDefault(conData, pakkage, clazz));
            case "junit4":
            case "junit":
                return new JUnit4TestGenerator(JUnitGeneratorSettings.getDefault(conData, pakkage, clazz));
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

        throw new IllegalArgumentException("Password should be given as follows (without quotes): pw=\"my_password\"");
    }

    private static String parsePackage(String pkg) {

        if (pkg.startsWith("pkg=")) {
            return pkg.substring(4);
        }

        throw new IllegalArgumentException("Package name should be given as follows (without quotes): "
                + "pkg=\"package\"");
    }

    private static String parseClass(String clazz) {

        if (clazz.startsWith("cls=")) {
            String className = clazz.substring(4);
            return className.isEmpty() ? "SQLTest" : className;
        }

        throw new IllegalArgumentException("Class name should be given as follows (without quotes): "
                + "cls=\"class_name\"");
    }

    /**
     * TODO
     * @param args queryfile.sql testformat jdbcString username pwd pkg=package cls=class_name [output]
     */
    public static void main(String[] args) {

        if (args.length < 7) { //TODO: package and class name
            throw new IllegalArgumentException("Usage: evosql queryfile.sql testformat jdbcString username pw=pwd [output]");
        }

        List<String> queries = readQueries(args[0]);

        String jdbcString = args[2];
        String username = args[3];
        String password = parsePassword(args[4]);
        ConnectionData connectionData = new ConnectionData(jdbcString, "", username, password);

        String pakkage = parsePackage(args[5]);
        String clazz = parseClass(args[6]);

        JUnitGenerator generator = (JUnitGenerator) parseTestFormat(args[1], connectionData, pakkage, clazz);

        OutputConsumer outputConsumer = args.length < 8 ? new PrintConsumer() :
                new FileConsumer(new File(args[7]).toPath());

        EvoSQLRunner evoSQLRunner = new EvoSQLRunner();

        List<Pipeline.ResultProcessor> resultProcessors = new ArrayList<>();
        // TODO: Vendor options
        resultProcessors.add(new Pipeline.ResultProcessor(generator, new PostgreSQLOptions(), outputConsumer));

        Pipeline pipeline = new Pipeline(evoSQLRunner, null, connectionData, resultProcessors);

        JUnitGeneratorSettings jUnitGeneratorSettings = generator.getJUnitGeneratorSettings();
        long queryCounter = 0;
        for (String query : queries) {
            pipeline.setSqlQuery(query);
            pipeline.execute();
            ++queryCounter;
            jUnitGeneratorSettings.setClassName(clazz + queryCounter);
        }
    }

}

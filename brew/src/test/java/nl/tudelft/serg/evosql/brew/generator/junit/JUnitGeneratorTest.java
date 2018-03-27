package nl.tudelft.serg.evosql.brew.generator.junit;

import java.util.Scanner;

public abstract class JUnitGeneratorTest {

    /*
     * You may use Docker to set up a test instance of MySQL.
     * Execute "docker run --rm -e MYSQL_ALLOW_EMPTY_PASSWORD=true -p 3306:3306 mysql"
     * (without quotes) to start a new MySQL Docker container.
     *
     * On the MySQL server container, execute the following SQL
     * to create a suitable schema for the data below:
     * "CREATE SCHEMA `evosql_brew_test` DEFAULT CHARACTER SET utf8 ;"
     * (without quotes).
     */

    protected static final String TEST_DATABASE_JDBC_URL = "jdbc:mysql://localhost:3306/evosql_brew_test";
    protected static final String TEST_DATABASE_USER = "root";
    protected static final String TEST_DATABASE_PASSWORD = "";

    String getExpected(String filename) {
        String raw = new Scanner(
                getClass().getClassLoader().getResourceAsStream("java/jUnitGenerator/" + filename),
                "UTF-8").useDelimiter("\\A").next();

        return normalizeLineEndings(raw);
    }

    private String normalizeLineEndings(String string) {
        return string.replaceAll("\r\n", "\n");
    }
}

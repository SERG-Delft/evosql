package nl.tudelft.serg.evosql.experiment;

import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.nio.file.Path;

/**
 * Creates a result CSV from test results.
 */
public class CsvMaker {
    private static final char SEPARATOR = ',';

    private final StringBuilder builder;

    /**
     * Initializes a new instance of the {@see CsvMaker} class.
     */
    public CsvMaker() {
        builder = new StringBuilder();
    }

    /**
     * Appends a line to the result CSV file.
     *
     * @param project  The project.
     * @param queryId  The query ID (zero-indexed).
     * @param query    The query itself.
     * @param mutantId The mutant ID.
     * @param mutant   The mutant query itself.
     * @param filePath The path to the test results.
     */
    public void appendCsvLine(String project,
                              int queryId,
                              String query,
                              int mutantId,
                              String mutant,
                              Path filePath) {
        try {
            TestRunResult result = TestRunResult.fromGradleXmlFile(filePath);
            builder.append(project);
            separate();
            builder.append(queryId);
            separate();
            appendString(query);
            separate();
            builder.append(mutantId);
            separate();
            appendString(mutant);
            separate();
            builder.append(result.getTestCaseCount());
            separate();
            builder.append(result.isSuccessful());
            separate();
            builder.append(result.isSuccessPresent());
            separate();
            builder.append(result.isAssertionFailurePresent());
            separate();
            builder.append(result.isExceptionFailurePresent());
            builder.append('\n');
        } catch (ParserConfigurationException | IOException | SAXException e) {
            e.printStackTrace();
        }
    }

    /**
     * Gets the full CSV string.
     *
     * @return The full CSV string.
     */
    @Override
    public String toString() {
        return builder.toString();
    }

    /**
     * Escapes the given string and appends it to the string builder.
     *
     * @param string The string to append.
     */
    private void appendString(String string) {
        builder.append('"');
        builder.append(string.replaceAll("\"", "\"\""));
        builder.append('"');
    }

    /**
     * Adds a new separator symbol.
     */
    private void separate() {
        builder.append(SEPARATOR);
    }
}

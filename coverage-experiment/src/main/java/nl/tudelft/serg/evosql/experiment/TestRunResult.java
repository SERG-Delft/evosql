package nl.tudelft.serg.evosql.experiment;

import lombok.Data;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.nio.file.Path;

/**
 * A class describing the result of a test class.
 */
@Data
public class TestRunResult {
    private final boolean hadSuccesses;
    private final boolean hadAssertionFailures;
    private final boolean hadExceptionFailures;

    public static TestRunResult fromGradleXmlFile(Path filePath)
            throws ParserConfigurationException, IOException, SAXException {
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = dbFactory.newDocumentBuilder();
        Document doc = builder.parse(filePath.toFile());

        boolean hadSuccesses = false;
        boolean hadAssertFailures = false;
        boolean hadExceptionFailures = false;

        Node testSuite = doc.getFirstChild();

        // Traverse all test cases
        NodeList testCases = testSuite.getChildNodes();
        for (int i = 0; i < testCases.getLength(); ++i) {
            Node testCase = testCases.item(i);
            // Skip the node if it is not a test case
            if (!testCase.getNodeName().equals("testcase")) continue;

            if (testCase.hasChildNodes()) {
                // If the node has child nodes, its test failed
                // Traverse nodes to find <failure>
                NodeList failureContaining = testCase.getChildNodes();
                Node failure = null;
                for (int j = 0; j < failureContaining.getLength(); ++j) {
                    failure = failureContaining.item(j);
                    if (failure.getNodeName().equals("failure")) break;
                }

                // See if the message indicates an assertion error
                if (failure.getAttributes().getNamedItem("message").getTextContent().contains("AssertionFailedError")) {
                    hadAssertFailures = true;
                } else {
                    hadExceptionFailures = true;
                }
            } else {
                hadSuccesses = true;
            }
        }

        return new TestRunResult(hadSuccesses, hadAssertFailures, hadExceptionFailures);
    }
}

package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.ws.WebServiceException;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Class responsible for mutating the conditions in the query.
 */
@AllArgsConstructor
public class QueryMutator {
    // FIXME: Make these attributes immutable?
    private String query;
    private ConnectionData connectionData;

    /**
     * Use the SQLMutation web service in order to create mutants of the query. We connect to
     * the web service with a connector class {@link WebMutatorConnector} which also makes the
     * request and secures the query string to the right format. The connector also fetches
     * the right schema XML from the resource files.
     *
     * @return a list of query mutants.
     */
    public List<String> createMutants() throws MutationException {
        WebMutatorConnector webMutatorConnector = new WebMutatorConnector(query, connectionData);
        String mutantsXML = webMutatorConnector.requestMutants();
        if (mutantsXML.contains("<error>")) {
            throw new MutationException(
                    "An error occurred in retrieving the mutants, the error XML is:\n\n" + mutantsXML +
                            "\n\nSchema: " + webMutatorConnector.getSchemaXml()
            );
        }
        return parseMutations(mutantsXML);
    }


    /**
     * Parses the XML of the mutants in a very naive way to a list of query strings without XML tags.
     *
     * @param xml XML representation of query mutants
     * @return list of mutants as query strings.
     */
    public List<String> parseMutations(String xml) throws MutationException {
        List<String> mutants = new ArrayList<>();

        try {
            // Setup for parser
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            InputSource is = new InputSource(new StringReader(xml));

            // Parse string
            Document doc = dBuilder.parse(is);
            doc.getDocumentElement().normalize();

            NodeList mutantNodeList = doc.getElementsByTagName("sql");
            for (int i = 0; i < mutantNodeList.getLength(); i++) {
                Node mutantNode = mutantNodeList.item(i);
                mutants.add(mutantNode.getFirstChild().getNodeValue().trim());
            }



        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }

        if (mutants.size() == 0 || mutants.get(0) == null) {
            throw new MutationException("List of mutants is invalid, please check the returned xml: " + xml);
        }
        return mutants;
    }
}

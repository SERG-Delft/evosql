package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;

import javax.xml.ws.WebServiceException;
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
        List<String> mutants = Arrays.stream(xml.split("\n"))
                .filter(x -> x.contains("<sql>"))
                .map(x -> x.replaceAll("<[^>]+>", ""))
                .map(x -> x.trim())
                .collect(Collectors.toList());
        if (mutants.size() == 0) {
            throw new MutationException("List of mutants is empty, please check the returned xml: " + xml);
        }
        return mutants;
    }
}

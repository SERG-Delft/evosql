package nl.tudelft.serg.evosql.experiment;


import com.google.common.base.Charsets;
import com.google.common.io.Resources;
import in2test.application.common.SQLToolsConfig;
import in2test.application.services.SQLMutationWSFacade;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

import java.io.IOException;
import java.net.URL;

/**
 * Class responsible for making a web request to retrieve the query mutations
 * from the SQLMutation web service.
 */
public class WebMutatorConnector {
    private final String secureSqlquery;
    private final String schemaXml;

    public WebMutatorConnector(String sqlQuery, String dbName) {
        SqlSecurer sqlSecurer = new SqlSecurer(sqlQuery);
        secureSqlquery = sqlSecurer.getSecureSql();
        schemaXml = fetchSchemaXml(dbName);
        SQLToolsConfig.configure();
    }

    /**
     * Fetches the XML format of the DB schema from the corresponding resource file.
     *
     * @param dbName database name of the given query
     * @return schema in XML format.
     */
    private String fetchSchemaXml(String dbName) {
        URL url = Resources.getResource("schema_xml/" + dbName + "_schema.xml");
        try {
            String text = Resources.toString(url, Charsets.UTF_8);
            return text;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * Calls the SQLMutation web service in order to get the mutants of the query.
     * The mutants are in XML format.
     *
     * Uses the <noequivalent/> option so that no duplicate mutants are created.
     *
     * @return XML representation of the web service.
     */
    public String requestMutants() {
        String mutantsXml = "";
        SQLMutationWSFacade mutationWSFacade = new SQLMutationWSFacade();
        mutantsXml = mutationWSFacade.getMutants(secureSqlquery, schemaXml, "<options><noequivalent/></options>");
        return mutantsXml;
    }


}

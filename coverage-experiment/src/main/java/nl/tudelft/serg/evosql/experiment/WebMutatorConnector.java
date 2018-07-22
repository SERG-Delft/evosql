package nl.tudelft.serg.evosql.experiment;


import com.google.common.base.Charsets;
import com.google.common.io.Resources;
import in2test.application.common.SQLToolsConfig;
import in2test.application.services.SQLMutationWSFacade;
import lombok.Getter;
import nl.tudelft.serg.evosql.brew.db.ConnectionData;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.db.TableXMLFormatter;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

import java.io.IOException;
import java.net.URL;

/**
 * Class responsible for making a web request to retrieve the query mutations
 * from the SQLMutation web service.
 */
public class WebMutatorConnector {
    private final String secureSqlquery;
    @Getter
    private final String schemaXml;

    public WebMutatorConnector(String sqlQuery, ConnectionData connectionData) {
        SqlSecurer sqlSecurer = new SqlSecurer(sqlQuery);
        secureSqlquery = sqlSecurer.getSecureSql();
        schemaXml = fetchSchemaXml(connectionData);
        SQLToolsConfig.configure();
    }

    /**
     * Fetches the XML format of the DB schema from the corresponding resource file.
     *
     * @return schema in XML format.
     */
    private String fetchSchemaXml(ConnectionData connectionData) {
        TableXMLFormatter tableXMLFormatter = new TableXMLFormatter(
                new SchemaExtractor(connectionData.getConnectionString(),
                                    connectionData.getDatabase(),
                                    connectionData.getUsername(),
                                    connectionData.getPassword()),
                secureSqlquery);

        return tableXMLFormatter.getSchemaXml();
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

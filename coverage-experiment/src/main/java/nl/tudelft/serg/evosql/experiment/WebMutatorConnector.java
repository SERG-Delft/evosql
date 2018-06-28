package nl.tudelft.serg.evosql.experiment;


import in2test.application.common.SQLToolsConfig;
import in2test.application.services.SQLMutationWSFacade;
import nl.tudelft.serg.evosql.db.ISchemaExtractor;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;

/**
 * Class responsible for making a web request to retrieve the query mutations
 * from the SQLMutation web service.
 */
public class WebMutatorConnector {
    private String secureSqlquery;
    private String schemaXml;

    public WebMutatorConnector(String sqlQuery, ISchemaExtractor schemaExtractor) {
        SqlSecurer sqlSecurer = new SqlSecurer(sqlQuery);
        secureSqlquery = sqlSecurer.getSecureSql();
        schemaXml = getSchemaXml(secureSqlquery, schemaExtractor);
        SQLToolsConfig.configure();
    }

    /**
     * Transforms the schema into XML format.
     *
     * @param schema schema of query
     * @return schema in XML format.
     */
    private String getSchemaXml(String schema, ISchemaExtractor schemaExtractor) {
        return new SchemaXMLBuilder(secureSqlquery, schemaExtractor).getSchemaXml();
    }


    /**
     * Calls the SQLMutation web service in order to get the mutants of the query.
     * The mutants are in XML format.
     *
     * @return XML representation of the web service.
     */
    public String requestMutants() {
        String mutantsXml = "";
        SQLMutationWSFacade mutationWSFacade = new SQLMutationWSFacade();
        mutantsXml = mutationWSFacade.getMutants(secureSqlquery, schemaXml, "");
        return mutantsXml;
    }


}

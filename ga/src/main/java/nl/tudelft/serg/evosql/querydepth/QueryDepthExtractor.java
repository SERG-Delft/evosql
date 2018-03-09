package nl.tudelft.serg.evosql.querydepth;

//import com.sun.istack.internal.NotNull;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.metaheuristics.Approach;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * This class is responsible for extracting the depth of a query.
 *
 * It uses the jSQLParser library for analysing the query and through a visitor class:
 * @see QueryDepthVisitor .
 */
public class QueryDepthExtractor {

    protected static Logger log = LogManager.getLogger(QueryDepthExtractor.class);

    //@NotNull
    private Select statement;
    private Integer depth = null;

    public QueryDepthExtractor(Select statement) {
        this.statement = statement;
    }

    public QueryDepthExtractor(String query) {
        Select stmt = null;
        try {
            stmt = (Select) CCJSqlParserUtil.parse(query);
        } catch (JSQLParserException e) {
            throw new RuntimeException(e);
        }
        statement = stmt;
    }


    public Select getStatement() {
        return statement;
    }

    /**
     * Setter for statement attribute, also sets depth as null to prevent
     * reuse of depth for different statement.
     * @param statement statement to set
     */
    public void setStatement(Select statement) {
        this.statement = statement;
        depth = null;
    }

    /**
     * Visits the statement (through visitor design pattern) and lets the visitor
     * find out which expressions contribute to the query level. It returns the
     * amount of expressions which increment the query depth.
     * @return query depth.
     */
    public int getQueryDepth() {
        if(depth == null) {
            QueryDepthVisitor visitor = new QueryDepthVisitor();
            statement.accept(visitor);
            depth = visitor.getQueryLevels().size();
            log.debug("current query depth: {}", depth);
            return depth;
        } else {
            return depth;
        }
    }

}

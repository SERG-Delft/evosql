package nl.tudelft.serg.evosql.querydepth;

import com.sun.istack.internal.NotNull;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;

/**
 * This class is responsible for extracting the depth of a query.
 *
 * It uses the jSQLParser library for analysing the query and through a visitor class:
 * @see QueryDepthVisitor .
 */
public class QueryDepthExtractor {

    @NotNull
    private Select statement;

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
     * Visits the statement (through visitor design pattern) and lets the visitor
     * find out which expressions contribute to the query level. It returns the
     * amount of expressions which increment the query depth.
     * @return query depth.
     */
    public int getQueryDepth() {
        QueryDepthVisitor visitor = new QueryDepthVisitor();
        statement.accept(visitor);
        return visitor.getQueryLevels().size();
    }

}

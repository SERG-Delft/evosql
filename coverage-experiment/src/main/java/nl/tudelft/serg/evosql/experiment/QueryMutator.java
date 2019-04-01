package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.util.deparser.ExpressionDeParser;
import net.sf.jsqlparser.util.deparser.SelectDeParser;
import net.sf.jsqlparser.util.deparser.StatementDeParser;

import java.util.ArrayList;
import java.util.List;

/**
 * Class responsible for mutating the conditions in the query.
 */
@AllArgsConstructor
public class QueryMutator {
    // FIXME: Make these attributes immutable?
    private String query;

    public String parseOriginalQuery(Select query) {
        StringBuilder buffer = new StringBuilder();
        SelectDeParser selectDeparser = new SelectDeParser();
        selectDeparser.setBuffer(buffer);
        ExpressionDeParser expressionDeParser = new ExpressionDeParser(selectDeparser, buffer);
        selectDeparser.setExpressionVisitor(expressionDeParser);
        query.getSelectBody().accept(selectDeparser);
        return selectDeparser.getBuffer().toString();
    }

    /**
     * @return a list of query mutants.
     */
    public List<String> createMutants() throws JSQLParserException {
        Select selectStatement = (Select) CCJSqlParserUtil.parse(query);
        int globalCounter = 0;

        StringBuilder buffer = new StringBuilder();
        SelectDeParser selectDeparser = new SelectDeParser();
        selectDeparser.setBuffer(buffer);
        QueryMutatorVisitor visitor = new QueryMutatorVisitor(selectDeparser, buffer,0,globalCounter);
        selectDeparser.setExpressionVisitor(visitor);

        String parsedOriginalQuery = parseOriginalQuery(selectStatement);
        List<String> mutants = new ArrayList<>();
        String mutatedQuery;

        do {
            visitor.setLocalCounter(0);
            selectStatement.getSelectBody().accept(selectDeparser);
            // run the visitor

            mutatedQuery = visitor.getBuffer().toString();
            mutants.add(mutatedQuery);

            StringBuilder newBuffer = new StringBuilder();
            visitor.setBuffer(newBuffer);
            selectDeparser.setBuffer(newBuffer);

            globalCounter++;
            visitor.setGlobalCounter(globalCounter);
        } while (!parsedOriginalQuery.equals(mutatedQuery));

        return mutants;
    }

}

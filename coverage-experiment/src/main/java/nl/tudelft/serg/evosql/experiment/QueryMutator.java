package nl.tudelft.serg.evosql.experiment;

import lombok.AllArgsConstructor;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.util.deparser.ExpressionDeParser;
import net.sf.jsqlparser.util.deparser.SelectDeParser;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Class responsible for mutating the conditions in the query.
 */
@AllArgsConstructor
public class QueryMutator {
    // FIXME: Make these attributes immutable?
    private String query;

    /**
     * Parses the original query in the jSQL format, so it can be used for comparison later.
     *
     * @param query original query in jSQL statement format
     * @return parsed query in string representation.
     */
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
     * Given the original query, mutants are generated based on flipping conditions. Using a counter, these conditions
     * are flipped one at a time so that each condition is flipped exactly once. A generated mutant will not
     * contain multiple flipped conditions, this allows us to isolate results based on these mutants for certain
     * conditions.
     *
     * @return a list of mutants with flipped conditions, does <i>NOT</i> include original query).
     * @throws JSQLParserException in case the query has syntax errors.
     */
    public List<String> createMutants() throws JSQLParserException {
        Select selectStatement = (Select) CCJSqlParserUtil.parse(query);

        QueryMutatorVisitor visitor = new QueryMutatorVisitor(new MutatorContext(new StringBuilder(), new ArrayList<>()));

        // run the visitor
        selectStatement.getSelectBody().accept(visitor);

        return visitor.getMutatorContext().exportMutants();
    }

}

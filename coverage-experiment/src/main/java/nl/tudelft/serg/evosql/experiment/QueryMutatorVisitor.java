package nl.tudelft.serg.evosql.experiment;

import lombok.Getter;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.util.deparser.ExpressionDeParser;
import net.sf.jsqlparser.util.deparser.SelectDeParser;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

// FIXME: implement more mutations

/**
 * The visitor visits expressions and adds each expression to a buffer in String format. For certain, conditions
 * we check if we can do a bitflip based on the counters. Once the local counter is equal to the global counter, then
 * it is allowed to do a bitflip. The global counter is then incremented in the higher-level method so that the next
 * iteration mutates a different condition.
 */
public class QueryMutatorVisitor extends ExpressionDeParser {

    @Getter
    private List<StringBuilder> buffers = new ArrayList<>();
    private ExpressionDeParser cleanDeParser;
    private StringBuilder sharedBuffer;
    private int lastSharedPosition;
    private SelectDeParser selectDeParser;

    public QueryMutatorVisitor(SelectDeParser selectVisitor) {
        super();
        sharedBuffer = selectVisitor.getBuffer();
        lastSharedPosition = sharedBuffer.length();
        cleanDeParser = new ExpressionDeParser(selectVisitor, sharedBuffer);

        this.selectDeParser = selectVisitor;
        this.setSelectVisitor(selectVisitor);
        this.setBuffer(sharedBuffer);
    }

    private void setDeParserBuffers(StringBuilder buffer) {
        super.buffer = buffer;
        this.selectDeParser.setBuffer(buffer);
    }

    private void setCleanDeParserBuffer(StringBuilder buffer) {
        setDeParserBuffers(buffer);
        cleanDeParser.setBuffer(buffer);
    }

    private void enterVisit(Expression expr) {
        String added = sharedBuffer.substring(lastSharedPosition);
        lastSharedPosition = sharedBuffer.length();

        for (StringBuilder buffer : buffers) {
            buffer.append(added);
            setCleanDeParserBuffer(buffer);
            expr.accept(cleanDeParser);
        }
        setCleanDeParserBuffer(sharedBuffer);
    }

    private void exitVisit(Expression expr) {
        setCleanDeParserBuffer(sharedBuffer);
        expr.accept(cleanDeParser);
        lastSharedPosition = sharedBuffer.length();
        setDeParserBuffers(sharedBuffer);
    }

    private void visitComparison(ComparisonOperator expr, String operator) {
        StringBuilder buf = new StringBuilder(sharedBuffer);
        buffers.add(buf);
        setDeParserBuffers(buf);
        super.visitOldOracleJoinBinaryExpression(expr, operator);
    }

//    @Override
//    public void visit(BitwiseRightShift aThis) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(BitwiseLeftShift aThis) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(NullValue nullValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Function function) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(SignedExpression signedExpression) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(JdbcParameter jdbcParameter) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(JdbcNamedParameter jdbcNamedParameter) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(DoubleValue doubleValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(LongValue longValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(HexValue hexValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(DateValue dateValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(TimeValue timeValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(TimestampValue timestampValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Parenthesis parenthesis) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(StringValue stringValue) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Addition addition) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Division division) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Multiplication multiplication) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Subtraction subtraction) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(AndExpression andExpression) {
//        if (localCounter == globalCounter) {
//            localCounter++;
//            OrExpression orExpression = new OrExpression(
//                    andExpression.getLeftExpression(),
//                    andExpression.getRightExpression());
//            super.visit(orExpression);
//        } else {
//            localCounter++;
//            super.visit(andExpression);
//        }
//    }

//    @Override
//    public void visit(OrExpression orExpression) {
//        if (localCounter == globalCounter) {
//            localCounter++;
//            AndExpression andExpression = new AndExpression(
//                    orExpression.getLeftExpression(),
//                    orExpression.getRightExpression());
//            super.visit(andExpression);
//        } else {
//            localCounter++;
//            super.visit(orExpression);
//        }
//    }
//
//    @Override
//    public void visit(Between between) {
//        // FIXME: override or remove
//    }
//
    @Override
    public void visit(EqualsTo equalsTo) {
        enterVisit(equalsTo);

        Arrays.asList(" <> ", " < ", " <= ", " > ", " >= ")
                .forEach(op -> visitComparison(equalsTo, op));

        exitVisit(equalsTo);
    }

    @Override
    public void visit(GreaterThan greaterThan) {
        enterVisit(greaterThan);

        Arrays.asList(" == ", " <> ", " < ", " <= ", " >= ")
                .forEach(op -> visitComparison(greaterThan, op));

        exitVisit(greaterThan);
    }

    @Override
    public void visit(GreaterThanEquals greaterThanEquals) {
        enterVisit(greaterThanEquals);

        Arrays.asList(" == ", " <> ", " < ", " <= ", " > ")
                .forEach(op -> visitComparison(greaterThanEquals, op));

        exitVisit(greaterThanEquals);
    }
//
//    @Override
//    public void visit(InExpression inExpression) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(IsNullExpression isNullExpression) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(LikeExpression likeExpression) {
//        // FIXME: override or remove
//    }
//
    @Override
    public void visit(MinorThan minorThan) {
        enterVisit(minorThan);

        Arrays.asList(" == ", " <> ", " <= ", " > ", " >= ")
                .forEach(op -> visitComparison(minorThan, op));

        exitVisit(minorThan);
    }

    @Override
    public void visit(MinorThanEquals minorThanEquals) {
        enterVisit(minorThanEquals);

        Arrays.asList(" == ", " <> ", " < ", " > ", " >= ")
                .forEach(op -> visitComparison(minorThanEquals, op));

        exitVisit(minorThanEquals);
    }
//
//    @Override
//    public void visit(NotEqualsTo notEqualsTo) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(Column tableColumn) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(SubSelect subSelect) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(CaseExpression caseExpression) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(WhenClause whenClause) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(ExistsExpression existsExpression) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(AllComparisonExpression allComparisonExpression) {
//        // FIXME: override or remove
//    }
//
//    @Override
//    public void visit(AnyComparisonExpression anyComparisonExpression) {
//
//    }
//
//    @Override
//    public void visit(Concat concat) {
//
//    }
//
//    @Override
//    public void visit(Matches matches) {
//
//    }
//
//    @Override
//    public void visit(BitwiseAnd bitwiseAnd) {
//
//    }
//
//    @Override
//    public void visit(BitwiseOr bitwiseOr) {
//
//    }
//
//    @Override
//    public void visit(BitwiseXor bitwiseXor) {
//
//    }
//
//    @Override
//    public void visit(CastExpression cast) {
//
//    }
//
//    @Override
//    public void visit(Modulo modulo) {
//
//    }
//
//    @Override
//    public void visit(AnalyticExpression aexpr) {
//
//    }
//
//    @Override
//    public void visit(ExtractExpression eexpr) {
//
//    }
//
//    @Override
//    public void visit(IntervalExpression iexpr) {
//
//    }
//
//    @Override
//    public void visit(OracleHierarchicalExpression oexpr) {
//
//    }
//
//    @Override
//    public void visit(RegExpMatchOperator rexpr) {
//
//    }
//
//    @Override
//    public void visit(JsonExpression jsonExpr) {
//
//    }
//
//    @Override
//    public void visit(JsonOperator jsonExpr) {
//
//    }
//
//    @Override
//    public void visit(RegExpMySQLOperator regExpMySQLOperator) {
//
//    }
//
//    @Override
//    public void visit(UserVariable var) {
//
//    }
//
//    @Override
//    public void visit(NumericBind bind) {
//
//    }
//
//    @Override
//    public void visit(KeepExpression aexpr) {
//
//    }
//
//    @Override
//    public void visit(MySQLGroupConcat groupConcat) {
//
//    }
//
//    @Override
//    public void visit(ValueListExpression valueList) {
//
//    }
//
//    @Override
//    public void visit(RowConstructor rowConstructor) {
//
//    }
//
//    @Override
//    public void visit(OracleHint hint) {
//
//    }
//
//    @Override
//    public void visit(TimeKeyExpression timeKeyExpression) {
//
//    }
//
//    @Override
//    public void visit(DateTimeLiteralExpression literal) {
//
//    }
//
//    @Override
//    public void visit(NotExpression aThis) {
//
//    }
}

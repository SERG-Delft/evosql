package nl.tudelft.serg.evosql.experiment;

import lombok.Getter;
import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.arithmetic.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.values.ValuesStatement;
import net.sf.jsqlparser.util.deparser.*;


import java.util.Iterator;
import java.util.List;

/**
 * This Visitor uses the DeParser implementations for both a SelectDeParser and ExpressionDeParser. Instead of writing
 * to a single buffer, the Visitor writes to a {@link MutatorContext}, which contains several buffers and automatically
 * updates every single buffer and thus hides the complexity of branching mutants. Whenever a new mutant is added, the
 * class should get the clean buffer from the MutatorContext and: 1. construct a new buffer based on the clean buffer,
 * 2. append the mutated clause to the new buffer, 3. add the buffer to the {@link MutatorContext} by calling the
 * {@link MutatorContext#branch(StringBuilder)} method.
 */
public class QueryMutatorVisitor implements SelectVisitor, SelectItemVisitor, FromItemVisitor, PivotVisitor, ExpressionVisitor, ItemsListVisitor {

    private static final String NOT = "NOT ";
    private boolean useBracketsInExprList = true;

    @Getter
    private MutatorContext mutatorContext;

    public QueryMutatorVisitor(MutatorContext mutatorContext) {
        this.mutatorContext = mutatorContext;
    }

    @Override
    public void visit(Addition addition) {
        visitBinaryExpression(addition, " + ");
    }

    @Override
    public void visit(AndExpression andExpression) {
        visitBinaryExpression(andExpression, " AND ");
    }

    @Override
    public void visit(Between between) {
        between.getLeftExpression().accept(this);
        if (between.isNot()) {
            mutatorContext.write(" NOT");
        }

        mutatorContext.write(" BETWEEN ");
        between.getBetweenExpressionStart().accept(this);
        mutatorContext.write(" AND ");
        between.getBetweenExpressionEnd().accept(this);

    }

    @Override
    public void visit(EqualsTo equalsTo) {
        visitOldOracleJoinBinaryExpression(equalsTo, " = ");
    }

    @Override
    public void visit(Division division) {
        visitBinaryExpression(division, " / ");
    }

    @Override
    public void visit(DoubleValue doubleValue) {
        mutatorContext.write(doubleValue.toString());
    }

    @Override
    public void visit(HexValue hexValue) {
        mutatorContext.write(hexValue.toString());
    }

    @Override
    public void visit(NotExpression notExpr) {
        mutatorContext.write(NOT);
        notExpr.getExpression().accept(this);
    }

    @Override
    public void visit(BitwiseRightShift expr) {
        visitBinaryExpression(expr, " >> ");
    }

    @Override
    public void visit(BitwiseLeftShift expr) {
        visitBinaryExpression(expr, " << ");
    }

    public void visitOldOracleJoinBinaryExpression(OldOracleJoinBinaryExpression expression, String operator) {
        if (expression.isNot()) {
            mutatorContext.write(NOT);
        }
        expression.getLeftExpression().accept(this);
        if (expression.getOldOracleJoinSyntax() == EqualsTo.ORACLE_JOIN_RIGHT) {
            mutatorContext.write("(+)");
        }
        mutatorContext.write(operator);
        expression.getRightExpression().accept(this);
        if (expression.getOldOracleJoinSyntax() == EqualsTo.ORACLE_JOIN_LEFT) {
            mutatorContext.write("(+)");
        }
    }

    @Override
    public void visit(GreaterThan greaterThan) {
        visitOldOracleJoinBinaryExpression(greaterThan, " > ");
    }

    @Override
    public void visit(GreaterThanEquals greaterThanEquals) {
        visitOldOracleJoinBinaryExpression(greaterThanEquals, " >= ");

    }

    @Override
    public void visit(InExpression inExpression) {
        if (inExpression.getLeftExpression() == null) {
            inExpression.getLeftItemsList().accept(this);
        } else {
            inExpression.getLeftExpression().accept(this);
            if (inExpression.getOldOracleJoinSyntax() == SupportsOldOracleJoinSyntax.ORACLE_JOIN_RIGHT) {
                mutatorContext.write("(+)");
            }
        }
        if (inExpression.isNot()) {
            mutatorContext.write(" NOT");
        }
        mutatorContext.write(" IN ");

        inExpression.getRightItemsList().accept(this);
    }

    @Override
    public void visit(SignedExpression signedExpression) {
        mutatorContext.write(String.valueOf(signedExpression.getSign()));
        signedExpression.getExpression().accept(this);
    }

    @Override
    public void visit(IsNullExpression isNullExpression) {
        isNullExpression.getLeftExpression().accept(this);
        if (isNullExpression.isUseIsNull()) {
            if (isNullExpression.isNot()) {
                mutatorContext.write(" NOT ISNULL");
            } else {
                mutatorContext.write(" ISNULL");
            }
        } else {
            if (isNullExpression.isNot()) {
                mutatorContext.write(" IS NOT NULL");
            } else {
                mutatorContext.write(" IS NULL");
            }
        }
    }

    @Override
    public void visit(JdbcParameter jdbcParameter) {
        mutatorContext.write("?");
        if (jdbcParameter.isUseFixedIndex()) {
            mutatorContext.write(String.valueOf(jdbcParameter.getIndex()));
        }

    }

    @Override
    public void visit(LikeExpression likeExpression) {
        visitBinaryExpression(likeExpression, likeExpression.isCaseInsensitive() ? " ILIKE " : " LIKE ");
        String escape = likeExpression.getEscape();
        if (escape != null) {
            mutatorContext.write(" ESCAPE '").write(escape).write("\'");
        }
    }

    @Override
    public void visit(ExistsExpression existsExpression) {
        if (existsExpression.isNot()) {
            mutatorContext.write("NOT EXISTS ");
        } else {
            mutatorContext.write("EXISTS ");
        }
        existsExpression.getRightExpression().accept(this);
    }

    @Override
    public void visit(LongValue longValue) {
        mutatorContext.write(longValue.getStringValue());

    }

    @Override
    public void visit(MinorThan minorThan) {
        visitOldOracleJoinBinaryExpression(minorThan, " < ");

    }

    @Override
    public void visit(MinorThanEquals minorThanEquals) {
        visitOldOracleJoinBinaryExpression(minorThanEquals, " <= ");

    }

    @Override
    public void visit(Multiplication multiplication) {
        visitBinaryExpression(multiplication, " * ");

    }

    @Override
    public void visit(NotEqualsTo notEqualsTo) {
        visitOldOracleJoinBinaryExpression(notEqualsTo, " " + notEqualsTo.getStringExpression() + " ");

    }

    @Override
    public void visit(NullValue nullValue) {
        mutatorContext.write(nullValue.toString());

    }

    @Override
    public void visit(OrExpression orExpression) {
        visitBinaryExpression(orExpression, " OR ");

    }

    @Override
    public void visit(Parenthesis parenthesis) {
        if (parenthesis.isNot()) {
            mutatorContext.write(NOT);
        }

        mutatorContext.write("(");
        parenthesis.getExpression().accept(this);
        mutatorContext.write(")");

    }

    @Override
    public void visit(StringValue stringValue) {
        if (stringValue.getPrefix() != null) {
            mutatorContext.write(stringValue.getPrefix());
        }
        mutatorContext.write("'").write(stringValue.getValue()).write("'");

    }

    @Override
    public void visit(Subtraction subtraction) {
        visitBinaryExpression(subtraction, " - ");
    }

    private void visitBinaryExpression(BinaryExpression binaryExpression, String operator) {
        if (binaryExpression.isNot()) {
            mutatorContext.write(NOT);
        }
        binaryExpression.getLeftExpression().accept(this);
        mutatorContext.write(operator);
        binaryExpression.getRightExpression().accept(this);

    }

    @Override
    public void visit(SubSelect subSelect) {
        mutatorContext.write("(");
        if (subSelect.getWithItemsList() != null && !subSelect.getWithItemsList().isEmpty()) {
            mutatorContext.write("WITH ");
            for (Iterator<WithItem> iter = subSelect.getWithItemsList().iterator(); iter.hasNext();) {
                WithItem withItem = iter.next();
                withItem.accept(this);
                if (iter.hasNext()) {
                    mutatorContext.write(",");
                }
                mutatorContext.write(" ");
            }
        }
        subSelect.getSelectBody().accept(this);
        mutatorContext.write(")");
        Alias alias = subSelect.getAlias();
        if (alias != null) {
            mutatorContext.write(alias.toString());
        }
        Pivot pivot = subSelect.getPivot();
        if (pivot != null) {
            pivot.accept(this);
        }
    }
//
//    @Override
//    public void visit(SubSelect subSelect) {
//        if (subSelect.isUseBrackets()) {
//            mutatorContext.write("(");
//        }
//
//        if (subSelect.getWithItemsList() != null) {
//            mutatorContext.write("WITH ");
//            for (Iterator<WithItem> iter = subSelect.getWithItemsList().iterator(); iter.
//                    hasNext();) {
//                iter.next().accept(this);
//                if (iter.hasNext()) {
//                    mutatorContext.write(", ");
//                }
//                mutatorContext.write(" ");
//            }
//            mutatorContext.write(" ");
//
//
//            subSelect.getSelectBody().accept(this);
//        }
//        if (subSelect.isUseBrackets()) {
//            mutatorContext.write(")");
//        }
//    }

    @Override
    public void visit(Column tableColumn) {
        final Table table = tableColumn.getTable();
        String tableName = null;
        if (table != null) {
            if (table.getAlias() != null) {
                tableName = table.getAlias().getName();
            } else {
                tableName = table.getFullyQualifiedName();
            }
        }
        if (tableName != null && !tableName.isEmpty()) {
            mutatorContext.write(tableName).write(".");
        }

        mutatorContext.write(tableColumn.getColumnName());
    }

    @Override
    public void visit(Function function) {
        if (function.isEscaped()) {
            mutatorContext.write("{fn ");
        }

        mutatorContext.write(function.getName());
        if (function.isAllColumns() && function.getParameters() == null) {
            mutatorContext.write("(*)");
        } else if (function.getParameters() == null && function.getNamedParameters() == null) {
            mutatorContext.write("()");
        } else {
            boolean oldUseBracketsInExprList = useBracketsInExprList;
            if (function.isDistinct()) {
                useBracketsInExprList = false;
                mutatorContext.write("(DISTINCT ");
            } else if (function.isAllColumns()) {
                useBracketsInExprList = false;
                mutatorContext.write("(ALL ");
            }
            if(function.getNamedParameters() != null){
                visit(function.getNamedParameters());
            }
            if(function.getParameters() != null){
                visit(function.getParameters());
            }
            useBracketsInExprList = oldUseBracketsInExprList;
            if (function.isDistinct() || function.isAllColumns()) {
                mutatorContext.write(")");
            }
        }

        if (function.getAttribute() != null) {
            mutatorContext.write(".").write(function.getAttribute());
        }
        if (function.getKeep() != null) {
            mutatorContext.write(" ").write(function.getKeep().toString());
        }

        if (function.isEscaped()) {
            mutatorContext.write("}");
        }
    }

    @Override
    public void visit(ExpressionList expressionList) {
        if (useBracketsInExprList) {
            mutatorContext.write("(");
        }
        for (Iterator<Expression> iter = expressionList.getExpressions().iterator(); iter.hasNext();) {
            Expression expression = iter.next();
            expression.accept(this);
            if (iter.hasNext()) {
                mutatorContext.write(", ");
            }
        }
        if (useBracketsInExprList) {
            mutatorContext.write(")");
        }
    }

    @Override
    public void visit(NamedExpressionList namedExpressionList) {
        if (useBracketsInExprList) {
            mutatorContext.write("(");
        }
        List<String> names = namedExpressionList.getNames();
        List<Expression> expressions = namedExpressionList.getExpressions();
        for (int i=0; i<names.size(); i++){
            if(i>0){
                mutatorContext.write(" ");
            }
            String name = names.get(i);
            if(! name.equals("")){
                mutatorContext.write(name);
                mutatorContext.write(" ");
            }
            expressions.get(i).accept(this);
        }
        if (useBracketsInExprList) {
            mutatorContext.write(")");
        }
    }


    @Override
    public void visit(DateValue dateValue) {
        mutatorContext.write("{d '").write(dateValue.getValue().toString()).write("'}");
    }

    @Override
    public void visit(TimestampValue timestampValue) {
        mutatorContext.write("{ts '").write(timestampValue.getValue().toString()).write("'}");
    }

    @Override
    public void visit(TimeValue timeValue) {
        mutatorContext.write("{t '").write(timeValue.getValue().toString()).write("'}");
    }

    @Override
    public void visit(CaseExpression caseExpression) {
        mutatorContext.write("CASE ");
        Expression switchExp = caseExpression.getSwitchExpression();
        if (switchExp != null) {
            switchExp.accept(this);
            mutatorContext.write(" ");
        }

        for (Expression exp : caseExpression.getWhenClauses()) {
            exp.accept(this);
        }

        Expression elseExp = caseExpression.getElseExpression();
        if (elseExp != null) {
            mutatorContext.write("ELSE ");
            elseExp.accept(this);
            mutatorContext.write(" ");
        }

        mutatorContext.write("END");
    }

    @Override
    public void visit(WhenClause whenClause) {
        mutatorContext.write("WHEN ");
        whenClause.getWhenExpression().accept(this);
        mutatorContext.write(" THEN ");
        whenClause.getThenExpression().accept(this);
        mutatorContext.write(" ");
    }

    @Override
    public void visit(AllComparisonExpression allComparisonExpression) {
        mutatorContext.write("ALL ");
        allComparisonExpression.getSubSelect().accept((ExpressionVisitor) this);
    }

    @Override
    public void visit(AnyComparisonExpression anyComparisonExpression) {
        mutatorContext.write(anyComparisonExpression.getAnyType().name()).write(" ");
        anyComparisonExpression.getSubSelect().accept((ExpressionVisitor) this);
    }

    @Override
    public void visit(Concat concat) {
        visitBinaryExpression(concat, " || ");
    }

    @Override
    public void visit(Matches matches) {
        visitOldOracleJoinBinaryExpression(matches, " @@ ");
    }

    @Override
    public void visit(BitwiseAnd bitwiseAnd) {
        visitBinaryExpression(bitwiseAnd, " & ");
    }

    @Override
    public void visit(BitwiseOr bitwiseOr) {
        visitBinaryExpression(bitwiseOr, " | ");
    }

    @Override
    public void visit(BitwiseXor bitwiseXor) {
        visitBinaryExpression(bitwiseXor, " ^ ");
    }

    @Override
    public void visit(CastExpression cast) {
        if (cast.isUseCastKeyword()) {
            mutatorContext.write("CAST(");
            mutatorContext.write(cast.getLeftExpression().toString());
            mutatorContext.write(" AS ");
            mutatorContext.write(cast.getType().toString());
            mutatorContext.write(")");
        } else {
            mutatorContext.write(cast.getLeftExpression().toString());
            mutatorContext.write("::");
            mutatorContext.write(cast.getType().toString());
        }
    }

    @Override
    public void visit(Modulo modulo) {
        visitBinaryExpression(modulo, " % ");
    }

    @Override
    public void visit(AnalyticExpression aexpr) {
        String name = aexpr.getName();
        Expression expression = aexpr.getExpression();
        Expression offset = aexpr.getOffset();
        Expression defaultValue = aexpr.getDefaultValue();
        boolean isAllColumns = aexpr.isAllColumns();
        KeepExpression keep = aexpr.getKeep();
        ExpressionList partitionExpressionList = aexpr.getPartitionExpressionList();
        List<OrderByElement> orderByElements = aexpr.getOrderByElements();
        WindowElement windowElement = aexpr.getWindowElement();

        mutatorContext.write(name).write("(");
        if (aexpr.isDistinct()) {
            mutatorContext.write("DISTINCT ");
        }
        if (expression != null) {
            expression.accept(this);
            if (offset != null) {
                mutatorContext.write(", ");
                offset.accept(this);
                if (defaultValue != null) {
                    mutatorContext.write(", ");
                    defaultValue.accept(this);
                }
            }
        } else if (isAllColumns) {
            mutatorContext.write("*");
        }
        if (aexpr.isIgnoreNulls()) {
            mutatorContext.write(" IGNORE NULLS");
        }
        mutatorContext.write(") ");
        if (keep != null) {
            keep.accept(this);
            mutatorContext.write(" ");
        }

        switch (aexpr.getType()) {
            case WITHIN_GROUP:
                mutatorContext.write("WITHIN GROUP");
                break;
            default:
                mutatorContext.write("OVER");
        }
        mutatorContext.write(" (");

        if (partitionExpressionList != null && !partitionExpressionList.getExpressions().isEmpty()) {
            mutatorContext.write("PARTITION BY ");
            List<Expression> expressions = partitionExpressionList.getExpressions();
            for (int i = 0; i < expressions.size(); i++) {
                if (i > 0) {
                    mutatorContext.write(", ");
                }
                expressions.get(i).accept(this);
            }
            mutatorContext.write(" ");
        }
        if (orderByElements != null && !orderByElements.isEmpty()) {
            mutatorContext.write("ORDER BY ");

            for (int i = 0; i < orderByElements.size(); i++) {
                if (i > 0) {
                    mutatorContext.write(", ");
                }
                orderByDeParseElement(orderByElements.get(i));
            }

            if (windowElement != null) {
                mutatorContext.write(" ");
                mutatorContext.write(windowElement.toString());
            }
        }

        mutatorContext.write(")");
    }

    @Override
    public void visit(ExtractExpression eexpr) {
        mutatorContext.write("EXTRACT(").write(eexpr.getName());
        mutatorContext.write(" FROM ");
        eexpr.getExpression().accept(this);
        mutatorContext.write(")");
    }

    @Override
    public void visit(MultiExpressionList multiExprList) {
        for (Iterator<ExpressionList> it = multiExprList.getExprList().iterator(); it.hasNext();) {
            it.next().accept(this);
            if (it.hasNext()) {
                mutatorContext.write(", ");
            }
        }
    }

    @Override
    public void visit(IntervalExpression iexpr) {
        mutatorContext.write(iexpr.toString());
    }

    @Override
    public void visit(JdbcNamedParameter jdbcNamedParameter) {
        mutatorContext.write(jdbcNamedParameter.toString());
    }

    @Override
    public void visit(OracleHierarchicalExpression oexpr) {
        mutatorContext.write(oexpr.toString());
    }

    @Override
    public void visit(RegExpMatchOperator rexpr) {
        visitBinaryExpression(rexpr, " " + rexpr.getStringExpression() + " ");
    }

    @Override
    public void visit(RegExpMySQLOperator rexpr) {
        visitBinaryExpression(rexpr, " " + rexpr.getStringExpression() + " ");
    }

    @Override
    public void visit(JsonExpression jsonExpr) {
        mutatorContext.write(jsonExpr.toString());
    }

    @Override
    public void visit(JsonOperator jsonExpr) {
        visitBinaryExpression(jsonExpr, " " + jsonExpr.getStringExpression() + " ");
    }

    @Override
    public void visit(UserVariable var) {
        mutatorContext.write(var.toString());
    }

    @Override
    public void visit(NumericBind bind) {
        mutatorContext.write(bind.toString());
    }

    @Override
    public void visit(KeepExpression aexpr) {
        mutatorContext.write(aexpr.toString());
    }

    @Override
    public void visit(MySQLGroupConcat groupConcat) {
        mutatorContext.write(groupConcat.toString());
    }

    @Override
    public void visit(ValueListExpression valueList) {
        mutatorContext.write(valueList.toString());
    }

    @Override
    public void visit(RowConstructor rowConstructor) {
        if (rowConstructor.getName() != null) {
            mutatorContext.write(rowConstructor.getName());
        }
        mutatorContext.write("(");
        boolean first = true;
        for (Expression expr : rowConstructor.getExprList().getExpressions()) {
            if (first) {
                first = false;
            } else {
                mutatorContext.write(", ");
            }
            expr.accept(this);
        }
        mutatorContext.write(")");
    }

    @Override
    public void visit(OracleHint hint) {
        mutatorContext.write(hint.toString());
    }

    @Override
    public void visit(TimeKeyExpression timeKeyExpression) {
        mutatorContext.write(timeKeyExpression.toString());
    }

    @Override
    public void visit(DateTimeLiteralExpression literal) {
        mutatorContext.write(literal.toString());
    }
    
    @Override
    public void visit(PlainSelect plainSelect) {
        if (plainSelect.isUseBrackets()) {
            mutatorContext.write("(");
        }
        mutatorContext.write("SELECT ");

        OracleHint hint = plainSelect.getOracleHint();
        if (hint != null) {
            mutatorContext.write(hint.toString()).write(" ");
        }

        Skip skip = plainSelect.getSkip();
        if (skip != null) {
            mutatorContext.write(skip.toString()).write(" ");
        }

        First first = plainSelect.getFirst();
        if (first != null) {
            mutatorContext.write(first.toString()).write(" ");
        }

        if (plainSelect.getDistinct() != null) {
            if (plainSelect.getDistinct().isUseUnique()) {
                mutatorContext.write("UNIQUE ");
            } else {
                mutatorContext.write("DISTINCT ");
            }
            if (plainSelect.getDistinct().getOnSelectItems() != null) {
                mutatorContext.write("ON (");
                for (Iterator<SelectItem> iter = plainSelect.getDistinct().getOnSelectItems().
                        iterator(); iter.hasNext();) {
                    SelectItem selectItem = iter.next();
                    selectItem.accept(this);
                    if (iter.hasNext()) {
                        mutatorContext.write(", ");
                    }
                }
                mutatorContext.write(") ");
            }

        }

        Top top = plainSelect.getTop();
        if (top != null) {
            mutatorContext.write(top.toString()).write(" ");
        }

        if (plainSelect.getMySqlSqlNoCache()) {
            mutatorContext.write("SQL_NO_CACHE").write(" ");
        }

        if (plainSelect.getMySqlSqlCalcFoundRows()) {
            mutatorContext.write("SQL_CALC_FOUND_ROWS").write(" ");
        }

        for (Iterator<SelectItem> iter = plainSelect.getSelectItems().iterator(); iter.hasNext();) {
            SelectItem selectItem = iter.next();
            selectItem.accept(this);
            if (iter.hasNext()) {
                mutatorContext.write(", ");
            }
        }

        if (plainSelect.getIntoTables() != null) {
            mutatorContext.write(" INTO ");
            for (Iterator<Table> iter = plainSelect.getIntoTables().iterator(); iter.hasNext();) {
                visit(iter.next());
                if (iter.hasNext()) {
                    mutatorContext.write(", ");
                }
            }
        }

        if (plainSelect.getFromItem() != null) {
            mutatorContext.write(" FROM ");
            plainSelect.getFromItem().accept(this);
        }

        if (plainSelect.getJoins() != null) {
            for (Join join : plainSelect.getJoins()) {
                deparseJoin(join);
            }
        }

        if (plainSelect.getWhere() != null) {
            mutatorContext.write(" WHERE ");
            plainSelect.getWhere().accept(this);
        }

        if (plainSelect.getOracleHierarchical() != null) {
            plainSelect.getOracleHierarchical().accept(this);
        }

        if (plainSelect.getGroupByColumnReferences() != null) {
            mutatorContext.write(" GROUP BY ");
            for (Iterator<Expression> iter = plainSelect.getGroupByColumnReferences().iterator(); iter.
                    hasNext();) {
                Expression columnReference = iter.next();
                columnReference.accept(this);
                if (iter.hasNext()) {
                    mutatorContext.write(", ");
                }
            }
        }

        if (plainSelect.getHaving() != null) {
            mutatorContext.write(" HAVING ");
            plainSelect.getHaving().accept(this);
        }

        if (plainSelect.getOrderByElements() != null) {
            orderByDeParse(plainSelect.isOracleSiblings(), plainSelect.getOrderByElements());
        }

        if (plainSelect.getLimit() != null) {
            limitDeParse(plainSelect.getLimit());
        }
        if (plainSelect.getOffset() != null) {
            deparseOffset(plainSelect.getOffset());
        }
        if (plainSelect.getFetch() != null) {
            deparseFetch(plainSelect.getFetch());
        }
        if (plainSelect.isForUpdate()) {
            mutatorContext.write(" FOR UPDATE");
            if (plainSelect.getForUpdateTable() != null) {
                mutatorContext.write(" OF ").write(plainSelect.getForUpdateTable().toString());
            }
            if (plainSelect.getWait() != null) {
                // wait's toString will do the formatting for us
                mutatorContext.write(plainSelect.getWait().toString());
            }
        }
        if (plainSelect.isUseBrackets()) {
            mutatorContext.write(")");
        }
    }

    @Override
    public void visit(AllTableColumns allTableColumns) {
        mutatorContext.write(allTableColumns.getTable().getFullyQualifiedName()).write(".*");
    }

    @Override
    public void visit(SelectExpressionItem selectExpressionItem) {
        selectExpressionItem.getExpression().accept(this);
        if (selectExpressionItem.getAlias() != null) {
            mutatorContext.write(selectExpressionItem.getAlias().toString());
        }

    }



    @Override
    public void visit(Table tableName) {
        mutatorContext.write(tableName.getFullyQualifiedName());
        Alias alias = tableName.getAlias();
        if (alias != null) {
            mutatorContext.write(alias.toString());
        }
        Pivot pivot = tableName.getPivot();
        if (pivot != null) {
            pivot.accept(this);
        }
        MySQLIndexHint indexHint = tableName.getIndexHint();
        if (indexHint != null) {
            mutatorContext.write(indexHint.toString());
        }
    }

    @Override
    public void visit(Pivot pivot) {
        List<Column> forColumns = pivot.getForColumns();
        mutatorContext.write(" PIVOT (")
                .write(PlainSelect.getStringList(pivot.getFunctionItems()))
                .write(" FOR ")
                .write(PlainSelect.
                        getStringList(forColumns, true, forColumns != null && forColumns.size() > 1)).
                write(" IN ")
                .write(PlainSelect.getStringList(pivot.getInItems(), true, true))
                .write(")");
        if (pivot.getAlias() != null) {
            mutatorContext.write(pivot.getAlias().toString());
        }
    }

    @Override
    public void visit(PivotXml pivot) {
        List<Column> forColumns = pivot.getForColumns();
        mutatorContext.write(" PIVOT XML (");
        mutatorContext.write(PlainSelect.getStringList(pivot.getFunctionItems()));
        mutatorContext.write(" FOR ");
        mutatorContext.write(PlainSelect.
                        getStringList(forColumns, true, forColumns != null && forColumns.size() > 1));
        mutatorContext.write(" IN (");
        if (pivot.isInAny()) {
            mutatorContext.write("ANY");
        } else if (pivot.getInSelect() != null) {
            mutatorContext.write(pivot.getInSelect().toString());
        } else {
            mutatorContext.write(PlainSelect.getStringList(pivot.getInItems()));
        }
        mutatorContext.write("))");
    }

    public void deparseOffset(Offset offset) {
        // OFFSET offset
        // or OFFSET offset (ROW | ROWS)
        if (offset.getOffsetJdbcParameter() != null) {
            mutatorContext.write(" OFFSET ").write(offset.getOffsetJdbcParameter().toString());
        } else {
            mutatorContext.write(" OFFSET ");
            mutatorContext.write(String.valueOf(offset.getOffset()));
        }
        if (offset.getOffsetParam() != null) {
            mutatorContext.write(" ").write(offset.getOffsetParam());
        }

    }

    public void deparseFetch(Fetch fetch) {
        // FETCH (FIRST | NEXT) row_count (ROW | ROWS) ONLY
        mutatorContext.write(" FETCH ");
        if (fetch.isFetchParamFirst()) {
            mutatorContext.write("FIRST ");
        } else {
            mutatorContext.write("NEXT ");
        }
        if (fetch.getFetchJdbcParameter() != null) {
            mutatorContext.write(fetch.getFetchJdbcParameter().toString());
        } else {
            mutatorContext.write(String.valueOf(fetch.getRowCount()));
        }
        mutatorContext.write(" ").write(fetch.getFetchParam()).write(" ONLY");

    }


    public ExpressionVisitor getExpressionVisitor() {
        return this;
    }

    @Override
    public void visit(SubJoin subjoin) {
        mutatorContext.write("(");
        subjoin.getLeft().accept(this);
        for (Join join : subjoin.getJoinList()) {
            deparseJoin(join);
        }
        mutatorContext.write(")");

        if (subjoin.getPivot() != null) {
            subjoin.getPivot().accept(this);
        }
    }

    public void deparseJoin(Join join) {
        if (join.isSimple()) {
            mutatorContext.write(", ");
        } else {

            if (join.isRight()) {
                mutatorContext.write(" RIGHT");
            } else if (join.isNatural()) {
                mutatorContext.write(" NATURAL");
            } else if (join.isFull()) {
                mutatorContext.write(" FULL");
            } else if (join.isLeft()) {
                mutatorContext.write(" LEFT");
            } else if (join.isCross()) {
                mutatorContext.write(" CROSS");
            }

            if (join.isOuter()) {
                mutatorContext.write(" OUTER");
            } else if (join.isInner()) {
                mutatorContext.write(" INNER");
            } else if (join.isSemi()) {
                mutatorContext.write(" SEMI");
            }

            mutatorContext.write(" JOIN ");

        }

        FromItem fromItem = join.getRightItem();
        fromItem.accept(this);
        if (join.isWindowJoin()) {
            mutatorContext.write(" WITHIN ");
            mutatorContext.write(join.getJoinWindow().toString());
        }
        if (join.getOnExpression() != null) {
            mutatorContext.write(" ON ");
            join.getOnExpression().accept(this);
        }
        if (join.getUsingColumns() != null) {
            mutatorContext.write(" USING (");
            for (Iterator<Column> iterator = join.getUsingColumns().iterator(); iterator.hasNext();) {
                Column column = iterator.next();
                mutatorContext.write(column.toString());
                if (iterator.hasNext()) {
                    mutatorContext.write(", ");
                }
            }
            mutatorContext.write(")");
        }

    }

    @Override
    public void visit(SetOperationList list) {
        for (int i = 0; i < list.getSelects().size(); i++) {
            if (i != 0) {
                mutatorContext.write(" ").write(list.getOperations().get(i - 1).toString()).write(" ");
            }
            boolean brackets = list.getBrackets() == null || list.getBrackets().get(i);
            if (brackets) {
                mutatorContext.write("(");
            }
            list.getSelects().get(i).accept(this);
            if (brackets) {
                mutatorContext.write(")");
            }
        }
        if (list.getOrderByElements() != null) {
            orderByDeParse(list.getOrderByElements());
        }

        if (list.getLimit() != null) {
            //FIXME: THIS WILL MAKE THE BUFFERS OUT OF SYNC
            new LimitDeparser(mutatorContext.getCleanBuffer()).deParse(list.getLimit());
        }
        if (list.getOffset() != null) {
            deparseOffset(list.getOffset());
        }
        if (list.getFetch() != null) {
            deparseFetch(list.getFetch());
        }
    }

    @Override
    public void visit(WithItem withItem) {
        if (withItem.isRecursive()) {
            mutatorContext.write("RECURSIVE ");
        }
        mutatorContext.write(withItem.getName());
        if (withItem.getWithItemList() != null) {
            mutatorContext.write(" ").write(PlainSelect.
                    getStringList(withItem.getWithItemList(), true, true));
        }
        mutatorContext.write(" AS (");
        withItem.getSelectBody().accept(this);
        mutatorContext.write(")");
    }

    @Override
    public void visit(LateralSubSelect lateralSubSelect) {
        mutatorContext.write(lateralSubSelect.toString());
    }

    @Override
    public void visit(ValuesList valuesList) {
        mutatorContext.write(valuesList.toString());
    }

    @Override
    public void visit(AllColumns allColumns) {
        mutatorContext.write("*");
    }

    @Override
    public void visit(TableFunction tableFunction) {
        mutatorContext.write(tableFunction.toString());
    }

    @Override
    public void visit(ParenthesisFromItem parenthesis) {
        mutatorContext.write("(");
        parenthesis.getFromItem().accept(this);
        mutatorContext.write(")");
        if (parenthesis.getAlias() != null) {
            mutatorContext.write(parenthesis.getAlias().toString());
        }
    }

    @Override
    public void visit(ValuesStatement values) {
        //FIXME: THIS WILL MAKE THE BUFFERS OUT OF SYNC
        new ValuesStatementDeParser(this, mutatorContext.getCleanBuffer()).deParse(values);
    }


    public void orderByDeParse(List<OrderByElement> orderByElementList) {
        orderByDeParse(false, orderByElementList);
    }

    public void orderByDeParse(boolean oracleSiblings, List<OrderByElement> orderByElementList) {
        if (oracleSiblings) {
            mutatorContext.write(" ORDER SIBLINGS BY ");
        } else {
            mutatorContext.write(" ORDER BY ");
        }

        for (Iterator<OrderByElement> iter = orderByElementList.iterator(); iter.hasNext();) {
            OrderByElement orderByElement = iter.next();
            orderByDeParseElement(orderByElement);
            if (iter.hasNext()) {
                mutatorContext.write(", ");
            }
        }
    }

    public void orderByDeParseElement(OrderByElement orderBy) {
        orderBy.getExpression().accept(this);
        if (!orderBy.isAsc()) {
            mutatorContext.write(" DESC");
        } else if (orderBy.isAscDescPresent()) {
            mutatorContext.write(" ASC");
        }
        if (orderBy.getNullOrdering() != null) {
            mutatorContext.write(" ");
            mutatorContext.write(orderBy.getNullOrdering() == OrderByElement.NullOrdering.NULLS_FIRST ? "NULLS FIRST" : "NULLS LAST");
        }
    }


    public void limitDeParse(Limit limit) {
//        if (limit.isRowCountJdbcParameter()) {
//            mutatorContext.write(" LIMIT ");
//            mutatorContext.write("?");
//        } else if (limit.getRowCount() >= 0) {
//            mutatorContext.write(" LIMIT ");
//            mutatorContext.write(String.valueOf(limit.getRowCount()));
//        } else if (limit.isLimitNull()) {
//            mutatorContext.write(" LIMIT NULL");
//        }
//
//        if (limit.isOffsetJdbcParameter()) {
//            mutatorContext.write(" OFFSET ?");
//        } else if (limit.getOffset() != 0) {
//            mutatorContext.write(" OFFSET ").write(limit.getOffset().toString());
//        }
        mutatorContext.write(limit.toString());
    }
}

// FIXME: implement more mutations

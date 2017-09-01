/* Copyright (c) 2001-2016, The HSQL Development Group
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the HSQL Development Group nor the names of its
 * contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL HSQL DEVELOPMENT GROUP, HSQLDB.ORG,
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


package org.hsqldb;

import org.hsqldb.HsqlNameManager.HsqlName;
import org.hsqldb.HsqlNameManager.SimpleName;
import org.hsqldb.ParserDQL.CompileContext;
import org.hsqldb.RangeGroup.RangeGroupSimple;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.index.Index;
import org.hsqldb.lib.ArrayListIdentity;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.HsqlArrayList;
import org.hsqldb.lib.HsqlList;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.lib.OrderedIntHashSet;
import org.hsqldb.lib.Set;
import org.hsqldb.navigator.RowSetNavigatorData;
import org.hsqldb.persist.PersistentStore;
import org.hsqldb.result.Result;
import org.hsqldb.types.ArrayType;
import org.hsqldb.types.CharacterType;
import org.hsqldb.types.Collation;
import org.hsqldb.types.NullType;
import org.hsqldb.types.Type;
import org.hsqldb.types.Types;

/**
 * Expression class.
 *
 * @author Campbell Burnet (boucherb@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class Expression implements Cloneable {

    public static final int LEFT    = 0;
    public static final int RIGHT   = 1;
    public static final int UNARY   = 1;
    public static final int BINARY  = 2;
    public static final int TERNARY = 3;

    //
    //
    static final Expression[] emptyArray = new Expression[]{};

    //
    static final Expression EXPR_TRUE  = new ExpressionLogical(true);
    static final Expression EXPR_FALSE = new ExpressionLogical(false);

    //
    static final OrderedIntHashSet aggregateFunctionSet =
        new OrderedIntHashSet();

    static {
        aggregateFunctionSet.add(OpTypes.COUNT);
        aggregateFunctionSet.add(OpTypes.SUM);
        aggregateFunctionSet.add(OpTypes.MIN);
        aggregateFunctionSet.add(OpTypes.MAX);
        aggregateFunctionSet.add(OpTypes.AVG);
        aggregateFunctionSet.add(OpTypes.EVERY);
        aggregateFunctionSet.add(OpTypes.SOME);
        aggregateFunctionSet.add(OpTypes.STDDEV_POP);
        aggregateFunctionSet.add(OpTypes.STDDEV_SAMP);
        aggregateFunctionSet.add(OpTypes.VAR_POP);
        aggregateFunctionSet.add(OpTypes.VAR_SAMP);
        aggregateFunctionSet.add(OpTypes.GROUP_CONCAT);
        aggregateFunctionSet.add(OpTypes.ARRAY_AGG);
        aggregateFunctionSet.add(OpTypes.MEDIAN);
        aggregateFunctionSet.add(OpTypes.USER_AGGREGATE);
    }

    static final OrderedIntHashSet columnExpressionSet =
        new OrderedIntHashSet();

    static {
        columnExpressionSet.add(OpTypes.COLUMN);
    }

    static final OrderedIntHashSet subqueryExpressionSet =
        new OrderedIntHashSet();

    static {
        subqueryExpressionSet.add(OpTypes.ROW_SUBQUERY);
        subqueryExpressionSet.add(OpTypes.TABLE_SUBQUERY);
    }

    static final OrderedIntHashSet subqueryAggregateExpressionSet =
        new OrderedIntHashSet();

    static {
        subqueryAggregateExpressionSet.add(OpTypes.COUNT);
        subqueryAggregateExpressionSet.add(OpTypes.SUM);
        subqueryAggregateExpressionSet.add(OpTypes.MIN);
        subqueryAggregateExpressionSet.add(OpTypes.MAX);
        subqueryAggregateExpressionSet.add(OpTypes.AVG);
        subqueryAggregateExpressionSet.add(OpTypes.EVERY);
        subqueryAggregateExpressionSet.add(OpTypes.SOME);
        subqueryAggregateExpressionSet.add(OpTypes.STDDEV_POP);
        subqueryAggregateExpressionSet.add(OpTypes.STDDEV_SAMP);
        subqueryAggregateExpressionSet.add(OpTypes.VAR_POP);
        subqueryAggregateExpressionSet.add(OpTypes.VAR_SAMP);
        subqueryAggregateExpressionSet.add(OpTypes.GROUP_CONCAT);
        subqueryAggregateExpressionSet.add(OpTypes.ARRAY_AGG);
        subqueryAggregateExpressionSet.add(OpTypes.MEDIAN);
        subqueryAggregateExpressionSet.add(OpTypes.USER_AGGREGATE);

        //
        subqueryAggregateExpressionSet.add(OpTypes.TABLE_SUBQUERY);
        subqueryAggregateExpressionSet.add(OpTypes.ROW_SUBQUERY);
    }

    static final OrderedIntHashSet functionExpressionSet =
        new OrderedIntHashSet();

    static {
        functionExpressionSet.add(OpTypes.SQL_FUNCTION);
        functionExpressionSet.add(OpTypes.FUNCTION);
    }

    static final OrderedIntHashSet sequenceExpressionSet =
        new OrderedIntHashSet();

    static {
        sequenceExpressionSet.add(OpTypes.ROWNUM);
        sequenceExpressionSet.add(OpTypes.SEQUENCE);
    }

    static final OrderedIntHashSet emptyExpressionSet =
        new OrderedIntHashSet();

    // type
    protected int opType;

    // type qualifier
    protected int exprSubType;

    //
    SimpleName alias;

    // aggregate
    private boolean isAggregate;
    boolean         isDistinctAggregate;

    // VALUE
    protected Object       valueData;
    protected Expression[] nodes;
    Type[]                 nodeDataTypes;
    TableDerived           table;

    // for query and value lists, etc
    boolean isCorrelated;

    // for COLUMN
    int columnIndex = -1;

    // data type
    protected Type dataType;
    
    //TUD_JC for left/right joins
    public boolean invertDistance = false;

    //
    int queryTableColumnIndex = -1;    // >= 0 when it is used for order by

    // index of a session-dependent field
    int parameterIndex = -1;

    //
    int rangePosition = -1;

    //
    boolean isColumnCondition;
    boolean isColumnEqual;
    boolean isSingleColumnCondition;
    boolean isSingleColumnEqual;
    boolean isSingleColumnNull;
    boolean isSingleColumnNotNull;
    byte    nullability = SchemaObject.Nullability.NULLABLE_UNKNOWN;

    //
    Collation    collation;
    RangeGroup[] rangeGroups;
    RangeGroup   rangeGroup;

    Expression(int type) {
        opType = type;
        nodes  = emptyArray;
    }

    // IN condition optimisation

    /**
     * Creates a SUBQUERY expression.
     */
    Expression(int type, TableDerived table) {

        switch (type) {

            case OpTypes.ARRAY :
                opType = OpTypes.ARRAY;
                break;

            case OpTypes.ARRAY_SUBQUERY :
                opType = OpTypes.ARRAY_SUBQUERY;
                break;

            case OpTypes.TABLE_SUBQUERY :
                opType = OpTypes.TABLE_SUBQUERY;
                break;

            case OpTypes.ROW_SUBQUERY :
            case OpTypes.SCALAR_SUBQUERY :
                opType = OpTypes.ROW_SUBQUERY;
                break;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
        }

        nodes      = emptyArray;
        this.table = table;
    }

    /**
     * ROW, ARRAY etc.
     */
    Expression(int type, Expression[] list) {

        this(type);

        this.nodes = list;
    }

    static String getContextSQL(Expression expression) {

        if (expression == null) {
            return null;
        }

        String ddl = expression.getSQL();
        //System.out.println(ddl);
        switch (expression.opType) {

            case OpTypes.VALUE :
            case OpTypes.COLUMN :
            case OpTypes.ROW :
            case OpTypes.FUNCTION :
            case OpTypes.SQL_FUNCTION :
            case OpTypes.ALTERNATIVE :
            case OpTypes.CASEWHEN :
            case OpTypes.CAST :
                return ddl;
        }

        StringBuffer sb = new StringBuffer();

        ddl = sb.append('(').append(ddl).append(')').toString();

        return ddl;
    }

    /**
     * For use with CHECK constraints. Under development.
     *
     * Currently supports a subset of expressions and is suitable for CHECK
     * search conditions that refer only to the inserted/updated row.
     *
     * For full DDL reporting of VIEW select queries and CHECK search
     * conditions, future improvements here are dependent upon improvements to
     * SELECT query parsing, so that it is performed in a number of passes.
     * An early pass should result in the query turned into an Expression tree
     * that contains the information in the original SQL without any
     * alterations, and with tables and columns all resolved. This Expression
     * can then be preserved for future use. Table and column names that
     * are not user-defined aliases should be kept as the HsqlName structures
     * so that table or column renaming is reflected in the precompiled
     * query.
     */
    public String getSQL() {

        StringBuffer sb = new StringBuffer(64);

        switch (opType) {

            case OpTypes.VALUE :
                if (valueData == null) {
                    return Tokens.T_NULL;
                }

                return dataType.convertToSQLString(valueData);

            case OpTypes.ROW :
                sb.append('(');

                for (int i = 0; i < nodes.length; i++) {
                    if (i > 0) {
                        sb.append(',');
                    }

                    sb.append(nodes[i].getSQL());
                }

                sb.append(')');

                return sb.toString();

            //
            case OpTypes.VALUELIST :
                for (int i = 0; i < nodes.length; i++) {
                    if (i > 0) {
                        sb.append(',');
                    }

                    sb.append(nodes[i].getSQL());
                }

                return sb.toString();
        }

        switch (opType) {

            case OpTypes.ARRAY :
                sb.append(Tokens.T_ARRAY).append('[');

                for (int i = 0; i < nodes.length; i++) {
                    if (i > 0) {
                        sb.append(',');
                    }

                    sb.append(nodes[i].getSQL());
                }

                sb.append(']');
                break;

            case OpTypes.ARRAY_SUBQUERY :

            //
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY :
                sb.append('(');
                sb.append(table.sql);
                sb.append(')');
                break;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
        }

        return sb.toString();
    }

    protected String describe(Session session, int blanks) {

        StringBuffer sb = new StringBuffer(64);

        sb.append('\n');

        for (int i = 0; i < blanks; i++) {
            sb.append(' ');
        }

        switch (opType) {

            case OpTypes.VALUE :
                sb.append("VALUE = ").append(
                    dataType.convertToSQLString(valueData));
                sb.append(", TYPE = ").append(dataType.getNameString());

                return sb.toString();

            case OpTypes.ARRAY :
                sb.append("ARRAY ");

                return sb.toString();

            case OpTypes.ARRAY_SUBQUERY :
                sb.append("ARRAY SUBQUERY");

                return sb.toString();

            //
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY :
                sb.append("QUERY ");
                sb.append(table.queryExpression.describe(session, blanks));

                return sb.toString();

            case OpTypes.ROW :
                sb.append("ROW = ");

                for (int i = 0; i < nodes.length; i++) {
                    sb.append(nodes[i].describe(session, blanks + 1));
                    sb.append(' ');
                }
                break;

            case OpTypes.VALUELIST :
                sb.append("VALUELIST ");

                for (int i = 0; i < nodes.length; i++) {
                    sb.append(nodes[i].describe(session, blanks + 1));
                    sb.append(' ');
                }
                break;
        }

        return sb.toString();
    }

    /**
     * Set the data type
     */
    void setDataType(Session session, Type type) {

        if (opType == OpTypes.VALUE) {
            valueData = type.convertToType(session, valueData, dataType);
        }

        dataType = type;
    }

    /**
     * SIMPLE_COLUMN expressions can be of different Expression subclass types
     */
    public boolean equals(Expression other) {

        if (other == this) {
            return true;
        }

        if (other == null) {
            return false;
        }

        if (opType != other.opType || exprSubType != other.exprSubType
                || !equals(dataType, other.dataType)) {
            return false;
        }

        switch (opType) {

            case OpTypes.SIMPLE_COLUMN :
                return this.columnIndex == other.columnIndex;

            case OpTypes.VALUE :
                return equals(valueData, other.valueData);

            case OpTypes.ARRAY :

            //
            case OpTypes.ARRAY_SUBQUERY :
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY :
                return table.queryExpression.isEquivalent(
                    other.table.queryExpression);

            default :
                return equals(nodes, other.nodes);
        }
    }

    public boolean equals(Object other) {

        if (other == this) {
            return true;
        }

        if (other instanceof Expression) {
            return equals((Expression) other);
        }

        return false;
    }

    public int hashCode() {

        int val = opType + exprSubType;

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                val += nodes[i].hashCode();
            }
        }

        return val;
    }

    static boolean equals(Object o1, Object o2) {

        if (o1 == o2) {
            return true;
        }

        return (o1 == null) ? false
                            : o1.equals(o2);
    }

    static boolean equals(Expression[] row1, Expression[] row2) {

        if (row1 == row2) {
            return true;
        }

        if (row1.length != row2.length) {
            return false;
        }

        int len = row1.length;

        for (int i = 0; i < len; i++) {
            Expression e1     = row1[i];
            Expression e2     = row2[i];
            boolean    equals = (e1 == null) ? e2 == null
                                             : e1.equals(e2);

            if (!equals) {
                return false;
            }
        }

        return true;
    }

    /**
     * For GROUP only.
     */
    boolean isComposedOf(Expression[] exprList, int start, int end,
                         OrderedIntHashSet excludeSet) {

        switch (opType) {

            case OpTypes.VALUE :
            case OpTypes.DYNAMIC_PARAM :
            case OpTypes.PARAMETER :
            case OpTypes.VARIABLE : {
                return true;
            }
        }

        if (excludeSet.contains(opType)) {
            return true;
        }

        for (int i = start; i < end; i++) {
            if (equals(exprList[i])) {
                return true;
            }
        }

        switch (opType) {

            case OpTypes.LIKE :
            case OpTypes.MATCH_SIMPLE :
            case OpTypes.MATCH_PARTIAL :
            case OpTypes.MATCH_FULL :
            case OpTypes.MATCH_UNIQUE_SIMPLE :
            case OpTypes.MATCH_UNIQUE_PARTIAL :
            case OpTypes.MATCH_UNIQUE_FULL :
            case OpTypes.UNIQUE :
            case OpTypes.EXISTS :
            case OpTypes.ARRAY :
            case OpTypes.ARRAY_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY :

            //
            case OpTypes.COUNT :
            case OpTypes.SUM :
            case OpTypes.MIN :
            case OpTypes.MAX :
            case OpTypes.AVG :
            case OpTypes.EVERY :
            case OpTypes.SOME :
            case OpTypes.STDDEV_POP :
            case OpTypes.STDDEV_SAMP :
            case OpTypes.VAR_POP :
            case OpTypes.VAR_SAMP :
                return false;

            case OpTypes.ROW_SUBQUERY : {
                if (table == null) {
                    break;
                }

                if (!(table.getQueryExpression()
                        instanceof QuerySpecification)) {
                    return false;
                }

                QuerySpecification qs =
                    (QuerySpecification) table.getQueryExpression();
                OrderedHashSet set = new OrderedHashSet();

                for (int i = start; i < end; i++) {
                    if (exprList[i].opType == OpTypes.COLUMN) {
                        set.add(exprList[i]);
                    }
                }

                return qs.collectOuterColumnExpressions(null, set) == null;
            }
        }

        if (nodes.length == 0) {
            return false;
        }

        boolean result = true;

        for (int i = 0; i < nodes.length; i++) {
            result &= (nodes[i] == null
                       || nodes[i].isComposedOf(exprList, start, end,
                                                excludeSet));
        }

        return result;
    }

    /**
     * For HAVING only.
     */
    boolean isComposedOf(OrderedHashSet expressions, RangeGroup[] rangeGroups,
                         OrderedIntHashSet excludeSet) {

        if (opType == OpTypes.VALUE || opType == OpTypes.DYNAMIC_PARAM
                || opType == OpTypes.PARAMETER || opType == OpTypes.VARIABLE) {
            return true;
        }

        if (excludeSet.contains(opType)) {
            return true;
        }

        for (int i = 0; i < expressions.size(); i++) {
            if (equals(expressions.get(i))) {
                return true;
            }
        }

        if (opType == OpTypes.COLUMN) {
            for (int i = 0; i < rangeGroups.length; i++) {
                RangeVariable[] ranges = rangeGroups[i].getRangeVariables();

                for (int j = 0; j < ranges.length; j++) {
                    if (ranges[j] == getRangeVariable()) {
                        return true;
                    }
                }
            }
        }

        switch (opType) {

            case OpTypes.COUNT :
            case OpTypes.SUM :
            case OpTypes.MIN :
            case OpTypes.MAX :
            case OpTypes.AVG :
            case OpTypes.EVERY :
            case OpTypes.SOME :
            case OpTypes.STDDEV_POP :
            case OpTypes.STDDEV_SAMP :
            case OpTypes.VAR_POP :
            case OpTypes.VAR_SAMP :
                return false;

            case OpTypes.FUNCTION :
            case OpTypes.SQL_FUNCTION :
                if (nodes.length == 0) {
                    return true;
                }
        }

/*
        case OpCodes.LIKE :
        case OpCodes.ALL :
        case OpCodes.ANY :
        case OpCodes.IN :
        case OpCodes.MATCH_SIMPLE :
        case OpCodes.MATCH_PARTIAL :
        case OpCodes.MATCH_FULL :
        case OpCodes.MATCH_UNIQUE_SIMPLE :
        case OpCodes.MATCH_UNIQUE_PARTIAL :
        case OpCodes.MATCH_UNIQUE_FULL :
        case OpCodes.UNIQUE :
        case OpCodes.EXISTS :
        case OpCodes.TABLE_SUBQUERY :
        case OpCodes.ROW_SUBQUERY :
*/
        if (nodes.length == 0) {
            return false;
        }

        boolean result = true;

        for (int i = 0; i < nodes.length; i++) {
            result &= (nodes[i] == null
                       || nodes[i].isComposedOf(expressions, rangeGroups,
                                                excludeSet));
        }

        return result;
    }

    Expression replaceColumnReferences(RangeVariable range,
                                       Expression[] list) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            nodes[i] = nodes[i].replaceColumnReferences(range, list);
        }

        if (table != null && table.queryExpression != null) {
            table.queryExpression.replaceColumnReferences(range, list);
        }

        return this;
    }

    void replaceRangeVariables(RangeVariable[] ranges,
                               RangeVariable[] newRanges) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            nodes[i].replaceRangeVariables(ranges, newRanges);
        }

        if (table != null && table.queryExpression != null) {
            table.queryExpression.replaceRangeVariables(ranges, newRanges);
        }
    }

    void resetColumnReferences() {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            nodes[i].resetColumnReferences();
        }
    }

    void convertToSimpleColumn(OrderedHashSet expressions,
                               OrderedHashSet replacements) {

        if (opType == OpTypes.VALUE) {
            return;
        }

        if (opType == OpTypes.SIMPLE_COLUMN) {
            return;
        }

        int index = expressions.getIndex(this);

        if (index != -1) {
            Expression e = (Expression) replacements.get(index);

            nodes         = emptyArray;
            opType        = OpTypes.SIMPLE_COLUMN;
            columnIndex   = e.columnIndex;
            rangePosition = e.rangePosition;

            return;
        }

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            nodes[i].convertToSimpleColumn(expressions, replacements);
        }

        if (table != null) {
            if (table.queryExpression != null) {
                OrderedHashSet set = new OrderedHashSet();

                table.queryExpression.collectAllExpressions(set,
                        Expression.columnExpressionSet,
                        Expression.emptyExpressionSet);

                for (int i = 0; i < set.size(); i++) {
                    Expression e = (Expression) set.get(i);

                    e.convertToSimpleColumn(expressions, replacements);
                }
            }
        }
    }

    boolean isAggregate() {
        return isAggregate;
    }

    boolean isDistinctAggregate() {
        return isDistinctAggregate;
    }

    void setAggregate() {
        isAggregate = true;
    }

    boolean isSelfAggregate() {
        return false;
    }

    /**
     * Set the column alias
     */
    void setAlias(SimpleName name) {
        alias = name;
    }

    /**
     * Get the column alias
     */
    String getAlias() {

        if (alias != null) {
            return alias.name;
        }

        return "";
    }

    SimpleName getSimpleName() {
        return alias;
    }

    /**
     * Returns the type of expression
     */
    public int getType() {
        return opType;
    }

    /**
     * Returns the left node
     */ //TUD_JC: Made public for Instrumenter
    public Expression getLeftNode() {
        return nodes.length > 0 ? nodes[LEFT]
                                : null;
    }

    /**
     * Returns the right node
     */ //TUD_JC: Made public for Instrumenter
    public Expression getRightNode() {
        return nodes.length > 1 ? nodes[RIGHT]
                                : null;
    }

    void setLeftNode(Expression e) {
        nodes[LEFT] = e;
    }

    void setRightNode(Expression e) {
        nodes[RIGHT] = e;
    }

    int getSubType() {
        return exprSubType;
    }

    void setSubType(int subType) {
        exprSubType = subType;
    }

    /**
     * Returns the range variable for a COLUMN expression
     */
    RangeVariable getRangeVariable() {
        return null;
    }

    /**
     * return the expression for an alias used in an ORDER BY clause
     */
    Expression replaceAliasInOrderBy(Session session, Expression[] columns,
                                     int length) {

        if (isSelfAggregate()) {
            return this;
        }

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            nodes[i] = nodes[i].replaceAliasInOrderBy(session, columns,
                    length);
        }

        return this;
    }

    /**
     * collects all range variables in expression tree
     */
    OrderedHashSet collectRangeVariables(OrderedHashSet set) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                set = nodes[i].collectRangeVariables(set);
            }
        }

        if (table != null && table.queryExpression != null) {
            set = table.queryExpression.collectRangeVariables(set);
        }

        return set;
    }

    OrderedHashSet collectRangeVariables(RangeVariable[] rangeVariables,
                                         OrderedHashSet set) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                set = nodes[i].collectRangeVariables(rangeVariables, set);
            }
        }

        if (table != null && table.queryExpression != null) {
            set = table.queryExpression.collectRangeVariables(rangeVariables,
                    set);
        }

        return set;
    }

    /**
     * collects all schema objects
     */
    void collectObjectNames(Set set) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                nodes[i].collectObjectNames(set);
            }
        }

        if (table != null) {
            if (table.queryExpression != null) {
                table.queryExpression.collectObjectNames(set);
            }
        }
    }

    /**
     * return true if given RangeVariable is used in expression tree
     */
    boolean hasReference(RangeVariable range) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                if (nodes[i].hasReference(range)) {
                    return true;
                }
            }
        }

        if (table != null && table.queryExpression != null) {
            if (table.queryExpression.hasReference(range)) {
                return true;
            }
        }

        return false;
    }

    /**
     * return true if given RangeVariable is used in expression tree
     */
    boolean hasReference(RangeVariable[] ranges, int exclude) {

        OrderedHashSet set = collectRangeVariables(ranges, null);

        if (set == null) {
            return false;
        }

        for (int j = 0; j < set.size(); j++) {
            if (set.get(j) != ranges[exclude]) {
                return true;
            }
        }

        return false;
    }

    /**
     * resolve tables and collect unresolved column expressions
     */
    public HsqlList resolveColumnReferences(Session session,
            RangeGroup rangeGroup, RangeGroup[] rangeGroups,
            HsqlList unresolvedSet) {

        return resolveColumnReferences(session, rangeGroup,
                                       rangeGroup.getRangeVariables().length,
                                       rangeGroups, unresolvedSet, true);
    }

    public HsqlList resolveColumnReferences(Session session,
            RangeGroup rangeGroup, int rangeCount, RangeGroup[] rangeGroups,
            HsqlList unresolvedSet, boolean acceptsSequences) {

        if (opType == OpTypes.VALUE) {
            return unresolvedSet;
        }

        switch (opType) {

            case OpTypes.TABLE :
            case OpTypes.VALUELIST : {
                if (table != null) {
                    if (rangeGroup.getRangeVariables().length > rangeCount) {
                        RangeVariable[] rangeVars =
                            (RangeVariable[]) ArrayUtil.resizeArray(
                                rangeGroup.getRangeVariables(), rangeCount);

                        rangeGroup = new RangeGroupSimple(rangeVars,
                                                          rangeGroup);
                    }

                    rangeGroups =
                        (RangeGroup[]) ArrayUtil.toAdjustedArray(rangeGroups,
                            rangeGroup, rangeGroups.length, 1);
                    rangeGroup = new RangeGroupSimple(table);
                    rangeCount = 0;
                }

                for (int i = 0; i < nodes.length; i++) {
                    if (nodes[i] == null) {
                        continue;
                    }

                    unresolvedSet = nodes[i].resolveColumnReferences(session,
                            rangeGroup, rangeCount, rangeGroups,
                            unresolvedSet, acceptsSequences);
                }

                return unresolvedSet;
            }
        }

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            unresolvedSet = nodes[i].resolveColumnReferences(session,
                    rangeGroup, rangeCount, rangeGroups, unresolvedSet,
                    acceptsSequences);
        }

        switch (opType) {

            case OpTypes.ARRAY :
                break;

            case OpTypes.ARRAY_SUBQUERY :
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY : {
                RangeVariable[] rangeVars = rangeGroup.getRangeVariables();

                if (rangeVars.length > rangeCount) {
                    rangeVars =
                        (RangeVariable[]) ArrayUtil.resizeArray(rangeVars,
                            rangeCount);
                    rangeGroup = new RangeGroupSimple(rangeVars, rangeGroup);
                }

                rangeGroups =
                    (RangeGroup[]) ArrayUtil.toAdjustedArray(rangeGroups,
                        rangeGroup, rangeGroups.length, 1);

                QueryExpression queryExpression = table.queryExpression;

                if (queryExpression != null) {
                    queryExpression.resolveReferences(session, rangeGroups);

                    if (!queryExpression.areColumnsResolved()) {
                        if (unresolvedSet == null) {
                            unresolvedSet = new ArrayListIdentity();
                        }

                        unresolvedSet.addAll(
                            queryExpression.getUnresolvedExpressions());
                    }
                }

                Expression dataExpression = table.dataExpression;

                if (dataExpression != null) {
                    unresolvedSet =
                        dataExpression.resolveColumnReferences(session,
                            rangeGroup, rangeCount, rangeGroups,
                            unresolvedSet, acceptsSequences);
                }

                break;
            }
            default :
        }

        return unresolvedSet;
    }

    public void setCorrelatedReferences(RangeGroup resolvedRangeGroup) {

        if (rangeGroups == null) {
            for (int i = 0; i < nodes.length; i++) {
                if (nodes[i] != null) {
                    nodes[i].setCorrelatedReferences(resolvedRangeGroup);
                }
            }
        } else if (ArrayUtil.find(rangeGroups, resolvedRangeGroup) > -1) {
            for (int idx = rangeGroups.length - 1; idx >= 0; idx--) {
                if (rangeGroups[idx] == resolvedRangeGroup) {
                    break;
                }

                rangeGroups[idx].setCorrelated();
            }

            rangeGroup.setCorrelated();
        }
    }

    public OrderedHashSet getUnkeyedColumns(OrderedHashSet unresolvedSet) {

        if (opType == OpTypes.VALUE) {
            return unresolvedSet;
        }

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            unresolvedSet = nodes[i].getUnkeyedColumns(unresolvedSet);
        }

        switch (opType) {

            case OpTypes.ARRAY :
            case OpTypes.ARRAY_SUBQUERY :
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY :
                if (table != null) {
                    if (unresolvedSet == null) {
                        unresolvedSet = new OrderedHashSet();
                    }

                    unresolvedSet.add(this);
                }
                break;

            default :
        }

        return unresolvedSet;
    }

    public void resolveTypes(Session session, Expression parent) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                nodes[i].resolveTypes(session, this);
            }
        }

        switch (opType) {

            case OpTypes.VALUE :
                break;

            case OpTypes.VALUELIST :

                /** @todo - should it fall through */
                break;

            case OpTypes.ROW :
                nodeDataTypes = new Type[nodes.length];

                for (int i = 0; i < nodes.length; i++) {
                    if (nodes[i] != null) {
                        nodeDataTypes[i] = nodes[i].dataType;
                    }
                }
                break;

            case OpTypes.ARRAY : {
                Type nodeDataType = null;

                for (int i = 0; i < nodes.length; i++) {
                    nodeDataType = Type.getAggregateType(nodeDataType,
                                                         nodes[i].dataType);
                }

                for (int i = 0; i < nodes.length; i++) {
                    nodes[i].dataType = nodeDataType;
                }

                if (nodeDataType != null) {
                    for (int i = 0; i < nodes.length; i++) {
                        if (nodes[i].valueData != null) {
                            nodes[i].valueData =
                                nodeDataType.convertToDefaultType(
                                    session, nodes[i].valueData);
                        }
                    }
                }

                dataType = new ArrayType(nodeDataType, nodes.length);

                return;
            }
            case OpTypes.ARRAY_SUBQUERY : {
                QueryExpression queryExpression = table.queryExpression;

                queryExpression.resolveTypes(session);
                table.prepareTable(session);

                nodeDataTypes = queryExpression.getColumnTypes();
                dataType      = nodeDataTypes[0];

                if (nodeDataTypes.length > 1) {
                    throw Error.error(ErrorCode.X_42564);
                }

                dataType = new ArrayType(dataType, Integer.MAX_VALUE);

                break;
            }
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY : {
                QueryExpression queryExpression = table.queryExpression;

                if (queryExpression != null) {
                    queryExpression.resolveTypes(session);
                }

                Expression dataExpression = table.dataExpression;

                if (dataExpression != null) {
                    dataExpression.resolveTypes(session, null);
                }

                table.prepareTable(session);

                nodeDataTypes = table.getColumnTypes();
                dataType      = nodeDataTypes[0];

                break;
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
        }
    }

    void setAsConstantValue(Session session, Expression parent) {

        valueData = getValue(session);
        opType    = OpTypes.VALUE;
        nodes     = emptyArray;
    }

    void setAsConstantValue(Object value, Expression parent) {

        valueData = value;
        opType    = OpTypes.VALUE;
        nodes     = emptyArray;
    }

    void prepareTable(Session session, Expression row, int degree) {

        if (nodeDataTypes != null) {
            return;
        }

        for (int i = 0; i < nodes.length; i++) {
            Expression e = nodes[i];

            if (e.opType == OpTypes.ROW) {
                if (degree != e.nodes.length) {
                    throw Error.error(ErrorCode.X_42564);
                }
            } else if (degree == 1) {
                nodes[i]       = new Expression(OpTypes.ROW);
                nodes[i].nodes = new Expression[]{ e };
            } else {
                throw Error.error(ErrorCode.X_42564);
            }
        }

        nodeDataTypes = new Type[degree];

        for (int j = 0; j < degree; j++) {
            Type    type                  = row == null ? null
                                                        : row.nodes[j]
                                                            .dataType;
            boolean hasUresolvedParameter = row == null ? false
                                                        : row.nodes[j]
                                                            .isUnresolvedParam();

            for (int i = 0; i < nodes.length; i++) {
                type = Type.getAggregateType(nodes[i].nodes[j].dataType, type);
                hasUresolvedParameter |= nodes[i].nodes[j].isUnresolvedParam();
            }

            if (type == null) {
                type = Type.SQL_VARCHAR_DEFAULT;
            }

            int typeCode = type.typeCode;

            if (hasUresolvedParameter && type.isCharacterType()) {
                if (typeCode == Types.SQL_CHAR
                        || type.precision
                           < Type.SQL_VARCHAR_DEFAULT.precision) {
                    if (typeCode == Types.SQL_CHAR) {
                        typeCode = Types.SQL_VARCHAR;
                    }

                    long precision =
                        Math.max(Type.SQL_VARCHAR_DEFAULT.precision,
                                 type.precision);

                    type = CharacterType.getCharacterType(typeCode, precision,
                                                          type.getCollation());
                }
            }

            nodeDataTypes[j] = type;

            if (row != null && row.nodes[j].isUnresolvedParam()) {
                row.nodes[j].dataType = type;
            }

            for (int i = 0; i < nodes.length; i++) {
                if (nodes[i].nodes[j].isUnresolvedParam()) {
                    nodes[i].nodes[j].dataType = nodeDataTypes[j];

                    continue;
                }

                if (nodes[i].nodes[j].opType == OpTypes.VALUE) {
                    if (nodes[i].nodes[j].valueData == null) {
                        nodes[i].nodes[j].dataType = nodeDataTypes[j];
                    }
                }
            }
        }
    }

    /**
     * Details of IN condition optimisation for 1.9.0
     * Predicates with SELECT are QUERY expressions
     *
     * Predicates with IN list
     *
     * Parser adds a SubQuery to the list for each predicate
     * At type resolution IN lists that are entirely fixed constant or parameter
     * values are selected for possible optimisation. The flags:
     *
     * IN expression right side isCorrelated == true if there are non-constant,
     * non-param expressions in the list (Expressions may have to be resolved
     * against the full set of columns of the query, so must be re-evaluated
     * for each row and evaluated after all the joins have been made)
     *
     * VALUELIST expression isFixedConstantValueList == true when all
     * expressions are fixed constant and none is a param. With this flag,
     * a single-column VALUELIST can be accessed as a HashMap.
     *
     * Predicates may be optimised as joins if isCorrelated == false
     *
     */
    void insertValuesIntoSubqueryTable(Session session,
                                       PersistentStore store) {

        for (int i = 0; i < nodes.length; i++) {
            Object[] values = nodes[i].getRowValue(session);
            Object[] data   = store.getTable().getEmptyRowData();

            for (int j = 0; j < nodeDataTypes.length; j++) {
                data[j] = nodeDataTypes[j].convertToType(session, values[j],
                        nodes[i].nodes[j].dataType);
            }

            Row row = (Row) store.getNewCachedObject(session, data, false);

            try {
                store.indexRow(session, row);
            } catch (HsqlException e) {}
        }
    }

    /**
     * Returns the name of a column as string
     *
     * @return column name
     */
    String getColumnName() {
        return getAlias();
    }

    public ColumnSchema getColumn() {
        return null;
    }

    /**
     * Returns the column index in the table
     */
    int getColumnIndex() {
        return columnIndex;
    }

    /**
     * Returns the data type
     */
    Type getDataType() {
        return dataType;
    }

    byte getNullability() {
        return nullability;
    }

    Type getNodeDataType(int i) {

        if (nodeDataTypes == null) {
            if (i > 0) {
                throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
            }

            return dataType;
        } else {
            return nodeDataTypes[i];
        }
    }

    Type[] getNodeDataTypes() {

        if (nodeDataTypes == null) {
            return new Type[]{ dataType };
        } else {
            return nodeDataTypes;
        }
    }

    int getDegree() {

        switch (opType) {

            case OpTypes.ROW :
                return nodes.length;

            case OpTypes.TABLE :
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY :
                if (table == null) {
                    return nodeDataTypes.length;
                }

                return table.queryExpression.getColumnCount();

            default :
                return 1;
        }
    }

    public Table getTable() {
        return table;
    }

    public void materialise(Session session) {

        if (table == null) {
            return;
        }

        if (table.isCorrelated()) {
            table.materialiseCorrelated(session);
        } else {
            table.materialise(session);
        }
    }

    Object getValue(Session session, Type type) {

        Object o = getValue(session);

        if (o == null || dataType == type) {
            return o;
        }

        return type.convertToType(session, o, dataType);
    }

    public Object getConstantValueNoCheck(Session session) {

        try {
            return getValue(session);
        } catch (HsqlException e) {
            return null;
        }
    }

    public Object[] getRowValue(Session session) {

        switch (opType) {

            case OpTypes.ROW : {
                Object[] data = new Object[nodes.length];

                for (int i = 0; i < nodes.length; i++) {
                    data[i] = nodes[i].getValue(session);
                }

                return data;
            }
            case OpTypes.ROW_SUBQUERY :
            case OpTypes.TABLE_SUBQUERY : {
                return table.queryExpression.getValues(session);
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
        }
    }

    public Object getValue(Session session) {
        switch (opType) {

            case OpTypes.VALUE :
                return valueData;

            case OpTypes.SIMPLE_COLUMN : {
                Object value =
                    session.sessionContext.rangeIterators[rangePosition]
                        .getCurrent(columnIndex);

                return value;
            }
            case OpTypes.ROW : {
                if (nodes.length == 1) {
                    return nodes[0].getValue(session);
                }

                Object[] row = new Object[nodes.length];

                for (int i = 0; i < nodes.length; i++) {
                    row[i] = nodes[i].getValue(session);
                }

                return row;
            }
            case OpTypes.ARRAY : {
                Object[] array = new Object[nodes.length];

                for (int i = 0; i < nodes.length; i++) {
                    array[i] = nodes[i].getValue(session);
                }

                return array;
            }
            case OpTypes.ARRAY_SUBQUERY : {
                table.materialiseCorrelated(session);

                RowSetNavigatorData nav   = table.getNavigator(session);
                int                 size  = nav.getSize();
                Object[]            array = new Object[size];

                nav.beforeFirst();

                for (int i = 0; nav.hasNext(); i++) {
                    Object[] data = nav.getNextRowData();

                    array[i] = data[0];
                }

                return array;
            }
            case OpTypes.TABLE_SUBQUERY :
            case OpTypes.ROW_SUBQUERY : {
            	genetic.Instrumenter.enterSubLevel();
            	
                table.materialiseCorrelated(session);
                
                genetic.Instrumenter.exitSubLevel();

                Object[] value = table.getValues(session);

                if (value.length == 1) {
                    return value[0];
                }

                return value;
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
        }
    }

    public Result getResult(Session session) {

        switch (opType) {

            case OpTypes.ARRAY : {
                RowSetNavigatorData navigator = table.getNavigator(session);
                Object[]            array = new Object[navigator.getSize()];

                navigator.beforeFirst();

                for (int i = 0; navigator.hasNext(); i++) {
                    Object[] data = navigator.getNext();

                    array[i] = data[0];
                }

                return Result.newPSMResult(array);
            }
            case OpTypes.TABLE_SUBQUERY : {
                table.materialiseCorrelated(session);

                RowSetNavigatorData navigator = table.getNavigator(session);
                Result              result    = Result.newResult(navigator);

                result.metaData = table.queryExpression.getMetaData();

                return result;
            }
            default : {
                Object value = getValue(session);

                return Result.newPSMResult(value);
            }
        }
    }

    public boolean testCondition(Session session) {
        return Boolean.TRUE.equals(getValue(session));
    }

    static int countNulls(Object[] a) {

        int nulls = 0;

        for (int i = 0; i < a.length; i++) {
            if (a[i] == null) {
                nulls++;
            }
        }

        return nulls;
    }

    public boolean isTrue() {
        return opType == OpTypes.VALUE && valueData instanceof Boolean
               && ((Boolean) valueData).booleanValue();
    }

    public boolean isFalse() {
        return opType == OpTypes.VALUE && valueData instanceof Boolean
               && !((Boolean) valueData).booleanValue();
    }

    public boolean isIndexable(RangeVariable range) {
        return false;
    }

    static void convertToType(Session session, Object[] data, Type[] dataType,
                              Type[] newType) {

        for (int i = 0; i < data.length; i++) {
            if (!dataType[i].canConvertFrom(newType[i])) {
                data[i] = newType[i].convertToType(session, data[i],
                                                   dataType[i]);
            }
        }
    }

    /**
     * Returns a Select object that can be used for checking the contents
     * of an existing table against the given CHECK search condition.
     */
    static QuerySpecification getCheckSelect(Session session, Table t,
            Expression e) {

        CompileContext compileContext = new CompileContext(session);

        compileContext.setNextRangeVarIndex(0);

        QuerySpecification s = new QuerySpecification(compileContext);
        RangeVariable range = new RangeVariable(t, null, null, null,
            compileContext);
        RangeVariable[] ranges     = new RangeVariable[]{ range };
        RangeGroup      rangeGroup = new RangeGroupSimple(ranges, false);

        e.resolveCheckOrGenExpression(session, rangeGroup, true);

        if (Type.SQL_BOOLEAN != e.getDataType()) {
            throw Error.error(ErrorCode.X_42568);
        }

        Expression condition = new ExpressionLogical(OpTypes.NOT, e);

        s.addSelectColumnExpression(EXPR_TRUE);
        s.addRangeVariable(session, range);
        s.addQueryCondition(condition);
        s.resolve(session);

        return s;
    }

    public void resolveCheckOrGenExpression(Session session,
            RangeGroup rangeGroup, boolean isCheck) {

        boolean        nonDeterministic = false;
        OrderedHashSet set              = new OrderedHashSet();
        HsqlList unresolved = resolveColumnReferences(session, rangeGroup,
            RangeGroup.emptyArray, null);

        ExpressionColumn.checkColumnsResolved(unresolved);
        resolveTypes(session, null);
        collectAllExpressions(set, Expression.subqueryAggregateExpressionSet,
                              Expression.emptyExpressionSet);

        if (!set.isEmpty()) {
            throw Error.error(ErrorCode.X_42512);
        }

        collectAllExpressions(set, Expression.functionExpressionSet,
                              Expression.emptyExpressionSet);

        for (int i = 0; i < set.size(); i++) {
            Expression current = (Expression) set.get(i);

            if (current.opType == OpTypes.FUNCTION) {
                if (!((FunctionSQLInvoked) current).isDeterministic()) {
                    throw Error.error(ErrorCode.X_42512);
                }
            }

            if (current.opType == OpTypes.SQL_FUNCTION) {
                if (!((FunctionSQL) current).isDeterministic()) {
                    if (isCheck) {
                        nonDeterministic = true;

                        continue;
                    }

                    throw Error.error(ErrorCode.X_42512);
                }
            }
        }

        if (isCheck && nonDeterministic) {
            HsqlArrayList list = new HsqlArrayList();

            RangeVariableResolver.decomposeAndConditions(session, this, list);

            for (int i = 0; i < list.size(); i++) {
                nonDeterministic = true;

                Expression e = (Expression) list.get(i);
                Expression e1;

                if (e instanceof ExpressionLogical) {
                    boolean b = ((ExpressionLogical) e).convertToSmaller();

                    if (!b) {
                        break;
                    }

                    e1 = e.getRightNode();
                    e  = e.getLeftNode();

                    if (!e.dataType.isDateTimeType()) {
                        nonDeterministic = true;

                        break;
                    }

                    if (e.hasNonDeterministicFunction()) {
                        nonDeterministic = true;

                        break;
                    }

                    // both sides are actually consistent regarding timeZone
                    // e.dataType.isDateTimeTypeWithZone();
                    if (e1 instanceof ExpressionArithmetic) {
                        if (opType == OpTypes.ADD) {
                            if (e1.getRightNode()
                                    .hasNonDeterministicFunction()) {
                                e1.swapLeftAndRightNodes();
                            }
                        } else if (opType == OpTypes.SUBTRACT) {}
                        else {
                            break;
                        }

                        if (e1.getRightNode().hasNonDeterministicFunction()) {
                            break;
                        }

                        e1 = e1.getLeftNode();
                    }

                    if (e1.opType == OpTypes.SQL_FUNCTION) {
                        FunctionSQL function = (FunctionSQL) e1;

                        switch (function.funcType) {

                            case FunctionSQL.FUNC_CURRENT_DATE :
                            case FunctionSQL.FUNC_CURRENT_TIMESTAMP :
                            case FunctionSQL.FUNC_LOCALTIMESTAMP :
                                nonDeterministic = false;

                                continue;
                            default :
                                break;
                        }

                        break;
                    }

                    break;
                } else {
                    break;
                }
            }

            if (nonDeterministic) {
                throw Error.error(ErrorCode.X_42512);
            }
        }

        set.clear();
        collectObjectNames(set);

        RangeVariable[] ranges = rangeGroup.getRangeVariables();

        for (int i = 0; i < set.size(); i++) {
            HsqlName name = (HsqlName) set.get(i);

            switch (name.type) {

                case SchemaObject.COLUMN : {
                    if (isCheck) {
                        break;
                    }

                    int colIndex = ranges[0].rangeTable.findColumn(name.name);
                    ColumnSchema column =
                        ranges[0].rangeTable.getColumn(colIndex);

                    if (column.isGenerated()) {
                        throw Error.error(ErrorCode.X_42512);
                    }

                    break;
                }
                case SchemaObject.SEQUENCE : {
                    throw Error.error(ErrorCode.X_42512);
                }
                case SchemaObject.SPECIFIC_ROUTINE : {
                    Routine routine =
                        (Routine) session.database.schemaManager
                            .getSchemaObject(name);

                    if (!routine.isDeterministic()) {
                        throw Error.error(ErrorCode.X_42512);
                    }

                    int impact = routine.getDataImpact();

                    if (impact == Routine.READS_SQL
                            || impact == Routine.MODIFIES_SQL) {
                        throw Error.error(ErrorCode.X_42512);
                    }
                }
            }
        }

        set.clear();
    }

    boolean isUnresolvedParam() {
        return false;
    }

    boolean isDynamicParam() {
        return false;
    }

    boolean hasNonDeterministicFunction() {

        OrderedHashSet list = null;

        list = collectAllExpressions(list, Expression.functionExpressionSet,
                                     Expression.emptyExpressionSet);

        if (list == null) {
            return false;
        }

        for (int j = 0; j < list.size(); j++) {
            Expression current = (Expression) list.get(j);

            if (current.opType == OpTypes.FUNCTION) {
                if (!((FunctionSQLInvoked) current).isDeterministic()) {
                    return true;
                }
            } else if (current.opType == OpTypes.SQL_FUNCTION) {
                if (!((FunctionSQL) current).isDeterministic()) {
                    return true;
                }
            }
        }

        return false;
    }

    void swapLeftAndRightNodes() {

        Expression temp = nodes[LEFT];

        nodes[LEFT]  = nodes[RIGHT];
        nodes[RIGHT] = temp;
    }

    void setAttributesAsColumn(ColumnSchema column, boolean isWritable) {
        throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
    }

    String getValueClassName() {

        Type type = dataType == null ? NullType.getNullType()
                                     : dataType;

        return type.getJDBCClassName();
    }

    /**
     * collect all expressions of a set of expression types appearing anywhere
     * in a select statement and its subselects, etc.
     */
    OrderedHashSet collectAllExpressions(OrderedHashSet set,
                                         OrderedIntHashSet typeSet,
                                         OrderedIntHashSet stopAtTypeSet) {

        if (stopAtTypeSet.contains(opType)) {
            return set;
        }

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                set = nodes[i].collectAllExpressions(set, typeSet,
                                                     stopAtTypeSet);
            }
        }

        boolean added = false;

        if (typeSet.contains(opType)) {
            if (set == null) {
                set = new OrderedHashSet();
            }

            set.add(this);

            added = true;
        }

        if (!added) {
            if (table != null && table.queryExpression != null) {
                set = table.queryExpression.collectAllExpressions(set,
                        typeSet, stopAtTypeSet);
            }
        }

        return set;
    }

    public OrderedHashSet getSubqueries() {
        return collectAllSubqueries(null);
    }

    OrderedHashSet collectAllSubqueries(OrderedHashSet set) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                set = nodes[i].collectAllSubqueries(set);
            }
        }

        if (table != null) {
            OrderedHashSet tempSet = null;

            if (table.queryExpression != null) {
                tempSet = table.queryExpression.getSubqueries();
                set     = OrderedHashSet.addAll(set, tempSet);
            }

            if (set == null) {
                set = new OrderedHashSet();
            }

            set.add(table);
        }

        return set;
    }

    /**
     * isCorrelated
     */
    public boolean isCorrelated() {

        if (table == null) {
            return false;
        }

        return table.isCorrelated();
    }

    /**
     * checkValidCheckConstraint
     */
    public void checkValidCheckConstraint() {

        OrderedHashSet set = null;

        set = collectAllExpressions(set,
                                    Expression.subqueryAggregateExpressionSet,
                                    Expression.emptyExpressionSet);

        if (set != null && !set.isEmpty()) {
            throw Error.error(ErrorCode.X_0A000,
                              "subquery in check constraint");
        }
    }

    static HsqlList resolveColumnSet(Session session,
                                     RangeVariable[] rangeVars,
                                     RangeGroup[] rangeGroups,
                                     HsqlList sourceSet) {
        return resolveColumnSet(session, rangeVars, rangeVars.length,
                                rangeGroups, sourceSet, null);
    }

    static HsqlList resolveColumnSet(Session session,
                                     RangeVariable[] rangeVars,
                                     int rangeCount, RangeGroup[] rangeGroups,
                                     HsqlList sourceSet, HsqlList targetSet) {

        if (sourceSet == null) {
            return targetSet;
        }

        RangeGroup rangeGroup = new RangeGroupSimple(rangeVars, false);

        for (int i = 0; i < sourceSet.size(); i++) {
            Expression e = (Expression) sourceSet.get(i);

            targetSet = e.resolveColumnReferences(session, rangeGroup,
                                                  rangeCount, rangeGroups,
                                                  targetSet, false);
        }

        return targetSet;
    }

    boolean isConditionRangeVariable(RangeVariable range) {
        return false;
    }

    void getJoinRangeVariables(RangeVariable[] ranges, HsqlList list) {}

    double costFactor(Session session, RangeVariable range, int operation) {
        return Index.minimumSelectivity;
    }

    Expression getIndexableExpression(RangeVariable rangeVar) {
        return null;
    }

    public Expression duplicate() {

        Expression e = null;

        try {
            e       = (Expression) super.clone();
            e.nodes = (Expression[]) nodes.clone();

            for (int i = 0; i < nodes.length; i++) {
                if (nodes[i] != null) {
                    e.nodes[i] = nodes[i].duplicate();
                }
            }
        } catch (CloneNotSupportedException ex) {
            throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
        }

        return e;
    }

    void replaceNode(Expression existing, Expression replacement) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == existing) {
                replacement.alias = nodes[i].alias;
                nodes[i]          = replacement;

                return;
            }
        }

        throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
    }

    public Object updateAggregatingValue(Session session, Object currValue) {
        throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
    }

    public Object getAggregatedValue(Session session, Object currValue) {
        throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
    }

    public Expression getCondition() {
        return null;
    }

    public boolean hasCondition() {
        return false;
    }

    public void setCondition(Expression e) {
        throw Error.runtimeError(ErrorCode.U_S0500, "Expression");
    }

    public void setCollation(Collation collation) {
        this.collation = collation;
    }
}

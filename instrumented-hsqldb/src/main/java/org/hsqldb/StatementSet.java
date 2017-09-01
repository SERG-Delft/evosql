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
import org.hsqldb.ParserDQL.CompileContext;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.map.ValuePool;
import org.hsqldb.result.Result;
import org.hsqldb.types.Type;

/**
 * Implementation of Statement for PSM and trigger assignment.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class StatementSet extends StatementDMQL {

    Expression expression;

    //
    Expression[] targets;
    int[]        variableIndexes;
    Type[]       sourceTypes;

    //
    final int               operationType;
    public static final int TRIGGER_SET  = 1;
    public static final int SELECT_INTO  = 2;
    public static final int VARIABLE_SET = 3;

    /**
     * Trigger SET statement.
     */
    StatementSet(Session session, Expression[] targets, Table table,
                 RangeVariable[] rangeVars, int[] indexes,
                 Expression[] colExpressions, CompileContext compileContext) {

        super(StatementTypes.ASSIGNMENT, StatementTypes.X_SQL_DATA_CHANGE,
              session.getCurrentSchemaHsqlName());

        this.operationType        = TRIGGER_SET;
        this.targets              = targets;
        this.targetTable          = table;
        this.baseTable            = targetTable.getBaseTable();
        this.updateColumnMap      = indexes;
        this.updateExpressions    = colExpressions;
        this.updateCheckColumns   = targetTable.getColumnCheckList(indexes);
        this.targetRangeVariables = rangeVars;
        isTransactionStatement    = false;

        setDatabaseObjects(session, compileContext);
        checkAccessRights(session);
    }

    /**
     * PSM and session variable SET
     */
    StatementSet(Session session, Expression[] targets, Expression e,
                 int[] indexes, CompileContext compileContext) {

        super(StatementTypes.ASSIGNMENT, StatementTypes.X_SQL_CONTROL, null);

        this.operationType     = VARIABLE_SET;
        this.targets           = targets;
        this.expression        = e;
        variableIndexes        = indexes;
        sourceTypes            = expression.getNodeDataTypes();
        isTransactionStatement = false;

        setDatabaseObjects(session, compileContext);
        checkAccessRights(session);
    }

    /**
     * Single row SELECT INTO
     */
    StatementSet(Session session, Expression[] targets, QueryExpression query,
                 int[] indexes, CompileContext compileContext) {

        super(StatementTypes.ASSIGNMENT, StatementTypes.X_SQL_CONTROL, null);

        this.operationType     = SELECT_INTO;
        this.queryExpression   = query;
        this.targets           = targets;
        variableIndexes        = indexes;
        sourceTypes            = query.getColumnTypes();
        isTransactionStatement = false;

        setDatabaseObjects(session, compileContext);
        checkAccessRights(session);
    }

    TableDerived[] getSubqueries(Session session) {

        OrderedHashSet subQueries = null;

        if (expression != null) {
            subQueries = expression.collectAllSubqueries(subQueries);
        }

        if (subQueries == null || subQueries.size() == 0) {
            return TableDerived.emptyArray;
        }

        TableDerived[] subQueryArray = new TableDerived[subQueries.size()];

        subQueries.toArray(subQueryArray);

        for (int i = 0; i < subqueries.length; i++) {
            subQueryArray[i].prepareTable(session);
        }

        return subQueryArray;
    }

    Result getResult(Session session) {

        Result result = null;

        switch (operationType) {

            case StatementSet.TRIGGER_SET :
                result = executeTriggerSetStatement(session);
                break;

            case StatementSet.SELECT_INTO : {
                Object[] values = queryExpression.getSingleRowValues(session);

                if (values == null) {
                    session.addWarning(HsqlException.noDataCondition);

                    result = Result.updateZeroResult;

                    break;
                }

                result = performAssignment(session, variableIndexes, targets,
                                           values, sourceTypes);

                break;
            }
            case StatementSet.VARIABLE_SET : {
                Object[] values = getExpressionValues(session);

                if (values == null) {
                    result = Result.updateZeroResult;

                    break;
                }

                result = performAssignment(session, variableIndexes, targets,
                                           values, sourceTypes);

                break;
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "StatementSet");
        }

        return result;
    }

    /**
     * extra names may be added to references
     */
    public void resolve(Session session) {

        switch (operationType) {

            case StatementSet.TRIGGER_SET :
                for (int i = 0; i < updateExpressions.length; i++) {
                    updateExpressions[i].collectObjectNames(references);
                }
                break;

            case StatementSet.SELECT_INTO :
            case StatementSet.VARIABLE_SET : {
                if (expression != null) {
                    expression.collectObjectNames(references);
                }

                break;
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "StatementSet");
        }
    }

    public String getSQL() {

        StringBuffer sb = new StringBuffer();

        switch (operationType) {

            case StatementSet.TRIGGER_SET :
                return sql;

            case StatementSet.VARIABLE_SET : {

                /** @todo - cover row assignment */
                sb.append(Tokens.T_SET).append(' ');
                sb.append(targets[0].getColumn().getName().statementName);
                sb.append(' ').append('=').append(' ').append(
                    expression.getSQL());

                break;
            }
        }

        return sb.toString();
    }

    protected String describe(Session session, int blanks) {

        StringBuffer sb = new StringBuffer();

        sb.append('\n');

        for (int i = 0; i < blanks; i++) {
            sb.append(' ');
        }

        sb.append(Tokens.T_STATEMENT);

        return sb.toString();
    }

    public Result execute(Session session) {

        Result result;

        try {
            if (subqueries.length > 0) {
                materializeSubQueries(session);
            }

            result = getResult(session);
        } catch (Throwable t) {
            result = Result.newErrorResult(t);
        }

        if (result.isError()) {
            result.getException().setStatementType(group, type);
        }

        return result;
    }

    public String describe(Session session) {
        return "";
    }

    Result executeTriggerSetStatement(Session session) {

        Table        table          = targetTable;
        int[]        colMap         = updateColumnMap;    // column map
        Expression[] colExpressions = updateExpressions;
        Type[]       colTypes       = table.getColumnTypes();
        int index = targetRangeVariables[TriggerDef.NEW_ROW].rangePosition;
        Object[]     oldData = session.sessionContext.triggerArguments[index];
        Object[] data = StatementDML.getUpdatedData(session, targets, table,
            colMap, colExpressions, colTypes, oldData);

        ArrayUtil.copyArray(data, oldData, data.length);

        return Result.updateOneResult;
    }

    // this fk references -> other  :  other read lock
    void collectTableNamesForRead(OrderedHashSet set) {

        if (queryExpression != null) {
            queryExpression.getBaseTableNames(set);
        }

        for (int i = 0; i < rangeVariables.length; i++) {
            Table    rangeTable = rangeVariables[i].rangeTable;
            HsqlName name       = rangeTable.getName();

            if (rangeTable.isDataReadOnly() || rangeTable.isTemp()) {
                continue;
            }

            if (rangeTable.isView()) {
                continue;
            }

            if (name.schema == SqlInvariants.SYSTEM_SCHEMA_HSQLNAME) {
                continue;
            }

            set.add(name);
        }

        for (int i = 0; i < subqueries.length; i++) {
            if (subqueries[i].queryExpression != null) {
                subqueries[i].queryExpression.getBaseTableNames(set);
            }
        }

        for (int i = 0; i < routines.length; i++) {
            set.addAll(routines[i].getTableNamesForRead());
        }
    }

    void collectTableNamesForWrite(OrderedHashSet set) {}

    public void checkIsNotColumnTarget() {

        for (int i = 0; i < targets.length; i++) {
            ColumnSchema col = targets[i].getColumn();

            if (col.getType() == SchemaObject.COLUMN) {
                throw Error.error(ErrorCode.X_0U000,
                                  col.getName().statementName);
            }
        }
    }

    Object[] getExpressionValues(Session session) {

        Object[] values;

        if (expression.getType() == OpTypes.ROW) {
            values = expression.getRowValue(session);
        } else if (expression.getType() == OpTypes.ROW_SUBQUERY) {
            values =
                expression.table.queryExpression.getSingleRowValues(session);

            if (values == null) {

                // todo - verify semantics
                return null;
            }
        } else {
            values    = new Object[1];
            values[0] = expression.getValue(session);
        }

        return values;
    }

    static Result performAssignment(Session session, int[] variableIndexes,
                                    Expression[] targets, Object[] values,
                                    Type[] sourceTypes) {

        for (int j = 0; j < values.length; j++) {
            Object[] data = ValuePool.emptyObjectArray;

            switch (targets[j].getColumn().getType()) {

                case SchemaObject.PARAMETER :
                    data = session.sessionContext.routineArguments;
                    break;

                case SchemaObject.VARIABLE :
                    data = session.sessionContext.routineVariables;
                    break;

                case SchemaObject.COLUMN :
                    data = session.sessionContext
                        .triggerArguments[TriggerDef.NEW_ROW];
                    break;
            }

            int    colIndex = variableIndexes[j];
            Object value    = values[j];
            Type   targetType;

            if (targets[j].getType() == OpTypes.ARRAY_ACCESS) {
                targetType =
                    targets[j].getLeftNode().getColumn().getDataType()
                        .collectionBaseType();
                value = targetType.convertToType(session, value,
                                                 sourceTypes[j]);
                data[colIndex] =
                    ((ExpressionAccessor) targets[j]).getUpdatedArray(session,
                        (Object[]) data[colIndex], value, true);
            } else {
                targetType = targets[j].getColumn().getDataType();
                value = targetType.convertToType(session, value,
                                                 sourceTypes[j]);
                data[colIndex] = value;
            }
        }

        return Result.updateZeroResult;
    }
}

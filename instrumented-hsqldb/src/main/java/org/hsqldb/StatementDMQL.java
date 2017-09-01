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
import org.hsqldb.lib.HashSet;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.map.ValuePool;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultMetaData;
import org.hsqldb.rights.Grantee;

/**
 * Statement implementation for DML and base DQL statements.
 *
 * @author Campbell Burnet (boucherb@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.7.2
 */

// fredt@users 20040404 - patch 1.7.2 - fixed type resolution for parameters
// boucherb@users 200404xx - patch 1.7.2 - changed parameter naming scheme for SQLCI client usability/support
// fredt@users 20050609 - 1.8.0 - fixed EXPLAIN PLAN by implementing describe(Session)
// fredt@users - 1.9.0 - support for generated column reporting
// fredt@users - 1.9.0 - support for multi-row inserts
public abstract class StatementDMQL extends Statement {

    public static final String PCOL_PREFIX        = "@p";
    static final String        RETURN_COLUMN_NAME = "@p0";

    /** target table for INSERT_XXX, UPDATE and DELETE and MERGE */
    Table targetTable;
    Table baseTable;

    /** column map of query expression */
    int[]           baseColumnMap;
    RangeVariable[] targetRangeVariables = RangeVariable.emptyArray;

    /** source table for MERGE */
    Table sourceTable;

    /** condition expression for UPDATE, MERGE and DELETE */
    Expression condition;

    /** for TRUNCATE variation of DELETE */
    boolean restartIdentity;

    /** column map for INSERT operation direct or via MERGE */
    int[] insertColumnMap = ValuePool.emptyIntArray;

    /** column map for UPDATE operation direct or via MERGE */
    int[] updateColumnMap     = ValuePool.emptyIntArray;
    int[] baseUpdateColumnMap = ValuePool.emptyIntArray;

    /** Column value Expressions for UPDATE and MERGE. */
    Expression[] updateExpressions = Expression.emptyArray;

    /** Column value Expressions for MERGE */
    Expression[][] multiColumnValues;

    /** INSERT_VALUES */
    Expression insertExpression;

    /**
     * Flags indicating which columns' values will/will not be
     * explicitly set.
     */
    boolean[] insertCheckColumns;
    boolean[] updateCheckColumns;

    /**
     * VIEW check
     */
    Expression    updatableTableCheck;
    RangeVariable checkRangeVariable;

    /**
     * Select to be evaluated when this is an INSERT_SELECT or
     * SELECT statement
     */
    QueryExpression queryExpression;

    /**
     * Name of cursor
     */
    HsqlName cursorName;

    /**
     * Parse-order array of Expression objects, all of type PARAMETER ,
     * involved in some way in any INSERT_XXX, UPDATE, DELETE, SELECT or
     * CALL CompiledStatement
     */
    ExpressionColumn[] parameters;

    /**
     * ResultMetaData for parameters
     */
    ResultMetaData parameterMetaData;

    /**
     * Subqueries inverse usage depth order
     */
    TableDerived[] subqueries = TableDerived.emptyArray;

    /**
     * Total number of RangeIterator objects used
     */
    int rangeIteratorCount;

    /**
     * Database objects used
     */
    NumberSequence[] sequences;
    Routine[]        routines;
    RangeVariable[]  rangeVariables;

    StatementDMQL(int type, int group, HsqlName schemaName) {

        super(type, group);

        this.schemaName             = schemaName;
        this.isTransactionStatement = true;
    }

    void setBaseIndexColumnMap() {

        if (targetTable != baseTable) {
            baseColumnMap = targetTable.getBaseTableColumnMap();
        }
    }

    public Result execute(Session session) {
    	// TUD_JC: Tell the instrumenter that the query execution starts
    	genetic.Instrumenter.signalStart();
        Result result;

        if (targetTable != null && session.isReadOnly()
                && !targetTable.isTemp()) {
            HsqlException e = Error.error(ErrorCode.X_25006);

            return Result.newErrorResult(e);
        }

        if (isExplain) {
            return getExplainResult(session);
        }

        try {
            if (subqueries.length > 0) {
                materializeSubQueries(session);
            }

            result = getResult(session);
        } catch (Throwable t) {
            result = Result.newErrorResult(t);

            result.getException().setStatementType(group, type);
        } finally {
            clearStructures(session);
        }

        return result;
    }

    private Result getExplainResult(Session session) {

        Result result = Result.newSingleColumnStringResult("OPERATION",
            describe(session));
        OrderedHashSet set = getReferences();

        result.navigator.add(new Object[]{ "Object References" });

        for (int i = 0; i < set.size(); i++) {
            HsqlName name = (HsqlName) set.get(i);

            result.navigator.add(new Object[]{
                name.getSchemaQualifiedStatementName() });
        }

        result.navigator.add(new Object[]{ "Read Locks" });

        for (int i = 0; i < readTableNames.length; i++) {
            HsqlName name = readTableNames[i];

            result.navigator.add(new Object[]{
                name.getSchemaQualifiedStatementName() });
        }

        result.navigator.add(new Object[]{ "WriteLocks" });

        for (int i = 0; i < writeTableNames.length; i++) {
            HsqlName name = writeTableNames[i];

            result.navigator.add(new Object[]{
                name.getSchemaQualifiedStatementName() });
        }

        return result;
    }

    abstract Result getResult(Session session);

    abstract void collectTableNamesForRead(OrderedHashSet set);

    abstract void collectTableNamesForWrite(OrderedHashSet set);

    boolean[] getInsertOrUpdateColumnCheckList() {

        switch (type) {

            case StatementTypes.INSERT :
                return insertCheckColumns;

            case StatementTypes.UPDATE_WHERE :
                return updateCheckColumns;

            case StatementTypes.MERGE :
                boolean[] check =
                    (boolean[]) ArrayUtil.duplicateArray(insertCheckColumns);

                ArrayUtil.orBooleanArray(updateCheckColumns, check);

                return check;
        }

        return null;
    }

    void materializeSubQueries(Session session) {

        HashSet subqueryPopFlags = new HashSet();

        for (int i = 0; i < subqueries.length; i++) {
            TableDerived td = subqueries[i];

            if (!subqueryPopFlags.add(td)) {
                continue;
            }

            if (!td.isCorrelated()) {
                td.materialise(session);
                //TUD_JC: Increasing query depth here
                genetic.Instrumenter.increaseQueryLevel();
            }
            
        }
    }

    TableDerived[] getSubqueries(Session session) {

        OrderedHashSet subQueries = null;

        for (int i = 0; i < targetRangeVariables.length; i++) {
            if (targetRangeVariables[i] == null) {
                continue;
            }

            OrderedHashSet set = targetRangeVariables[i].getSubqueries();

            subQueries = OrderedHashSet.addAll(subQueries, set);
        }

        for (int i = 0; i < updateExpressions.length; i++) {
            subQueries = updateExpressions[i].collectAllSubqueries(subQueries);
        }

        if (insertExpression != null) {
            subQueries = insertExpression.collectAllSubqueries(subQueries);
        }

        if (condition != null) {
            subQueries = condition.collectAllSubqueries(subQueries);
        }

        if (queryExpression != null) {
            OrderedHashSet set = queryExpression.getSubqueries();

            subQueries = OrderedHashSet.addAll(subQueries, set);
        }

        if (updatableTableCheck != null) {
            OrderedHashSet set = updatableTableCheck.getSubqueries();

            subQueries = OrderedHashSet.addAll(subQueries, set);
        }

        if (subQueries == null || subQueries.size() == 0) {
            return TableDerived.emptyArray;
        }

        TableDerived[] subQueryArray = new TableDerived[subQueries.size()];

        subQueries.toArray(subQueryArray);

        return subQueryArray;
    }

    void setDatabaseObjects(Session session, CompileContext compileContext) {

        parameters = compileContext.getParameters();

        setParameterMetaData();

        subqueries         = getSubqueries(session);
        rangeIteratorCount = compileContext.getRangeVarCount();
        rangeVariables     = compileContext.getAllRangeVariables();
        sequences          = compileContext.getSequences();
        routines           = compileContext.getRoutines();

        OrderedHashSet set = new OrderedHashSet();

        collectTableNamesForWrite(set);

        if (set.size() > 0) {
            writeTableNames = new HsqlName[set.size()];

            set.toArray(writeTableNames);
            set.clear();
        }

        collectTableNamesForRead(set);
        set.removeAll(writeTableNames);

        if (set.size() > 0) {
            readTableNames = new HsqlName[set.size()];

            set.toArray(readTableNames);
        }

        if (readTableNames.length == 0 && writeTableNames.length == 0) {
            if (type == StatementTypes.SELECT_CURSOR
                    || type == StatementTypes.SELECT_SINGLE) {
                isTransactionStatement = false;
            }
        }

        references = compileContext.getSchemaObjectNames();

        if (targetTable != null) {
            references.add(targetTable.getName());

            if (targetTable == baseTable) {
                if (insertCheckColumns != null) {
                    targetTable.getColumnNames(insertCheckColumns, references);
                }

                if (updateCheckColumns != null) {
                    targetTable.getColumnNames(updateCheckColumns, references);
                }
            }
        }
    }

    /**
     * Determines if the authorizations are adequate
     * to execute the compiled object. Completion requires the list of
     * all database objects in a compiled statement.
     */
    void checkAccessRights(Session session) {

        if (targetTable != null && !targetTable.isTemp()) {
            if (!session.isProcessingScript()) {
                targetTable.checkDataReadOnly();
            }

            Grantee owner = targetTable.getOwner();

            if (owner != null && owner.isSystem()) {
                if (!session.getUser().isSystem()) {
                    throw Error.error(ErrorCode.X_42501,
                                      targetTable.getName().name);
                }
            }

            session.checkReadWrite();
        }

        if (session.isAdmin()) {
            return;
        }

        for (int i = 0; i < sequences.length; i++) {
            session.getGrantee().checkAccess(sequences[i]);
        }

        for (int i = 0; i < routines.length; i++) {
            if (routines[i].isLibraryRoutine()) {
                continue;
            }

            session.getGrantee().checkAccess(routines[i]);
        }

        for (int i = 0; i < rangeVariables.length; i++) {
            RangeVariable range = rangeVariables[i];

            if (range.rangeTable.getSchemaName()
                    == SqlInvariants.SYSTEM_SCHEMA_HSQLNAME) {
                continue;
            }

            session.getGrantee().checkSelect(range.rangeTable,
                                             range.usedColumns);
        }

        switch (type) {

            case StatementTypes.CALL : {
                break;
            }
            case StatementTypes.INSERT : {
                session.getGrantee().checkInsert(targetTable,
                                                 insertCheckColumns);

                break;
            }
            case StatementTypes.SELECT_CURSOR :
                break;

            case StatementTypes.DELETE_WHERE : {
                session.getGrantee().checkDelete(targetTable);

                break;
            }
            case StatementTypes.UPDATE_WHERE : {
                session.getGrantee().checkUpdate(targetTable,
                                                 updateCheckColumns);

                break;
            }
            case StatementTypes.MERGE : {
                session.getGrantee().checkInsert(targetTable,
                                                 insertCheckColumns);
                session.getGrantee().checkUpdate(targetTable,
                                                 updateCheckColumns);

                break;
            }
        }
    }

    Result getWriteAccessResult(Session session) {

        try {
            if (targetTable != null && !targetTable.isTemp()) {
                session.checkReadWrite();
            }
        } catch (HsqlException e) {
            return Result.newErrorResult(e);
        }

        return null;
    }

    /**
     * Returns the metadata, which is empty if the CompiledStatement does not
     * generate a Result.
     */
    public ResultMetaData getResultMetaData() {

        switch (type) {

            case StatementTypes.DELETE_WHERE :
            case StatementTypes.INSERT :
            case StatementTypes.UPDATE_WHERE :
            case StatementTypes.MERGE :
                return ResultMetaData.emptyResultMetaData;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "StatementDMQL");
        }
    }

    /** @todo 1.9.0 - build the metadata only once and reuse */

    /**
     * Returns the metadata for the placeholder parameters.
     */
    public ResultMetaData getParametersMetaData() {
        return parameterMetaData;
    }

    void setParameterMetaData() {

        int     offset;
        int     idx;
        boolean hasReturnValue;

        offset = 0;

        if (parameters.length == 0) {
            parameterMetaData = ResultMetaData.emptyParamMetaData;

            return;
        }

// NO:  Not yet
//        hasReturnValue = (type == CALL && !expression.isProcedureCall());
//
//        if (hasReturnValue) {
//            outlen++;
//            offset = 1;
//        }
        parameterMetaData =
            ResultMetaData.newParameterMetaData(parameters.length);

// NO: Not yet
//        if (hasReturnValue) {
//            e = expression;
//            out.sName[0]       = DIProcedureInfo.RETURN_COLUMN_NAME;
//            out.sClassName[0]  = e.getValueClassName();
//            out.colType[0]     = e.getDataType();
//            out.colSize[0]     = e.getColumnSize();
//            out.colScale[0]    = e.getColumnScale();
//            out.nullability[0] = e.nullability;
//            out.isIdentity[0]  = false;
//            out.paramMode[0]   = expression.PARAM_OUT;
//        }
        for (int i = 0; i < parameters.length; i++) {
            idx = i + offset;

            // always i + 1.  We currently use the convention of @p0 to name the
            // return value OUT parameter
            parameterMetaData.columnLabels[idx] = StatementDMQL.PCOL_PREFIX
                                                  + (i + 1);
            parameterMetaData.columnTypes[idx] = parameters[i].dataType;

            if (parameters[i].dataType == null) {
                throw Error.error(ErrorCode.X_42567);
            }

            byte parameterMode = SchemaObject.ParameterModes.PARAM_IN;

            if (parameters[i].column != null
                    && parameters[i].column.getParameterMode()
                       != SchemaObject.ParameterModes.PARAM_UNKNOWN) {
                parameterMode = parameters[i].column.getParameterMode();
            }

            parameterMetaData.paramModes[idx] = parameterMode;
            parameterMetaData.paramNullable[idx] =
                parameters[i].column == null
                ? SchemaObject.Nullability.NULLABLE
                : parameters[i].column.getNullability();
        }
    }

    /**
     * Retrieves a String representation of this object.
     */
    public String describe(Session session) {

        try {
            return describeImpl(session);
        } catch (Throwable e) {
            e.printStackTrace();

            return e.toString();
        }
    }

    /**
     * Provides the toString() implementation.
     */
    String describeImpl(Session session) throws Exception {

        StringBuffer sb;

        sb = new StringBuffer();

        int blanks = 0;

        switch (type) {

            case StatementTypes.SELECT_CURSOR : {
                sb.append(queryExpression.describe(session, 0));
                appendParams(sb).append('\n');
                appendSubqueries(session, sb, 2);

                return sb.toString();
            }
            case StatementTypes.INSERT : {
                if (queryExpression == null) {
                    sb.append("INSERT VALUES");
                    sb.append('[').append('\n');
                    appendMultiColumns(sb, insertColumnMap).append('\n');
                    appendTable(sb).append('\n');
                    appendParams(sb).append('\n');
                    appendSubqueries(session, sb, 2).append(']');

                    return sb.toString();
                } else {
                    sb.append("INSERT SELECT");
                    sb.append('[').append('\n');
                    appendColumns(sb, insertColumnMap).append('\n');
                    appendTable(sb).append('\n');
                    sb.append(queryExpression.describe(session,
                                                       blanks)).append('\n');
                    appendParams(sb).append('\n');
                    appendSubqueries(session, sb, 2).append(']');

                    return sb.toString();
                }
            }
            case StatementTypes.UPDATE_WHERE : {
                sb.append("UPDATE");
                sb.append('[').append('\n');
                appendColumns(sb, updateColumnMap).append('\n');
                appendTable(sb).append('\n');
                appendCondition(session, sb);

                for (int i = 0; i < targetRangeVariables.length; i++) {
                    sb.append(targetRangeVariables[i].describe(session,
                            blanks)).append('\n');
                }

                appendParams(sb).append('\n');
                appendSubqueries(session, sb, 2).append(']');

                return sb.toString();
            }
            case StatementTypes.DELETE_WHERE : {
                sb.append("DELETE");
                sb.append('[').append('\n');
                appendTable(sb).append('\n');
                appendCondition(session, sb);

                for (int i = 0; i < targetRangeVariables.length; i++) {
                    sb.append(targetRangeVariables[i].describe(session,
                            blanks)).append('\n');
                }

                appendParams(sb).append('\n');
                appendSubqueries(session, sb, 2).append(']');

                return sb.toString();
            }
            case StatementTypes.CALL : {
                sb.append("CALL");
                sb.append('[').append(']');

                return sb.toString();
            }
            case StatementTypes.MERGE : {
                sb.append("MERGE");
                sb.append('[').append('\n');
                appendMultiColumns(sb, insertColumnMap).append('\n');
                appendColumns(sb, updateColumnMap).append('\n');
                appendTable(sb).append('\n');
                appendCondition(session, sb);

                for (int i = 0; i < targetRangeVariables.length; i++) {
                    sb.append(targetRangeVariables[i].describe(session,
                            blanks)).append('\n');
                }

                appendParams(sb).append('\n');
                appendSubqueries(session, sb, 2).append(']');

                return sb.toString();
            }
            default : {
                return "UNKNOWN";
            }
        }
    }

    private StringBuffer appendSubqueries(Session session, StringBuffer sb,
                                          int blanks) {

        sb.append("SUBQUERIES[");

        for (int i = 0; i < subqueries.length; i++) {
            sb.append("\n[level=").append(subqueries[i].depth).append('\n');

            if (subqueries[i].queryExpression == null) {
                for (int j = 0; j < blanks; j++) {
                    sb.append(' ');
                }

                sb.append("value expression");
            } else {
                sb.append(subqueries[i].queryExpression.describe(session,
                        blanks));
            }

            sb.append("]");
        }

        sb.append(']');

        return sb;
    }

    private StringBuffer appendTable(StringBuffer sb) {

        sb.append("TABLE[").append(targetTable.getName().name).append(']');

        return sb;
    }

    private StringBuffer appendSourceTable(StringBuffer sb) {

        sb.append("SOURCE TABLE[").append(sourceTable.getName().name).append(
            ']');

        return sb;
    }

    private StringBuffer appendColumns(StringBuffer sb, int[] columnMap) {

        if (columnMap == null || updateExpressions.length == 0) {
            return sb;
        }

        sb.append("COLUMNS=[");

        for (int i = 0; i < columnMap.length; i++) {
            sb.append('\n').append(columnMap[i]).append(':').append(
                ' ').append(
                targetTable.getColumn(columnMap[i]).getNameString());
        }

        for (int i = 0; i < updateExpressions.length; i++) {
            sb.append('[').append(updateExpressions[i]).append(']');
        }

        sb.append(']');

        return sb;
    }

    private StringBuffer appendMultiColumns(StringBuffer sb, int[] columnMap) {

        // todo - multiColVals is always null
        if (columnMap == null || multiColumnValues == null) {
            return sb;
        }

        sb.append("COLUMNS=[");

        for (int j = 0; j < multiColumnValues.length; j++) {
            for (int i = 0; i < columnMap.length; i++) {
                sb.append('\n').append(columnMap[i]).append(':').append(
                    ' ').append(
                    targetTable.getColumn(columnMap[i]).getName().name).append(
                    '[').append(multiColumnValues[j][i]).append(']');
            }
        }

        sb.append(']');

        return sb;
    }

    private StringBuffer appendParams(StringBuffer sb) {

        sb.append("PARAMETERS=[");

        for (int i = 0; i < parameters.length; i++) {
            sb.append('\n').append('@').append(i).append('[').append(
                parameters[i].describe(null, 0)).append(']');
        }

        sb.append(']');

        return sb;
    }

    private StringBuffer appendCondition(Session session, StringBuffer sb) {

        return condition == null ? sb.append("CONDITION[]\n")
                                 : sb.append("CONDITION[").append(
                                     condition.describe(session, 0)).append(
                                     "]\n");
    }

    public void resolve(Session session) {}

    public final boolean isCatalogLock() {
        return false;
    }

    public boolean isCatalogChange() {
        return false;
    }

    public void clearStructures(Session session) {
        session.sessionContext.clearStructures(this);
    }
}

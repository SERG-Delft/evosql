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

import org.hsqldb.ParserDQL.CompileContext;
import org.hsqldb.navigator.RowIterator;
import org.hsqldb.navigator.RowSetNavigator;
import org.hsqldb.navigator.RowSetNavigatorClient;
import org.hsqldb.navigator.RowSetNavigatorDataChange;
import org.hsqldb.navigator.RowSetNavigatorDataChangeMemory;
import org.hsqldb.persist.PersistentStore;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultConstants;
import org.hsqldb.types.Type;

/**
 * Implementation of Statement for INSERT statements.<p>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class StatementInsert extends StatementDML {

    static final int isNone            = 0;
    static final int isIgnore          = 1;
    static final int isReplace         = 2;
    static final int isUpdate          = 3;
    int              overrideUserValue = -1;
    int              specialAction     = isNone;

    /**
     * Instantiate this as an INSERT_VALUES statement.
     */
    StatementInsert(Session session, Table targetTable, int[] insertColumnMap,
                    Expression insertExpression, boolean[] insertCheckColumns,
                    Expression[] updateExpressions,
                    boolean[] updateCheckColumns, int[] updateColumnMap,
                    Expression[] targets, int specialAction,
                    CompileContext compileContext) {

        super(StatementTypes.INSERT, StatementTypes.X_SQL_DATA_CHANGE,
              session.getCurrentSchemaHsqlName());

        this.targetTable = targetTable;
        this.baseTable   = targetTable.isTriggerInsertable() ? targetTable
                                                             : targetTable
                                                             .getBaseTable();
        this.insertColumnMap    = insertColumnMap;
        this.insertCheckColumns = insertCheckColumns;
        this.insertExpression   = insertExpression;
        this.updateCheckColumns = updateCheckColumns;
        this.updateExpressions  = updateExpressions;
        this.updateColumnMap    = updateColumnMap;
        this.targets            = targets;
        this.specialAction      = specialAction;

        setupChecks();
        setDatabaseObjects(session, compileContext);
        checkAccessRights(session);

        isSimpleInsert = insertExpression != null
                         && insertExpression.nodes.length == 1
                         && updatableTableCheck == null
                         && specialAction == isNone;
    }

    /**
     * Instantiate this as an INSERT_SELECT statement.
     */
    StatementInsert(Session session, Table targetTable, int[] insertColumnMap,
                    boolean[] insertCheckColumns,
                    QueryExpression queryExpression,
                    Expression[] updateExpressions,
                    boolean[] updateCheckColumns, int[] updateColumnMap,
                    Expression[] targets, int specialAction, int override,
                    CompileContext compileContext) {

        super(StatementTypes.INSERT, StatementTypes.X_SQL_DATA_CHANGE,
              session.getCurrentSchemaHsqlName());

        this.targetTable = targetTable;
        this.baseTable   = targetTable.isTriggerInsertable() ? targetTable
                                                             : targetTable
                                                             .getBaseTable();
        this.insertColumnMap    = insertColumnMap;
        this.insertCheckColumns = insertCheckColumns;
        this.queryExpression    = queryExpression;
        this.overrideUserValue  = override;
        this.updateCheckColumns = updateCheckColumns;
        this.updateExpressions  = updateExpressions;
        this.updateColumnMap    = updateColumnMap;
        this.targets            = targets;
        this.specialAction      = specialAction;

        setupChecks();
        setDatabaseObjects(session, compileContext);
        checkAccessRights(session);
    }

    /**
     * Executes an INSERT_SELECT or INSERT_VALUES statement.  It is assumed that
     * the argument is of the correct type.
     *
     * @return the result of executing the statement
     */
    Result getResult(Session session) {

        Result          resultOut          = null;
        RowSetNavigator generatedNavigator = null;
        PersistentStore store              = baseTable.getRowStore(session);
        int             count              = 0;

        if (generatedIndexes != null) {
            resultOut = Result.newUpdateCountResult(generatedResultMetaData,
                    0);
            generatedNavigator = resultOut.getChainedResult().getNavigator();
        }

        if (isSimpleInsert) {
            Type[] colTypes = baseTable.getColumnTypes();
            Object[] data = getInsertData(session, colTypes,
                                          insertExpression.nodes[0].nodes);

            return insertSingleRow(session, store, data);
        }

        RowSetNavigator newDataNavigator = queryExpression == null
                                           ? getInsertValuesNavigator(session)
                                           : getInsertSelectNavigator(session);
        RowSetNavigatorDataChange changeNavigator = null;

        if (specialAction != StatementInsert.isNone) {
            while (newDataNavigator.hasNext()) {
                boolean  remove = false;
                Object[] data   = newDataNavigator.getNext();

                for (int i = 0, size = baseTable.constraintList.length;
                        i < size; i++) {
                    Constraint constraint = baseTable.constraintList[i];

                    if (constraint.isUniqueOrPK()) {
                        RowIterator it = constraint.findUniqueRows(session,
                            data);

                        while (it.hasNext()) {
                            remove = true;

                            if (specialAction == StatementInsert.isIgnore) {
                                break;
                            }

                            if (changeNavigator == null) {
                                changeNavigator =
                                    new RowSetNavigatorDataChangeMemory(
                                        session);
                            }

                            Row row = it.getNextRow();

                            if (constraint.core.mainIndex.compareRowNonUnique(
                                    session, row.getData(), data,
                                    constraint.core.mainCols) != 0) {
                                break;
                            }

                            changeNavigator.addRow(session, row, data,
                                                   baseTable.getColumnTypes(),
                                                   baseTable.defaultColumnMap);

                            count++;
                        }

                        it.release();
                    }
                }

                if (remove) {
                    newDataNavigator.removeCurrent();
                }
            }
        }

        if (specialAction == StatementInsert.isReplace
                && changeNavigator != null) {
            count = update(session, baseTable, changeNavigator, null);

            changeNavigator.endMainDataSet();
        } else if (specialAction == StatementInsert.isUpdate
                   && changeNavigator != null) {
            Type[] colTypes = baseTable.getColumnTypes();

            session.sessionContext.setRangeIterator(
                changeNavigator.getUpdateRowIterator());

            while (changeNavigator.next()) {
                session.sessionData.startRowProcessing();

                Row      row  = changeNavigator.getCurrentRow();
                Object[] data = row.getData();
                Object[] newData;

                newData = getUpdatedData(session, targets, baseTable,
                                         updateColumnMap, updateExpressions,
                                         colTypes, data);

                changeNavigator.addUpdate(row, newData, updateColumnMap);

                session.sessionContext.rownum++;
            }

            count = update(session, baseTable, changeNavigator, null);

            changeNavigator.endMainDataSet();
        }

        if (newDataNavigator.getSize() != 0) {
            insertRowSet(session, generatedNavigator, newDataNavigator);

            count += newDataNavigator.getSize();
        }

        if (baseTable.triggerLists[Trigger.INSERT_AFTER].length > 0) {
            baseTable.fireTriggers(session, Trigger.INSERT_AFTER,
                                   newDataNavigator);
        }

        if (resultOut == null) {
            resultOut = new Result(ResultConstants.UPDATECOUNT, count);
        } else {
            resultOut.setUpdateCount(count);
        }

        if (count == 0) {
            session.addWarning(HsqlException.noDataCondition);
        }

        session.sessionContext
            .diagnosticsVariables[ExpressionColumn.idx_row_count] =
                Integer.valueOf(count);

        return resultOut;
    }

    RowSetNavigator getInsertSelectNavigator(Session session) {

        Type[] colTypes  = baseTable.getColumnTypes();
        int[]  columnMap = insertColumnMap;

        //
        Result          result      = queryExpression.getResult(session, 0);
        RowSetNavigator nav         = result.initialiseNavigator();
        Type[]          sourceTypes = result.metaData.columnTypes;
        RowSetNavigatorClient newData =
            new RowSetNavigatorClient(nav.getSize());

        while (nav.hasNext()) {
            Object[] data       = baseTable.getNewRowData(session);
            Object[] sourceData = nav.getNext();

            for (int i = 0; i < columnMap.length; i++) {
                int j = columnMap[i];

                if (j == this.overrideUserValue) {
                    continue;
                }

                Type sourceType = sourceTypes[i];

                data[j] = colTypes[j].convertToType(session, sourceData[i],
                                                    sourceType);
            }

            newData.add(data);
        }

        return newData;
    }

    RowSetNavigator getInsertValuesNavigator(Session session) {

        Type[] colTypes = baseTable.getColumnTypes();

        //
        Expression[]          list    = insertExpression.nodes;
        RowSetNavigatorClient newData = new RowSetNavigatorClient(list.length);

        for (int j = 0; j < list.length; j++) {
            Expression[] rowArgs = list[j].nodes;
            Object[]     data    = getInsertData(session, colTypes, rowArgs);

            newData.add(data);
        }

        return newData;
    }
}

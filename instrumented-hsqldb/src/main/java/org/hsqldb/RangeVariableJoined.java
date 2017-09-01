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

import org.hsqldb.HsqlNameManager.SimpleName;
import org.hsqldb.ParserDQL.CompileContext;
import org.hsqldb.RangeVariable.RangeIteratorMain;
import org.hsqldb.index.Index;
import org.hsqldb.lib.HashMap;
import org.hsqldb.lib.HashSet;
import org.hsqldb.lib.HsqlArrayList;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.map.ValuePool;

/**
 * Metadata for range joined variables
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class RangeVariableJoined extends RangeVariable {

    RangeVariable[] rangeArray;

    public RangeVariableJoined(Table table, SimpleName alias,
                               OrderedHashSet columnList,
                               SimpleName[] columnNameList,
                               CompileContext compileContext) {

        super(table, alias, columnList, columnNameList, compileContext);

        setParameters();
    }

    private void setParameters() {

        namedJoinColumnExpressions = new HashMap();

        QuerySpecification qs =
            (QuerySpecification) this.rangeTable.getQueryExpression();

        this.rangeArray = qs.rangeVariables;

        for (int i = 0; i < rangeArray.length; i++) {
            if (rangeArray[i].isLeftJoin) {
                hasLeftJoin = true;
            }

            if (rangeArray[i].isRightJoin) {
                hasRightJoin = true;
            }

            if (rangeArray[i].isLateral) {
                hasLateral = true;
            }

            if (rangeArray[i].namedJoinColumnExpressions != null) {
                namedJoinColumnExpressions.putAll(
                    rangeArray[i].namedJoinColumnExpressions);
            }
        }
    }

    public RangeVariable[] getBaseRangeVariables() {
        return rangeArray;
    }

    public void setRangeTableVariables() {
        super.setRangeTableVariables();
    }

    public void setJoinType(boolean isLeft, boolean isRight) {
        super.setJoinType(isLeft, isRight);
    }

    public void addNamedJoinColumns(OrderedHashSet columns) {
        super.addNamedJoinColumns(columns);
    }

    public void addColumn(int columnIndex) {
        super.addColumn(columnIndex);
    }

    public void addAllColumns() {
        super.addAllColumns();
    }

    public void addNamedJoinColumnExpression(String name, Expression e,
            int position) {
        super.addNamedJoinColumnExpression(name, e, position);
    }

    public ExpressionColumn getColumnExpression(String name) {

        ExpressionColumn col = super.getColumnExpression(name);

        if (col == null) {
            col = rangeArray[0].getColumnExpression(name);
        }

        return col;
    }

    public Table getTable() {
        return super.getTable();
    }

    public boolean hasSingleIndexCondition() {
        return super.hasSingleIndexCondition();
    }

    public boolean setDistinctColumnsOnIndex(int[] colMap) {
        return super.setDistinctColumnsOnIndex(colMap);
    }

    /**
     * Used for sort
     */
    public Index getSortIndex() {
        return super.getSortIndex();
    }

    /**
     * Used for sort
     */
    public boolean setSortIndex(Index index, boolean reversed) {
        return super.setSortIndex(index, reversed);
    }

    public boolean reverseOrder() {
        return super.reverseOrder();
    }

    public OrderedHashSet getColumnNames() {
        return super.getColumnNames();
    }

    public OrderedHashSet getUniqueColumnNameSet() {
        return super.getUniqueColumnNameSet();
    }

    public int findColumn(String schemaName, String tableName,
                          String columnName) {

        if (tableAlias != null) {
            return super.findColumn(schemaName, tableName, columnName);
        }

        int count    = 0;
        int colIndex = -1;

        // this covers named column reference without tableName
        if (tableName == null
                && namedJoinColumnExpressions.containsKey(columnName)) {
            return super.findColumn(null, null, columnName);
        }

        for (int i = 0; i < rangeArray.length; i++) {
            RangeVariable currentRange = rangeArray[i];

            colIndex = currentRange.findColumn(schemaName, tableName,
                                               columnName);

            if (currentRange.namedJoinColumnCheck == null) {
                if (colIndex > -1) {
                    count += colIndex;
                } else {
                    count += currentRange.rangeTable.getColumnCount();
                }
            } else {
                int limit = colIndex > -1 ? colIndex
                                          : currentRange.namedJoinColumnCheck
                                              .length;

                for (int j = 0; j < limit; j++) {
                    if (!currentRange.namedJoinColumnCheck[j]) {
                        count++;
                    }
                }
            }

            if (colIndex > -1) {
                break;
            }
        }

        if (colIndex > -1) {
            if (namedJoinColumnExpressions != null) {
                count += namedJoinColumnExpressions.size();
            }

            return count;
        }

        return -1;
    }

    public SimpleName getColumnAlias(int i) {
        return super.getColumnAlias(i);
    }

    public boolean hasColumnAlias() {
        return super.hasColumnAlias();
    }

    public SimpleName getTableAlias() {
        return super.getTableAlias();
    }

    public RangeVariable getRangeForTableName(String name) {

        if (tableAlias != null) {
            return super.getRangeForTableName(name);
        }

        for (int i = 0; i < rangeArray.length; i++) {
            RangeVariable range = rangeArray[i].getRangeForTableName(name);

            if (range != null) {
                return range;
            }
        }

        return null;
    }

    /**
     * Add all columns to a list of expressions
     */
    public void addTableColumns(HsqlArrayList exprList) {
        super.addTableColumns(exprList);
    }

    /**
     * Add all columns to a list of expressions
     */
    public int addTableColumns(HsqlArrayList exprList, int position,
                               HashSet exclude) {
        return super.addTableColumns(exprList, position, exclude);
    }

    public void addTableColumns(RangeVariable subRange, Expression expression,
                                HashSet exclude) {

        int index = getFirstColumnIndex(subRange);

        addTableColumns(expression, index,
                        subRange.rangeTable.getColumnCount(), exclude);
    }

    protected int getFirstColumnIndex(RangeVariable subRange) {

        if (subRange == this) {
            return 0;
        }

        int count = 0;

        for (int i = 0; i < rangeArray.length; i++) {
            int index = rangeArray[i].getFirstColumnIndex(subRange);

            if (index == -1) {
                count += rangeArray[i].rangeTable.getColumnCount();
            } else {
                return count + index;
            }
        }

        return -1;
    }

    /**
     * Removes reference to Index to avoid possible memory leaks after alter
     * table or drop index
     */
    public void setForCheckConstraint() {
        super.setForCheckConstraint();
    }

    /**
     * used before condition processing
     */
    public Expression getJoinCondition() {
        return super.getJoinCondition();
    }

    public void addJoinCondition(Expression e) {
        super.addJoinCondition(e);
    }

    public void resetConditions() {
        super.resetConditions();
    }

    public void replaceColumnReference(RangeVariable range,
                                       Expression[] list) {}

    public void replaceRangeVariables(RangeVariable[] ranges,
                                      RangeVariable[] newRanges) {
        super.replaceRangeVariables(ranges, newRanges);
    }

    public void resolveRangeTable(Session session, RangeGroup rangeGroup,
                                  RangeGroup[] rangeGroups) {
        super.resolveRangeTable(session, rangeGroup, rangeGroups);
    }

    /**
     * Retrieves a String representation of this object. <p>
     *
     * The returned String describes this object's table, alias
     * access mode, index, join mode, Start, End and And conditions.
     *
     * @return a String representation of this object
     */
    public String describe(Session session, int blanks) {

        RangeVariableConditions[] conditionsArray = joinConditions;
        StringBuffer              sb;
        String b = ValuePool.spaceString.substring(0, blanks);

        sb = new StringBuffer();

        String temp = "INNER";

        if (isLeftJoin) {
            temp = "LEFT OUTER";

            if (isRightJoin) {
                temp = "FULL";
            }
        } else if (isRightJoin) {
            temp = "RIGHT OUTER";
        }

        sb.append(b).append("join type=").append(temp).append("\n");
        sb.append(b).append("table=").append(rangeTable.getName().name).append(
            "\n");

        if (tableAlias != null) {
            sb.append(b).append("alias=").append(tableAlias.name).append("\n");
        }

        boolean fullScan = !conditionsArray[0].hasIndexCondition();

        sb.append(b).append("access=").append(fullScan ? "FULL SCAN"
                                                       : "INDEX PRED").append(
                                                       "\n");

        for (int i = 0; i < conditionsArray.length; i++) {
            RangeVariableConditions conditions = this.joinConditions[i];

            if (i > 0) {
                sb.append(b).append("OR condition = [");
            } else {
                sb.append(b).append("condition = [");
            }

            sb.append(conditions.describe(session, blanks + 2));
            sb.append(b).append("]\n");
        }

        return sb.toString();
    }

    public RangeIteratorMain getIterator(Session session) {
        return super.getIterator(session);
    }
}

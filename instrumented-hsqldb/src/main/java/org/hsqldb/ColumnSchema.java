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
import org.hsqldb.RangeGroup.RangeGroupSimple;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.Iterator;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.rights.Grantee;
import org.hsqldb.types.Type;
import org.hsqldb.types.Types;

/**
 * Implementation of SQL table column metadata.<p>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class ColumnSchema extends ColumnBase implements SchemaObject {

    public static final ColumnSchema[] emptyArray = new ColumnSchema[]{};

    //
    private HsqlName       columnName;
    private boolean        isPrimaryKey;
    private Expression     defaultExpression;
    private Expression     generatingExpression;
    private Expression     updateExpression;
    private NumberSequence sequence;
    private OrderedHashSet references;
    private OrderedHashSet generatedColumnReferences;
    private Expression     accessor;

    ColumnSchema(HsqlName name, Type type) {
        this.columnName = name;
        this.dataType   = type;
    }

    /**
     * Creates a column defined in DDL statement.
     */
    public ColumnSchema(HsqlName name, Type type, boolean isNullable,
                        boolean isPrimaryKey, Expression defaultExpression) {

        columnName             = name;
        nullability = isNullable ? SchemaObject.Nullability.NULLABLE
                                 : SchemaObject.Nullability.NO_NULLS;
        this.dataType          = type;
        this.isPrimaryKey      = isPrimaryKey;
        this.defaultExpression = defaultExpression;

        setReferences();
    }

    public int getType() {
        return columnName.type;
    }

    public HsqlName getName() {
        return columnName;
    }

    public String getNameString() {
        return columnName.name;
    }

    public String getTableNameString() {
        return columnName.parent == null ? null
                                         : columnName.parent.name;
    }

    public HsqlName getSchemaName() {
        return columnName.schema;
    }

    public String getSchemaNameString() {
        return columnName.schema == null ? null
                                         : columnName.schema.name;
    }

    public HsqlName getCatalogName() {
        return columnName.schema == null ? null
                                         : columnName.schema.schema;
    }

    public String getCatalogNameString() {

        return columnName.schema == null ? null
                                         : columnName.schema.schema == null
                                           ? null
                                           : columnName.schema.schema.name;
    }

    public Grantee getOwner() {
        return columnName.schema == null ? null
                                         : columnName.schema.owner;
    }

    public OrderedHashSet getReferences() {
        return references;
    }

    public OrderedHashSet getComponents() {
        return null;
    }

    public void compile(Session session, SchemaObject table) {

        if (generatingExpression == null) {
            return;
        }

        generatingExpression.resetColumnReferences();
        generatingExpression.resolveCheckOrGenExpression(
            session,
            new RangeGroupSimple(((Table) table).getDefaultRanges(), false),
            false);

        if (!dataType.canBeAssignedFrom(generatingExpression.getDataType())) {
            throw Error.error(ErrorCode.X_42561);
        }

        setReferences();
    }

    public String getSQL() {

        StringBuffer sb = new StringBuffer();

        switch (parameterMode) {

            case SchemaObject.ParameterModes.PARAM_IN :
                sb.append(Tokens.T_IN).append(' ');
                break;

            case SchemaObject.ParameterModes.PARAM_OUT :
                sb.append(Tokens.T_OUT).append(' ');
                break;

            case SchemaObject.ParameterModes.PARAM_INOUT :
                sb.append(Tokens.T_INOUT).append(' ');
                break;

            default :
        }

        if (columnName != null) {
            sb.append(columnName.statementName);
            sb.append(' ');
        }

        sb.append(dataType.getTypeDefinition());

        return sb.toString();
    }

    public long getChangeTimestamp() {
        return 0;
    }

    public void setType(Type type) {

        this.dataType = type;

        setReferences();
    }

    public void setName(HsqlName name) {
        this.columnName = name;
    }

    void setIdentity(NumberSequence sequence) {
        this.sequence = sequence;
        isIdentity    = sequence != null;
    }

    void setType(ColumnSchema other) {
        nullability = other.nullability;
        dataType    = other.dataType;
    }

    public NumberSequence getIdentitySequence() {
        return sequence;
    }

    /**
     *  Is column nullable.
     *
     * @return boolean
     */
    public boolean isNullable() {

        boolean isNullable = super.isNullable();

        if (isNullable) {
            if (dataType.isDomainType()) {
                return dataType.userTypeModifier.isNullable();
            }
        }

        return isNullable;
    }

    public byte getNullability() {
        return isPrimaryKey ? SchemaObject.Nullability.NO_NULLS
                            : super.getNullability();
    }

    public boolean isGenerated() {
        return generatingExpression != null;
    }

    public boolean isAutoUpdate() {
        return updateExpression != null;
    }

    public boolean hasDefault() {
        return getDefaultExpression() != null;
    }

    public void setUpdateExpression(Expression updateExpression) {
        this.updateExpression = updateExpression;
    }

    public Expression getUpdateExpression() {
        return updateExpression;
    }
    /**
     * Is column writeable or always generated
     *
     * @return boolean
     */
    public boolean isWriteable() {
        return isWriteable;
    }

    public void setWriteable(boolean value) {
        isWriteable = value;
    }

    public boolean isSearchable() {
        return Types.isSearchable(dataType.typeCode);
    }

    /**
     *  Is this single column primary key of the table.
     *
     * @return boolean
     */
    public boolean isPrimaryKey() {
        return isPrimaryKey;
    }

    /**
     *  Set primary key.
     *
     */
    void setPrimaryKey(boolean value) {
        isPrimaryKey = value;
    }

    /**
     *  Returns default value in the session context.
     */
    public Object getDefaultValue(Session session) {

        return defaultExpression == null ? null
                                         : defaultExpression.getValue(session,
                                         dataType);
    }

    /**
     *  Returns generated value in the session context.
     */
    public Object getGeneratedValue(Session session) {

        return generatingExpression == null ? null
                                            : generatingExpression.getValue(
                                            session, dataType);
    }

    /**
     *  Returns SQL for default value.
     */
    public String getDefaultSQL() {

        String ddl = null;

        ddl = defaultExpression == null ? null
                                        : defaultExpression.getSQL();

        return ddl;
    }

    /**
     *  Returns default expression for the column.
     */
    Expression getDefaultExpression() {

        if (defaultExpression == null) {
            if (dataType.isDomainType()) {
                return dataType.userTypeModifier.getDefaultClause();
            }

            return null;
        } else {
            return defaultExpression;
        }
    }

    void setDefaultExpression(Expression expr) {
        defaultExpression = expr;
    }

    /**
     *  Returns generated expression for the column.
     */
    public Expression getGeneratingExpression() {
        return generatingExpression;
    }

    void setGeneratingExpression(Expression expr) {

        generatingExpression = expr;

        setWriteable(generatingExpression == null);
    }

    public ColumnSchema duplicate() {

        ColumnSchema copy = new ColumnSchema(columnName, dataType, true,
                                             isPrimaryKey, defaultExpression);

        copy.setNullability(this.nullability);
        copy.setGeneratingExpression(generatingExpression);
        copy.setIdentity(sequence);

        return copy;
    }

    public Expression getAccessor() {

        if (accessor == null) {
            accessor = new ExpressionColumnAccessor(this);
        }

        return accessor;
    }

    public OrderedHashSet getGeneratedColumnReferences() {
        return generatedColumnReferences;
    }

    private void setReferences() {

        if (references != null) {
            references.clear();
        }

        if (generatedColumnReferences != null) {
            generatedColumnReferences.clear();
        }

        if (dataType.isDomainType() || dataType.isDistinctType()) {
            HsqlName name = dataType.getName();

            if (references == null) {
                references = new OrderedHashSet();
            }

            references.add(name);
        }

        if (generatingExpression != null) {
            OrderedHashSet set = new OrderedHashSet();

            generatingExpression.collectObjectNames(set);

            Iterator it = set.iterator();

            while (it.hasNext()) {
                HsqlName name = (HsqlName) it.next();

                if (name.type == SchemaObject.COLUMN
                        || name.type == SchemaObject.TABLE) {
                    if (name.type == SchemaObject.COLUMN) {
                        if (generatedColumnReferences == null) {
                            generatedColumnReferences = new OrderedHashSet();
                        }

                        generatedColumnReferences.add(name);
                    }
                } else {
                    if (references == null) {
                        references = new OrderedHashSet();
                    }

                    references.add(name);
                }
            }
        }
    }
}

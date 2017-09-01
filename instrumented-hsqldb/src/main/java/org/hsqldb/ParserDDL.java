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

import java.lang.reflect.Method;

import org.hsqldb.HsqlNameManager.HsqlName;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.index.Index;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.HsqlArrayList;
import org.hsqldb.lib.HsqlList;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.lib.OrderedIntHashSet;
import org.hsqldb.map.ValuePool;
import org.hsqldb.rights.Grantee;
import org.hsqldb.rights.GranteeManager;
import org.hsqldb.rights.Right;
import org.hsqldb.rights.User;
import org.hsqldb.types.Charset;
import org.hsqldb.types.Collation;
import org.hsqldb.types.Type;
import org.hsqldb.types.UserTypeModifier;

/**
 * Parser for DDL statements
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class ParserDDL extends ParserRoutine {

    static final int[]   schemaCommands             = new int[] {
        Tokens.CREATE, Tokens.GRANT
    };
    static final short[] startStatementTokens       = new short[] {
        Tokens.CREATE, Tokens.GRANT, Tokens.ALTER, Tokens.DROP
    };
    static final short[] startStatementTokensSchema = new short[] {
        Tokens.CREATE, Tokens.GRANT,
    };

    ParserDDL(Session session, Scanner scanner) {
        super(session, scanner);
    }

    void reset(Session session, String sql) {
        super.reset(session, sql);
    }

    StatementSchema compileCreate() {

        int     tableType;
        boolean isTable     = false;
        boolean isOrReplace = false;

        read();

        switch (token.tokenType) {

            case Tokens.GLOBAL :
                read();
                readThis(Tokens.TEMPORARY);
                readIfThis(Tokens.MEMORY);
                readThis(Tokens.TABLE);

                isTable   = true;
                tableType = TableBase.TEMP_TABLE;
                break;

            case Tokens.TEMP :
                read();
                readThis(Tokens.TABLE);

                isTable   = true;
                tableType = TableBase.TEMP_TABLE;
                break;

            case Tokens.TEMPORARY :
                read();
                readThis(Tokens.TABLE);

                isTable   = true;
                tableType = TableBase.TEMP_TABLE;
                break;

            case Tokens.MEMORY :
                read();
                readThis(Tokens.TABLE);

                isTable   = true;
                tableType = TableBase.MEMORY_TABLE;
                break;

            case Tokens.CACHED :
                read();
                readThis(Tokens.TABLE);

                isTable   = true;
                tableType = TableBase.CACHED_TABLE;
                break;

            case Tokens.TEXT :
                read();
                readThis(Tokens.TABLE);

                isTable   = true;
                tableType = TableBase.TEXT_TABLE;
                break;

            case Tokens.TABLE :
                read();

                isTable   = true;
                tableType = database.schemaManager.getDefaultTableType();
                break;

            default :
                tableType = TableBase.MEMORY_TABLE;
        }

        if (isTable) {
            return compileCreateTable(tableType);
        }

        if (database.sqlSyntaxOra) {
            if (token.tokenType == Tokens.OR) {
                read();
                readThis(Tokens.REPLACE);

                switch (token.tokenType) {

                    case Tokens.FUNCTION :
                    case Tokens.PROCEDURE :
                    case Tokens.TRIGGER :
                    case Tokens.TYPE :
                    case Tokens.VIEW :
                    case Tokens.SYNONYM :
                        break;

                    default :
                        throw unexpectedToken(Tokens.T_OR);
                }

                isOrReplace = true;
            }
        }

        switch (token.tokenType) {

            // other objects
            case Tokens.ALIAS :
                return compileCreateAlias();

            case Tokens.SEQUENCE :
                return compileCreateSequence();

            case Tokens.SCHEMA :
                return compileCreateSchema();

            case Tokens.TRIGGER :
                return compileCreateTrigger(isOrReplace);

            case Tokens.USER :
                return compileCreateUser();

            case Tokens.ROLE :
                return compileCreateRole();

            case Tokens.VIEW :
                return compileCreateView(false, isOrReplace);

            case Tokens.DOMAIN :
                return compileCreateDomain();

            case Tokens.TYPE :
                return compileCreateType(isOrReplace);

            case Tokens.CHARACTER :
                return compileCreateCharacterSet();

            case Tokens.COLLATION :
                return compileCreateCollation();

            // index
            case Tokens.UNIQUE :
                read();
                checkIsThis(Tokens.INDEX);

                return compileCreateIndex(true);

            case Tokens.INDEX :
                return compileCreateIndex(false);

            case Tokens.AGGREGATE :
                return compileCreateProcedureOrFunction(isOrReplace);

            case Tokens.FUNCTION :
            case Tokens.PROCEDURE :
                return compileCreateProcedureOrFunction(isOrReplace);

            case Tokens.SYNONYM :
                return compileCreateSynonym(isOrReplace);

            default : {
                throw unexpectedToken();
            }
        }
    }

    Statement compileAlter() {

        read();

        switch (token.tokenType) {

            case Tokens.INDEX : {
                read();

                HsqlName name = readNewSchemaObjectName(SchemaObject.INDEX,
                    true);

                name.setSchemaIfNull(session.getCurrentSchemaHsqlName());

                if (token.tokenType == Tokens.RENAME) {
                    read();
                    readThis(Tokens.TO);

                    return compileRenameObject(name, SchemaObject.INDEX);
                }

                readThis(Tokens.AS);

                Index index =
                    (Index) database.schemaManager.getSchemaObject(name);

                if (index == null) {
                    throw Error.error(ErrorCode.X_42501);
                }

                Table table = (Table) database.schemaManager.getSchemaObject(
                    index.getName().parent);
                int[]      indexColumns   = readColumnList(table, true);
                String     sql            = getLastPart();
                Object[]   args           = new Object[] {
                    table, indexColumns, index.getName()
                };
                HsqlName[] writeLockNames = new HsqlName[] {
                    database.getCatalogName(), table.getName()
                };

                return new StatementSchema(sql, StatementTypes.ALTER_INDEX,
                                           args, null, writeLockNames);
            }
            case Tokens.SCHEMA : {
                read();

                HsqlName name = readSchemaName();

                readThis(Tokens.RENAME);
                readThis(Tokens.TO);

                return compileRenameObject(name, SchemaObject.SCHEMA);
            }
            case Tokens.CATALOG : {
                read();
                checkIsSimpleName();

                String name = token.tokenString;

                checkValidCatalogName(name);
                read();
                readThis(Tokens.RENAME);
                readThis(Tokens.TO);

                return compileRenameObject(database.getCatalogName(),
                                           SchemaObject.CATALOG);
            }
            case Tokens.SEQUENCE : {
                return compileAlterSequence();
            }
            case Tokens.TABLE : {
                return compileAlterTable();
            }
            case Tokens.USER : {
                return compileAlterUser();
            }
            case Tokens.DOMAIN : {
                return compileAlterDomain();
            }
            case Tokens.VIEW : {
                return compileCreateView(true, false);
            }
            case Tokens.SESSION : {
                return compileAlterSession();
            }
            case Tokens.SPECIFIC : {
                return compileAlterSpecificRoutine();
            }
            case Tokens.ROUTINE : {
                return compileAlterRoutine();
            }
            case Tokens.CONSTRAINT : {
                read();

                Constraint constraint =
                    (Constraint) readSchemaObjectName(SchemaObject.CONSTRAINT);

                readThis(Tokens.RENAME);
                readThis(Tokens.TO);

                return compileRenameObject(constraint.getName(),
                                           SchemaObject.CONSTRAINT);
            }
            default : {
                throw unexpectedToken();
            }
        }
    }

    Statement compileAlterRoutine() {

        readThis(Tokens.ROUTINE);

        RoutineSchema routine =
            (RoutineSchema) readSchemaObjectName(SchemaObject.ROUTINE);

        readThis(Tokens.RENAME);
        readThis(Tokens.TO);

        return compileRenameObject(routine.getName(), routine.getName().type);
    }

    Statement compileDrop() {

        int          objectTokenType;
        int          objectType;
        int          statementType;
        boolean      canCascade  = false;
        boolean      cascade     = false;
        boolean      useIfExists = false;
        boolean      ifExists    = false;
        SchemaObject object;
        HsqlName[]   writeLockNames;

        read();

        objectTokenType = token.tokenType;

        switch (objectTokenType) {

            case Tokens.INDEX : {
                read();

                statementType = StatementTypes.DROP_INDEX;
                objectType    = SchemaObject.INDEX;
                useIfExists   = true;

                break;
            }
            case Tokens.ASSERTION : {
                read();

                statementType = StatementTypes.DROP_ASSERTION;
                objectType    = SchemaObject.ASSERTION;
                canCascade    = true;

                break;
            }
            case Tokens.SPECIFIC : {
                read();

                switch (token.tokenType) {

                    case Tokens.ROUTINE :
                    case Tokens.PROCEDURE :
                    case Tokens.FUNCTION :
                        read();
                        break;

                    default :
                        throw unexpectedToken();
                }

                statementType = StatementTypes.DROP_ROUTINE;
                objectType    = SchemaObject.SPECIFIC_ROUTINE;
                canCascade    = true;
                useIfExists   = true;

                break;
            }
            case Tokens.PROCEDURE : {
                read();

                statementType = StatementTypes.DROP_ROUTINE;
                objectType    = SchemaObject.PROCEDURE;
                canCascade    = true;
                useIfExists   = true;

                break;
            }
            case Tokens.FUNCTION : {
                read();

                statementType = StatementTypes.DROP_ROUTINE;
                objectType    = SchemaObject.FUNCTION;
                canCascade    = true;
                useIfExists   = true;

                break;
            }
            case Tokens.SCHEMA : {
                read();

                statementType = StatementTypes.DROP_SCHEMA;
                objectType    = SchemaObject.SCHEMA;
                canCascade    = true;
                useIfExists   = true;

                break;
            }
            case Tokens.SEQUENCE : {
                read();

                statementType = StatementTypes.DROP_SEQUENCE;
                objectType    = SchemaObject.SEQUENCE;
                canCascade    = true;
                useIfExists   = true;

                break;
            }
            case Tokens.TRIGGER : {
                read();

                statementType = StatementTypes.DROP_TRIGGER;
                objectType    = SchemaObject.TRIGGER;
                canCascade    = false;
                useIfExists   = true;

                break;
            }
            case Tokens.USER : {
                read();

                statementType = StatementTypes.DROP_USER;
                objectType    = SchemaObject.GRANTEE;
                canCascade    = true;

                break;
            }
            case Tokens.ROLE : {
                read();

                statementType = StatementTypes.DROP_ROLE;
                objectType    = SchemaObject.GRANTEE;
                canCascade    = true;

                break;
            }
            case Tokens.DOMAIN :
                read();

                statementType = StatementTypes.DROP_DOMAIN;
                objectType    = SchemaObject.DOMAIN;
                canCascade    = true;
                useIfExists   = true;
                break;

            case Tokens.TYPE :
                read();

                statementType = StatementTypes.DROP_TYPE;
                objectType    = SchemaObject.TYPE;
                canCascade    = true;
                useIfExists   = true;
                break;

            case Tokens.CHARACTER :
                read();
                readThis(Tokens.SET);

                statementType = StatementTypes.DROP_CHARACTER_SET;
                objectType    = SchemaObject.CHARSET;
                canCascade    = false;
                useIfExists   = true;
                break;

            case Tokens.COLLATION :
                read();

                statementType = StatementTypes.DROP_COLLATION;
                objectType    = SchemaObject.COLLATION;
                canCascade    = false;
                useIfExists   = true;
                break;

            case Tokens.VIEW :
                read();

                statementType = StatementTypes.DROP_VIEW;
                objectType    = SchemaObject.VIEW;
                canCascade    = true;
                useIfExists   = true;
                break;

            case Tokens.TABLE :
                read();

                statementType = StatementTypes.DROP_TABLE;
                objectType    = SchemaObject.TABLE;
                canCascade    = true;
                useIfExists   = true;
                break;

            case Tokens.SYNONYM :
                read();

                statementType = StatementTypes.DROP_REFERENCE;
                objectType    = SchemaObject.REFERENCE;
                canCascade    = false;
                useIfExists   = true;
                break;

            default :
                throw unexpectedToken();
        }

        if (useIfExists && token.tokenType == Tokens.IF) {
            int position = getPosition();

            read();

            if (token.tokenType == Tokens.EXISTS) {
                read();

                ifExists = true;
            } else {
                rewind(position);
            }
        }

        checkIsIdentifier();

        HsqlName name = null;

        switch (objectTokenType) {

            case Tokens.USER : {
                checkIsSimpleName();
                checkDatabaseUpdateAuthorisation();

                object = database.getUserManager().get(token.tokenString);

                read();

                break;
            }
            case Tokens.ROLE : {
                checkIsSimpleName();
                checkDatabaseUpdateAuthorisation();

                object =
                    database.getGranteeManager().getRole(token.tokenString);

                read();

                break;
            }
            case Tokens.SCHEMA : {
                name   = readNewSchemaName();
                object = database.schemaManager.findSchema(name.name);

                break;
            }
            case Tokens.TABLE : {
                boolean isModule =
                    token.namePrePrefix == null
                    && (Tokens.T_MODULE.equals(token.namePrefix)
                        || Tokens.T_SESSION.equals(token.namePrefix));

                if (isModule) {
                    name = readNewSchemaObjectName(objectType, false);

                    if (!ifExists && token.tokenType == Tokens.IF) {
                        read();
                        readThis(Tokens.EXISTS);

                        ifExists = true;
                    }

                    Object[] args = new Object[] {
                        name, Boolean.valueOf(ifExists)
                    };

                    return new StatementSession(StatementTypes.DROP_TABLE,
                                                args);
                }
            }

            // fall through
            default :
                name = readNewSchemaObjectName(objectType, false);

                name.setSchemaIfNull(session.getCurrentSchemaHsqlName());

                object = database.schemaManager.findSchemaObject(name.name,
                        name.schema.name, name.type);
        }

        if (!ifExists && useIfExists && token.tokenType == Tokens.IF) {
            read();
            readThis(Tokens.EXISTS);

            ifExists = true;
        }

        if (canCascade) {
            if (token.tokenType == Tokens.CASCADE) {
                cascade = true;

                read();

                if (database.sqlSyntaxOra) {
                    readIfThis(Tokens.CONSTRAINTS);
                }
            } else if (token.tokenType == Tokens.RESTRICT) {
                read();
            }
        }

        if (object == null) {
            writeLockNames = null;
        } else {
            name = object.getName();
            writeLockNames =
                database.schemaManager.getCatalogAndBaseTableNames(name);
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            name, Integer.valueOf(objectType), Boolean.valueOf(cascade),
            Boolean.valueOf(ifExists)
        };
        Statement cs = new StatementSchema(sql, statementType, args, null,
                                           writeLockNames);

        return cs;
    }

    Statement compileAlterTable() {

        read();

        String   tableName = token.tokenString;
        HsqlName schema    = session.getSchemaHsqlName(token.namePrefix);

        checkSchemaUpdateAuthorisation(schema);

        Table t = database.schemaManager.getUserTable(tableName, schema.name);

        read();

        switch (token.tokenType) {

            case Tokens.RENAME : {
                read();

                if (database.sqlSyntaxPgs) {
                    if (token.tokenType == Tokens.COLUMN) {
                        read();
                        checkIsIdentifier();

                        int columnIndex = t.getColumnIndex(token.tokenString);
                        ColumnSchema column = t.getColumn(columnIndex);

                        read();
                        readThis(Tokens.TO);

                        return compileAlterColumnRename(t, column);
                    }
                }

                readThis(Tokens.TO);

                return compileRenameObject(t.getName(), SchemaObject.TABLE);
            }
            case Tokens.ADD : {
                read();

                HsqlName cname       = null;
                Boolean  ifNotExists = Boolean.FALSE;

                if (token.tokenType == Tokens.CONSTRAINT) {
                    read();

                    ifNotExists = readIfNotExists();
                    cname = readNewDependentSchemaObjectName(t.getName(),
                            SchemaObject.CONSTRAINT);
                }

                switch (token.tokenType) {

                    case Tokens.FOREIGN :
                        read();
                        readThis(Tokens.KEY);

                        return compileAlterTableAddForeignKeyConstraint(t,
                                cname, ifNotExists);

                    case Tokens.UNIQUE :
                        read();

                        if (database.sqlSyntaxMys) {
                            if (!readIfThis(Tokens.INDEX)) {
                                readIfThis(Tokens.KEY);
                            }
                        }

                        return compileAlterTableAddUniqueConstraint(t, cname,
                                ifNotExists);

                    case Tokens.CHECK :
                        read();

                        return compileAlterTableAddCheckConstraint(t, cname,
                                ifNotExists);

                    case Tokens.PRIMARY :
                        read();
                        readThis(Tokens.KEY);

                        return compileAlterTableAddPrimaryKey(t, cname,
                                                              ifNotExists);

                    case Tokens.COLUMN :
                        if (cname != null) {
                            throw unexpectedToken();
                        }

                        read();
                        checkIsSimpleName();

                        return compileAlterTableAddColumn(t);

                    default :
                        if (cname != null) {
                            throw unexpectedToken();
                        }

                        checkIsSimpleName();

                        return compileAlterTableAddColumn(t);
                }
            }
            case Tokens.DROP : {
                read();

                switch (token.tokenType) {

                    case Tokens.PRIMARY : {
                        read();
                        readThis(Tokens.KEY);

                        return compileAlterTableDropPrimaryKey(t);
                    }
                    case Tokens.CONSTRAINT : {
                        read();

                        return compileAlterTableDropConstraint(t);
                    }
                    case Tokens.COLUMN :
                        read();

                    // fall through
                    default : {
                        checkIsSimpleName();

                        String  name    = token.tokenString;
                        boolean cascade = false;

                        read();

                        if (token.tokenType == Tokens.RESTRICT) {
                            read();
                        } else if (token.tokenType == Tokens.CASCADE) {
                            read();

                            cascade = true;
                        }

                        return compileAlterTableDropColumn(t, name, cascade);
                    }
                }
            }
            case Tokens.ALTER : {
                read();

                if (token.tokenType == Tokens.COLUMN) {
                    read();
                }

                int          columnIndex = t.getColumnIndex(token.tokenString);
                ColumnSchema column      = t.getColumn(columnIndex);

                read();

                return compileAlterColumn(t, column, columnIndex);
            }
            default : {
                throw unexpectedToken();
            }
        }
    }

    private Statement compileAlterTableDropConstraint(Table table) {

        boolean cascade = false;
        SchemaObject object = readSchemaObjectName(table.getSchemaName(),
            SchemaObject.CONSTRAINT);

        if (token.tokenType == Tokens.RESTRICT) {
            read();
        } else if (token.tokenType == Tokens.CASCADE) {
            read();

            cascade = true;
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            object.getName(), ValuePool.getInt(SchemaObject.CONSTRAINT),
            Boolean.valueOf(cascade), Boolean.FALSE
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());
        HsqlName mainTableName = ((Constraint) object).getMainTableName();

        if (mainTableName != null && mainTableName != table.getName()) {
            writeLockNames =
                (HsqlName[]) ArrayUtil.toAdjustedArray(writeLockNames,
                    mainTableName, writeLockNames.length, 1);
        }

        Statement cs = new StatementSchema(sql,
                                           StatementTypes.DROP_CONSTRAINT,
                                           args, null, writeLockNames);

        return cs;
    }

    private Statement compileAlterTableDropPrimaryKey(Table table) {

        boolean cascade = false;

        if (token.tokenType == Tokens.RESTRICT) {
            read();
        } else if (token.tokenType == Tokens.CASCADE) {
            read();

            cascade = true;
        }

        if (!table.hasPrimaryKey()) {
            throw Error.error(ErrorCode.X_42501);
        }

        String       sql    = getLastPart();
        SchemaObject object = table.getPrimaryConstraint();
        Object[]     args   = new Object[] {
            object.getName(), ValuePool.getInt(SchemaObject.CONSTRAINT),
            Boolean.valueOf(cascade), Boolean.FALSE
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());
        Statement cs = new StatementSchema(sql,
                                           StatementTypes.DROP_CONSTRAINT,
                                           args, null, writeLockNames);

        return cs;
    }

    StatementSession compileDeclareLocalTableOrNull() {

        int position = getPosition();

        try {
            readThis(Tokens.DECLARE);
            readThis(Tokens.LOCAL);
            readThis(Tokens.TEMPORARY);
            readThis(Tokens.TABLE);
        } catch (HsqlException e) {
            lastError = e;

            // may be cursor
            rewind(position);

            return null;
        }

        if (token.namePrePrefix == null
                && (token.namePrefix == null
                    || Tokens.T_MODULE.equals(token.namePrefix)
                    || Tokens.T_SESSION.equals(token.namePrefix))) {

            // valid name
        } else {
            throw unexpectedToken();
        }

        boolean  ifNot = readIfNotExists();
        HsqlName name  = readNewSchemaObjectName(SchemaObject.TABLE, false);

        name.schema = SqlInvariants.MODULE_HSQLNAME;

        Table table = new Table(database, name, TableBase.TEMP_TABLE);
        StatementSchema cs;

        if (token.tokenType == Tokens.AS) {
            cs = compileCreateTableAsSubqueryDefinition(table);
        } else {
            cs = compileCreateTableBody(table, ifNot);

            HsqlArrayList constraints = (HsqlArrayList) cs.arguments[1];

            for (int i = 0; i < constraints.size(); i++) {
                Constraint c = (Constraint) constraints.get(i);

                if (c.getConstraintType()
                        == SchemaObject.ConstraintTypes.FOREIGN_KEY) {
                    throw unexpectedToken(Tokens.T_FOREIGN);
                }
            }
        }

        StatementSession ss =
            new StatementSession(StatementTypes.DECLARE_SESSION_TABLE,
                                 cs.arguments);

        return ss;
    }

    StatementSchema compileCreateView(boolean alter, boolean orReplace) {

        read();

        Boolean ifNotExists = Boolean.FALSE;

        if (!alter) {
            ifNotExists = readIfNotExists();
        }

        HsqlName name = readNewSchemaObjectName(SchemaObject.VIEW, true);

        name.setSchemaIfNull(session.getCurrentSchemaHsqlName());
        checkSchemaUpdateAuthorisation(name.schema);

        HsqlName[] colList = null;

        if (token.tokenType == Tokens.OPENBRACKET) {
            try {
                colList = readColumnNames(name);
            } catch (HsqlException e) {
                if (session.isProcessingScript()
                        && database.getProperties().isVersion18()) {
                    while (token.tokenType != Tokens.AS) {
                        read();
                    }
                } else {
                    throw e;
                }
            }
        }

        readThis(Tokens.AS);
        startRecording();

        QueryExpression queryExpression;

        try {
            isViewDefinition = true;
            queryExpression  = XreadQueryExpression();
        } catch (HsqlException e) {
            queryExpression = XreadJoinedTableAsView();
        } finally {
            isViewDefinition = false;
        }

        Token[] tokenisedStatement = getRecordedStatement();
        int     check              = SchemaObject.ViewCheckModes.CHECK_NONE;

        if (token.tokenType == Tokens.WITH) {
            read();

            check = SchemaObject.ViewCheckModes.CHECK_CASCADE;

            if (readIfThis(Tokens.LOCAL)) {
                check = SchemaObject.ViewCheckModes.CHECK_LOCAL;
            } else {
                readIfThis(Tokens.CASCADED);
            }

            readThis(Tokens.CHECK);
            readThis(Tokens.OPTION);
        }

        View view = new View(database, name, colList, check);

        queryExpression.setView(view);
        queryExpression.resolve(session);
        view.setStatement(Token.getSQL(tokenisedStatement));

        StatementQuery s = new StatementQuery(session, queryExpression,
                                              compileContext);
        String     fullSQL        = getLastPart();
        Object[]   args           = new Object[] {
            view, ifNotExists
        };
        int        type           = alter ? StatementTypes.ALTER_VIEW
                                          : StatementTypes.CREATE_VIEW;
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(fullSQL, type, args, s.readTableNames,
                                   writeLockNames);
    }

    StatementSchema compileCreateSequence() {

        read();

        Boolean ifNotExists = readIfNotExists();
        /*
                CREATE SEQUENCE <name>
                [AS {INTEGER | BIGINT}]
                [START WITH <value>]
                [INCREMENT BY <value>]
        */
        HsqlName name = readNewSchemaObjectName(SchemaObject.SEQUENCE, false);
        NumberSequence sequence = new NumberSequence(name, Type.SQL_INTEGER);

        readSequenceOptions(sequence, true, false, false);

        String     sql            = getLastPart();
        Object[]   args           = new Object[] {
            sequence, ifNotExists
        };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_SEQUENCE, args,
                                   null, writeLockNames);
    }

    StatementSchema compileCreateDomain() {

        UserTypeModifier userTypeModifier = null;
        HsqlName         name;

        read();

        name = readNewSchemaObjectName(SchemaObject.DOMAIN, false);

        readIfThis(Tokens.AS);

        Type       type          = readTypeDefinition(true, false).duplicate();
        Expression defaultClause = null;

        if (readIfThis(Tokens.DEFAULT)) {
            defaultClause = readDefaultClause(type);
        }

        userTypeModifier = new UserTypeModifier(name, SchemaObject.DOMAIN,
                type);

        userTypeModifier.setDefaultClause(defaultClause);

        type.userTypeModifier = userTypeModifier;

        HsqlArrayList tempConstraints = new HsqlArrayList();

        compileContext.currentDomain = type;

        while (true) {
            boolean end = false;

            switch (token.tokenType) {

                case Tokens.CONSTRAINT :
                case Tokens.CHECK :
                    readConstraint(type, tempConstraints);
                    break;

                default :
                    end = true;
                    break;
            }

            if (end) {
                break;
            }
        }

        compileContext.currentDomain = null;

        for (int i = 0; i < tempConstraints.size(); i++) {
            Constraint c = (Constraint) tempConstraints.get(i);

            c.prepareCheckConstraint(session, null);
            userTypeModifier.addConstraint(c);
        }

        String     sql            = getLastPart();
        Object[]   args           = new Object[]{ type };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_DOMAIN, args,
                                   null, writeLockNames);
    }

    StatementSchema compileCreateType(boolean orReplace) {

        read();

        HsqlName name = readNewSchemaObjectName(SchemaObject.TYPE, false);

        readThis(Tokens.AS);

        Type type = readTypeDefinition(true, false).duplicate();

        readIfThis(Tokens.FINAL);

        UserTypeModifier userTypeModifier = new UserTypeModifier(name,
            SchemaObject.TYPE, type);

        type.userTypeModifier = userTypeModifier;

        String     sql            = getLastPart();
        Object[]   args           = new Object[]{ type };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_TYPE, args,
                                   null, writeLockNames);
    }

    StatementSchema compileCreateCharacterSet() {

        read();
        readThis(Tokens.SET);

        HsqlName name = readNewSchemaObjectName(SchemaObject.CHARSET, false);

        readIfThis(Tokens.AS);
        readThis(Tokens.GET);

        String schema = token.namePrefix;
        Charset source =
            (Charset) database.schemaManager.getCharacterSet(session,
                token.tokenString, schema);

        read();

        if (token.tokenType == Tokens.COLLATION) {
            read();
            readThis(Tokens.FROM);
            readThis(Tokens.DEFAULT);
        }

        Charset charset = new Charset(name);

        charset.base = source.getName();

        String     sql            = getLastPart();
        Object[]   args           = new Object[]{ charset };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_CHARACTER_SET,
                                   args, null, writeLockNames);
    }

    StatementSchema compileCreateCollation() {

        read();

        HsqlName name = readNewSchemaObjectName(SchemaObject.COLLATION, false);

        name.setSchemaIfNull(session.getCurrentSchemaHsqlName());
        readThis(Tokens.FOR);

        HsqlName charsetName = readNewSchemaObjectName(SchemaObject.CHARSET,
            false);

        readThis(Tokens.FROM);

        HsqlName sourceName = readNewSchemaObjectName(SchemaObject.COLLATION,
            false);
        Boolean padSpace = null;

        if (readIfThis(Tokens.NO)) {
            readThis(Tokens.PAD);

            padSpace = Boolean.FALSE;
        } else if (readIfThis(Tokens.PAD)) {
            readThis(Tokens.SPACE);

            padSpace = Boolean.TRUE;
        }

        String schemaName = charsetName.schema == null ? null
                                                       : charsetName.schema
                                                           .name;
        Charset charset =
            (Charset) database.schemaManager.getCharacterSet(session,
                charsetName.name, schemaName);

        if (charset == null) {
            throw Error.error(ErrorCode.X_42501,
                              charsetName.getSchemaQualifiedStatementName());
        }

        schemaName = sourceName.schema == null ? null
                                               : sourceName.schema.name;

        Collation source = database.schemaManager.getCollation(session,
            sourceName.name, schemaName);
        Collation  collation = new Collation(name, source, charset, padSpace);
        String     sql            = getLastPart();
        Object[]   args           = new Object[]{ collation };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_COLLATION, args,
                                   null, writeLockNames);
    }

    StatementSchema compileCreateAlias() {

        HsqlName  name     = null;
        Routine[] routines = null;
        String    alias;
        String    methodFQN = null;

        if (!session.isProcessingScript()) {
            throw unsupportedFeature();
        }

        read();

        try {
            alias = token.tokenString;

            read();
            readThis(Tokens.FOR);

            methodFQN = token.tokenString;

            read();
        } catch (HsqlException e) {
            alias = null;
        }

        if (alias != null) {
            HsqlName schema =
                database.schemaManager.getDefaultSchemaHsqlName();

            name = database.nameManager.newHsqlName(schema, alias,
                    SchemaObject.FUNCTION);

            Method[] methods = Routine.getMethods(methodFQN);

            routines = Routine.newRoutines(session, methods);
        }

        String     sql            = getLastPart();
        Object[]   args           = new Object[] {
            name, routines
        };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_ALIAS, args,
                                   null, writeLockNames);
    }

    StatementSchema compileCreateIndex(boolean unique) {

        Table    table;
        HsqlName indexHsqlName;

        read();

        Boolean ifNotExists = readIfNotExists();

        indexHsqlName = readNewSchemaObjectName(SchemaObject.INDEX, true);

        if (database.sqlSyntaxMys) {
            if (readIfThis(Tokens.USING)) {
                if (!readIfThis("HASH")) {
                    readThis("BTREE");
                }
            }
        }

        readThis(Tokens.ON);

        table = readTableName();

        HsqlName tableSchema = table.getSchemaName();

        indexHsqlName.setSchemaIfNull(tableSchema);

        indexHsqlName.parent = table.getName();

        if (indexHsqlName.schema != tableSchema) {
            throw Error.error(ErrorCode.X_42505);
        }

        indexHsqlName.schema = table.getSchemaName();

        int[] indexColumns = readColumnList(table, true);

        if (database.sqlSyntaxMys) {
            if (readIfThis(Tokens.USING)) {
                if (!readIfThis("HASH")) {
                    readThis("BTREE");
                }
            }

            if (readIfThis(Tokens.COMMENT)) {
                String comment = readQuotedString();

                indexHsqlName.comment = comment;
            }
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            table, indexColumns, indexHsqlName, Boolean.valueOf(unique), null,
            ifNotExists
        };

        return new StatementSchema(sql, StatementTypes.CREATE_INDEX, args,
                                   null, new HsqlName[] {
            database.getCatalogName(), table.getName()
        });
    }

    StatementSchema compileCreateSchema() {

        HsqlName schemaName       = null;
        String   authorisation    = null;
        HsqlName characterSetName = null;

        read();

        if (token.tokenType != Tokens.AUTHORIZATION) {
            schemaName = readNewSchemaName();
        }

        if (token.tokenType == Tokens.AUTHORIZATION) {
            read();
            checkIsSimpleName();

            authorisation = token.tokenString;

            read();

            if (schemaName == null) {
                Grantee owner =
                    database.getGranteeManager().get(authorisation);

                if (owner == null) {
                    throw Error.error(ErrorCode.X_28501, authorisation);
                }

                schemaName =
                    database.nameManager.newHsqlName(owner.getName().name,
                                                     isDelimitedIdentifier(),
                                                     SchemaObject.SCHEMA);

                SqlInvariants.checkSchemaNameNotSystem(token.tokenString);
            }
        }

        if (SqlInvariants.PUBLIC_ROLE_NAME.equals(authorisation)) {
            throw Error.error(ErrorCode.X_28502, authorisation);
        }

        Grantee owner = authorisation == null ? session.getGrantee()
                                              : database.getGranteeManager()
                                                  .get(authorisation);

        if (owner == null) {
            throw Error.error(ErrorCode.X_28501, authorisation);
        }

        if (!session.getGrantee().isSchemaCreator()) {
            throw Error.error(ErrorCode.X_0L501,
                              session.getGrantee().getName().getNameString());
        }

        if (owner instanceof User && ((User) owner).isExternalOnly) {
            throw Error.error(ErrorCode.X_0L000,
                              session.getGrantee().getName().getNameString());
        }

        if (database.schemaManager.schemaExists(schemaName.name)) {
            if (session.isProcessingScript()
                    && SqlInvariants.PUBLIC_SCHEMA.equals(schemaName.name)) {}
            else {
                throw Error.error(ErrorCode.X_42504, schemaName.name);
            }
        }

        if (schemaName.name.equals(SqlInvariants.LOBS_SCHEMA)) {
            schemaName = SqlInvariants.LOBS_SCHEMA_HSQLNAME;
            owner      = schemaName.owner;
        }

        if (readIfThis(Tokens.DEFAULT)) {
            readThis(Tokens.CHARACTER);
            readThis(Tokens.SET);

            characterSetName = readNewSchemaObjectName(SchemaObject.CHARSET,
                    false);
        }

        String     sql            = getLastPart();
        Object[]   args           = new Object[] {
            schemaName, owner
        };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;
        StatementSchema cs = new StatementSchema(sql,
            StatementTypes.CREATE_SCHEMA, args, null, writeLockNames);

        cs.setSchemaHsqlName(schemaName);

        HsqlArrayList list = new HsqlArrayList();

        list.add(cs);
        getCompiledStatementBody(list);

        StatementSchema[] array = new StatementSchema[list.size()];

        list.toArray(array);

        boolean swapped;

        do {
            swapped = false;

            for (int i = 0; i < array.length - 1; i++) {
                if (array[i].order > array[i + 1].order) {
                    StatementSchema temp = array[i + 1];

                    array[i + 1] = array[i];
                    array[i]     = temp;
                    swapped      = true;
                }
            }
        } while (swapped);

        return new StatementSchemaDefinition(array);
    }

    void getCompiledStatementBody(HsqlList list) {

        int    position;
        String sql;
        int    statementType;

        for (boolean end = false; !end; ) {
            StatementSchema cs = null;

            position = getPosition();

            switch (token.tokenType) {

                case Tokens.CREATE :
                    read();

                    switch (token.tokenType) {

                        // not in schema definition
                        case Tokens.SCHEMA :
                        case Tokens.USER :
                        case Tokens.UNIQUE :
                            throw unexpectedToken();
                        case Tokens.INDEX :
                            statementType = StatementTypes.CREATE_INDEX;
                            sql = getStatement(position,
                                               startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        case Tokens.SEQUENCE :
                            cs     = compileCreateSequence();
                            cs.sql = getLastPart(position);
                            break;

                        case Tokens.ROLE :
                            cs     = compileCreateRole();
                            cs.sql = getLastPart(position);
                            break;

                        case Tokens.DOMAIN :
                            statementType = StatementTypes.CREATE_DOMAIN;
                            sql = getStatement(position,
                                               startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        case Tokens.TYPE :
                            cs     = compileCreateType(false);
                            cs.sql = getLastPart(position);
                            break;

                        case Tokens.CHARACTER :
                            cs     = compileCreateCharacterSet();
                            cs.sql = getLastPart(position);
                            break;

                        // no supported
                        case Tokens.ASSERTION :
                            throw unexpectedToken();
                        case Tokens.TABLE :
                        case Tokens.MEMORY :
                        case Tokens.CACHED :
                        case Tokens.TEMP :
                        case Tokens.GLOBAL :
                        case Tokens.TEMPORARY :
                        case Tokens.TEXT :
                            statementType = StatementTypes.CREATE_TABLE;
                            sql = getStatement(position,
                                               startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        case Tokens.TRIGGER :
                            statementType = StatementTypes.CREATE_TRIGGER;
                            sql = getStatement(position,
                                               startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        case Tokens.VIEW :
                            statementType = StatementTypes.CREATE_VIEW;
                            sql = getStatement(position,
                                               startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        case Tokens.FUNCTION :
                            statementType = StatementTypes.CREATE_ROUTINE;
                            sql = getStatementForRoutine(
                                position, startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        case Tokens.PROCEDURE :
                            statementType = StatementTypes.CREATE_ROUTINE;
                            sql = getStatementForRoutine(
                                position, startStatementTokensSchema);
                            cs = new StatementSchema(sql, statementType);
                            break;

                        default :
                            throw unexpectedToken();
                    }
                    break;

                case Tokens.GRANT :
                    cs     = compileGrantOrRevoke();
                    cs.sql = getLastPart(position);
                    break;

                case Tokens.SEMICOLON :
                    read();

                    end = true;
                    break;

                case Tokens.X_ENDPARSE :
                    end = true;
                    break;

                default :
                    throw unexpectedToken();
            }

            if (cs != null) {
                cs.isSchemaDefinition = true;

                list.add(cs);
            }
        }
    }

    StatementSchema compileCreateRole() {

        read();

        HsqlName   name           = readNewUserIdentifier();
        String     sql            = getLastPart();
        Object[]   args           = new Object[]{ name };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_ROLE, args,
                                   null, writeLockNames);
    }

    StatementSchema compileCreateUser() {

        HsqlName name;
        String   password;
        Boolean  admin    = Boolean.FALSE;
        Boolean  isDigest = Boolean.FALSE;
        Grantee  grantor  = session.getGrantee();

        read();

        name = readNewUserIdentifier();

        readThis(Tokens.PASSWORD);

        if (readIfThis(Tokens.DIGEST)) {
            isDigest = Boolean.TRUE;
        }

        password = readPassword();

        if (token.tokenType == Tokens.ADMIN) {
            read();

            admin = Boolean.TRUE;
        }

        checkDatabaseUpdateAuthorisation();

        String     sql            = getLastPart();
        Object[]   args           = new Object[] {
            name, password, grantor, admin, isDigest
        };
        HsqlName[] writeLockNames = database.schemaManager.catalogNameArray;

        return new StatementSchema(sql, StatementTypes.CREATE_USER, args,
                                   null, writeLockNames);
    }

    HsqlName readNewUserIdentifier() {

        checkIsSimpleName();

        String  tokenS   = token.tokenString;
        boolean isQuoted = isDelimitedIdentifier();

        if (tokenS.equalsIgnoreCase("SA")) {
            tokenS   = "SA";
            isQuoted = false;
        }

        HsqlName name = database.nameManager.newHsqlName(tokenS, isQuoted,
            SchemaObject.GRANTEE);

        read();

        return name;
    }

    String readPassword() {

        String tokenS = token.tokenString;

        if (isUndelimitedSimpleName() || isDelimitedSimpleName()) {
            read();
        } else {
            readQuotedString();
        }

        return tokenS;
    }

    StatementSchema compileCreateSynonym(boolean isOrReplace) {

        HsqlName synonymHsqlName;
        HsqlName targetHsqlName;

        read();

        synonymHsqlName = readNewSchemaObjectName(SchemaObject.REFERENCE,
                true);

        readThis(Tokens.FOR);

        targetHsqlName = readNewSchemaObjectName(SchemaObject.REFERENCE, true);

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            synonymHsqlName, targetHsqlName
        };

        return new StatementSchema(sql, StatementTypes.CREATE_REFERENCE, args,
                                   null,
                                   new HsqlName[]{
                                       database.getCatalogName() });
    }

    Statement compileRenameObject(HsqlName name, int type) {

        HsqlName newName = readNewSchemaObjectName(type, true);
        String   sql     = getLastPart();

        switch (type) {

            case SchemaObject.CATALOG :
                break;

            case SchemaObject.SCHEMA :
                checkSchemaUpdateAuthorisation(session, name);
                break;

            default :
                name.setSchemaIfNull(session.getCurrentSchemaHsqlName());
                checkSchemaUpdateAuthorisation(session, name.schema);
        }

        Object[] args = new Object[] {
            name, newName
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogNameArray();

        return new StatementSchema(sql, StatementTypes.RENAME_OBJECT, args,
                                   null, writeLockNames);
    }

    Statement compileAlterTableAddUniqueConstraint(Table table, HsqlName name,
            Boolean ifNotExists) {

        if (name == null) {
            name = database.nameManager.newAutoName("CT",
                    table.getSchemaName(), table.getName(),
                    SchemaObject.CONSTRAINT);
        }

        int[] cols = readColumnList(table, false);
        HsqlName indexname = database.nameManager.newAutoName("IDX",
            name.name, table.getSchemaName(), table.getName(),
            SchemaObject.INDEX);
        Index index = table.createIndexStructure(indexname, cols, null, null,
            true, true, false);
        Constraint c = new Constraint(name, table, index,
                                      SchemaObject.ConstraintTypes.UNIQUE);
        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ADD_CONSTRAINT, table, c, ifNotExists
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    Statement compileAlterTableAddForeignKeyConstraint(Table table,
            HsqlName name, Boolean ifNotExists) {

        if (name == null) {
            name = database.nameManager.newAutoName("FK",
                    table.getSchemaName(), table.getName(),
                    SchemaObject.CONSTRAINT);
        }

        OrderedHashSet set           = readColumnNames(false);
        Constraint     c             = readFKReferences(table, name, set);
        HsqlName       mainTableName = c.getMainTableName();

        c.core.mainTable =
            database.schemaManager.getUserTable(mainTableName.name,
                mainTableName.schema.name);

        c.setColumnsIndexes(table);

        if (c.core.mainCols.length != c.core.refCols.length) {
            throw Error.error(ErrorCode.X_42593);
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ADD_CONSTRAINT, table, c, ifNotExists
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        if (mainTableName != table.getName()) {
            writeLockNames =
                (HsqlName[]) ArrayUtil.toAdjustedArray(writeLockNames,
                    mainTableName, writeLockNames.length, 1);
        }

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    Statement compileAlterTableAddCheckConstraint(Table table, HsqlName name,
            Boolean ifNotExists) {

        Constraint check;

        if (name == null) {
            name = database.nameManager.newAutoName("CT",
                    table.getSchemaName(), table.getName(),
                    SchemaObject.CONSTRAINT);
        }

        check = new Constraint(name, null, SchemaObject.ConstraintTypes.CHECK);

        readCheckConstraintCondition(check);

        String     sql            = getLastPart();
        Object[]   args           = new Object[] {
            StatementTypes.ADD_CONSTRAINT, table, check, ifNotExists
        };
        HsqlName[] writeLockNames = new HsqlName[] {
            database.getCatalogName(), table.getName()
        };

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    Statement compileAlterTableAddColumn(Table table) {

        int           colIndex = table.getColumnCount();
        HsqlArrayList list     = new HsqlArrayList();
        Constraint constraint =
            new Constraint(null, null, SchemaObject.ConstraintTypes.TEMP);

        list.add(constraint);
        checkIsSchemaObjectName();

        HsqlName hsqlName =
            database.nameManager.newColumnHsqlName(table.getName(),
                token.tokenString, isDelimitedIdentifier());

        read();

        ColumnSchema column = readColumnDefinitionOrNull(table, hsqlName,
            list);

        if (column == null) {
            throw Error.error(ErrorCode.X_42000);
        }

        if (token.tokenType == Tokens.BEFORE) {
            read();

            colIndex = table.getColumnIndex(token.tokenString);

            read();
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            Integer.valueOf(StatementTypes.ADD_COLUMN), table, column,
            Integer.valueOf(colIndex), list
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    Statement compileAlterTableAddPrimaryKey(Table table, HsqlName name,
            Boolean ifNotExists) {

        if (name == null) {
            name = session.database.nameManager.newAutoName("PK",
                    table.getSchemaName(), table.getName(),
                    SchemaObject.CONSTRAINT);
        }

        OrderedHashSet set = readColumnNames(false);
        Constraint constraint =
            new Constraint(name, set,
                           SchemaObject.ConstraintTypes.PRIMARY_KEY);

        constraint.setColumnsIndexes(table);

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ADD_CONSTRAINT, table, constraint, ifNotExists
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    Statement compileAlterTableDropColumn(Table table, String colName,
                                          boolean cascade) {

        int colindex = table.getColumnIndex(colName);

        if (table.getColumnCount() == 1) {
            throw Error.error(ErrorCode.X_42591);
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            table.getColumn(colindex).getName(),
            ValuePool.getInt(SchemaObject.COLUMN), Boolean.valueOf(cascade),
            Boolean.FALSE
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.DROP_COLUMN, args,
                                   null, writeLockNames);
    }

    Statement compileAlterColumn(Table table, ColumnSchema column,
                                 int columnIndex) {

        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());
        int position = getPosition();

        switch (token.tokenType) {

            case Tokens.RENAME : {
                read();
                readThis(Tokens.TO);

                return compileAlterColumnRename(table, column);
            }
            case Tokens.DROP : {
                read();

                if (token.tokenType == Tokens.DEFAULT) {
                    read();

                    String   sql  = getLastPart();
                    Object[] args = new Object[] {
                        StatementTypes.ALTER_COLUMN_DROP_DEFAULT, table,
                        column, Integer.valueOf(columnIndex)
                    };

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_TABLE,
                                               args, null, writeLockNames);
                } else if (token.tokenType == Tokens.EXPRESSION) {
                    read();

                    String   sql  = getLastPart();
                    Object[] args = new Object[] {
                        StatementTypes.ALTER_COLUMN_DROP_EXPRESSION, table,
                        column, Integer.valueOf(columnIndex)
                    };

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_TABLE,
                                               args, null, writeLockNames);
                } else if (token.tokenType == Tokens.GENERATED
                           || token.tokenType == Tokens.IDENTITY) {
                    read();

                    String   sql  = getLastPart();
                    Object[] args = new Object[] {
                        StatementTypes.ALTER_COLUMN_DROP_GENERATED, table,
                        column, Integer.valueOf(columnIndex)
                    };

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_TABLE,
                                               args, null, writeLockNames);
                } else if (token.tokenType == Tokens.NOT) {
                    read();
                    readThis(Tokens.NULL);

                    String   sql  = getLastPart();
                    Object[] args = new Object[] {
                        StatementTypes.ALTER_COLUMN_NULL, table, column,
                        Boolean.TRUE
                    };

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_TABLE,
                                               args, null, writeLockNames);
                } else {
                    throw unexpectedToken();
                }
            }
            case Tokens.SET : {
                read();

                switch (token.tokenType) {

                    case Tokens.DATA : {
                        read();
                        readThis(Tokens.TYPE);

                        return compileAlterColumnDataType(table, column);
                    }
                    case Tokens.DEFAULT : {
                        read();

                        //ALTER TABLE .. ALTER COLUMN .. SET DEFAULT
                        Type       type = column.getDataType();
                        Expression expr = readDefaultClause(type);
                        String     sql  = getLastPart();
                        Object[]   args = new Object[] {
                            StatementTypes.ALTER_COLUMN_DEFAULT, table, column,
                            Integer.valueOf(columnIndex), expr
                        };

                        return new StatementSchema(sql,
                                                   StatementTypes.ALTER_TABLE,
                                                   args, null, writeLockNames);
                    }
                    case Tokens.NOT : {

                        //ALTER TABLE .. ALTER COLUMN .. SET NOT NULL
                        read();
                        readThis(Tokens.NULL);

                        return compileAlterColumnSetNullability(table, column,
                                false);
                    }
                    case Tokens.NULL : {
                        read();

                        return compileAlterColumnSetNullability(table, column,
                                true);
                    }
                    case Tokens.GENERATED : {
                        return compileAlterColumnAddSequence(table, column,
                                                             columnIndex);
                    }
                    default :
                        rewind(position);
                        read();
                        break;
                }

                break;
            }
            case Tokens.GENERATED :
                return compileAlterColumnAddSequence(table, column,
                                                     columnIndex);

            // fall through
            default :
        }

        if (token.tokenType == Tokens.SET
                || token.tokenType == Tokens.RESTART) {
            if (!column.isIdentity()) {
                throw Error.error(ErrorCode.X_42535);
            }

            return compileAlterColumnSequenceOptions(table, column,
                    columnIndex);
        } else {
            return compileAlterColumnDataTypeIdentity(table, column);
        }
    }

    /**
     * Allows changes to type of column or addition / removal of an IDENTITY generator.
     * IDENTITY is removed if it does not appear in new column definition
     * Constraint definitions are not allowed
     */
    private Statement compileAlterColumnDataTypeIdentity(Table table,
            ColumnSchema column) {

        if (column.isGenerated()) {
            throw Error.error(ErrorCode.X_42561);
        }

        NumberSequence sequence = column.getIdentitySequence();
        Type           type     = column.getDataType();

        if (token.tokenType == Tokens.IDENTITY) {
            read();

            if (!type.isIntegralType()) {
                throw Error.error(ErrorCode.X_42561);
            }

            if (sequence == null) {
                sequence = new NumberSequence(null, type);
            }
        } else {
            type = readTypeDefinition(true, true);

            switch (token.tokenType) {

                case Tokens.IDENTITY : {
                    if (!type.isIntegralType()) {
                        throw Error.error(ErrorCode.X_42561);
                    }

                    read();

                    if (sequence == null) {
                        sequence = new NumberSequence(null, type);
                    }

                    break;
                }
                case Tokens.GENERATED : {
                    sequence = readSequence(column);

                    break;
                }
                default :
                    sequence = null;
            }
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ALTER_COLUMN_TYPE_IDENTITY, table, column, type,
            sequence
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    private Statement compileAlterColumnDataType(Table table,
            ColumnSchema column) {

        if (column.isGenerated()) {
            throw Error.error(ErrorCode.X_42561);
        }

        Type type = readTypeDefinition(true, true);

        if (column.isIdentity()) {
            if (!type.isIntegralType()) {
                throw Error.error(ErrorCode.X_42561);
            }
        }

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ALTER_COLUMN_TYPE, table, column, type
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    private Statement compileAlterColumnSetNullability(Table table,
            ColumnSchema column, boolean nullable) {

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ALTER_COLUMN_NULL, table, column,
            Boolean.valueOf(nullable)
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    Statement compileAlterSequence() {

        read();

        HsqlName schema = session.getSchemaHsqlName(token.namePrefix);
        NumberSequence sequence =
            database.schemaManager.getSequence(token.tokenString, schema.name,
                                               true);

        read();

        if (token.tokenType == Tokens.RENAME) {
            read();
            readThis(Tokens.TO);

            return compileRenameObject(sequence.getName(),
                                       SchemaObject.SEQUENCE);
        }

        checkSchemaUpdateAuthorisation(session, sequence.getName().schema);

        NumberSequence copy = sequence.duplicate();

        readSequenceOptions(copy, false, true, false);

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            sequence, copy
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogNameArray();

        return new StatementSchema(sql, StatementTypes.ALTER_SEQUENCE, args,
                                   null, writeLockNames);
    }

    StatementSchema compileAlterColumnAddSequence(Table table,
            ColumnSchema column, int colIndex) {

        if (!column.getDataType().isIntegralType()) {
            throw Error.error(ErrorCode.X_42525);
        }

        if (column.isIdentity()) {
            throw Error.error(ErrorCode.X_42525);
        }

        NumberSequence sequence = readSequence(column);
        String         sql      = getLastPart();
        Object[]       args     = new Object[] {
            StatementTypes.ALTER_COLUMN_SEQUENCE, table, column,
            Integer.valueOf(colIndex), sequence
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogAndBaseTableNames(
                table.getName());

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    NumberSequence readSequence(ColumnSchema column) {

        readThis(Tokens.GENERATED);

        NumberSequence sequence;

        sequence = new NumberSequence(null, column.getDataType());

        boolean generatedAlways = false;

        if (token.tokenType == Tokens.BY) {
            read();
            readThis(Tokens.DEFAULT);
        } else {
            readThis(Tokens.ALWAYS);

            generatedAlways = true;
        }

        readThis(Tokens.AS);
        readThis(Tokens.IDENTITY);
        sequence.setAlways(generatedAlways);

        if (token.tokenType == Tokens.OPENBRACKET) {
            read();
            readSequenceOptions(sequence, false, false, false);
            readThis(Tokens.CLOSEBRACKET);
        }

        sequence.checkValues();

        return sequence;
    }

    StatementSchema compileAlterColumnSequenceOptions(Table table,
            ColumnSchema column, int columnIndex) {

        OrderedIntHashSet set      = new OrderedIntHashSet();
        NumberSequence    sequence = column.getIdentitySequence().duplicate();

        while (true) {
            boolean end = false;

            switch (token.tokenType) {

                case Tokens.RESTART : {
                    if (!set.add(token.tokenType)) {
                        throw unexpectedToken();
                    }

                    read();

                    if (readIfThis(Tokens.WITH)) {
                        long value = readBigint();

                        sequence.setCurrentValueNoCheck(value);
                    } else {
                        sequence.reset();
                    }

                    break;
                }
                case Tokens.SET :
                    read();

                    switch (token.tokenType) {

                        case Tokens.INCREMENT : {
                            if (!set.add(token.tokenType)) {
                                throw unexpectedToken();
                            }

                            read();
                            readThis(Tokens.BY);

                            long value = readBigint();

                            sequence.setIncrement(value);

                            break;
                        }
                        case Tokens.NO :
                            read();

                            if (token.tokenType == Tokens.MAXVALUE) {
                                sequence.setDefaultMaxValue();
                            } else if (token.tokenType == Tokens.MINVALUE) {
                                sequence.setDefaultMinValue();
                            } else if (token.tokenType == Tokens.CYCLE) {
                                sequence.setCycle(false);
                            } else {
                                throw unexpectedToken();
                            }

                            if (!set.add(token.tokenType)) {
                                throw unexpectedToken();
                            }

                            read();
                            break;

                        case Tokens.MAXVALUE : {
                            if (!set.add(token.tokenType)) {
                                throw unexpectedToken();
                            }

                            read();

                            long value = readBigint();

                            sequence.setMaxValueNoCheck(value);

                            break;
                        }
                        case Tokens.MINVALUE : {
                            if (!set.add(token.tokenType)) {
                                throw unexpectedToken();
                            }

                            read();

                            long value = readBigint();

                            sequence.setMinValueNoCheck(value);

                            break;
                        }
                        case Tokens.CYCLE :
                            if (!set.add(token.tokenType)) {
                                throw unexpectedToken();
                            }

                            read();
                            sequence.setCycle(true);
                            break;

                        default :
                            throw unexpectedToken();
                    }
                    break;

                default :
                    end = true;
                    break;
            }

            if (end) {
                break;
            }
        }

        sequence.checkValues();

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            StatementTypes.ALTER_COLUMN_SEQUENCE, table, column,
            Integer.valueOf(columnIndex), sequence
        };
        HsqlName[] writeLockNames = new HsqlName[] {
            database.getCatalogName(), table.getName()
        };

        return new StatementSchema(sql, StatementTypes.ALTER_TABLE, args,
                                   null, writeLockNames);
    }

    /**
     * Responsible for handling tail of ALTER COLUMN ... RENAME ...
     */
    private Statement compileAlterColumnRename(Table table,
            ColumnSchema column) {

        checkIsSimpleName();

        HsqlName name = readNewSchemaObjectName(SchemaObject.COLUMN, true);

        if (table.findColumn(name.name) > -1) {
            throw Error.error(ErrorCode.X_42504, name.name);
        }

        database.schemaManager.checkColumnIsReferenced(table.getName(),
                column.getName());

        String     sql            = getLastPart();
        Object[]   args           = new Object[] {
            column.getName(), name
        };
        HsqlName[] writeLockNames = new HsqlName[] {
            database.getCatalogName(), table.getName()
        };

        return new StatementSchema(sql, StatementTypes.RENAME_OBJECT, args,
                                   null, writeLockNames);
    }

    Statement compileAlterSchemaRename() {

        HsqlName name = readSchemaName();

        checkSchemaUpdateAuthorisation(name);
        readThis(Tokens.RENAME);
        readThis(Tokens.TO);

        HsqlName newName = readNewSchemaName();
        String   sql     = getLastPart();
        Object[] args    = new Object[] {
            name, newName
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogNameArray();

        return new StatementSchema(sql, StatementTypes.RENAME_OBJECT, args,
                                   null, writeLockNames);
    }

    Statement compileAlterUser() {

        read();

        String   password;
        User     userObject;
        HsqlName userName = readNewUserIdentifier();

        userObject = database.getUserManager().get(userName.name);

        if (userName.name.equals(Tokens.T_PUBLIC)) {
            throw Error.error(ErrorCode.X_42503);
        }

        if (userName.name.equals(SqlInvariants.SYSTEM_AUTHORIZATION_NAME)) {
            throw Error.error(ErrorCode.X_42503);
        }

        readThis(Tokens.SET);

        switch (token.tokenType) {

            case Tokens.LOCAL : {
                read();

                Boolean  mode = processTrueOrFalseObject();
                Object[] args = new Object[] {
                    userObject, mode
                };

                return new StatementCommand(StatementTypes.SET_USER_LOCAL,
                                            args);
            }
            case Tokens.PASSWORD : {
                read();

                boolean isDigest = false;

                if (readIfThis(Tokens.DIGEST)) {
                    isDigest = Boolean.TRUE;
                }

                password = readPassword();

                Object[] args = new Object[] {
                    userObject, password, Boolean.valueOf(isDigest)
                };
                Statement cs =
                    new StatementCommand(StatementTypes.SET_USER_PASSWORD,
                                         args);
                String sql = userObject.getSetUserPasswordDigestSQL(password,
                    isDigest);

                cs.setSQL(sql);

                return cs;
            }
            case Tokens.INITIAL : {
                read();
                readThis(Tokens.SCHEMA);

                HsqlName schemaName;

                if (token.tokenType == Tokens.DEFAULT) {
                    schemaName = null;
                } else {
                    schemaName = database.schemaManager.getSchemaHsqlName(
                        token.tokenString);
                }

                read();

                Object[] args = new Object[] {
                    userObject, schemaName
                };

                return new StatementCommand(
                    StatementTypes.SET_USER_INITIAL_SCHEMA, args);
            }
            default : {
                throw unexpectedToken();
            }
        }
    }

    Statement compileAlterDomain() {

        read();

        HsqlName schema = session.getSchemaHsqlName(token.namePrefix);

        checkSchemaUpdateAuthorisation(schema);

        Type domain = database.schemaManager.getDomain(token.tokenString,
            schema.name, true);

        read();

        switch (token.tokenType) {

            case Tokens.RENAME : {
                read();
                readThis(Tokens.TO);

                return compileRenameObject(domain.getName(),
                                           SchemaObject.DOMAIN);
            }
            case Tokens.DROP : {
                read();

                if (token.tokenType == Tokens.DEFAULT) {
                    read();

                    String   sql  = getLastPart();
                    Object[] args = new Object[] {
                        StatementTypes.DROP_DEFAULT, domain
                    };
                    HsqlName[] writeLockNames =
                        database.schemaManager.getCatalogAndBaseTableNames(
                            domain.getName());

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_DOMAIN,
                                               args, null, writeLockNames);
                } else if (token.tokenType == Tokens.CONSTRAINT) {
                    read();
                    checkIsSchemaObjectName();

                    HsqlName name = database.schemaManager.getSchemaObjectName(
                        domain.getSchemaName(), token.tokenString,
                        SchemaObject.CONSTRAINT, true);

                    read();

                    String   sql  = getLastPart();
                    Object[] args = new Object[] {
                        StatementTypes.DROP_CONSTRAINT, domain, name
                    };
                    HsqlName[] writeLockNames =
                        database.schemaManager.getCatalogAndBaseTableNames(
                            domain.getName());

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_DOMAIN,
                                               args, null, writeLockNames);
                } else {
                    throw unexpectedToken();
                }
            }
            case Tokens.SET : {
                read();
                readThis(Tokens.DEFAULT);

                Expression e    = readDefaultClause(domain);
                String     sql  = getLastPart();
                Object[]   args = new Object[] {
                    StatementTypes.ADD_DEFAULT, domain, e
                };
                HsqlName[] writeLockNames =
                    database.schemaManager.getCatalogAndBaseTableNames(
                        domain.getName());

                return new StatementSchema(sql, StatementTypes.ALTER_DOMAIN,
                                           args, null, writeLockNames);
            }
            case Tokens.ADD : {
                read();

                if (token.tokenType == Tokens.CONSTRAINT
                        || token.tokenType == Tokens.CHECK) {
                    HsqlArrayList tempConstraints = new HsqlArrayList();

                    compileContext.currentDomain = domain;

                    readConstraint(domain, tempConstraints);

                    compileContext.currentDomain = null;

                    Constraint c    = (Constraint) tempConstraints.get(0);
                    String     sql  = getLastPart();
                    Object[]   args = new Object[] {
                        StatementTypes.ADD_CONSTRAINT, domain, c
                    };
                    HsqlName[] writeLockNames =
                        database.schemaManager.getCatalogAndBaseTableNames(
                            domain.getName());

                    return new StatementSchema(sql,
                                               StatementTypes.ALTER_DOMAIN,
                                               args, null, writeLockNames);
                }
            }
        }

        throw unexpectedToken();
    }

    private boolean isGrantToken() {

        switch (token.tokenType) {

            case Tokens.ALL :
            case Tokens.INSERT :
            case Tokens.UPDATE :
            case Tokens.SELECT :
            case Tokens.DELETE :
            case Tokens.USAGE :
            case Tokens.EXECUTE :
            case Tokens.REFERENCES :
                return true;

            default :
                return false;
        }
    }

    StatementSchema compileGrantOrRevoke() {

        boolean grant = token.tokenType == Tokens.GRANT;

        read();

        if (isGrantToken()
                || (!grant
                    && (token.tokenType == Tokens.GRANT
                        || token.tokenType == Tokens.HIERARCHY))) {
            return compileRightGrantOrRevoke(grant);
        } else {
            return compileRoleGrantOrRevoke(grant);
        }
    }

    private StatementSchema compileRightGrantOrRevoke(boolean grant) {

        OrderedHashSet granteeList   = new OrderedHashSet();
        Grantee        grantor       = null;
        Right          right         = null;
        HsqlName       objectName    = null;
        boolean        isTable       = false;
        boolean        isUsage       = false;
        boolean        isExec        = false;
        boolean        isAll         = false;
        boolean        isGrantOption = false;
        boolean        cascade       = false;

        if (!grant) {
            if (token.tokenType == Tokens.GRANT) {
                read();
                readThis(Tokens.OPTION);
                readThis(Tokens.FOR);

                isGrantOption = true;
            } else if (token.tokenType == Tokens.HIERARCHY) {
                throw unsupportedFeature();
/*
                read();
                readThis(Token.OPTION);
                readThis(Token.FOR);
*/
            }
        }

        // ALL means all the rights the grantor can grant
        if (token.tokenType == Tokens.ALL) {
            read();

            if (token.tokenType == Tokens.PRIVILEGES) {
                read();
            }

            right = Right.fullRights;
            isAll = true;
        } else {
            right = new Right();

            boolean loop = true;

            while (loop) {
                checkIsUndelimitedIdentifier();

                int rightType =
                    GranteeManager.getCheckSingleRight(token.tokenString);
                int            grantType = token.tokenType;
                OrderedHashSet columnSet = null;

                read();

                switch (grantType) {

                    case Tokens.REFERENCES :
                    case Tokens.SELECT :
                    case Tokens.INSERT :
                    case Tokens.UPDATE :
                        if (token.tokenType == Tokens.OPENBRACKET) {
                            columnSet = readColumnNames(false);
                        }

                    // fall through
                    case Tokens.TRIGGER :
                        if (right == null) {
                            right = new Right();
                        }

                        right.set(rightType, columnSet);

                        isTable = true;
                        break;

                    case Tokens.DELETE :
                        if (right == null) {
                            right = new Right();
                        }

                        right.set(rightType, null);

                        isTable = true;
                        break;

                    case Tokens.USAGE :
                        if (isTable) {
                            throw unexpectedToken();
                        }

                        right   = Right.fullRights;
                        isUsage = true;
                        loop    = false;

                        continue;
                    case Tokens.EXECUTE :
                        if (isTable) {
                            throw unexpectedToken();
                        }

                        right  = Right.fullRights;
                        isExec = true;
                        loop   = false;

                        continue;
                }

                if (token.tokenType == Tokens.COMMA) {
                    read();

                    continue;
                }

                break;
            }
        }

        readThis(Tokens.ON);

        int objectType = 0;

        switch (token.tokenType) {

            case Tokens.CLASS :
                if (!isExec && !isAll) {
                    throw unexpectedToken();
                }

                read();

                if (!isSimpleName() || !isDelimitedIdentifier()) {
                    throw Error.error(ErrorCode.X_42569);
                }

                objectType = SchemaObject.FUNCTION;
                break;

            case Tokens.SPECIFIC : {
                if (!isExec && !isAll) {
                    throw unexpectedToken();
                }

                read();

                switch (token.tokenType) {

                    case Tokens.ROUTINE :
                    case Tokens.PROCEDURE :
                    case Tokens.FUNCTION :
                        read();
                        break;

                    default :
                        throw unexpectedToken();
                }

                objectType = SchemaObject.SPECIFIC_ROUTINE;

                break;
            }
            case Tokens.FUNCTION :
                if (!isExec && !isAll) {
                    throw unexpectedToken();
                }

                read();

                objectType = SchemaObject.FUNCTION;
                break;

            case Tokens.PROCEDURE :
                if (!isExec && !isAll) {
                    throw unexpectedToken();
                }

                read();

                objectType = SchemaObject.PROCEDURE;
                break;

            case Tokens.ROUTINE :
                if (!isExec && !isAll) {
                    throw unexpectedToken();
                }

                read();

                objectType = SchemaObject.ROUTINE;
                break;

            case Tokens.TYPE :
                if (!isUsage && !isAll) {
                    throw unexpectedToken();
                }

                read();

                objectType = SchemaObject.TYPE;
                break;

            case Tokens.DOMAIN :
                if (!isUsage && !isAll) {
                    throw unexpectedToken();
                }

                read();

                objectType = SchemaObject.DOMAIN;
                break;

            case Tokens.SEQUENCE :
                if (!isUsage && !isAll) {
                    throw unexpectedToken();
                }

                read();

                objectType = SchemaObject.SEQUENCE;
                break;

            case Tokens.CHARACTER :
                if (!isUsage && !isAll) {
                    throw unexpectedToken();
                }

                read();
                readThis(Tokens.SET);

                objectType = SchemaObject.CHARSET;
                break;

            case Tokens.TABLE :
            default :
                if (!isTable && !isAll) {
                    throw unexpectedToken();
                }

                readIfThis(Tokens.TABLE);

                objectType = SchemaObject.TABLE;
        }

        objectName = readNewSchemaObjectName(objectType, false);

        if (grant) {
            readThis(Tokens.TO);
        } else {
            readThis(Tokens.FROM);
        }

        while (true) {
            checkIsSimpleName();
            granteeList.add(token.tokenString);
            read();

            if (token.tokenType == Tokens.COMMA) {
                read();
            } else {
                break;
            }
        }

        if (grant) {
            if (token.tokenType == Tokens.WITH) {
                read();
                readThis(Tokens.GRANT);
                readThis(Tokens.OPTION);

                isGrantOption = true;
            }

            /** @todo - implement */
            if (token.tokenType == Tokens.GRANTED) {
                read();
                readThis(Tokens.BY);

                if (token.tokenType == Tokens.CURRENT_USER) {
                    read();

                    //
                } else {
                    readThis(Tokens.CURRENT_ROLE);

                    if (session.getRole() == null) {
                        throw Error.error(ErrorCode.X_0P000);
                    }

                    grantor = session.getRole();
                }
            }
        } else {
            if (token.tokenType == Tokens.CASCADE) {
                cascade = true;

                read();
            } else {
                readThis(Tokens.RESTRICT);
            }
        }

        String   sql  = getLastPart();
        int      type = grant ? StatementTypes.GRANT
                              : StatementTypes.REVOKE;
        Object[] args = new Object[] {
            granteeList, objectName, right, grantor, Boolean.valueOf(cascade),
            Boolean.valueOf(isGrantOption)
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogNameArray();
        StatementSchema cs = new StatementSchema(sql, type, args, null,
            writeLockNames);

        return cs;
    }

    private StatementSchema compileRoleGrantOrRevoke(boolean grant) {

        Grantee        grantor     = session.getGrantee();
        OrderedHashSet roleList    = new OrderedHashSet();
        OrderedHashSet granteeList = new OrderedHashSet();
        boolean        cascade     = false;

        if (!grant && token.tokenType == Tokens.ADMIN) {
            throw unsupportedFeature();
/*
            read();
            readThis(Token.OPTION);
            readThis(Token.FOR);
*/
        }

        while (true) {
            checkIsSimpleName();
            roleList.add(token.tokenString);
            read();

            if (token.tokenType == Tokens.COMMA) {
                read();

                continue;
            }

            break;
        }

        if (grant) {
            readThis(Tokens.TO);
        } else {
            readThis(Tokens.FROM);
        }

        while (true) {
            checkIsSimpleName();
            granteeList.add(token.tokenString);
            read();

            if (token.tokenType == Tokens.COMMA) {
                read();
            } else {
                break;
            }
        }

        if (grant) {
            if (token.tokenType == Tokens.WITH) {
                throw unsupportedFeature();
/*
                read();
                readThis(Token.ADMIN);
                readThis(Token.OPTION);
*/
            }
        }

        if (token.tokenType == Tokens.GRANTED) {
            read();
            readThis(Tokens.BY);

            if (token.tokenType == Tokens.CURRENT_USER) {
                read();

                //
            } else {
                readThis(Tokens.CURRENT_ROLE);

                if (session.getRole() == null) {
                    throw Error.error(ErrorCode.X_0P000);
                }

                grantor = session.getRole();
            }
        }

        if (!grant) {
            if (token.tokenType == Tokens.CASCADE) {
                cascade = true;

                read();
            } else {
                readThis(Tokens.RESTRICT);
            }
        }

        String   sql  = getLastPart();
        int      type = grant ? StatementTypes.GRANT_ROLE
                              : StatementTypes.REVOKE_ROLE;
        Object[] args = new Object[] {
            granteeList, roleList, grantor, Boolean.valueOf(cascade)
        };
        HsqlName[] writeLockNames =
            database.schemaManager.getCatalogNameArray();
        StatementSchema cs = new StatementSchema(sql, type, args, null,
            writeLockNames);

        return cs;
    }

    void checkDatabaseUpdateAuthorisation() {
        session.checkAdmin();
        session.checkDDLWrite();
    }

    void checkSchemaUpdateAuthorisation(Session session, HsqlName schema) {

        if (session.isProcessingLog()) {
            return;
        }

        if (SqlInvariants.isSystemSchemaName(schema.name)) {
            throw Error.error(ErrorCode.X_42503);
        }

        if (session.parser.isSchemaDefinition) {
            if (schema == session.getCurrentSchemaHsqlName()) {
                return;
            }

            throw Error.error(ErrorCode.X_42505, schema.name);
        }

        session.getGrantee().checkSchemaUpdateOrGrantRights(schema.name);
        session.checkDDLWrite();
    }

    StatementSchema compileComment() {

        HsqlName name;
        int      type;

        readThis(Tokens.COMMENT);
        readThis(Tokens.ON);

        switch (token.tokenType) {

            case Tokens.ROUTINE :
            case Tokens.TABLE : {
                type = token.tokenType == Tokens.ROUTINE ? SchemaObject.ROUTINE
                                                         : SchemaObject.TABLE;

                read();
                checkIsSchemaObjectName();

                name = database.nameManager.newHsqlName(token.tokenString,
                        token.isDelimitedIdentifier, type);

                if (token.namePrefix == null) {
                    name.schema = session.getCurrentSchemaHsqlName();
                } else {
                    name.schema = database.nameManager.newHsqlName(
                        token.namePrefix, token.isDelimitedPrefix,
                        SchemaObject.SCHEMA);
                }

                read();

                break;
            }
            case Tokens.COLUMN : {
                read();
                checkIsSchemaObjectName();

                name = database.nameManager.newHsqlName(token.tokenString,
                        token.isDelimitedIdentifier, SchemaObject.COLUMN);

                if (token.namePrefix == null) {
                    throw Error.error(ErrorCode.X_42501);
                }

                name.parent =
                    database.nameManager.newHsqlName(token.namePrefix,
                                                     token.isDelimitedPrefix,
                                                     SchemaObject.TABLE);

                if (token.namePrePrefix == null) {
                    name.parent.schema = session.getCurrentSchemaHsqlName();
                } else {
                    name.parent.schema = database.nameManager.newHsqlName(
                        token.namePrePrefix, token.isDelimitedPrePrefix,
                        SchemaObject.TABLE);
                }

                read();

                break;
            }
            default :
                throw unexpectedToken();
        }

        readThis(Tokens.IS);

        String   comment   = readQuotedString();
        Object[] arguments = new Object[] {
            name, comment
        };

        return new StatementSchema(null, StatementTypes.COMMENT, arguments,
                                   null, null);
    }

    Statement compileAlterSession() {

        read();
        session.checkAdmin();

        if (token.tokenType == Tokens.RESET) {
            read();

            int action = token.tokenType;

            switch (token.tokenType) {

                case Tokens.ALL :
                    read();
                    break;

                case Tokens.RESULT :
                    read();
                    readThis(Tokens.SETS);
                    break;

                case Tokens.TABLE :
                    read();
                    readThis(Tokens.DATA);
                    break;

                default :
                    throw unexpectedTokenRequire(Tokens.T_ALL + ','
                                                 + Tokens.T_RESULT + ','
                                                 + Tokens.T_TABLE);
            }

            Object[] args = new Object[] {
                Long.valueOf(session.getId()), Integer.valueOf(action)
            };

            return new StatementCommand(StatementTypes.ALTER_SESSION, args);
        }

        long    sessionID     = readBigint();
        Session targetSession = database.sessionManager.getSession(sessionID);

        if (targetSession == null) {
            throw Error.error(ErrorCode.X_2E000);
        }

        int action = token.tokenType;

        switch (token.tokenType) {

            case Tokens.CLOSE :
                read();
                break;

            case Tokens.RELEASE :
                read();
                break;

            case Tokens.END :
                read();

                readThis(Tokens.STATEMENT);
                break;

            default :
                throw unexpectedToken();
        }

        Object[] args = new Object[] {
            Long.valueOf(sessionID), Integer.valueOf(action)
        };

        return new StatementCommand(StatementTypes.ALTER_SESSION, args);
    }

    /**
     * Retrieves boolean value corresponding to the next token.
     *
     * @return   true if next token is "TRUE"; false if next token is "FALSE"
     * @throws  HsqlException if the next token is neither "TRUE" or "FALSE"
     */
    boolean processTrueOrFalse() {

        if (token.namePrefix != null) {
            throw unexpectedToken();
        }

        if (token.tokenType == Tokens.TRUE) {
            read();

            return true;
        } else if (token.tokenType == Tokens.FALSE) {
            read();

            return false;
        } else {
            throw unexpectedToken();
        }
    }

    Boolean processTrueOrFalseObject() {
        return Boolean.valueOf(processTrueOrFalse());
    }
}

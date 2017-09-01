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
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.HsqlArrayList;
import org.hsqldb.lib.HsqlList;
import org.hsqldb.lib.LongDeque;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.lib.OrderedIntHashSet;
import org.hsqldb.result.ResultProperties;
import org.hsqldb.types.ArrayType;
import org.hsqldb.types.RowType;
import org.hsqldb.types.Type;
import org.hsqldb.types.Types;

/**
 * Parser for SQL stored procedures and functions - PSM
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class ParserRoutine extends ParserTable {

    ParserRoutine(Session session, Scanner t) {
        super(session, t);
    }

    Statement compileOpenCursorStatement(StatementCompound context) {

        readThis(Tokens.OPEN);
        checkIsSimpleName();

        String tokenString = token.tokenString;

        read();

        for (int i = 0; i < context.cursors.length; i++) {
            if (context.cursors[i].getCursorName().name.equals(tokenString)) {
                return context.cursors[i];
            }
        }

        throw Error.parseError(ErrorCode.X_34000, null,
                               scanner.getLineNumber());
    }

    Statement compileSelectSingleRowStatement(RangeGroup[] rangeGroups) {

        OrderedHashSet     variableNames = new OrderedHashSet();
        Type[]             targetTypes;
        LongDeque          colIndexList = new LongDeque();
        QuerySpecification select;

        compileContext.setOuterRanges(rangeGroups);

        select = XreadSelect();

        readThis(Tokens.INTO);

        RangeVariable[] ranges = rangeGroups[0].getRangeVariables();

        readTargetSpecificationList(variableNames, ranges, colIndexList);
        XreadTableExpression(select);
        select.setReturningResult();

        int[] columnMap = new int[colIndexList.size()];

        colIndexList.toArray(columnMap);

        Expression[] variables = new Expression[variableNames.size()];

        variableNames.toArray(variables);

        targetTypes = new Type[variables.length];

        for (int i = 0; i < variables.length; i++) {
            if (variables[i].getColumn().getParameterMode()
                    == SchemaObject.ParameterModes.PARAM_IN) {

                // todo - use more specific error message
                throw Error.parseError(ErrorCode.X_0U000, null,
                                       scanner.getLineNumber());
            }

            targetTypes[i] = variables[i].getDataType();
        }

        select.setReturningResult();
        select.resolve(session, rangeGroups, targetTypes);

        if (select.getColumnCount() != variables.length) {
            throw Error.error(ErrorCode.X_42564, Tokens.T_INTO);
        }

        Statement statement = new StatementSet(session, variables, select,
                                               columnMap, compileContext);

        return statement;
    }

    /**
     * Creates GET DIAGNOSTICS.
     */
    Statement compileGetStatement(RangeGroup[] rangeGroups) {

        read();
        readThis(Tokens.DIAGNOSTICS);

        OrderedHashSet  targetSet    = new OrderedHashSet();
        HsqlArrayList   exprList     = new HsqlArrayList();
        LongDeque       colIndexList = new LongDeque();
        RangeVariable[] rangeVars    = rangeGroups[0].getRangeVariables();

        readGetClauseList(rangeVars, targetSet, colIndexList, exprList);

        if (exprList.size() > 1) {
            throw Error.parseError(ErrorCode.X_42602, null,
                                   scanner.getLineNumber());
        }

        Expression expression = (Expression) exprList.get(0);

        if (expression.getDegree() != targetSet.size()) {
            throw Error.error(ErrorCode.X_42546, Tokens.T_SET);
        }

        int[] columnMap = new int[colIndexList.size()];

        colIndexList.toArray(columnMap);

        Expression[] targets = new Expression[targetSet.size()];

        targetSet.toArray(targets);

        for (int i = 0; i < targets.length; i++) {
            resolveOuterReferencesAndTypes(rangeGroups, targets[i]);
        }

        resolveOuterReferencesAndTypes(rangeGroups, expression);

        for (int i = 0; i < targets.length; i++) {
            if (targets[i].getColumn().getParameterMode()
                    == SchemaObject.ParameterModes.PARAM_IN) {

                // todo - use more specific error message
                throw Error.parseError(ErrorCode.X_0U000, null,
                                       scanner.getLineNumber());
            }

            if (!targets[i].getDataType().canBeAssignedFrom(
                    expression.getNodeDataType(i))) {
                throw Error.parseError(ErrorCode.X_42561, null,
                                       scanner.getLineNumber());
            }
        }

        StatementSet cs = new StatementSet(session, targets, expression,
                                           columnMap, compileContext);

        return cs;
    }

    /**
     * Creates SET Statement for PSM or session variables from this parse context.
     */
    StatementSet compileSetStatement(RangeGroup[] rangeGroups,
                                     RangeVariable[] rangeVars) {

        OrderedHashSet targetSet    = new OrderedHashSet();
        HsqlArrayList  exprList     = new HsqlArrayList();
        LongDeque      colIndexList = new LongDeque();

        readSetClauseList(rangeVars, targetSet, colIndexList, exprList);

        if (exprList.size() > 1) {
            throw Error.parseError(ErrorCode.X_42602, null,
                                   scanner.getLineNumber());
        }

        Expression expression = (Expression) exprList.get(0);

        if (expression.getDegree() != targetSet.size()) {
            throw Error.error(ErrorCode.X_42546, Tokens.T_SET);
        }

        int[] columnMap = new int[colIndexList.size()];

        colIndexList.toArray(columnMap);

        Expression[] targets = new Expression[targetSet.size()];

        targetSet.toArray(targets);

        for (int i = 0; i < targets.length; i++) {
            resolveOuterReferencesAndTypes(rangeGroups, targets[i]);
        }

        resolveOuterReferencesAndTypes(rangeGroups, expression);

        for (int i = 0; i < targets.length; i++) {
            ColumnSchema col = targets[i].getColumn();

            if (col.getParameterMode()
                    == SchemaObject.ParameterModes.PARAM_IN) {

                // todo - use more specific error message
                throw Error.error(ErrorCode.X_0U000,
                                  col.getName().statementName);
            }

            if (!targets[i].getDataType().canBeAssignedFrom(
                    expression.getNodeDataType(i))) {
                throw Error.parseError(ErrorCode.X_42561, null,
                                       scanner.getLineNumber());
            }
        }

        StatementSet cs = new StatementSet(session, targets, expression,
                                           columnMap, compileContext);

        return cs;
    }

    /**
     * Creates SET Statement for a trigger row from this parse context.
     */
    StatementDMQL compileTriggerSetStatement(Table table,
            RangeGroup[] rangeGroups) {

        Expression[]   updateExpressions;
        int[]          columnMap;
        OrderedHashSet targetSet = new OrderedHashSet();
        HsqlArrayList  exprList  = new HsqlArrayList();
        RangeVariable[] targetRangeVars = new RangeVariable[]{
            rangeGroups[0].getRangeVariables()[TriggerDef.NEW_ROW] };
        LongDeque colIndexList = new LongDeque();

        readSetClauseList(targetRangeVars, targetSet, colIndexList, exprList);

        columnMap = new int[colIndexList.size()];

        colIndexList.toArray(columnMap);

        Expression[] targets = new Expression[targetSet.size()];

        targetSet.toArray(targets);

        for (int i = 0; i < targets.length; i++) {
            resolveOuterReferencesAndTypes(RangeGroup.emptyArray, targets[i]);
        }

        updateExpressions = new Expression[exprList.size()];

        exprList.toArray(updateExpressions);
        resolveUpdateExpressions(table, RangeGroup.emptyGroup, columnMap,
                                 updateExpressions, rangeGroups);

        StatementDMQL cs = new StatementSet(session, targets, table,
                                            rangeGroups[0].getRangeVariables(),
                                            columnMap, updateExpressions,
                                            compileContext);

        return cs;
    }

    StatementSchema compileAlterSpecificRoutine() {

        boolean restrict = false;

        readThis(Tokens.SPECIFIC);
        readThis(Tokens.ROUTINE);

        Routine routine =
            (Routine) readSchemaObjectName(SchemaObject.SPECIFIC_ROUTINE);

        routine = routine.duplicate();

        readRoutineCharacteristics(routine);

        restrict = readIfThis(Tokens.RESTRICT);

        if (restrict) {
            OrderedHashSet set = database.schemaManager.getReferencesTo(
                routine.getSpecificName());

            if (!set.isEmpty()) {
                throw Error.parseError(ErrorCode.X_42502, null,
                                       scanner.getLineNumber());
            }
        }

        if (token.tokenType == Tokens.BODY) {
            read();
        } else if (token.tokenType == Tokens.NAME) {
            read();
        }

        readRoutineBody(routine);
        routine.resetAlteredRoutineSettings();
        routine.resolve(session);

        Object[] args = new Object[]{ routine };
        String   sql  = getLastPart();
        StatementSchema cs = new StatementSchema(sql,
            StatementTypes.ALTER_ROUTINE, args, null,
            database.schemaManager.getCatalogNameArray());

        return cs;
    }

    // SQL-invoked routine
    StatementSchema compileCreateProcedureOrFunction(boolean orReplace) {

        Routine  routine = readCreateProcedureOrFunction();
        Object[] args    = new Object[]{ routine };
        String   sql     = getLastPart();
        StatementSchema cs = new StatementSchema(sql,
            StatementTypes.CREATE_ROUTINE, args, null,
            database.schemaManager.getCatalogNameArray());

        return cs;
    }

    Routine readCreateProcedureOrFunction() {

        Routine routine = readProcedureOrFunctionDeclaration();

        readRoutineBody(routine);

        return routine;
    }

    Routine readProcedureOrFunctionDeclaration() {

        int     routineType;
        boolean isAggregate = false;

        if (token.tokenType == Tokens.AGGREGATE) {
            isAggregate = true;

            read();

            if (token.tokenType == Tokens.PROCEDURE) {
                throw unexpectedToken();
            }
        }

        routineType = token.tokenType == Tokens.PROCEDURE
                      ? SchemaObject.PROCEDURE
                      : SchemaObject.FUNCTION;

        HsqlName name;

        read();

        name = readNewSchemaObjectName(routineType, true);

        name.setSchemaIfNull(session.getCurrentSchemaHsqlName());

        Routine routine = new Routine(routineType);

        routine.setName(name);
        routine.setAggregate(isAggregate);
        readRoutineArguments(routine);

        if (routineType != SchemaObject.PROCEDURE) {
            readThis(Tokens.RETURNS);

            if (token.tokenType == Tokens.TABLE) {
                read();

                TableDerived table =
                    new TableDerived(database, SqlInvariants.MODULE_HSQLNAME,
                                     TableBase.FUNCTION_TABLE);

                readTableDefinition(routine, table);
                routine.setReturnTable(table);
            } else {
                Type type = readTypeDefinition(false, true);

                routine.setReturnType(type);
            }
        }

        readRoutineCharacteristics(routine);

        return routine;
    }

    void readRoutineArguments(Routine routine) {

        readThis(Tokens.OPENBRACKET);

        if (token.tokenType == Tokens.CLOSEBRACKET) {
            read();
        } else {
            while (true) {
                ColumnSchema newcolumn = readRoutineParameter(routine, true);

                routine.addParameter(newcolumn);

                if (token.tokenType == Tokens.COMMA) {
                    read();
                } else {
                    readThis(Tokens.CLOSEBRACKET);

                    break;
                }
            }
        }
    }

    Routine readCreatePasswordCheckFunction() {

        Routine routine = new Routine(SchemaObject.FUNCTION);

        if (token.tokenType == Tokens.NONE) {
            read();

            return null;
        } else if (token.tokenType == Tokens.EXTERNAL) {
            routine.setLanguage(Routine.LANGUAGE_JAVA);
            routine.setDataImpact(Routine.NO_SQL);
        } else {
            routine.setLanguage(Routine.LANGUAGE_SQL);
            routine.setDataImpact(Routine.CONTAINS_SQL);
        }

        HsqlName hsqlName = database.nameManager.newHsqlName(Tokens.T_PASSWORD,
            false, SchemaObject.FUNCTION);

        hsqlName.setSchemaIfNull(SqlInvariants.SYSTEM_SCHEMA_HSQLNAME);
        routine.setName(hsqlName);

        hsqlName = database.nameManager.newHsqlName(Tokens.T_PASSWORD, false,
                SchemaObject.PARAMETER);

        ColumnSchema column = new ColumnSchema(hsqlName, Type.SQL_VARCHAR,
                                               false, false, null);

        routine.addParameter(column);
        routine.setReturnType(Type.SQL_BOOLEAN);
        readRoutineBody(routine);
        routine.resolve(session);

        return routine;
    }

    Routine readCreateDatabaseAuthenticationFunction() {

        Routine routine = new Routine(SchemaObject.FUNCTION);

        if (token.tokenType == Tokens.NONE) {
            read();

            return null;
        }

        checkIsThis(Tokens.EXTERNAL);
        routine.setLanguage(Routine.LANGUAGE_JAVA);
        routine.setDataImpact(Routine.NO_SQL);
        routine.setName(
            database.nameManager.newHsqlName(
                Tokens.T_AUTHENTICATION, false, SchemaObject.FUNCTION));

        for (int i = 0; i < 3; i++) {
            ColumnSchema column = new ColumnSchema(null, Type.SQL_VARCHAR,
                                                   false, false, null);

            routine.addParameter(column);
        }

        routine.setReturnType(
            new ArrayType(
                Type.SQL_VARCHAR_DEFAULT, ArrayType.defaultArrayCardinality));
        readRoutineBody(routine);
        routine.resolve(session);

        return routine;
    }

    private void readTableDefinition(Routine routine, Table table) {

        readThis(Tokens.OPENBRACKET);

        for (int i = 0; ; i++) {
            ColumnSchema newcolumn = readRoutineParameter(routine, false);

            if (newcolumn.getName() == null) {
                throw unexpectedToken();
            }

            table.addColumn(newcolumn);

            if (token.tokenType == Tokens.COMMA) {
                read();
            } else {
                readThis(Tokens.CLOSEBRACKET);

                break;
            }
        }

        table.createPrimaryKey();
    }

    private void readRoutineCharacteristics(Routine routine) {

        OrderedIntHashSet set = new OrderedIntHashSet();
        boolean           end = false;

        while (!end) {
            switch (token.tokenType) {

                case Tokens.LANGUAGE : {
                    if (!set.add(Tokens.LANGUAGE)) {
                        throw unexpectedToken();
                    }

                    read();

                    if (token.tokenType == Tokens.JAVA) {
                        read();
                        routine.setLanguage(Routine.LANGUAGE_JAVA);
                    } else if (token.tokenType == Tokens.SQL) {
                        read();
                        routine.setLanguage(Routine.LANGUAGE_SQL);
                    } else {
                        throw unexpectedToken();
                    }

                    break;
                }
                case Tokens.PARAMETER : {
                    if (!set.add(Tokens.PARAMETER)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.STYLE);

                    if (token.tokenType == Tokens.JAVA) {
                        read();
                        routine.setParameterStyle(Routine.PARAM_STYLE_JAVA);
                    } else {
                        readThis(Tokens.SQL);
                        routine.setParameterStyle(Routine.PARAM_STYLE_SQL);
                    }

                    break;
                }
                case Tokens.SPECIFIC : {
                    if (!set.add(Tokens.SPECIFIC)) {
                        throw unexpectedToken();
                    }

                    read();

                    HsqlName name =
                        readNewSchemaObjectName(SchemaObject.SPECIFIC_ROUTINE,
                                                false);

                    routine.setSpecificName(name);

                    break;
                }
                case Tokens.DETERMINISTIC : {
                    if (!set.add(Tokens.DETERMINISTIC)) {
                        throw unexpectedToken();
                    }

                    read();
                    routine.setDeterministic(true);

                    break;
                }
                case Tokens.NOT : {
                    if (!set.add(Tokens.DETERMINISTIC)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.DETERMINISTIC);
                    routine.setDeterministic(false);

                    break;
                }
                case Tokens.MODIFIES : {
                    if (!set.add(Tokens.SQL)) {
                        throw unexpectedToken();
                    }

                    if (routine.getType() == SchemaObject.FUNCTION) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.SQL);
                    readThis(Tokens.DATA);
                    routine.setDataImpact(Routine.MODIFIES_SQL);

                    break;
                }
                case Tokens.NO : {
                    if (!set.add(Tokens.SQL)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.SQL);
                    routine.setDataImpact(Routine.NO_SQL);

                    break;
                }
                case Tokens.READS : {
                    if (!set.add(Tokens.SQL)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.SQL);
                    readThis(Tokens.DATA);
                    routine.setDataImpact(Routine.READS_SQL);

                    break;
                }
                case Tokens.CONTAINS : {
                    if (!set.add(Tokens.SQL)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.SQL);
                    routine.setDataImpact(Routine.CONTAINS_SQL);

                    break;
                }
                case Tokens.RETURNS : {
                    if (!set.add(Tokens.NULL) || routine.isProcedure()) {
                        throw unexpectedToken();
                    }

                    if (routine.isAggregate()) {
                        throw Error.error(ErrorCode.X_42604,
                                          token.tokenString);
                    }

                    read();
                    readThis(Tokens.NULL);
                    readThis(Tokens.ON);
                    readThis(Tokens.NULL);
                    readThis(Tokens.INPUT);
                    routine.setNullInputOutput(true);

                    break;
                }
                case Tokens.CALLED : {
                    if (!set.add(Tokens.NULL) || routine.isProcedure()) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.ON);
                    readThis(Tokens.NULL);
                    readThis(Tokens.INPUT);
                    routine.setNullInputOutput(false);

                    break;
                }
                case Tokens.DYNAMIC : {
                    if (!set.add(Tokens.RESULT) || routine.isFunction()) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.RESULT);
                    readThis(Tokens.SETS);

                    int results = readInteger();

                    if (results < 0 || results > 16) {
                        throw Error.error(ErrorCode.X_42604,
                                          String.valueOf(results));
                    }

                    routine.setMaxDynamicResults(results);

                    break;
                }
                case Tokens.NEW : {
                    if (routine.getType() == SchemaObject.FUNCTION
                            || !set.add(Tokens.SAVEPOINT)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.SAVEPOINT);
                    readThis(Tokens.LEVEL);
                    routine.setNewSavepointLevel(true);

                    break;
                }
                case Tokens.OLD : {
                    if (routine.getType() == SchemaObject.FUNCTION
                            || !set.add(Tokens.SAVEPOINT)) {
                        throw unexpectedToken();
                    }

                    read();
                    readThis(Tokens.SAVEPOINT);
                    readThis(Tokens.LEVEL);
                    routine.setNewSavepointLevel(false);

                    throw unsupportedFeature(Tokens.T_OLD);

                    // break;
                }
                default :
                    end = true;
                    break;
            }
        }
    }

    void readRoutineBody(Routine routine) {

        if (token.tokenType == Tokens.EXTERNAL) {
            readRoutineJavaBody(routine);
        } else {
            readRoutineSQLBody(routine);
        }
    }

    void readRoutineSQLBody(Routine routine) {

        startRecording();
        session.sessionContext.pushRoutineTables();

        try {
            Statement statement = compileSQLProcedureStatementOrNull(routine,
                null);

            if (statement == null) {
                throw unexpectedToken();
            }

            Token[] tokenisedStatement = getRecordedStatement();
            String  sql                = Token.getSQL(tokenisedStatement);

            statement.setSQL(sql);
            routine.setProcedure(statement);
        } finally {
            session.sessionContext.popRoutineTables();
        }
    }

    void readRoutineJavaBody(Routine routine) {

        if (routine.getLanguage() != Routine.LANGUAGE_JAVA) {
            throw unexpectedToken();
        }

        read();
        readThis(Tokens.NAME);
        checkIsQuotedString();
        routine.setMethodURL((String) token.tokenValue);
        read();

        if (token.tokenType == Tokens.PARAMETER) {
            read();
            readThis(Tokens.STYLE);
            readThis(Tokens.JAVA);
        }
    }

    /*
        <SQL control statement> ::=
        <call statement>
        | <return statement>

        <compound statement>
        <case statement>
        <if statement>
        <iterate statement>
        <leave statement>
        <loop statement>
        <while statement>
        <repeat statement>
       <for statement>
       <assignment statement> SET (,,,) = (,,,) or SET a = b


     */
    Object[] readLocalDeclarationList(Routine routine,
                                      StatementCompound context) {

        HsqlArrayList list                = new HsqlArrayList();
        final int     table               = 0;
        final int     variableOrCondition = 1;
        final int     cursor              = 2;
        final int     handler             = 3;
        int           objectType          = table;
        RangeGroup[]  rangeGroups         = new RangeGroup[1];

        rangeGroups[0] = context == null ? routine
                                         : context;

        compileContext.setOuterRanges(rangeGroups);

        while (token.tokenType == Tokens.DECLARE) {
            Object var = null;

            if (objectType == table) {
                var = readLocalTableVariableDeclarationOrNull(routine);

                if (var == null) {
                    objectType = variableOrCondition;
                } else {
                    list.add(var);
                    readThis(Tokens.SEMICOLON);
                }
            } else if (objectType == variableOrCondition) {
                var = readLocalVariableDeclarationOrNull();

                if (var == null) {
                    objectType = cursor;
                } else {
                    list.addAll((Object[]) var);
                }
            } else if (objectType == cursor) {
                var = compileDeclareCursorOrNull(rangeGroups, true);

                if (var == null) {
                    objectType = handler;
                } else {
                    list.add(var);
                    readThis(Tokens.SEMICOLON);
                }
            } else if (objectType == handler) {
                var = compileLocalHandlerDeclaration(routine, context);

                list.add(var);
            }
        }

        Object[] declarations = new Object[list.size()];

        list.toArray(declarations);

        return declarations;
    }

    Table readLocalTableVariableDeclarationOrNull(Routine routine) {

        int position = getPosition();

        readThis(Tokens.DECLARE);

        if (token.tokenType == Tokens.TABLE) {
            read();

            HsqlName name = readNewSchemaObjectName(SchemaObject.TABLE, false);

            name.schema = SqlInvariants.MODULE_HSQLNAME;

            Table table = new Table(database, name, TableBase.TEMP_TABLE);

            table.persistenceScope = TableBase.SCOPE_ROUTINE;

            readTableDefinition(routine, table);
            session.sessionContext.addSessionTable(table);

            return table;
        } else {
            rewind(position);

            return null;
        }
    }

    ColumnSchema[] readLocalVariableDeclarationOrNull() {

        int           position = getPosition();
        Type          type;
        HsqlArrayList names = new HsqlArrayList();

        try {
            readThis(Tokens.DECLARE);

            if (isReservedKey()) {
                rewind(position);

                return null;
            }

            while (true) {
                HsqlName name = readNewSchemaObjectName(SchemaObject.VARIABLE,
                    false);

                if (token.tokenType == Tokens.CONDITION) {
                    rewind(position);

                    return null;
                }

                names.add(name);

                if (token.tokenType == Tokens.COMMA) {
                    read();
                } else {
                    break;
                }
            }

            type = readTypeDefinition(false, true);
        } catch (HsqlException e) {

            // may be cursor
            rewind(position);

            return null;
        }

        Expression def = null;

        if (token.tokenType == Tokens.DEFAULT) {
            read();

            def = readDefaultClause(type);
        }

        ColumnSchema[] variable = new ColumnSchema[names.size()];

        for (int i = 0; i < names.size(); i++) {
            variable[i] = new ColumnSchema((HsqlName) names.get(i), type,
                                           true, false, def);

            variable[i].setParameterMode(
                SchemaObject.ParameterModes.PARAM_INOUT);
        }

        readThis(Tokens.SEMICOLON);

        return variable;
    }

    private StatementHandler compileLocalHandlerDeclaration(Routine routine,
            StatementCompound context) {

        int handlerType;

        readThis(Tokens.DECLARE);

        switch (token.tokenType) {

            case Tokens.CONTINUE :
                read();

                handlerType = StatementHandler.CONTINUE;
                break;

            case Tokens.EXIT :
                read();

                handlerType = StatementHandler.EXIT;
                break;

            case Tokens.UNDO :
                read();

                handlerType = StatementHandler.UNDO;
                break;

            default :
                throw unexpectedToken();
        }

        readThis(Tokens.HANDLER);
        readThis(Tokens.FOR);

        StatementHandler handler = new StatementHandler(handlerType);
        boolean          end     = false;
        boolean          start   = true;

        while (!end) {
            int conditionType = StatementHandler.NONE;

            switch (token.tokenType) {

                case Tokens.COMMA :
                    if (start) {
                        throw unexpectedToken();
                    }

                    read();

                    start = true;
                    break;

                case Tokens.SQLSTATE :
                    conditionType = StatementHandler.SQL_STATE;

                // fall through
                case Tokens.SQLEXCEPTION :
                    if (conditionType == StatementHandler.NONE) {
                        conditionType = StatementHandler.SQL_EXCEPTION;
                    }

                // fall through
                case Tokens.SQLWARNING :
                    if (conditionType == StatementHandler.NONE) {
                        conditionType = StatementHandler.SQL_WARNING;
                    }

                // fall through
                case Tokens.NOT :
                    if (conditionType == StatementHandler.NONE) {
                        conditionType = StatementHandler.SQL_NOT_FOUND;
                    }

                    if (!start) {
                        throw unexpectedToken();
                    }

                    start = false;

                    read();

                    if (conditionType == StatementHandler.SQL_NOT_FOUND) {
                        readThis(Tokens.FOUND);
                    } else if (conditionType == StatementHandler.SQL_STATE) {
                        String sqlState = parseSQLStateValue();

                        handler.addConditionState(sqlState);

                        break;
                    }

                    handler.addConditionType(conditionType);
                    break;

                default :
                    if (start) {
                        throw unexpectedToken();
                    }

                    end = true;
                    break;
            }
        }

        if (token.tokenType == Tokens.SEMICOLON) {
            read();
        } else {
            Statement e = compileSQLProcedureStatementOrNull(routine, context);

            if (e == null) {
                throw unexpectedToken();
            }

            readThis(Tokens.SEMICOLON);
            handler.addStatement(e);
        }

        return handler;
    }

    String parseSQLStateValue() {

        readIfThis(Tokens.VALUE);
        checkIsQuotedString();

        String sqlState = token.tokenString;

        if (sqlState.length() != 5) {
            throw Error.parseError(ErrorCode.X_42607, null,
                                   scanner.getLineNumber());
        }

        read();

        return sqlState;
    }

    static String[] featureStrings = new String[]{ "H901_03" };

    String parseSQLFeatureValue() {

        if (!isUndelimitedSimpleName()) {
            throw Error.parseError(ErrorCode.X_42555, token.tokenString,
                                   scanner.getLineNumber());
        }

        String sqlFeature = token.tokenString;
        int    index      = ArrayUtil.find(featureStrings, sqlFeature);

        if (index < 0) {
            throw Error.parseError(ErrorCode.X_42555, token.tokenString,
                                   scanner.getLineNumber());
        }

        read();

        return sqlFeature;
    }

    Statement compileCompoundStatement(Routine routine,
                                       StatementCompound context,
                                       HsqlName label) {

        final boolean atomic = true;

        readThis(Tokens.BEGIN);
        readThis(Tokens.ATOMIC);

        label = createLabelIfNull(context, label);

        StatementCompound statement =
            new StatementCompound(StatementTypes.BEGIN_END, label, context);

        statement.setAtomic(atomic);
        statement.setRoot(routine);

        Object[] declarations = readLocalDeclarationList(routine, context);

        statement.setLocalDeclarations(declarations);

        Statement[] statements = compileSQLProcedureStatementList(routine,
            statement);

        statement.setStatements(statements);
        readThis(Tokens.END);

        if (isSimpleName() && !isReservedKey()) {
            if (label == null) {
                throw unexpectedToken();
            }

            if (!label.name.equals(token.tokenString)) {
                throw Error.error(ErrorCode.X_42508, token.tokenString);
            }

            read();
        }

        return statement;
    }

    HsqlName createLabelIfNull(StatementCompound context, HsqlName label) {

        if (label != null) {
            return label;
        }

        String            labelString;
        StatementCompound parent = context;
        int               level  = 0;

        while (parent != null) {
            level++;

            parent = parent.parent;
        }

        labelString = "_" + level;
        label = session.database.nameManager.newHsqlName(labelString, false,
                SchemaObject.LABEL);

        return label;
    }

    Statement[] compileSQLProcedureStatementList(Routine routine,
            StatementCompound context) {

        Statement     e;
        HsqlArrayList list = new HsqlArrayList();

        while (true) {
            e = compileSQLProcedureStatementOrNull(routine, context);

            if (e == null) {
                break;
            }

            readThis(Tokens.SEMICOLON);
            list.add(e);
        }

        if (list.size() == 0) {
            throw unexpectedToken();
        }

        Statement[] statements = new Statement[list.size()];

        list.toArray(statements);

        return statements;
    }

    Statement compileSQLProcedureStatementOrNull(Routine routine,
            StatementCompound context) {

        Statement    cs          = null;
        HsqlName     label       = null;
        RangeGroup   rangeGroup  = context == null ? routine
                                                   : context;
        RangeGroup[] rangeGroups = new RangeGroup[]{ rangeGroup };

        if (!routine.isTrigger() && isSimpleName() && !isReservedKey()) {
            label = readLabel();
        }

        compileContext.reset();

        HsqlName oldSchema = session.getCurrentSchemaHsqlName();

        session.setCurrentSchemaHsqlName(routine.getSchemaName());

        try {
            switch (token.tokenType) {

                // data
                case Tokens.OPEN : {
                    if (routine.dataImpact == Routine.CONTAINS_SQL) {
                        throw Error.error(ErrorCode.X_42602,
                                          routine.getDataImpactString());
                    }

                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileOpenCursorStatement(context);

                    break;
                }
                case Tokens.SELECT : {
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileSelectSingleRowStatement(rangeGroups);

                    break;
                }

                // data change
                case Tokens.INSERT :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileInsertStatement(rangeGroups);
                    break;

                case Tokens.UPDATE :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileUpdateStatement(rangeGroups);
                    break;

                case Tokens.DELETE :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileDeleteStatement(rangeGroups);
                    break;

                case Tokens.TRUNCATE :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileTruncateStatement();
                    break;

                case Tokens.MERGE :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileMergeStatement(rangeGroups);
                    break;

                case Tokens.SET :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    read();

                    if (routine.isTrigger()) {
                        if (routine.triggerType == TriggerDef.BEFORE
                                && routine.triggerOperation
                                   != StatementTypes.DELETE_WHERE) {
                            int position = getPosition();

                            try {
                                cs = compileTriggerSetStatement(
                                    routine.triggerTable, rangeGroups);

                                break;
                            } catch (HsqlException e) {
                                rewind(position);

                                cs = compileSetStatement(
                                    rangeGroups,
                                    rangeGroup.getRangeVariables());
                            }
                        } else {
                            cs = compileSetStatement(
                                rangeGroups, rangeGroup.getRangeVariables());
                        }

                        ((StatementSet) cs).checkIsNotColumnTarget();
                    } else {
                        cs = compileSetStatement(
                            rangeGroups, rangeGroup.getRangeVariables());
                    }
                    break;

                case Tokens.GET :
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileGetStatement(rangeGroups);
                    break;

                // control
                case Tokens.CALL : {
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileCallStatement(rangeGroups, true);

                    Routine proc = ((StatementProcedure) cs).procedure;

                    if (proc != null) {
                        switch (routine.dataImpact) {

                            case Routine.CONTAINS_SQL : {
                                if (proc.dataImpact == Routine.READS_SQL
                                        || proc.dataImpact
                                           == Routine.MODIFIES_SQL) {
                                    throw Error.error(
                                        ErrorCode.X_42602,
                                        routine.getDataImpactString());
                                }

                                break;
                            }
                            case Routine.READS_SQL : {
                                if (proc.dataImpact == Routine.MODIFIES_SQL) {
                                    throw Error.error(
                                        ErrorCode.X_42602,
                                        routine.getDataImpactString());
                                }

                                break;
                            }
                        }
                    }

                    break;
                }
                case Tokens.RETURN : {
                    if (routine.isTrigger() || label != null) {
                        throw unexpectedToken();
                    }

                    read();

                    cs = compileReturnValue(routine, context);

                    break;
                }
                case Tokens.BEGIN : {
                    cs = compileCompoundStatement(routine, context, label);

                    break;
                }
                case Tokens.WHILE : {
                    if (routine.isTrigger()) {
                        throw unexpectedToken();
                    }

                    cs = compileWhile(routine, context, label);

                    break;
                }
                case Tokens.REPEAT : {
                    cs = compileRepeat(routine, context, label);

                    break;
                }
                case Tokens.LOOP : {
                    cs = compileLoop(routine, context, label);

                    break;
                }
                case Tokens.FOR : {
                    cs = compileFor(routine, context, label);

                    break;
                }
                case Tokens.ITERATE : {
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileIterate();

                    break;
                }
                case Tokens.LEAVE : {
                    if (label != null) {
                        throw unexpectedToken();
                    }

                    cs = compileLeave(routine, context);

                    break;
                }
                case Tokens.IF : {
                    cs = compileIf(routine, context);

                    break;
                }
                case Tokens.CASE : {
                    cs = compileCase(routine, context);

                    break;
                }
                case Tokens.SIGNAL : {
                    cs = compileSignal(routine, context, label);

                    break;
                }
                case Tokens.RESIGNAL : {
                    cs = compileResignal(routine, context, label);

                    break;
                }
                default :
                    return null;
            }

            cs.setRoot(routine);
            cs.setParent(context);

            return cs;
        } finally {
            session.setCurrentSchemaHsqlName(oldSchema);
        }
    }

    HsqlName readLabel() {

        HsqlName label = readNewSchemaObjectName(SchemaObject.LABEL, false);

        if (token.tokenType != Tokens.COLON) {
            throw unexpectedToken(label.getNameString());
        }

        readThis(Tokens.COLON);

        return label;
    }

    Statement compileReturnValue(Routine routine, StatementCompound context) {

        RangeGroup[] rangeGroups = new RangeGroup[1];

        rangeGroups[0] = context == null ? routine
                                         : context;

        compileContext.setOuterRanges(rangeGroups);

        Expression e = XreadValueExpressionOrNull();

        if (e == null) {
            throw unexpectedToken();
        }

        resolveOuterReferencesAndTypes(routine, context, e);

        if (routine.isProcedure()) {
            throw Error.parseError(ErrorCode.X_42602, null,
                                   scanner.getLineNumber());
        }

        if (routine.returnsTable()) {
            if (e.getType() != OpTypes.TABLE_SUBQUERY) {
                throw Error.parseError(ErrorCode.X_42611, null,
                                       scanner.getLineNumber());
            }
        }

        Type returnType   = new RowType(e.getNodeDataTypes());
        Type declaredType = routine.getReturnType();

        if (!declaredType.isRowType()) {
            declaredType = new RowType(new Type[]{ routine.getReturnType() });
        }

        if (declaredType.getDegree() != returnType.getDegree()) {
            throw Error.parseError(ErrorCode.X_42564, null,
                                   scanner.getLineNumber());
        }

        if (!declaredType.canBeAssignedFrom(returnType)) {
            throw Error.parseError(ErrorCode.X_42611, null,
                                   scanner.getLineNumber());
        }

        return new StatementExpression(session, compileContext,
                                       StatementTypes.RETURN, e);
    }

    Statement compileIterate() {

        readThis(Tokens.ITERATE);

        HsqlName label = readNewSchemaObjectName(SchemaObject.LABEL, false);

        return new StatementSimple(StatementTypes.ITERATE, label);
    }

    Statement compileLeave(Routine routine, StatementCompound context) {

        readThis(Tokens.LEAVE);

        HsqlName label = readNewSchemaObjectName(SchemaObject.LABEL, false);

        return new StatementSimple(StatementTypes.LEAVE, label);
    }

    Statement compileWhile(Routine routine, StatementCompound context,
                           HsqlName label) {

        readThis(Tokens.WHILE);

        Expression e = XreadBooleanValueExpression();

        resolveOuterReferencesAndTypes(routine, context, e);

        StatementExpression condition = new StatementExpression(session,
            compileContext, StatementTypes.CONDITION, e);

        readThis(Tokens.DO);

        Statement[] statements = compileSQLProcedureStatementList(routine,
            context);

        readThis(Tokens.END);
        readThis(Tokens.WHILE);

        if (isSimpleName() && !isReservedKey()) {
            if (label == null) {
                throw unexpectedToken();
            }

            if (!label.name.equals(token.tokenString)) {
                throw Error.error(ErrorCode.X_42508, token.tokenString);
            }

            read();
        }

        StatementCompound statement =
            new StatementCompound(StatementTypes.WHILE, label, context);

        statement.setStatements(statements);
        statement.setCondition(condition);

        return statement;
    }

    Statement compileRepeat(Routine routine, StatementCompound context,
                            HsqlName label) {

        readThis(Tokens.REPEAT);

        Statement[] statements = compileSQLProcedureStatementList(routine,
            context);

        readThis(Tokens.UNTIL);

        Expression e = XreadBooleanValueExpression();

        resolveOuterReferencesAndTypes(routine, context, e);

        StatementExpression condition = new StatementExpression(session,
            compileContext, StatementTypes.CONDITION, e);

        readThis(Tokens.END);
        readThis(Tokens.REPEAT);

        if (isSimpleName() && !isReservedKey()) {
            if (label == null) {
                throw unexpectedToken();
            }

            if (!label.name.equals(token.tokenString)) {
                throw Error.error(ErrorCode.X_42508, token.tokenString);
            }

            read();
        }

        StatementCompound statement =
            new StatementCompound(StatementTypes.REPEAT, label, context);

        statement.setStatements(statements);
        statement.setCondition(condition);

        return statement;
    }

    Statement compileLoop(Routine routine, StatementCompound context,
                          HsqlName label) {

        readThis(Tokens.LOOP);

        Statement[] statements = compileSQLProcedureStatementList(routine,
            context);

        readThis(Tokens.END);
        readThis(Tokens.LOOP);

        if (isSimpleName() && !isReservedKey()) {
            if (label == null) {
                throw unexpectedToken();
            }

            if (!label.name.equals(token.tokenString)) {
                throw Error.error(ErrorCode.X_42508, token.tokenString);
            }

            read();
        }

        StatementCompound result = new StatementCompound(StatementTypes.LOOP,
            label, context);

        result.setStatements(statements);

        return result;
    }

    Statement compileFor(Routine routine, StatementCompound context,
                         HsqlName label) {

        RangeGroup[] rangeGroups = new RangeGroup[1];

        rangeGroups[0] = context == null ? routine
                                         : context;

        compileContext.setOuterRanges(rangeGroups);
        readThis(Tokens.FOR);

        StatementQuery cursorStatement =
            compileCursorSpecification(rangeGroups,
                                       ResultProperties.defaultPropsValue,
                                       false);

        readThis(Tokens.DO);

        StatementCompound forStatement =
            new StatementCompound(StatementTypes.FOR, label, context);

        forStatement.setAtomic(true);
        forStatement.setRoot(routine);
        forStatement.setLoopStatement(null, cursorStatement);

        Statement[] statements = compileSQLProcedureStatementList(routine,
            forStatement);

        readThis(Tokens.END);
        readThis(Tokens.FOR);

        if (isSimpleName() && !isReservedKey()) {
            if (label == null) {
                throw unexpectedToken();
            }

            if (!label.name.equals(token.tokenString)) {
                throw Error.error(ErrorCode.X_42508, token.tokenString);
            }

            read();
        }

        forStatement.setStatements(statements);

        return forStatement;
    }

    Statement compileIf(Routine routine, StatementCompound context) {

        HsqlArrayList list = new HsqlArrayList();

        readThis(Tokens.IF);

        Expression e = XreadBooleanValueExpression();

        resolveOuterReferencesAndTypes(routine, context, e);

        Statement statement = new StatementExpression(session, compileContext,
            StatementTypes.CONDITION, e);

        list.add(statement);
        readThis(Tokens.THEN);

        Statement[] statements = compileSQLProcedureStatementList(routine,
            context);

        for (int i = 0; i < statements.length; i++) {
            list.add(statements[i]);
        }

        while (token.tokenType == Tokens.ELSEIF) {
            read();

            e = XreadBooleanValueExpression();

            resolveOuterReferencesAndTypes(routine, context, e);

            statement = new StatementExpression(session, compileContext,
                                                StatementTypes.CONDITION, e);

            list.add(statement);
            readThis(Tokens.THEN);

            statements = compileSQLProcedureStatementList(routine, context);

            for (int i = 0; i < statements.length; i++) {
                list.add(statements[i]);
            }
        }

        if (token.tokenType == Tokens.ELSE) {
            read();

            e = Expression.EXPR_TRUE;
            statement = new StatementExpression(session, compileContext,
                                                StatementTypes.CONDITION, e);

            list.add(statement);

            statements = compileSQLProcedureStatementList(routine, context);

            for (int i = 0; i < statements.length; i++) {
                list.add(statements[i]);
            }
        }

        readThis(Tokens.END);
        readThis(Tokens.IF);

        statements = new Statement[list.size()];

        list.toArray(statements);

        StatementCompound result = new StatementCompound(StatementTypes.IF,
            null, context);

        result.setStatements(statements);

        return result;
    }

    Statement compileCase(Routine routine, StatementCompound context) {

        HsqlArrayList list      = new HsqlArrayList();
        Expression    condition = null;
        Statement     statement;
        Statement[]   statements;

        readThis(Tokens.CASE);

        if (token.tokenType == Tokens.WHEN) {
            list = readCaseWhen(routine, context);
        } else {
            list = readSimpleCaseWhen(routine, context);
        }

        if (token.tokenType == Tokens.ELSE) {
            read();

            condition = Expression.EXPR_TRUE;
            statement = new StatementExpression(session, compileContext,
                                                StatementTypes.CONDITION,
                                                condition);

            list.add(statement);

            statements = compileSQLProcedureStatementList(routine, context);

            for (int i = 0; i < statements.length; i++) {
                list.add(statements[i]);
            }
        }

        readThis(Tokens.END);
        readThis(Tokens.CASE);

        statements = new Statement[list.size()];

        list.toArray(statements);

        StatementCompound result = new StatementCompound(StatementTypes.IF,
            null, context);

        result.setStatements(statements);

        return result;
    }

    HsqlArrayList readSimpleCaseWhen(Routine routine,
                                     StatementCompound context) {

        HsqlArrayList list      = new HsqlArrayList();
        Expression    condition = null;
        Statement     statement;
        Statement[]   statements;
        Expression    predicand = XreadRowValuePredicand();

        do {
            readThis(Tokens.WHEN);

            do {
                Expression newCondition = XreadPredicateRightPart(predicand);

                if (predicand == newCondition) {
                    newCondition =
                        new ExpressionLogical(predicand,
                                              XreadRowValuePredicand());
                }

                resolveOuterReferencesAndTypes(routine, context, newCondition);

                if (condition == null) {
                    condition = newCondition;
                } else {
                    condition = new ExpressionLogical(OpTypes.OR, condition,
                                                      newCondition);
                }

                if (token.tokenType == Tokens.COMMA) {
                    read();
                } else {
                    break;
                }
            } while (true);

            statement = new StatementExpression(session, compileContext,
                                                StatementTypes.CONDITION,
                                                condition);

            list.add(statement);
            readThis(Tokens.THEN);

            statements = compileSQLProcedureStatementList(routine, context);

            for (int i = 0; i < statements.length; i++) {
                list.add(statements[i]);
            }

            if (token.tokenType != Tokens.WHEN) {
                break;
            }
        } while (true);

        return list;
    }

    HsqlArrayList readCaseWhen(Routine routine, StatementCompound context) {

        HsqlArrayList list      = new HsqlArrayList();
        Expression    condition = null;
        Statement     statement;
        Statement[]   statements;

        do {
            readThis(Tokens.WHEN);

            condition = XreadBooleanValueExpression();

            resolveOuterReferencesAndTypes(routine, context, condition);

            statement = new StatementExpression(session, compileContext,
                                                StatementTypes.CONDITION,
                                                condition);

            list.add(statement);
            readThis(Tokens.THEN);

            statements = compileSQLProcedureStatementList(routine, context);

            for (int i = 0; i < statements.length; i++) {
                list.add(statements[i]);
            }

            if (token.tokenType != Tokens.WHEN) {
                break;
            }
        } while (true);

        return list;
    }

    Statement compileSignal(Routine routine, StatementCompound context,
                            HsqlName label) {

        String     sqlState;
        Expression message = null;

        readThis(Tokens.SIGNAL);
        readThis(Tokens.SQLSTATE);

        sqlState = parseSQLStateValue();

        if (readIfThis(Tokens.SET)) {
            readThis(Tokens.MESSAGE_TEXT);
            readThis(Tokens.EQUALS_OP);

            message = XreadSimpleValueSpecificationOrNull();

            if (message == null) {
                throw unexpectedToken();
            }

            resolveOuterReferencesAndTypes(routine, context, message);
        }

        StatementSignal cs = new StatementSignal(StatementTypes.SIGNAL,
            sqlState, message);

        return cs;
    }

    private Statement compileResignal(Routine routine,
                                      StatementCompound context,
                                      HsqlName label) {

        String     sqlState = null;
        Expression message  = null;

        readThis(Tokens.RESIGNAL);

        if (readIfThis(Tokens.SQLSTATE)) {
            sqlState = parseSQLStateValue();

            if (readIfThis(Tokens.SET)) {
                readThis(Tokens.MESSAGE_TEXT);
                readThis(Tokens.EQUALS_OP);

                message = XreadSimpleValueSpecificationOrNull();

                if (message == null) {
                    throw unexpectedToken();
                }

                resolveOuterReferencesAndTypes(routine, context, message);
            }
        }

        StatementSignal cs = new StatementSignal(StatementTypes.RESIGNAL,
            sqlState, message);

        return cs;
    }

    ColumnSchema readRoutineParameter(Routine routine, boolean isParam) {

        HsqlName hsqlName = null;
        int parameterMode = readRoutineParameterMode(routine.routineType,
            routine.isAggregate);

        if (!isReservedKey()) {
            hsqlName = readNewDependentSchemaObjectName(routine.getName(),
                    SchemaObject.PARAMETER);
        }

        Type typeObject = readTypeDefinition(false, true);
        ColumnSchema column = new ColumnSchema(hsqlName, typeObject, true,
                                               false, null);

        if (isParam) {
            column.setParameterMode((byte) parameterMode);
        }

        return column;
    }

    int readRoutineParameterMode(int routineType, boolean isAggregate) {

        int parameterMode = SchemaObject.ParameterModes.PARAM_IN;

        switch (token.tokenType) {

            case Tokens.IN :
                read();
                break;

            case Tokens.OUT :
                if (routineType != SchemaObject.PROCEDURE) {
                    throw unexpectedToken();
                }

                read();

                parameterMode = SchemaObject.ParameterModes.PARAM_OUT;
                break;

            case Tokens.INOUT :
                if (routineType != SchemaObject.PROCEDURE) {
                    if (!isAggregate) {
                        throw unexpectedToken();
                    }
                }

                read();

                parameterMode = SchemaObject.ParameterModes.PARAM_INOUT;
                break;

            default :
        }

        return parameterMode;
    }

    void resolveOuterReferencesAndTypes(Routine routine,
                                        StatementCompound context,
                                        Expression e) {

        RangeGroup rangeGroup = context == null ? routine
                                                : context;

        resolveOuterReferencesAndTypes(new RangeGroup[]{ rangeGroup }, e);
    }

    StatementSchema compileCreateTrigger(boolean orReplace) {

        Table          table;
        Boolean        isForEachRow = null;
        boolean        isNowait     = false;
        boolean        hasQueueSize = false;
        int            queueSize    = 0;
        int            beforeOrAfterType;
        int            operationType;
        String         className;
        TriggerDef     td;
        HsqlName       name;
        HsqlName       otherName           = null;
        OrderedHashSet columns             = null;
        int[]          updateColumnIndexes = null;

        read();

        name = readNewSchemaObjectName(SchemaObject.TRIGGER, true);

        switch (token.tokenType) {

            case Tokens.INSTEAD :
                beforeOrAfterType = TriggerDef.getTiming(Tokens.INSTEAD);

                read();
                readThis(Tokens.OF);
                break;

            case Tokens.BEFORE :
            case Tokens.AFTER :
                beforeOrAfterType = TriggerDef.getTiming(token.tokenType);

                read();
                break;

            default :
                throw unexpectedToken();
        }

        switch (token.tokenType) {

            case Tokens.INSERT :
            case Tokens.DELETE :
                operationType = TriggerDef.getOperationType(token.tokenType);

                read();
                break;

            case Tokens.UPDATE :
                operationType = TriggerDef.getOperationType(token.tokenType);

                read();

                if (token.tokenType == Tokens.OF
                        && beforeOrAfterType != TriggerDef.INSTEAD) {
                    read();

                    columns = new OrderedHashSet();

                    readColumnNameList(columns, null, false);
                }
                break;

            default :
                throw unexpectedToken();
        }

        readThis(Tokens.ON);

        table = readTableName();

        if (token.tokenType == Tokens.BEFORE) {
            read();
            checkIsSimpleName();

            otherName = readNewSchemaObjectName(SchemaObject.TRIGGER, true);
        }

        name.setSchemaIfNull(table.getSchemaName());
        checkSchemaUpdateAuthorisation(name.schema);

        if (beforeOrAfterType == TriggerDef.INSTEAD) {
            if (!table.isView()
                    || ((View) table).getCheckOption()
                       == SchemaObject.ViewCheckModes.CHECK_CASCADE) {
                throw Error.error(ErrorCode.X_42538, name.schema.name);
            }
        } else {
            if (table.isView()) {
                throw Error.error(ErrorCode.X_42538, name.schema.name);
            }
        }

        if (name.schema != table.getSchemaName()) {
            throw Error.error(ErrorCode.X_42505, name.schema.name);
        }

        name.parent = table.getName();

        database.schemaManager.checkSchemaObjectNotExists(name);

        if (columns != null) {
            updateColumnIndexes = table.getColumnIndexes(columns);

            for (int i = 0; i < updateColumnIndexes.length; i++) {
                if (updateColumnIndexes[i] == -1) {
                    throw Error.error(ErrorCode.X_42544,
                                      (String) columns.get(i));
                }
            }
        }

        Expression      condition    = null;
        SimpleName      oldTableName = null;
        SimpleName      newTableName = null;
        SimpleName      oldRowName   = null;
        SimpleName      newRowName   = null;
        Table[]         transitions  = new Table[4];
        RangeVariable[] rangeVars    = new RangeVariable[4];
        String          conditionSQL = null;
        RangeGroup[] rangeGroups = new RangeGroup[]{
            new RangeGroup.RangeGroupSimple(rangeVars, false) };

        if (token.tokenType == Tokens.REFERENCING) {
            read();

            if (token.tokenType != Tokens.OLD
                    && token.tokenType != Tokens.NEW) {
                throw unexpectedToken();
            }

            while (true) {
                if (token.tokenType == Tokens.OLD) {
                    if (operationType == StatementTypes.INSERT) {
                        throw unexpectedToken();
                    }

                    read();

                    if (token.tokenType == Tokens.TABLE) {
                        if (Boolean.TRUE.equals(isForEachRow)
                                || oldTableName != null
                                || beforeOrAfterType == TriggerDef.BEFORE) {
                            throw unexpectedToken();
                        }

                        read();
                        readIfThis(Tokens.AS);
                        checkIsSimpleName();
                        read();

                        oldTableName = HsqlNameManager.getSimpleName(
                            token.tokenString, token.isDelimitedIdentifier);

                        SimpleName n = oldTableName;

                        if (n.equals(newTableName) || n.equals(oldRowName)
                                || n.equals(newRowName)) {
                            throw unexpectedToken();
                        }

                        isForEachRow = Boolean.FALSE;

                        HsqlName hsqlName = database.nameManager.newHsqlName(
                            table.getSchemaName(), n.name,
                            isDelimitedIdentifier(), SchemaObject.TRANSITION);
                        Table transition = new Table(table, hsqlName);
                        RangeVariable range = new RangeVariable(transition,
                            null, null, null, compileContext);

                        transitions[TriggerDef.OLD_TABLE] = transition;
                        rangeVars[TriggerDef.OLD_TABLE]   = range;
                    } else {
                        if (Boolean.FALSE.equals(isForEachRow)
                                || oldRowName != null) {
                            throw unexpectedToken();
                        }

                        readIfThis(Tokens.ROW);
                        readIfThis(Tokens.AS);
                        checkIsSimpleName();

                        oldRowName = HsqlNameManager.getSimpleName(
                            token.tokenString, token.isDelimitedIdentifier);

                        read();

                        SimpleName n = oldRowName;

                        if (n.equals(newTableName) || n.equals(oldTableName)
                                || n.equals(newRowName)) {
                            throw unexpectedToken();
                        }

                        isForEachRow = Boolean.TRUE;

                        RangeVariable range =
                            new RangeVariable(table.columnList, oldRowName,
                                              false,
                                              RangeVariable.TRANSITION_RANGE);

                        range.rangePosition             = TriggerDef.OLD_ROW;
                        transitions[TriggerDef.OLD_ROW] = null;
                        rangeVars[TriggerDef.OLD_ROW]   = range;
                    }
                } else if (token.tokenType == Tokens.NEW) {
                    if (operationType == StatementTypes.DELETE_WHERE) {
                        throw unexpectedToken();
                    }

                    read();

                    if (token.tokenType == Tokens.TABLE) {
                        if (Boolean.TRUE.equals(isForEachRow)
                                || newTableName != null
                                || beforeOrAfterType == TriggerDef.BEFORE) {
                            throw unexpectedToken();
                        }

                        read();
                        readIfThis(Tokens.AS);
                        checkIsSimpleName();

                        newTableName = HsqlNameManager.getSimpleName(
                            token.tokenString, token.isDelimitedIdentifier);

                        read();

                        isForEachRow = Boolean.FALSE;

                        SimpleName n = newTableName;

                        if (n.equals(oldTableName) || n.equals(oldRowName)
                                || n.equals(newRowName)) {
                            throw unexpectedToken();
                        }

                        HsqlName hsqlName = database.nameManager.newHsqlName(
                            table.getSchemaName(), n.name,
                            isDelimitedIdentifier(), SchemaObject.TRANSITION);
                        Table transition = new Table(table, hsqlName);
                        RangeVariable range = new RangeVariable(transition,
                            null, null, null, compileContext);

                        transitions[TriggerDef.NEW_TABLE] = transition;
                        rangeVars[TriggerDef.NEW_TABLE]   = range;
                    } else {
                        if (Boolean.FALSE.equals(isForEachRow)
                                || newRowName != null) {
                            throw unexpectedToken();
                        }

                        readIfThis(Tokens.ROW);
                        readIfThis(Tokens.AS);
                        checkIsSimpleName();

                        newRowName = HsqlNameManager.getSimpleName(
                            token.tokenString, token.isDelimitedIdentifier);

                        read();

                        SimpleName n = newRowName;

                        if (n.equals(oldTableName) || n.equals(newTableName)
                                || n.equals(oldRowName)) {
                            throw unexpectedToken();
                        }

                        isForEachRow = Boolean.TRUE;

                        RangeVariable range =
                            new RangeVariable(table.columnList, newRowName,
                                              false,
                                              RangeVariable.TRANSITION_RANGE);

                        range.rangePosition             = TriggerDef.NEW_ROW;
                        transitions[TriggerDef.NEW_ROW] = null;
                        rangeVars[TriggerDef.NEW_ROW]   = range;
                    }
                } else {
                    break;
                }
            }
        }

        if (Boolean.TRUE.equals(isForEachRow)
                && token.tokenType != Tokens.FOR) {
            throw unexpectedTokenRequire(Tokens.T_FOR);
        }

        if (token.tokenType == Tokens.FOR) {
            read();
            readThis(Tokens.EACH);

            if (token.tokenType == Tokens.ROW) {
                if (Boolean.FALSE.equals(isForEachRow)) {
                    throw unexpectedToken();
                }

                isForEachRow = Boolean.TRUE;
            } else if (token.tokenType == Tokens.STATEMENT) {
                if (Boolean.TRUE.equals(isForEachRow)
                        || beforeOrAfterType == TriggerDef.BEFORE) {
                    throw unexpectedToken();
                }

                isForEachRow = Boolean.FALSE;
            } else {
                throw unexpectedToken();
            }

            read();
        }

        //
        if (rangeVars[TriggerDef.OLD_TABLE] != null) {}

        if (rangeVars[TriggerDef.NEW_TABLE] != null) {}

        //
        if (Tokens.T_QUEUE.equals(token.tokenString)) {
            read();

            queueSize    = readInteger();
            hasQueueSize = true;
        }

        if (Tokens.T_NOWAIT.equals(token.tokenString)) {
            read();

            isNowait = true;
        }

        if (token.tokenType == Tokens.WHEN
                && beforeOrAfterType != TriggerDef.INSTEAD) {
            read();
            readThis(Tokens.OPENBRACKET);

            int position = getPosition();

            isCheckOrTriggerCondition = true;
            condition                 = XreadBooleanValueExpression();
            conditionSQL              = getLastPart(position);
            isCheckOrTriggerCondition = false;

            readThis(Tokens.CLOSEBRACKET);

            HsqlList unresolved = condition.resolveColumnReferences(session,
                rangeGroups[0], rangeGroups, null);

            ExpressionColumn.checkColumnsResolved(unresolved);
            condition.resolveTypes(session, null);

            if (condition.getDataType() != Type.SQL_BOOLEAN) {
                throw Error.error(ErrorCode.X_42568);
            }
        }

        if (isForEachRow == null) {
            isForEachRow = Boolean.FALSE;
        }

        if (token.tokenType == Tokens.CALL) {
            int position = getPosition();

            try {
                read();
                checkIsSimpleName();
                checkIsDelimitedIdentifier();

                className = token.tokenString;

                read();

                if (token.tokenType == Tokens.OPENBRACKET) {
                    throw unexpectedToken();
                }

                td = new TriggerDef(name, beforeOrAfterType, operationType,
                                    isForEachRow.booleanValue(), table,
                                    transitions, rangeVars, condition,
                                    conditionSQL, updateColumnIndexes,
                                    className, isNowait, queueSize);

                String     sql            = getLastPart();
                Object[]   args           = new Object[] {
                    td, otherName
                };
                HsqlName[] writeLockNames = new HsqlName[] {
                    database.getCatalogName(), table.getName()
                };

                return new StatementSchema(sql, StatementTypes.CREATE_TRIGGER,
                                           args, null, writeLockNames);
            } catch (HsqlException e) {
                rewind(position);
            }
        }

        //
        if (hasQueueSize) {
            throw unexpectedToken(Tokens.T_QUEUE);
        }

        if (isNowait) {
            throw unexpectedToken(Tokens.T_NOWAIT);
        }

        Routine routine = compileTriggerRoutine(table, rangeVars,
            beforeOrAfterType, operationType);

        td = new TriggerDefSQL(name, beforeOrAfterType, operationType,
                               isForEachRow.booleanValue(), table,
                               transitions, rangeVars, condition,
                               conditionSQL, updateColumnIndexes, routine);

        String   sql  = getLastPart();
        Object[] args = new Object[] {
            td, otherName
        };

        return new StatementSchema(sql, StatementTypes.CREATE_TRIGGER, args,
                                   null, new HsqlName[] {
            database.getCatalogName(), table.getName()
        });
    }

    Routine compileTriggerRoutine(Table table, RangeVariable[] ranges,
                                  int beforeOrAfter, int operation) {

        int impact = (beforeOrAfter == TriggerDef.BEFORE) ? Routine.READS_SQL
                                                          : Routine
                                                              .MODIFIES_SQL;
        Routine routine = new Routine(table, ranges, impact, beforeOrAfter,
                                      operation);

        session.sessionContext.pushRoutineTables();

        try {
            startRecording();

            StatementCompound parent =
                new StatementCompound(StatementTypes.BEGIN_END, null, null);

            parent.rangeVariables = ranges;

            Statement statement = compileSQLProcedureStatementOrNull(routine,
                null);

            if (statement == null) {
                throw unexpectedToken();
            }

            Token[] tokenisedStatement = getRecordedStatement();
            String  sql                = Token.getSQL(tokenisedStatement);

            statement.setSQL(sql);
            routine.setProcedure(statement);
            routine.resolve(session);
        } finally {
            session.sessionContext.popRoutineTables();
        }

        return routine;
    }

    void checkSchemaUpdateAuthorisation(HsqlName schema) {

        if (session.isProcessingLog()) {
            return;
        }

        SqlInvariants.checkSchemaNameNotSystem(schema.name);

        if (isSchemaDefinition) {
            if (schema != session.getCurrentSchemaHsqlName()) {
                throw Error.error(ErrorCode.X_42505);
            }
        } else {
            session.getGrantee().checkSchemaUpdateOrGrantRights(schema.name);
        }

        session.checkDDLWrite();
    }
}

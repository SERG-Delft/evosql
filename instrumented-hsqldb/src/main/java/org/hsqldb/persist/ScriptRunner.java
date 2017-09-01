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


package org.hsqldb.persist;

import java.io.EOFException;

import org.hsqldb.ColumnSchema;
import org.hsqldb.Database;
import org.hsqldb.HsqlException;
import org.hsqldb.HsqlNameManager.HsqlName;
import org.hsqldb.Row;
import org.hsqldb.Session;
import org.hsqldb.Statement;
import org.hsqldb.StatementDML;
import org.hsqldb.StatementSchema;
import org.hsqldb.StatementTypes;
import org.hsqldb.Table;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.IntKeyHashMap;
import org.hsqldb.map.ValuePool;
import org.hsqldb.result.Result;
import org.hsqldb.scriptio.ScriptReaderBase;
import org.hsqldb.scriptio.ScriptReaderDecode;
import org.hsqldb.scriptio.ScriptReaderText;
import org.hsqldb.types.Type;

/**
 * Restores the state of a Database instance from an SQL log file. <p>
 *
 * If there is an error, processing stops at that line and the message is
 * logged to the application log. If memory runs out, an exception is thrown.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.7.2
 */
public class ScriptRunner {

    /**
     *  This is used to read the *.log file and manage any necessary
     *  transaction rollback.
     */
    public static void runScript(Database database, String logFilename,
                                 boolean fullReplay) {

        Crypto           crypto = database.logger.getCrypto();
        ScriptReaderBase scr;

        try {
            if (crypto == null) {
                scr = new ScriptReaderText(database, logFilename, false);
            } else {
                scr = new ScriptReaderDecode(database, logFilename, crypto,
                                             true);
            }
        } catch (Throwable e) {

            // catch out-of-memory errors and terminate
            if (e instanceof EOFException) {

                // end of file - normal end
            } else {

                // stop processing on bad script line
                database.logger.logSevereEvent("opening log file", e);
            }

            return;
        }

        runScript(database, scr, fullReplay);
    }

    private static void runScript(Database database, ScriptReaderBase scr,
                                  boolean fullReplay) {

        IntKeyHashMap sessionMap = new IntKeyHashMap();
        Session       current    = null;
        int           currentId  = 0;
        String        statement;
        int           statementType;
        Statement dummy = new StatementDML(StatementTypes.UPDATE_CURSOR,
                                           StatementTypes.X_SQL_DATA_CHANGE,
                                           null);
        String databaseFile = database.getCanonicalPath();
        String action       = fullReplay ? "open aborted"
                                         : "open continued";

        dummy.setCompileTimestamp(Long.MAX_VALUE);
        database.setReferentialIntegrity(false);

        try {
            while (scr.readLoggedStatement(current)) {
                int sessionId = scr.getSessionNumber();

                if (current == null || currentId != sessionId) {
                    currentId = sessionId;
                    current   = (Session) sessionMap.get(currentId);

                    if (current == null) {

                        // note the sessionId does not match the sessionId of
                        // new session
                        current =
                            database.getSessionManager().newSessionForLog(
                                database);

                        sessionMap.put(currentId, current);
                    }
                }

                Result result = null;

                statementType = scr.getStatementType();

                switch (statementType) {

                    case ScriptReaderBase.SET_FILES_CHECK_STATEMENT :
                        result = null;
                    case ScriptReaderBase.ANY_STATEMENT :
                        statement = scr.getLoggedStatement();

                        Statement cs;

                        try {
                            cs = current.compileStatement(statement);

                            if (database.getProperties().isVersion18()) {

                                // convert BIT columns in .log to BOOLEAN
                                if (cs.getType()
                                        == StatementTypes.CREATE_TABLE) {
                                    Table table =
                                        (Table) ((StatementSchema) cs)
                                            .getArguments()[0];

                                    for (int i = 0; i < table.getColumnCount();
                                            i++) {
                                        ColumnSchema column =
                                            table.getColumn(i);

                                        if (column.getDataType().isBitType()) {
                                            column.setType(Type.SQL_BOOLEAN);
                                        }
                                    }
                                }
                            }

                            result = current.executeCompiledStatement(cs,
                                    ValuePool.emptyObjectArray, 0);
                        } catch (Throwable e) {
                            result = Result.newErrorResult(e);
                        }

                        if (result != null && result.isError()) {
                            if (result.getException() != null) {
                                throw result.getException();
                            }

                            throw Error.error(result);
                        }
                        break;

                    case ScriptReaderBase.COMMIT_STATEMENT :
                        current.commit(false);
                        break;

                    case ScriptReaderBase.INSERT_STATEMENT : {
                        current.sessionContext.currentStatement = dummy;

                        current.beginAction(dummy);

                        Object[] data = scr.getData();

                        scr.getCurrentTable().insertNoCheckFromLog(current,
                                data);
                        current.endAction(Result.updateOneResult);

                        break;
                    }
                    case ScriptReaderBase.DELETE_STATEMENT : {
                        current.sessionContext.currentStatement = dummy;

                        current.beginAction(dummy);

                        Table           table = scr.getCurrentTable();
                        PersistentStore store = table.getRowStore(current);
                        Object[]        data  = scr.getData();
                        Row row = table.getDeleteRowFromLog(current, data);

                        if (row != null) {
                            current.addDeleteAction(table, store, row, null);
                        }

                        current.endAction(Result.updateOneResult);

                        break;
                    }
                    case ScriptReaderBase.SET_SCHEMA_STATEMENT : {
                        HsqlName name =
                            database.schemaManager.findSchemaHsqlName(
                                scr.getCurrentSchema());

                        current.setCurrentSchemaHsqlName(name);

                        break;
                    }
                    case ScriptReaderBase.SESSION_ID : {
                        break;
                    }
                    default :
                        throw Error.error(ErrorCode.ERROR_IN_LOG_FILE);
                }

                if (current.isClosed()) {
                    current = null;

                    sessionMap.remove(currentId);
                }
            }
        } catch (HsqlException e) {
            if (e.getErrorCode() == -ErrorCode.ERROR_IN_LOG_FILE) {
                throw e;
            }

            // stop processing on bad log line
            String error = "statement error processing log - " + action
                           + scr.getFileNamePath() + " line: "
                           + scr.getLineNumber();

            database.logger.logSevereEvent(error, e);

            if (fullReplay) {
                throw Error.error(e, ErrorCode.ERROR_IN_LOG_FILE, error);
            }
        } catch (OutOfMemoryError e) {
            String error = "out of memory processing log - "
                           + databaseFile + " line: " + scr.getLineNumber();

            // catch out-of-memory errors and terminate
            database.logger.logSevereEvent(error, e);

            throw Error.error(ErrorCode.OUT_OF_MEMORY);
        } catch (Throwable t) {
            HsqlException e =
                Error.error(t, ErrorCode.ERROR_IN_LOG_FILE,
                            ErrorCode.M_DatabaseScriptReader_read,
                            new String[] {
                scr.getLineNumber() + " " + databaseFile, t.getMessage()
            });

            // stop processing on bad script line
            String error = "statement error processing log - " + action
                           + scr.getFileNamePath() + " line: "
                           + scr.getLineNumber();

            database.logger.logSevereEvent(error, e);

            if (fullReplay) {
                throw e;
            }
        } finally {
            if (scr != null) {
                scr.close();
            }

            database.getSessionManager().closeAllSessions();
            database.setReferentialIntegrity(true);
        }
    }
}

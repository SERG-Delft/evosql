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

import org.hsqldb.HsqlException;
import org.hsqldb.Session;
import org.hsqldb.Table;
import org.hsqldb.TableBase;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.index.Index;
import org.hsqldb.lib.HsqlDeque;
import org.hsqldb.lib.Iterator;
import org.hsqldb.lib.LongKeyHashMap;

/**
 * Collection of PersistenceStore items currently used by a session.
 * An item is retrieved based on key returned by
 * TableBase.getPersistenceId().
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class PersistentStoreCollectionSession
implements PersistentStoreCollection {

    private final Session        session;
    private final LongKeyHashMap rowStoreMapSession     = new LongKeyHashMap();
    private LongKeyHashMap       rowStoreMapTransaction = new LongKeyHashMap();
    private LongKeyHashMap       rowStoreMapStatement   = new LongKeyHashMap();
    private LongKeyHashMap       rowStoreMapRoutine     = new LongKeyHashMap();
    private HsqlDeque            rowStoreListStack;

    public PersistentStoreCollectionSession(Session session) {
        this.session = session;
    }

    synchronized public void removeStore(TableBase table) {

        switch (table.persistenceScope) {

            case TableBase.SCOPE_ROUTINE :
                rowStoreMapRoutine.remove(table.getPersistenceId());
                break;

            case TableBase.SCOPE_STATEMENT :
                rowStoreMapStatement.remove(table.getPersistenceId());
                break;

            // TEMP TABLE default, SYSTEM_TABLE + INFO_SCHEMA_TABLE
            case TableBase.SCOPE_FULL :
            case TableBase.SCOPE_TRANSACTION :
                rowStoreMapTransaction.remove(table.getPersistenceId());
                break;

            case TableBase.SCOPE_SESSION :
                rowStoreMapSession.remove(table.getPersistenceId());
                break;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500,
                                         "PersistentStoreCollectionSession");
        }
    }

    synchronized public PersistentStore getViewStore(long persistenceId) {
        return (PersistentStore) rowStoreMapStatement.get(persistenceId);
    }

    synchronized public PersistentStore getStore(TableBase table) {

        PersistentStore store;

        switch (table.persistenceScope) {

            case TableBase.SCOPE_ROUTINE :
                store = (PersistentStore) rowStoreMapRoutine.get(
                    table.getPersistenceId());

                if (store == null) {
                    store = session.database.logger.newStore(session, this,
                            table);

                    rowStoreMapRoutine.put(table.getPersistenceId(), store);
                }

                return store;

            case TableBase.SCOPE_STATEMENT :
                store = (PersistentStore) rowStoreMapStatement.get(
                    table.getPersistenceId());

                if (store == null) {
                    store = session.database.logger.newStore(session, this,
                            table);

                    rowStoreMapStatement.put(table.getPersistenceId(), store);
                }

                return store;

            // TEMP TABLE default, SYSTEM_TABLE + INFO_SCHEMA_TABLE
            case TableBase.SCOPE_FULL :
            case TableBase.SCOPE_TRANSACTION :
                store = (PersistentStore) rowStoreMapTransaction.get(
                    table.getPersistenceId());

                if (store == null) {
                    store = session.database.logger.newStore(session, this,
                            table);

                    rowStoreMapTransaction.put(table.getPersistenceId(),
                                               store);
                }

                if (table.getTableType() == TableBase.INFO_SCHEMA_TABLE) {
                    session.database.dbInfo.setStore(session, (Table) table,
                                                     store);
                }

                return store;

            case TableBase.SCOPE_SESSION :
                store = (PersistentStore) rowStoreMapSession.get(
                    table.getPersistenceId());

                if (store == null) {
                    store = session.database.logger.newStore(session, this,
                            table);

                    rowStoreMapSession.put(table.getPersistenceId(), store);
                }

                return store;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500,
                                         "PersistentStoreCollectionSession");
        }
    }

    synchronized public void clearAllTables() {

        clearSessionTables();
        clearTransactionTables();
        clearStatementTables();
        clearRoutineTables();
        closeSessionDataCache();
    }

    synchronized public void clearResultTables(long actionTimestamp) {

        if (rowStoreMapSession.isEmpty()) {
            return;
        }

        Iterator it = rowStoreMapSession.values().iterator();

        while (it.hasNext()) {
            PersistentStore store = (PersistentStore) it.next();

            if (store.getTimestamp() == actionTimestamp) {
                store.release();
                it.remove();
            }
        }
    }

    synchronized public void clearSessionTables() {

        if (rowStoreMapSession.isEmpty()) {
            return;
        }

        Iterator it = rowStoreMapSession.values().iterator();

        while (it.hasNext()) {
            PersistentStore store = (PersistentStore) it.next();

            store.release();
        }

        rowStoreMapSession.clear();
    }

    synchronized public void clearTransactionTables() {

        if (rowStoreMapTransaction.isEmpty()) {
            return;
        }

        Iterator it = rowStoreMapTransaction.values().iterator();

        while (it.hasNext()) {
            PersistentStore store = (PersistentStore) it.next();

            store.release();
        }

        rowStoreMapTransaction.clear();
    }

    synchronized public void clearStatementTables() {

        if (rowStoreMapStatement.isEmpty()) {
            return;
        }

        Iterator it = rowStoreMapStatement.values().iterator();

        while (it.hasNext()) {
            PersistentStore store = (PersistentStore) it.next();

            store.release();
        }

        rowStoreMapStatement.clear();
    }

    synchronized public void clearRoutineTables() {

        if (rowStoreMapRoutine.isEmpty()) {
            return;
        }

        Iterator it = rowStoreMapRoutine.values().iterator();

        while (it.hasNext()) {
            PersistentStore store = (PersistentStore) it.next();

            store.release();
        }

        rowStoreMapRoutine.clear();
    }

    synchronized public PersistentStore findStore(TableBase table) {

        PersistentStore store = null;

        switch (table.persistenceScope) {

            case TableBase.SCOPE_ROUTINE :
                store = (PersistentStore) rowStoreMapRoutine.get(
                    table.getPersistenceId());
                break;

            case TableBase.SCOPE_STATEMENT :
                store = (PersistentStore) rowStoreMapStatement.get(
                    table.getPersistenceId());
                break;

            // TEMP TABLE default, SYSTEM_TABLE + INFO_SCHEMA_TABLE
            case TableBase.SCOPE_FULL :
            case TableBase.SCOPE_TRANSACTION :
                store = (PersistentStore) rowStoreMapTransaction.get(
                    table.getPersistenceId());
                break;

            case TableBase.SCOPE_SESSION :
                store = (PersistentStore) rowStoreMapSession.get(
                    table.getPersistenceId());
                break;
        }

        return store;
    }

    synchronized public void resetAccessorKeys(Session session, Table table,
            Index[] indexes) {

        PersistentStore store = findStore(table);

        if (store == null) {
            return;
        }

        store.resetAccessorKeys(session, indexes);
    }

    synchronized public void moveData(Table oldTable, Table newTable,
                                      int colIndex, int adjust) {

        PersistentStore store = findStore(oldTable);

        if (store == null) {
            return;
        }

        PersistentStore newStore = getStore(newTable);

        try {
            newStore.moveData(session, store, colIndex, adjust);
        } catch (HsqlException e) {
            newStore.release();
            removeStore(newTable);

            throw e;
        }

        removeStore(oldTable);
    }

    synchronized public void push(boolean isRoutine) {

        if (rowStoreListStack == null) {
            rowStoreListStack = new HsqlDeque();
        }

        Object[] array = rowStoreMapStatement.toArray();

        rowStoreListStack.add(array);
        rowStoreMapStatement.clear();

        if (isRoutine) {
            array = rowStoreMapRoutine.toArray();

            rowStoreListStack.add(array);
            rowStoreMapRoutine.clear();
        }
    }

    synchronized public void pop(boolean isRoutine) {

        Object[] array;

        if (isRoutine) {
            array = (Object[]) rowStoreListStack.removeLast();

            clearRoutineTables();

            for (int i = 0; i < array.length; i++) {
                PersistentStore store = (PersistentStore) array[i];

                rowStoreMapRoutine.put(store.getTable().getPersistenceId(),
                                       store);
            }
        }

        array = (Object[]) rowStoreListStack.removeLast();

        clearStatementTables();

        for (int i = 0; i < array.length; i++) {
            PersistentStore store = (PersistentStore) array[i];

            rowStoreMapStatement.put(store.getTable().getPersistenceId(),
                                     store);
        }
    }

    DataFileCacheSession resultCache;

    synchronized public DataFileCacheSession getSessionDataCache() {

        if (resultCache == null) {
            String path = session.database.logger.getTempDirectoryPath();

            if (path == null) {
                return null;
            }

            try {
                resultCache =
                    new DataFileCacheSession(session.database,
                                             path + "/session_"
                                             + Long.toString(session.getId()));

                resultCache.open(false);
            } catch (Throwable t) {
                return null;
            }
        }

        return resultCache;
    }

    private void closeSessionDataCache() {

        if (resultCache != null) {
            try {
                resultCache.release();
                resultCache.deleteFile();
            } catch (HsqlException e) {}

            resultCache = null;
        }
    }

    synchronized public void release() {
        clearAllTables();
    }
}

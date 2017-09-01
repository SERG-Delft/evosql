/* Copyright (c) 2001-2015, The HSQL Development Group
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

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.hsqldb.Database;
import org.hsqldb.Row;
import org.hsqldb.RowAVL;
import org.hsqldb.RowAction;
import org.hsqldb.Session;
import org.hsqldb.Table;
import org.hsqldb.TransactionManager;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.rowio.RowInputInterface;

/*
 * Implementation of PersistentStore for MEMORY tables.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class RowStoreAVLMemory extends RowStoreAVL implements PersistentStore {

    Database      database;
    AtomicInteger rowIdSequence = new AtomicInteger();
    ReadWriteLock lock;
    Lock          readLock;
    Lock          writeLock;

    public RowStoreAVLMemory(Table table) {

        this.database     = table.database;
        this.table        = table;
        this.indexList    = table.getIndexList();
        this.accessorList = new CachedObject[indexList.length];
        lock              = new ReentrantReadWriteLock();
        readLock          = lock.readLock();
        writeLock         = lock.writeLock();
    }

    public boolean isMemory() {
        return true;
    }

    public int getAccessCount() {
        return 0;
    }

    public void set(CachedObject object) {}

    public CachedObject get(long i) {
        throw Error.runtimeError(ErrorCode.U_S0500, "RowStoreAVMemory");
    }

    public CachedObject get(long i, boolean keep) {
        throw Error.runtimeError(ErrorCode.U_S0500, "RowStoreAVLMemory");
    }

    public CachedObject get(CachedObject object, boolean keep) {
        return object;
    }

    public void add(Session session, CachedObject object, boolean tx) {}

    public CachedObject get(RowInputInterface in) {
        throw Error.runtimeError(ErrorCode.U_S0500, "RowStoreAVLMemory");
    }

    public CachedObject getNewCachedObject(Session session, Object object,
                                           boolean tx) {

        int id  = rowIdSequence.getAndIncrement();
        Row row = new RowAVL(table, (Object[]) object, id, this);

        if (tx) {
            RowAction.addInsertAction(session, table, row);
        }

        return row;
    }

    public void removeAll() {

        destroy();
        setTimestamp(0);
        elementCount.set(0);
        ArrayUtil.fillArray(accessorList, null);
    }

    public void remove(CachedObject object) {}

    public void release(long i) {}

    public void commitPersistence(CachedObject row) {}

    public void postCommitAction(Session session, RowAction action) {

        if (action.getType() == RowAction.ACTION_DELETE_FINAL
                && !action.isDeleteComplete()) {
            action.setDeleteComplete();

            Row row = action.getRow();

            delete(session, row);
        }
    }

    public void commitRow(Session session, Row row, int changeAction,
                          int txModel) {

        Object[] data = row.getData();

        switch (changeAction) {

            case RowAction.ACTION_DELETE :
                database.logger.writeDeleteStatement(session, (Table) table,
                                                     data);
                break;

            case RowAction.ACTION_INSERT :
                database.logger.writeInsertStatement(session, row,
                                                     (Table) table);
                break;

            case RowAction.ACTION_INSERT_DELETE :

                // INSERT + DELETE
                break;

            case RowAction.ACTION_DELETE_FINAL :
                throw Error.runtimeError(ErrorCode.U_S0500, "RowStore");
        }
    }

    public void rollbackRow(Session session, Row row, int changeAction,
                            int txModel) {

        switch (changeAction) {

            case RowAction.ACTION_DELETE :
                if (txModel == TransactionManager.LOCKS) {
                    ((RowAVL) row).setNewNodes(this);
                    indexRow(session, row);
                }
                break;

            case RowAction.ACTION_INSERT :
                delete(session, row);
                remove(row);
                break;

            case RowAction.ACTION_INSERT_DELETE :

                // INSERT + DELETE
                remove(row);
                break;
        }
    }

    //
    public DataFileCache getCache() {
        return null;
    }

    public void setCache(DataFileCache cache) {}

    public void release() {

        destroy();
        setTimestamp(0);
        elementCount.set(0);
        ArrayUtil.fillArray(accessorList, null);
    }

    public void readLock() {
        readLock.lock();
    }

    public void readUnlock() {
        readLock.unlock();
    }

    public void writeLock() {
        writeLock.lock();
    }

    public void writeUnlock() {
        writeLock.unlock();
    }
}

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

import java.io.IOException;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.hsqldb.HsqlException;
import org.hsqldb.Row;
import org.hsqldb.RowAVL;
import org.hsqldb.RowAVLDisk;
import org.hsqldb.RowAVLDiskLarge;
import org.hsqldb.RowAction;
import org.hsqldb.Session;
import org.hsqldb.Table;
import org.hsqldb.TransactionManager;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.index.Index;
import org.hsqldb.index.NodeAVL;
import org.hsqldb.index.NodeAVLDisk;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.DoubleIntIndex;
import org.hsqldb.navigator.RowIterator;
import org.hsqldb.rowio.RowInputInterface;
import org.hsqldb.rowio.RowOutputInterface;

/*
 * Implementation of PersistentStore for CACHED tables.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class RowStoreAVLDisk extends RowStoreAVL implements PersistentStore {

    DataFileCache      cache;
    RowOutputInterface rowOut;
    boolean            largeData;

    public RowStoreAVLDisk(DataFileCache cache, Table table) {

        this(table);

        this.cache = cache;
        rowOut     = cache.rowOut.duplicate();

        cache.adjustStoreCount(1);

        largeData  = database.logger.propLargeData;
        tableSpace = cache.spaceManager.getTableSpace(table.getSpaceID());
        lock       = new ReentrantReadWriteLock();
        readLock   = lock.readLock();
        writeLock  = lock.writeLock();
    }

    protected RowStoreAVLDisk(Table table) {

        this.database     = table.database;
        this.table        = table;
        this.indexList    = table.getIndexList();
        this.accessorList = new CachedObject[indexList.length];
        largeData         = database.logger.getDataFileFactor() > 1;
    }

    public boolean isMemory() {
        return false;
    }

    public void set(CachedObject object) {
        database.txManager.setTransactionInfo(this, object);
    }

    public CachedObject get(long key) {

        CachedObject object = cache.get(key, this, false);

        return object;
    }

    public CachedObject get(long key, boolean keep) {

        CachedObject object = cache.get(key, this, keep);

        return object;
    }

    public CachedObject get(CachedObject object, boolean keep) {

        object = cache.get(object, this, keep);

        return object;
    }

    public void add(Session session, CachedObject object, boolean tx) {

        int size = object.getRealSize(rowOut);

        size += indexList.length * NodeAVLDisk.SIZE_IN_BYTE;
        size = rowOut.getStorageSize(size);

        object.setStorageSize(size);

        long pos = tableSpace.getFilePosition(size, false);

        object.setPos(pos);

        if (tx) {
            RowAction.addInsertAction(session, table, (Row) object);
            database.txManager.addTransactionInfo(object);
        }

        cache.add(object, false);

        storageSize += size;
    }

    public CachedObject get(RowInputInterface in) {

        try {
            if (largeData) {
                return new RowAVLDiskLarge(table, in);
            } else {
                return new RowAVLDisk(table, in);
            }
        } catch (IOException e) {
            throw Error.error(ErrorCode.DATA_FILE_ERROR, e);
        }
    }

    public CachedObject getNewCachedObject(Session session, Object object,
                                           boolean tx) {

        Row row;

        if (largeData) {
            row = new RowAVLDiskLarge(table, (Object[]) object, this);
        } else {
            row = new RowAVLDisk(table, (Object[]) object, this);
        }

        add(session, row, tx);

        return row;
    }

    public void delete(Session session, Row row) {

        writeLock();

        try {
            super.delete(session, row);
        } finally {
            writeUnlock();
        }
    }

    public void indexRow(Session session, Row row) {

        writeLock();

        try {
            row = (Row) get(row, true);

            super.indexRow(session, row);
        } catch (HsqlException e) {
            database.txManager.removeTransactionInfo(row);

            throw e;
        } finally {
            row.keepInMemory(false);
            writeUnlock();
        }
    }

    public void removeAll() {

        elementCount.set(0);
        cache.spaceManager.freeTableSpace(tableSpace.getSpaceID());
        ArrayUtil.fillArray(accessorList, null);
    }

    public void remove(CachedObject object) {

        cache.remove(object);
        tableSpace.release(object.getPos(), object.getStorageSize());

        storageSize -= object.getStorageSize();
    }

    public void commitPersistence(CachedObject row) {}

    public void postCommitAction(Session session, RowAction action) {

        if (action.getType() == RowAction.ACTION_NONE) {
            database.txManager.removeTransactionInfo(action.getPos());
        } else if (action.getType() == RowAction.ACTION_DELETE_FINAL
                   && !action.isDeleteComplete()) {
            action.setDeleteComplete();

            Row row = action.getRow();

            if (row == null) {
                row = (Row) get(action.getPos(), false);
            }

            delete(session, row);

            // remove info after delete but before removing persistence
            database.txManager.removeTransactionInfo(row);
            remove(row);
        }
    }

    public void commitRow(Session session, Row row, int changeAction,
                          int txModel) {

        Object[] data = row.getData();

        switch (changeAction) {

            case RowAction.ACTION_DELETE :
                database.logger.writeDeleteStatement(session, (Table) table,
                                                     data);

                if (txModel == TransactionManager.LOCKS) {
                    remove(row);
                }
                break;

            case RowAction.ACTION_INSERT :
                database.logger.writeInsertStatement(session, row,
                                                     (Table) table);
                break;

            case RowAction.ACTION_INSERT_DELETE :

                // INSERT + DELETE
                if (txModel == TransactionManager.LOCKS) {
                    remove(row);
                }
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
                    row = (Row) get(row, true);

                    ((RowAVL) row).setNewNodes(this);
                    row.keepInMemory(false);
                    indexRow(session, row);
                }
                break;

            case RowAction.ACTION_INSERT :
                delete(session, row);

                // remove info after delete but before removing persistence
                database.txManager.removeTransactionInfo(row);
                remove(row);
                break;

            case RowAction.ACTION_INSERT_DELETE :
                if (txModel != TransactionManager.LOCKS) {

                    // INSERT + DELETE
                    delete(session, row);

                    // remove info after delete but before removing persistence
                    database.txManager.removeTransactionInfo(row);
                }

                remove(row);
                break;
        }
    }

    public DataFileCache getCache() {
        return cache;
    }

    /**
     * Works only for TEXT TABLE as others need specific spaceManager
     */
    public void setCache(DataFileCache cache) {
        throw Error.runtimeError(ErrorCode.U_S0500, "RowStoreAVLDisk");
    }

    public void release() {

        cache.adjustStoreCount(-1);

        cache = null;

        elementCount.set(0);
        ArrayUtil.fillArray(accessorList, null);
    }

    public CachedObject getAccessor(Index key) {

        NodeAVL node = (NodeAVL) accessorList[key.getPosition()];

        if (node == null) {
            return null;
        }

        RowAVL row = (RowAVL) get(node.getRow(this), false);

        node                            = row.getNode(key.getPosition());
        accessorList[key.getPosition()] = node;

        return node;
    }

    public void setAccessor(Index key, long accessor) {

        CachedObject object = get(accessor, false);

        if (object != null) {
            NodeAVL node = ((RowAVL) object).getNode(key.getPosition());

            object = node;
        }

        setAccessor(key, object);
    }

    public void resetAccessorKeys(Session session, Index[] keys) {

        if (indexList.length == 0 || accessorList[0] == null) {
            indexList    = keys;
            accessorList = new CachedObject[indexList.length];

            return;
        }

        throw Error.runtimeError(ErrorCode.U_S0500, "RowStoreAVLDisk");
    }

    public void setReadOnly(boolean readOnly) {}

    public void moveDataToSpace(Session session) {

        Table table    = (Table) this.table;
        long  rowCount = elementCount();

        if (rowCount == 0) {
            return;
        }

        if (rowCount > Integer.MAX_VALUE) {

            // error too big
            return;
        }

        DoubleIntIndex pointerLookup = new DoubleIntIndex((int) rowCount,
            false);

        pointerLookup.setKeysSearchTarget();
        writeLock();

        try {
            moveDataToSpace(cache, pointerLookup);

            CachedObject[] newAccessorList =
                new CachedObject[accessorList.length];

            for (int i = 0; i < accessorList.length; i++) {
                long pos = pointerLookup.lookup(accessorList[i].getPos());

                newAccessorList[i] = cache.get(pos, this, false);
            }

            RowIterator it = rowIterator();

            // todo - check this - must remove from old space, not new one
            while (it.hasNext()) {
                Row row = it.getNextRow();

                cache.remove(row);
                tableSpace.release(row.getPos(), row.getStorageSize());
            }

            accessorList = newAccessorList;
        } finally {
            writeUnlock();
        }

        database.logger.logDetailEvent("table written "
                                       + table.getName().name);
    }

    public void moveDataToSpace(DataFileCache targetCache,
                                DoubleIntIndex pointerLookup) {

        int spaceId = table.getSpaceID();
        TableSpaceManager targetSpace =
            targetCache.spaceManager.getTableSpace(spaceId);

        pointerLookup.setKeysSearchTarget();

        RowIterator it = indexList[0].firstRow(this);

        while (it.hasNext()) {
            CachedObject row = it.getNextRow();

            pointerLookup.addUnsorted(row.getPos(), row.getStorageSize());
        }

        pointerLookup.sort();

        for (int i = 0; i < pointerLookup.size(); i++) {
            long newPos =
                targetSpace.getFilePosition(pointerLookup.getValue(i), false);

            pointerLookup.setValue(i, (int) newPos);
        }

        it = indexList[0].firstRow(this);

        while (it.hasNext()) {
            CachedObject row    = it.getNextRow();
            long         newPos = pointerLookup.lookup(row.getPos());

            // write
            targetCache.rowOut.reset();
            row.write(targetCache.rowOut, pointerLookup);
            targetCache.saveRowOutput(newPos);
        }
    }

    long getStorageSizeEstimate() {

        if (elementCount.get() == 0) {
            return 0;
        }

        CachedObject accessor = getAccessor(indexList[0]);
        CachedObject row      = get(accessor.getPos());

        return row.getStorageSize() * elementCount.get();
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

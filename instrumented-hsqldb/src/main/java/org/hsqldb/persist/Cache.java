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

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArraySort;
import org.hsqldb.lib.IntIndex;
import org.hsqldb.lib.Iterator;
import org.hsqldb.lib.ObjectComparator;
import org.hsqldb.lib.StopWatch;
import org.hsqldb.map.BaseHashMap;

/**
 * New implementation of row caching for CACHED tables.<p>
 *
 * Manages memory for the cache map and its contents based on least recently
 * used clearup.<p>
 * Also provides services for selecting rows to be saved and passing them
 * to DataFileCache.<p>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.8.0
 */
public class Cache extends BaseHashMap {

    private int                                reserveCount;
    final DataFileCache                        dataFileCache;
    private int                                capacity;         // number of Rows
    private long                               bytesCapacity;    // number of bytes
    private final CachedObjectComparator       rowComparator;
    private final BaseHashMap.BaseHashIterator objectIterator;
    private boolean                            updateAccess;

    //
    private CachedObject[] rowTable;
    private long           cacheBytesLength;

    // for testing
    StopWatch saveAllTimer = new StopWatch(false);
    StopWatch shadowTimer  = new StopWatch(false);
    int       saveRowCount = 0;

    Cache(DataFileCache dfc) {

        super(dfc.capacity(), BaseHashMap.objectKeyOrValue,
              BaseHashMap.noKeyOrValue, true);

        maxCapacity      = dfc.capacity();
        dataFileCache    = dfc;
        capacity         = dfc.capacity();
        bytesCapacity    = dfc.bytesCapacity();
        rowComparator    = new CachedObjectComparator();
        rowTable         = new CachedObject[capacity];
        cacheBytesLength = 0;
        objectIterator   = new BaseHashIterator(true);
        updateAccess     = true;
        comparator       = rowComparator;
        reserveCount = dfc instanceof TextCache
                       || dfc instanceof DataFileCacheSession ? 0
                                                              : 8;
    }

    long getTotalCachedBlockSize() {
        return cacheBytesLength;
    }

    /**
     * Returns a row if in memory cache.
     */
    public CachedObject get(long pos) {

        if (accessCount > ACCESS_MAX) {
            updateAccessCounts();
            resetAccessCount();
            updateObjectAccessCounts();
        }

        int lookup = getObjectLookup(pos);

        if (lookup == -1) {
            return null;
        }

        accessTable[lookup] = ++accessCount;

        CachedObject object = (CachedObject) objectKeyTable[lookup];

        return object;
    }

    /**
     * Adds a row to the cache.
     */
    void put(CachedObject row) {

        int storageSize = row.getStorageSize();

        if (preparePut(storageSize)) {
            putNoCheck(row);
        } else {
            long value = size() + reserveCount >= capacity ? capacity
                                                           : bytesCapacity
                                                             / 1024L;

            throw Error.error(ErrorCode.DATA_CACHE_IS_FULL,
                              String.valueOf(value));
        }
    }

    /**
     * reserve slots may be used and storage size may exceed bytesCapacity
     */
    void putUsingReserve(CachedObject row) {

        int storageSize = row.getStorageSize();

        preparePut(storageSize);

        if (size() >= capacity) {
            throw Error.error(ErrorCode.DATA_CACHE_IS_FULL,
                              String.valueOf(capacity));
        }

        putNoCheck(row);
    }

    boolean preparePut(int storageSize) {

        boolean exceedsCount = size() + reserveCount >= capacity;
        boolean exceedsSize  = storageSize + cacheBytesLength > bytesCapacity;

        if (exceedsCount || exceedsSize) {
            cleanUp(false);

            exceedsCount = size() + reserveCount >= capacity;
            exceedsSize  = storageSize + cacheBytesLength > bytesCapacity;

            if (exceedsCount || exceedsSize) {
                clearUnchanged();
            } else {
                return true;
            }

            exceedsCount = size() + reserveCount >= capacity;
            exceedsSize  = storageSize + cacheBytesLength > bytesCapacity;

            if (exceedsCount || exceedsSize) {
                cleanUp(true);
            } else {
                return true;
            }

            exceedsCount = size() + reserveCount >= capacity;
            exceedsSize  = storageSize + cacheBytesLength > bytesCapacity;

            if (exceedsCount) {
                dataFileCache.logInfoEvent(
                    "dataFileCache CACHE ROWS limit reached");
            }

            if (exceedsSize) {
                dataFileCache.logInfoEvent(
                    "dataFileCache CACHE SIZE limit reached");
            }

            if (exceedsCount || exceedsSize) {
                return false;
            }
        }

        return true;
    }

    private void putNoCheck(CachedObject row) {

        if (accessCount > ACCESS_MAX) {
            updateAccessCounts();
            resetAccessCount();
            updateObjectAccessCounts();
        }

        Object existing = super.addOrRemoveObject(row, row.getPos(), false);

        if (existing != null) {
            dataFileCache.logSevereEvent("existing object in Cache.put() "
                                         + row.getPos() + " "
                                         + row.getStorageSize(), null);
        }

        row.setInMemory(true);

        cacheBytesLength += row.getStorageSize();
    }

    /**
     * Removes an object from memory cache. Does not release the file storage.
     */
    CachedObject release(long pos) {

        CachedObject r = (CachedObject) super.addOrRemoveObject(null, pos,
            true);

        if (r == null) {
            return null;
        }

        cacheBytesLength -= r.getStorageSize();

        r.setInMemory(false);

        return r;
    }

    public void releaseRange(IntIndex list, int fileBlockItemCount) {

        objectIterator.reset();

        while (objectIterator.hasNext()) {
            CachedObject o     = (CachedObject) objectIterator.next();
            long         pos   = o.getPos();
            int          block = (int) (pos / fileBlockItemCount);
            int          index = list.findFirstEqualKeyIndex(block);

            if (index >= 0) {
                o.setInMemory(false);
                objectIterator.remove();

                cacheBytesLength -= o.getStorageSize();
            }
        }
    }

    public void releaseRange(long startPos, long limitPos) {

        objectIterator.reset();

        while (objectIterator.hasNext()) {
            CachedObject o   = (CachedObject) objectIterator.next();
            long         pos = o.getPos();

            if (pos >= startPos && pos < limitPos) {
                o.setInMemory(false);
                objectIterator.remove();

                cacheBytesLength -= o.getStorageSize();
            }
        }
    }

    private void updateAccessCounts() {

        CachedObject r;
        int          count;

        if (updateAccess) {
            for (int i = 0; i < objectKeyTable.length; i++) {
                r = (CachedObject) objectKeyTable[i];

                if (r != null) {
                    count = r.getAccessCount();

                    if (count > accessTable[i]) {
                        accessTable[i] = count;
                    }
                }
            }
        }
    }

    private void updateObjectAccessCounts() {

        CachedObject r;
        int          count;

        if (updateAccess) {
            for (int i = 0; i < objectKeyTable.length; i++) {
                r = (CachedObject) objectKeyTable[i];

                if (r != null) {
                    count = accessTable[i];

                    r.updateAccessCount(count);
                }
            }
        }
    }

    /**
     * Reduces the number of rows held in this Cache object. <p>
     *
     * Cleanup is done by checking the accessCount of the Rows and removing
     * the rows with the lowest access count.
     *
     * Index operations require that some rows remain
     * in the cache. This is ensured by prior calling keepInMemory().
     *
     */
    private void cleanUp(boolean all) {

        updateAccessCounts();

        int savecount    = 0;
        int removeCount  = size() / 2;
        int accessTarget = all ? accessCount + 1
                               : getAccessCountCeiling(removeCount,
                                   removeCount / 8);
        int accessMid = all ? accessCount + 1
                            : (accessMin + accessTarget) / 2;

        objectIterator.reset();

        for (; objectIterator.hasNext(); ) {
            CachedObject row = (CachedObject) objectIterator.next();
            int          currentAccessCount = objectIterator.getAccessCount();
            boolean oldRow = currentAccessCount < accessTarget
                             && !row.isKeepInMemory();
            boolean newRow = row.isNew()
                             && row.getStorageSize()
                                >= DataFileCache.initIOBufferSize;
            boolean saveRow = row.hasChanged() && (oldRow || newRow);

            objectIterator.setAccessCount(accessTarget);

            synchronized (row) {
                if (saveRow) {
                    rowTable[savecount++] = row;
                }

                if (oldRow) {
                    row.setInMemory(false);
                    objectIterator.remove();

                    cacheBytesLength -= row.getStorageSize();
                }
            }

            if (savecount == rowTable.length) {
                saveRows(savecount);

                savecount = 0;
            }
        }

        saveRows(savecount);
        setAccessCountFloor(accessTarget);

        accessCount++;
    }

    void clearUnchanged() {

        objectIterator.reset();

        for (; objectIterator.hasNext(); ) {
            CachedObject row = (CachedObject) objectIterator.next();

            synchronized (row) {
                if (!row.isKeepInMemory() && !row.hasChanged()) {
                    row.setInMemory(false);
                    objectIterator.remove();

                    cacheBytesLength -= row.getStorageSize();
                }
            }
        }
    }

    private synchronized void saveRows(int count) {

        if (count == 0) {
            return;
        }

        rowComparator.setType(CachedObjectComparator.COMPARE_POSITION);
        ArraySort.sort(rowTable, 0, count, rowComparator);
        dataFileCache.saveRows(rowTable, 0, count);

        saveRowCount += count;
    }

    /**
     * Writes out all modified cached Rows.
     */
    void saveAll() {

        int savecount = 0;

        objectIterator.reset();

        for (; objectIterator.hasNext(); ) {
            if (savecount == rowTable.length) {
                saveRows(savecount);

                savecount = 0;
            }

            CachedObject r = (CachedObject) objectIterator.next();

            if (r.hasChanged()) {
                rowTable[savecount] = r;

                savecount++;
            }
        }

        saveRows(savecount);
    }

    void logSaveRowsEvent(int saveCount, long storageSize, long startTime) {

        long         time = saveAllTimer.elapsedTime();
        StringBuffer sb   = new StringBuffer();

        sb.append("cache save rows total [count,time] ");
        sb.append(saveRowCount + saveCount);
        sb.append(',').append(time).append(' ');
        sb.append("operation [count,size,time]").append(saveCount).append(' ');
        sb.append(storageSize).append(',');
        sb.append(time - startTime).append(' ');

//
        sb.append("tx-ts ");
        sb.append(dataFileCache.database.txManager.getGlobalChangeTimestamp());

//
        dataFileCache.logDetailEvent(sb.toString());
    }

    /**
     * clears out the memory cache
     */
    public void clear() {

        super.clear();

        cacheBytesLength = 0;
    }

    public Iterator getIterator() {

        objectIterator.reset();

        return objectIterator;
    }

    protected int incrementAccessCount() {
        return super.incrementAccessCount();
    }

    static final class CachedObjectComparator implements ObjectComparator {

        static final int COMPARE_LAST_ACCESS = 0;
        static final int COMPARE_POSITION    = 1;
        static final int COMPARE_SIZE        = 2;
        private int      compareType         = COMPARE_POSITION;

        CachedObjectComparator() {}

        void setType(int type) {
            compareType = type;
        }

        public int compare(Object a, Object b) {

            long diff;

            switch (compareType) {

                case COMPARE_POSITION :
                    diff = ((CachedObject) a).getPos()
                           - ((CachedObject) b).getPos();
                    break;

                case COMPARE_SIZE :
                    diff = ((CachedObject) a).getStorageSize()
                           - ((CachedObject) b).getStorageSize();
                    break;

                default :
                    return 0;
            }

            return diff == 0 ? 0
                             : diff > 0 ? 1
                                        : -1;
        }

        public int hashCode(Object o) {
            return o.hashCode();
        }

        public long longKey(Object o) {
            return ((CachedObject) o).getPos();
        }
    }
}

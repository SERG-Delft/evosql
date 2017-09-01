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

import java.util.concurrent.atomic.AtomicInteger;

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.DoubleIntIndex;
import org.hsqldb.lib.IntIndex;
import org.hsqldb.lib.IntKeyHashMap;
import org.hsqldb.lib.Iterator;

/**
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 2.3.0
 */
public class DataSpaceManagerBlocks implements DataSpaceManager {

    //
    DataFileCache           cache;
    TableSpaceManagerBlocks defaultSpaceManager;
    TableSpaceManagerBlocks directorySpaceManager;

    //
    IntKeyHashMap spaceManagerList;

    //
    BlockObjectStore rootStore;
    BlockObjectStore directoryStore;
    BlockObjectStore bitMapStore;

    //
    IntArrayCachedObject rootBlock;

    //
    AtomicInteger spaceIdSequence = new AtomicInteger(tableIdFirst);
    IntIndex      emptySpaceList;
    int           released = 0;

    //
    static final int blockSize               = 1024 * 2;
    static final int fileBlockItemCountLimit = 64 * 1024;

    //
    int bitmapIntSize;
    int bitmapStorageSize;
    int fileBlockItemCount;
    int fileBlockSize;
    int dataFileScale;

    //
    BlockAccessor ba;

    public DataSpaceManagerBlocks(DataFileCache dataFileCache) {

        cache         = dataFileCache;
        dataFileScale = cache.getDataFileScale();
        fileBlockSize = cache.database.logger.getDataFileSpaces() * 1024
                        * 1024;
        fileBlockItemCount = fileBlockSize / dataFileScale;
        bitmapIntSize      = fileBlockItemCount / 32;
        bitmapStorageSize  = BitMapCachedObject.fileSizeFactor * bitmapIntSize;

        if (bitmapStorageSize < fixedBlockSizeUnit) {
            bitmapStorageSize = fixedBlockSizeUnit;
        }

        ba               = new BlockAccessor();
        spaceManagerList = new IntKeyHashMap();
        emptySpaceList   = new IntIndex(32, false);

        //
        directorySpaceManager = new TableSpaceManagerBlocks(this,
                tableIdDirectory, fileBlockSize, 16, dataFileScale, 0);
        defaultSpaceManager = new TableSpaceManagerBlocks(this,
                tableIdDefault, fileBlockSize,
                cache.database.logger.propMaxFreeBlocks, dataFileScale,
                cache.database.logger.propMinReuse);

        spaceManagerList.put(tableIdDirectory, directorySpaceManager);
        spaceManagerList.put(tableIdDefault, defaultSpaceManager);

        //
        rootStore = new BlockObjectStore(cache, directorySpaceManager,
                                         IntArrayCachedObject.class,
                                         IntArrayCachedObject.fileSizeFactor
                                         * blockSize, blockSize);
        directoryStore =
            new BlockObjectStore(cache, directorySpaceManager,
                                 DirectoryBlockCachedObject.class,
                                 DirectoryBlockCachedObject.fileSizeFactor
                                 * blockSize, blockSize);
        bitMapStore = new BlockObjectStore(cache, directorySpaceManager,
                                           BitMapCachedObject.class,
                                           bitmapStorageSize, bitmapIntSize);

        if (cache.spaceManagerPosition == 0) {
            initialiseNewSpaceDirectory();

            cache.spaceManagerPosition = rootBlock.getPos() * dataFileScale;
        } else {
            long pos = cache.spaceManagerPosition / dataFileScale;

            rootBlock = (IntArrayCachedObject) rootStore.get(pos, true);

            // integrity check
            if (getBlockIndexLimit() == 0) {
                throw Error.error(ErrorCode.FILE_IO_ERROR);
            }

            initialiseSpaceList();
            initialiseTableSpace(directorySpaceManager);
            initialiseTableSpace(defaultSpaceManager);
        }
    }

    private void initialiseNewSpaceDirectory() {

        long currentSize = cache.getFileFreePos();
        long totalBlocks = (currentSize / fileBlockSize) + 1;
        long lastFreePosition = cache.enlargeFileSpace(totalBlocks
            * fileBlockSize - currentSize);

        defaultSpaceManager.initialiseFileBlock(null, lastFreePosition,
                cache.getFileFreePos());

        long defaultSpaceBlockCount = totalBlocks;
        long directorySpaceBlockCount =
            calculateDirectorySpaceBlocks(totalBlocks);

        lastFreePosition = cache.enlargeFileSpace(directorySpaceBlockCount
                * fileBlockSize);

        // file block is empty
        directorySpaceManager.initialiseFileBlock(null, lastFreePosition,
                cache.getFileFreePos());

        IntArrayCachedObject root = new IntArrayCachedObject(blockSize);

        rootStore.add(root, true);

        rootBlock = root;

        createFileBlocksInDirectory((int) defaultSpaceBlockCount,
                                    (int) directorySpaceBlockCount,
                                    tableIdDirectory);
        createFileBlocksInDirectory(0, (int) defaultSpaceBlockCount,
                                    tableIdDefault);
    }

    private long calculateDirectorySpaceBlocks(long blockCount) {

        long currentSize   = calculateDirectorySpaceSize(blockCount);
        long currentBlocks = currentSize / fileBlockSize + 1;

        currentSize   += calculateDirectorySpaceSize(currentBlocks);
        currentBlocks = currentSize / fileBlockSize + 1;

        return currentBlocks;
    }

    private long calculateDirectorySpaceSize(long blockCount) {

        long blockLimit = ArrayUtil.getBinaryMultipleCeiling(blockCount + 1,
            blockSize);
        long currentSize = IntArrayCachedObject.fileSizeFactor * blockLimit;    // root

        currentSize += DirectoryBlockCachedObject.fileSizeFactor * blockLimit;    // directory
        currentSize += bitmapStorageSize * (blockCount + 1);                      // bitmaps

        return currentSize;
    }

    /**
     * The space for a new directory block must be added to the directorySpaceManager
     * before createFileBlocksInDirectory is called, otherwise there is no space
     * to create the bit-map
     */
    private void ensureDirectorySpaceAvailable(int blockCount) {

        int dirObjectSize = bitmapStorageSize * blockCount
                            + DirectoryBlockCachedObject.fileSizeFactor
                              * blockSize;

        if (!directorySpaceManager.hasFileRoom(dirObjectSize)) {
            int index         = getBlockIndexLimit();
            int dirBlockCount = dirObjectSize / fileBlockSize + 1;
            long filePosition = cache.enlargeFileSpace((long) dirBlockCount
                * fileBlockSize);

            directorySpaceManager.addFileBlock(filePosition,
                                               filePosition
                                               + (long) dirBlockCount
                                                 * fileBlockSize);
            createFileBlocksInDirectory(index, dirBlockCount,
                                        tableIdDirectory);

            // integrity check
            index = getBlockIndexLimit();

            if ((long) index * fileBlockSize != cache.getFileFreePos()) {
                cache.logSevereEvent(
                    "space manager end file pos different from data file: "
                    + (index * fileBlockSize) + ", "
                    + cache.getFileFreePos(), null);
            }
        }
    }

    /**
     * try available blocks first, then get fresh block
     */
    public long getFileBlocks(int tableId, int blockCount) {

        cache.writeLock.lock();

        try {
            long index = getExistingBlockIndex(tableId, blockCount);

            if (index > 0) {
                return index * fileBlockSize;
            } else {
                return getNewFileBlocks(tableId, blockCount);
            }
        } finally {
            cache.writeLock.unlock();
        }
    }

    private long getNewFileBlocks(int tableId, int blockCount) {

        ensureDirectorySpaceAvailable(blockCount);

        return getNewFileBlocksNoCheck(tableId, blockCount);
    }

    private long getNewFileBlocksNoCheck(int tableId, int blockCount) {

        long index        = getBlockIndexLimit();
        long filePosition = index * fileBlockSize;
        long delta = filePosition + ((long) blockCount * fileBlockSize)
                     - cache.getFileFreePos();

        if (delta > 0) {
            cache.enlargeFileSpace(delta);
        }

        createFileBlocksInDirectory((int) index, blockCount, tableId);

        return filePosition;
    }

    private void createFileBlocksInDirectory(int fileBlockIndex,
            int blockCount, int tableId) {

        for (int i = 0; i < blockCount; i++) {
            createFileBlockInDirectory(fileBlockIndex + i, tableId);
        }
    }

    private void createFileBlockInDirectory(int fileBlockIndex, int tableId) {

        // add keep
        BitMapCachedObject bitMap = new BitMapCachedObject(bitmapIntSize);

        bitMapStore.add(bitMap, false);

        //
        int bitmapBlockPos = (int) (bitMap.getPos() * dataFileScale
                                    / fixedBlockSizeUnit);
        int blockOffset = fileBlockIndex % blockSize;
        DirectoryBlockCachedObject directory = getDirectory(fileBlockIndex,
            true);

        if (directory == null) {
            createDirectory(fileBlockIndex);

            directory = getDirectory(fileBlockIndex, true);
        }

        directory.getTableIdArray()[blockOffset]       = tableId;
        directory.getBitmapAddressArray()[blockOffset] = bitmapBlockPos;

        directory.setChanged(true);
        directory.keepInMemory(false);
    }

    private DirectoryBlockCachedObject getDirectory(int fileBlockIndex,
            boolean keep) {

        DirectoryBlockCachedObject directory;
        int                        indexInRoot = fileBlockIndex / blockSize;
        long position = rootBlock.getIntArray()[indexInRoot];

        if (position == 0) {
            return null;
        }

        position *= (fixedBlockSizeUnit / dataFileScale);
        directory = (DirectoryBlockCachedObject) directoryStore.get(position,
                keep);

        return directory;
    }

    private void createDirectory(int fileBlockIndex) {

        DirectoryBlockCachedObject directory;

        directory = new DirectoryBlockCachedObject(blockSize);

        directoryStore.add(directory, false);

        int indexInRoot = fileBlockIndex / blockSize;
        int blockPosition = (int) (directory.getPos() * dataFileScale
                                   / fixedBlockSizeUnit);

        rootBlock.getIntArray()[indexInRoot] = blockPosition;

        rootBlock.setChanged(true);
    }

    private int getBlockIndexLimit() {

        int[] rootArray      = rootBlock.getIntArray();
        int   rootBlockIndex = 0;

        for (; rootBlockIndex < rootArray.length; rootBlockIndex++) {
            if (rootArray[rootBlockIndex] == 0) {
                break;
            }
        }

        if (rootBlockIndex == 0) {
            return 0;
        }

        rootBlockIndex--;

        long position = rootArray[rootBlockIndex];

        position *= (fixedBlockSizeUnit / dataFileScale);

        //
        DirectoryBlockCachedObject currentDir;

        currentDir = (DirectoryBlockCachedObject) directoryStore.get(position,
                false);

        int[] bitmapArray          = currentDir.getBitmapAddressArray();
        int   directoryBlockOffset = 0;

        for (; directoryBlockOffset < bitmapArray.length;
                directoryBlockOffset++) {
            if (bitmapArray[directoryBlockOffset] == 0) {
                break;
            }
        }

        return rootBlockIndex * blockSize + directoryBlockOffset;
    }

    private void initialiseSpaceList() {

        int maxId = tableIdDefault;

        ba.initialise(false);

        for (;;) {
            boolean result = ba.nextBlock();

            if (!result) {
                break;
            }

            int currentId = ba.getTableId();

            if (currentId > maxId) {
                maxId = currentId;
            }

            if (currentId == tableIdEmpty) {
                emptySpaceList.addUnique(ba.currentBlockIndex);
            }
        }

        ba.reset();
        spaceIdSequence.set((maxId + 2) & -2);
    }

    private int getExistingBlockIndex(int tableId, int blockCount) {

        int blockIndex = emptySpaceList.removeFirstConsecutiveKeys(blockCount,
            -1);

        if (blockIndex > 0) {
            setDirectoryBlocksAsTable(tableId, blockIndex, blockCount);
        }

        return blockIndex;
    }

    /**
     * index and blockCount always valid
     */
    private void setDirectoryBlocksAsTable(int tableId, int blockIndex,
                                           int blockCount) {

        int                        directoryIndex = -1;
        DirectoryBlockCachedObject directory      = null;

        for (int i = blockIndex; i < blockIndex + blockCount; i++) {
            if (directoryIndex != i / blockSize) {
                if (directory != null) {
                    directory.keepInMemory(false);
                }

                directory      = getDirectory(i, true);
                directoryIndex = i / blockSize;
            }

            int offset = i % blockSize;

            directory.getTableIdArray()[offset] = tableId;
        }

        directory.keepInMemory(false);
    }

    public TableSpaceManager getDefaultTableSpace() {
        return defaultSpaceManager;
    }

    public TableSpaceManager getTableSpace(int spaceId) {

        if (spaceId == DataSpaceManager.tableIdDefault) {
            return defaultSpaceManager;
        }

        if (spaceId >= spaceIdSequence.get()) {
            spaceIdSequence.set((spaceId + 2) & -2);
        }

        cache.writeLock.lock();

        try {
            TableSpaceManagerBlocks manager =
                (TableSpaceManagerBlocks) spaceManagerList.get(spaceId);

            if (manager == null) {
                int minReuse = cache.database.logger.propMinReuse;

                manager = new TableSpaceManagerBlocks(
                    this, spaceId, fileBlockSize,
                    cache.database.logger.propMaxFreeBlocks, dataFileScale,
                    minReuse);

                initialiseTableSpace(manager);
                spaceManagerList.put(spaceId, manager);
            }

            return manager;
        } finally {
            cache.writeLock.unlock();
        }
    }

    public int getNewTableSpaceID() {
        return spaceIdSequence.getAndAdd(2);
    }

    public void freeTableSpace(int spaceId) {

        if (spaceId == tableIdDefault || spaceId == tableIdDirectory) {
            return;
        }

        cache.writeLock.lock();

        try {
            TableSpaceManager tableSpace =
                (TableSpaceManager) spaceManagerList.get(spaceId);

            if (tableSpace != null) {
                tableSpace.reset();
                spaceManagerList.remove(spaceId);
            }

            IntIndex list = new IntIndex(16, false);

            ba.initialise(true);

            while (ba.nextBlockForTable(spaceId)) {
                list.addUnsorted(ba.currentBlockIndex);
                ba.setTable(tableIdEmpty);
                emptySpaceList.addUnique(ba.currentBlockIndex);
            }

            ba.reset();
            cache.releaseRange(list, fileBlockItemCount);
        } finally {
            cache.writeLock.unlock();
        }
    }

    public void freeTableSpace(int spaceId, DoubleIntIndex spaceList,
                               long offset, long limit, boolean full) {

        if (spaceList.size() == 0 && offset == limit) {
            return;
        }

        // sorts by keys
        spaceList.compactLookupAsIntervals();

        if (!full) {
            int available = spaceList.capacity() - spaceList.size();

            if (available > spaceList.capacity() / 4) {
                spaceList.setValuesSearchTarget();
                spaceList.sort();

                return;
            }
        }

        cache.writeLock.lock();

        try {
            ba.initialise(true);

            // spaceId may be the tableIdDefault for moved spaces
            int[] keys   = spaceList.getKeys();
            int[] values = spaceList.getValues();

            for (int i = 0; i < spaceList.size(); i++) {
                int position = keys[i];
                int units    = values[i];

                freeTableSpacePart(position, units);
            }

            long position = offset / dataFileScale;
            int  units    = (int) ((limit - offset) / dataFileScale);

            freeTableSpacePart(position, units);
            ba.reset();
        } finally {
            cache.writeLock.unlock();
        }

        spaceList.clear();
        spaceList.setValuesSearchTarget();
    }

    private void freeTableSpacePart(long position, int units) {

        for (; units > 0; ) {

            // count can cover more than one file block
            int blockIndex   = (int) (position / fileBlockItemCount);
            int offset       = (int) (position % fileBlockItemCount);
            int currentUnits = fileBlockItemCount - offset;

            if (currentUnits > units) {
                currentUnits = units;
            }

            ba.moveToBlock(blockIndex);

            int setCount = ba.setRange(offset, currentUnits);

            if (setCount != currentUnits) {
                ba.unsetRange(offset, currentUnits);
                cache.logSevereEvent("space manager error - recovered", null);
            }

            units    -= currentUnits;
            position += currentUnits;
        }
    }

    public int findTableSpace(long position) {

        int blockIndex = (int) (position / fileBlockItemCount);

        cache.writeLock.lock();

        try {
            ba.initialise(false);

            boolean result = ba.moveToBlock(blockIndex);

            if (!result) {
                ba.reset();

                return DataSpaceManager.tableIdDefault;
            }

            int id = ba.getTableId();

            ba.reset();

            return id;
        } finally {
            cache.writeLock.unlock();
        }
    }

    public long getLostBlocksSize() {

        long fragment = 0;

        cache.writeLock.lock();

        try {
            ba.initialise(false);

            for (;;) {
                boolean result = ba.nextBlock();

                if (!result) {
                    break;
                }

                if (ba.getTableId() == tableIdDirectory) {
                    continue;
                }

                fragment += ba.getFreeSpaceValue() * dataFileScale;

                if (ba.getTableId() == tableIdEmpty) {
                    fragment += fileBlockSize;
                }
            }

            ba.reset();
        } finally {
            cache.writeLock.unlock();
        }

        return fragment;
    }

    public int getFileBlockSize() {
        return fileBlockSize;
    }

    public boolean isModified() {
        return true;
    }

    public void initialiseSpaces() {

        cache.writeLock.lock();

        try {
            Iterator it = spaceManagerList.values().iterator();

            while (it.hasNext()) {
                TableSpaceManagerBlocks tableSpace =
                    (TableSpaceManagerBlocks) it.next();

                initialiseTableSpace(tableSpace);
            }
        } finally {
            cache.writeLock.unlock();
        }
    }

    public void reset() {

        cache.writeLock.lock();

        try {
            Iterator it = spaceManagerList.values().iterator();

            while (it.hasNext()) {
                TableSpaceManagerBlocks tableSpace =
                    (TableSpaceManagerBlocks) it.next();

                tableSpace.reset();
            }
        } finally {
            cache.writeLock.unlock();
        }
    }

    public boolean isMultiSpace() {
        return true;
    }

    public int getFileBlockItemCount() {
        return fileBlockItemCount;
    }

    public DirectoryBlockCachedObject[] getDirectoryList() {

        int                          count = 0;
        DirectoryBlockCachedObject[] directoryList;
        int[]                        rootArray = rootBlock.getIntArray();

        while (rootArray[count] != 0) {
            count++;
        }

        directoryList = new DirectoryBlockCachedObject[count];

        for (int i = 0; i < directoryList.length; i++) {
            directoryList[i] = getDirectory(i * blockSize, false);
        }

        return directoryList;
    }

    private void initialiseTableSpace(TableSpaceManagerBlocks tableSpace) {

        int spaceId        = tableSpace.getSpaceID();
        int maxFree        = 0;
        int blockIndex     = -1;
        int lastBlockIndex = tableSpace.getFileBlockIndex();

        if (lastBlockIndex >= 0) {
            ba.initialise(false);

            boolean result = ba.moveToBlock(lastBlockIndex);

            if (result) {
                if (ba.getTableId() == spaceId) {
                    if (ba.getFreeBlockValue() > 0) {
                        blockIndex = lastBlockIndex;
                    }
                }
            }

            ba.reset();
        }

        if (blockIndex < 0) {
            ba.initialise(false);

            for (; ba.nextBlockForTable(spaceId); ) {

                // find the largest free
                int currentFree = ba.getFreeBlockValue();

                if (currentFree > maxFree) {
                    blockIndex = ba.currentBlockIndex;
                    maxFree    = currentFree;
                }
            }

            ba.reset();
        }

        if (blockIndex < 0) {
            return;
        }

        // get existing file block and initialise
        ba.initialise(true);
        ba.moveToBlock(blockIndex);

        int  freeItems = ba.getFreeBlockValue();
        long blockPos  = (long) blockIndex * fileBlockSize;
        int unsetCount = ba.unsetRange(fileBlockItemCount - freeItems,
                                       freeItems);

        if (unsetCount == freeItems) {
            tableSpace.initialiseFileBlock(
                null, blockPos + (fileBlockSize - freeItems * dataFileScale),
                blockPos + fileBlockSize);
        } else {
            cache.logSevereEvent("space manager error - recovered", null);
        }

        ba.reset();
    }

    private class BlockAccessor {

        boolean                    currentKeep;
        int                        currentBlockIndex  = -1;
        int                        currentDirIndex    = -1;
        int                        currentBlockOffset = -1;
        DirectoryBlockCachedObject currentDir         = null;
        BitMapCachedObject         currentBitMap      = null;

        void initialise(boolean forUpdate) {
            currentKeep = forUpdate;
        }

        boolean nextBlock() {

            boolean result = moveToBlock(currentBlockIndex + 1);

            return result;
        }

        boolean nextBlockForTable(int tableId) {

            for (;;) {
                boolean result = moveToBlock(currentBlockIndex + 1);

                if (!result) {
                    return false;
                }

                if (getTableId() == tableId) {
                    return true;
                }
            }
        }

        boolean moveToBlock(int fileBlockIndex) {

            if (currentBlockIndex != fileBlockIndex) {
                endBlockUpdate();

                currentBitMap = null;

                if (currentDirIndex != fileBlockIndex / blockSize) {
                    reset();

                    currentDirIndex = fileBlockIndex / blockSize;
                    currentDir = getDirectory(fileBlockIndex, currentKeep);
                }

                if (currentDir == null) {
                    reset();

                    return false;
                }

                currentBlockIndex  = fileBlockIndex;
                currentBlockOffset = fileBlockIndex % blockSize;

                long position =
                    currentDir.getBitmapAddressArray()[currentBlockOffset];

                if (position == 0) {
                    reset();

                    return false;
                }

                if (currentKeep) {
                    position *= (fixedBlockSizeUnit / dataFileScale);
                    currentBitMap =
                        (BitMapCachedObject) bitMapStore.get(position, true);
                }
            }

            return true;
        }

        int setRange(int offset, int currentUnits) {

            currentBitMap.setChanged(true);

            return currentBitMap.bitMap.setRange(offset, currentUnits);
        }

        int unsetRange(int offset, int currentUnits) {

            currentBitMap.setChanged(true);

            return currentBitMap.bitMap.unsetRange(offset, currentUnits);
        }

        void reset() {

            endBlockUpdate();

            if (currentDir != null) {
                if (currentKeep) {
                    currentDir.keepInMemory(false);
                }
            }

            currentBlockIndex  = -1;
            currentDirIndex    = -1;
            currentBlockOffset = -1;
            currentDir         = null;
            currentBitMap      = null;
        }

        private void endBlockUpdate() {

            if (currentBitMap == null) {
                return;
            }

            if (!currentBitMap.hasChanged()) {
                currentBitMap.keepInMemory(false);

                return;
            }

            int freeUnits      = currentBitMap.bitMap.countSetBits();
            int freeBlockUnits = currentBitMap.bitMap.countSetBitsEnd();

            currentBitMap.keepInMemory(false);

            if (freeUnits == fileBlockItemCount) {
                setTable(tableIdEmpty);
                emptySpaceList.addUnique(currentBlockIndex);

                released++;

                return;
            }

            currentDir.getFreeSpaceArray()[currentBlockOffset] =
                (char) freeUnits;
            currentDir.getFreeBlockArray()[currentBlockOffset] =
                (char) freeBlockUnits;

            currentDir.setChanged(true);
        }

        void setTable(int tableId) {

            currentDir.getTableIdArray()[currentBlockOffset]   = tableId;
            currentDir.getFreeSpaceArray()[currentBlockOffset] = (char) 0;
            currentDir.getFreeBlockArray()[currentBlockOffset] = (char) 0;

            currentDir.setChanged(true);
            currentBitMap.bitMap.reset();
            currentBitMap.setChanged(true);
        }

        int getTableId() {
            return currentDir.getTableIdArray()[currentBlockOffset];
        }

        char getFreeSpaceValue() {
            return currentDir.getFreeSpaceArray()[currentBlockOffset];
        }

        char getFreeBlockValue() {
            return currentDir.getFreeBlockArray()[currentBlockOffset];
        }
    }
}

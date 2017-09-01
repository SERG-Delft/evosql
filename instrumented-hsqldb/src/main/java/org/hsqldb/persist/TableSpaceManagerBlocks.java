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
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.DoubleIntIndex;

/**
 * Manages allocation of space for rows.<p>
 * Maintains a list of free file blocks with fixed capacity.<p>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 2.3.0
 */
public class TableSpaceManagerBlocks implements TableSpaceManager {

    DataSpaceManager  spaceManager;
    private final int scale;
    final int         mainBlockSize;
    final int         spaceID;
    final int         minReuse;

    //
    private DoubleIntIndex lookup;
    private final int      capacity;
    private long           requestGetCount;
    private long           releaseCount;
    private long           requestCount;
    private long           requestSize;
    boolean                isModified;

    //
    long freshBlockFreePos = 0;
    long freshBlockLimit   = 0;
    int  fileBlockIndex    = -1;

    /**
     *
     */
    public TableSpaceManagerBlocks(DataSpaceManager spaceManager, int tableId,
                                   int fileBlockSize, int capacity,
                                   int fileScale, int minReuse) {

        this.spaceManager  = spaceManager;
        this.scale         = fileScale;
        this.spaceID       = tableId;
        this.mainBlockSize = fileBlockSize;
        this.minReuse      = minReuse;
        lookup             = new DoubleIntIndex(capacity, true);

        lookup.setValuesSearchTarget();

        this.capacity = capacity;
    }

    public boolean hasFileRoom(long blockSize) {
        return freshBlockLimit - freshBlockFreePos > blockSize;
    }

    public void addFileBlock(long blockFreePos, long blockLimit) {

        int released = (int) (freshBlockLimit - freshBlockFreePos);

        if (released > 0) {
            release(freshBlockFreePos / scale, released);
        }

        initialiseFileBlock(null, blockFreePos, blockLimit);
    }

    public void initialiseFileBlock(DoubleIntIndex spaceList,
                                    long blockFreePos, long blockLimit) {

        freshBlockFreePos = blockFreePos;
        freshBlockLimit   = blockLimit;

        if (spaceList != null) {
            spaceList.copyTo(lookup);
        }
    }

    boolean getNewMainBlock(long rowSize) {

        long blockCount = (mainBlockSize + rowSize) / mainBlockSize;
        long blockSize  = blockCount * mainBlockSize;
        long position = spaceManager.getFileBlocks(spaceID, (int) blockCount);

        if (position < 0) {
            return false;
        }

        if (position != freshBlockLimit) {
            long released = freshBlockLimit - freshBlockFreePos;

            if (released > 0) {
                release(freshBlockFreePos / scale, (int) released);
            }

            freshBlockFreePos = position;
            freshBlockLimit   = position;
        }

        freshBlockLimit += blockSize;

        return true;
    }

    long getNewBlock(long rowSize, boolean asBlocks) {

        if (asBlocks) {
            rowSize = (int) ArrayUtil.getBinaryMultipleCeiling(rowSize,
                    DataSpaceManager.fixedBlockSizeUnit);
        }

        if (freshBlockFreePos + rowSize > freshBlockLimit) {
            boolean result = getNewMainBlock(rowSize);

            if (!result) {
                throw Error.error(ErrorCode.DATA_FILE_IS_FULL);
            }
        }

        long position = freshBlockFreePos;

        if (asBlocks) {
            position = ArrayUtil.getBinaryMultipleCeiling(position,
                    DataSpaceManager.fixedBlockSizeUnit);

            long released = position - freshBlockFreePos;

            if (released > 0) {
                release(freshBlockFreePos / scale, (int) released);

                freshBlockFreePos = position;
            }
        }

        freshBlockFreePos += rowSize;

        return position / scale;
    }

    public int getSpaceID() {
        return spaceID;
    }

    synchronized public void release(long pos, int rowSize) {

        isModified = true;

        releaseCount++;

        if (lookup.size() == capacity) {
            resetList();
        }

        if (pos >= Integer.MAX_VALUE) {
            return;
        }

        lookup.add(pos, rowSize / scale);
    }

    /**
     * Returns the position of a free block or 0.
     */
    synchronized public long getFilePosition(int rowSize, boolean asBlocks) {

        requestGetCount++;

        if (capacity == 0) {
            return getNewBlock(rowSize, asBlocks);
        }

        if (asBlocks) {
            rowSize = (int) ArrayUtil.getBinaryMultipleCeiling(rowSize,
                    DataSpaceManager.fixedBlockSizeUnit);
        }

        int index    = -1;
        int rowUnits = rowSize / scale;

        if (rowSize >= minReuse && lookup.size() > 0) {
            if (lookup.getValue(0) >= rowUnits) {
                index = 0;
            } else if (rowSize > Integer.MAX_VALUE) {
                index = -1;
            } else {
                index = lookup.findFirstGreaterEqualKeyIndex(rowUnits);
            }
        }

        if (index == -1) {
            return getNewBlock(rowSize, asBlocks);
        }

        if (asBlocks) {
            for (; index < lookup.size(); index++) {
                long pos = lookup.getKey(index);

                if (pos % (DataSpaceManager.fixedBlockSizeUnit / scale) == 0) {
                    break;
                }
            }

            if (index == lookup.size()) {
                return getNewBlock(rowSize, asBlocks);
            }
        }

        // statistics for successful requests only - to be used later for midSize
        requestCount++;

        requestSize += rowSize;

        int key        = lookup.getKey(index);
        int units      = lookup.getValue(index);
        int difference = units - rowUnits;

        lookup.remove(index);

        if (difference > 0) {
            int pos = key + rowUnits;

            lookup.add(pos, difference);
        }

        return key;
    }

    public void reset() {

        if (freshBlockFreePos == 0) {
            fileBlockIndex = -1;
        } else {
            fileBlockIndex = (int) (freshBlockFreePos / mainBlockSize);
        }

        spaceManager.freeTableSpace(spaceID, lookup, freshBlockFreePos,
                                    freshBlockLimit, true);

        freshBlockFreePos = 0;
        freshBlockLimit   = 0;
    }

    public long getLostBlocksSize() {

        long total = freshBlockLimit - freshBlockFreePos
                     + lookup.getTotalValues() * scale;

        return total;
    }

    public boolean isDefaultSpace() {
        return spaceID == DataSpaceManager.tableIdDefault;
    }

    public int getFileBlockIndex() {
        return fileBlockIndex;
    }

    private void resetList() {

        // dummy args for file block release
        spaceManager.freeTableSpace(spaceID, lookup, 0, 0, false);
    }
}

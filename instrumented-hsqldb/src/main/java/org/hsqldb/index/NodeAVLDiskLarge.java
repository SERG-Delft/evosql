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


package org.hsqldb.index;

import java.io.IOException;

import org.hsqldb.RowAVL;
import org.hsqldb.RowAVLDisk;
import org.hsqldb.lib.LongLookup;
import org.hsqldb.persist.PersistentStore;
import org.hsqldb.rowio.RowInputInterface;
import org.hsqldb.rowio.RowOutputInterface;

/**
 *  Subclass of NodeAVL for huge databases.
 * @author Fred Toussi (fredt@users dot sourceforge dot net)
 * @version 2.3.4
 * @since 2.2.9
 */
public class NodeAVLDiskLarge extends NodeAVL {

    private long            iLeft   = NO_POS;
    private long            iRight  = NO_POS;
    private long            iParent = NO_POS;
    private int             iId;    // id of Index object for this Node
    public static final int SIZE_IN_BYTE = 4 * 4;

    public NodeAVLDiskLarge(RowAVLDisk r, RowInputInterface in,
                            int id) throws IOException {

        super(r);

        iId = id;

        int ext = in.readInt();

        iBalance = (byte) ext;
        iLeft    = in.readInt() & 0xffffffffL;
        iRight   = in.readInt() & 0xffffffffL;
        iParent  = in.readInt() & 0xffffffffL;

        if (ext > 0xff) {
            iParent |= (((long) ext << 8) & 0xff00000000L);
            iLeft   |= (((long) ext << 16) & 0xff00000000L);
            iRight  |= (((long) ext << 24) & 0xff00000000L);
        }

        if (iLeft == 0) {
            iLeft = NO_POS;
        }

        if (iRight == 0) {
            iRight = NO_POS;
        }

        if (iParent == 0) {
            iParent = NO_POS;
        }
    }

    public NodeAVLDiskLarge(RowAVLDisk r, int id) {

        super(r);

        iId = id;
    }

    public void delete() {

        iLeft    = NO_POS;
        iRight   = NO_POS;
        iParent  = NO_POS;
        iBalance = 0;

        ((RowAVLDisk) row).setNodesChanged();
    }

    public boolean isInMemory() {
        return row.isInMemory();
    }

    public boolean isMemory() {
        return false;
    }

    public long getPos() {
        return row.getPos();
    }

    public RowAVL getRow(PersistentStore store) {
        return (RowAVLDisk) store.get(this.row, false);
    }

    public Object[] getData(PersistentStore store) {
        return row.getData();
    }

    private NodeAVLDiskLarge findNode(PersistentStore store, long pos) {

        NodeAVLDiskLarge ret = null;
        RowAVLDisk       r   = (RowAVLDisk) store.get(pos, false);

        if (r != null) {
            ret = (NodeAVLDiskLarge) r.getNode(iId);
        }

        return ret;
    }

    boolean isLeft(NodeAVL n) {

        if (n == null) {
            return iLeft == NO_POS;
        }

        return iLeft == n.getPos();
    }

    boolean isRight(NodeAVL n) {

        if (n == null) {
            return iRight == NO_POS;
        }

        return iRight == n.getPos();
    }

    NodeAVL getLeft(PersistentStore store) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, false);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        if (node.iLeft == NO_POS) {
            return null;
        }

        NodeAVLDiskLarge temp = findNode(store, node.iLeft);

        return temp;
    }

    NodeAVL getRight(PersistentStore store) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, false);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        if (node.iRight == NO_POS) {
            return null;
        }

        NodeAVLDiskLarge temp = findNode(store, node.iRight);

        return temp;
    }

    NodeAVL getParent(PersistentStore store) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, false);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        if (node.iParent == NO_POS) {
            return null;
        }

        NodeAVLDiskLarge temp = findNode(store, iParent);

        return temp;
    }

    public int getBalance(PersistentStore store) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, false);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        return node.iBalance;
    }

    boolean isRoot(PersistentStore store) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, false);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        return node.iParent == NO_POS;
    }

    boolean isFromLeft(PersistentStore store) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, false);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        if (node.iParent == NO_POS) {
            return true;
        }

        NodeAVLDiskLarge temp = findNode(store, iParent);

        return row.getPos() == temp.iLeft;
    }

    public NodeAVL child(PersistentStore store, boolean isleft) {
        return isleft ? getLeft(store)
                      : getRight(store);
    }

    NodeAVL setParent(PersistentStore store, NodeAVL n) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, true);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        row.setNodesChanged();

        node.iParent = n == null ? NO_POS
                                 : n.getPos();

        row.keepInMemory(false);

        return node;
    }

    public NodeAVL setBalance(PersistentStore store, int b) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, true);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        row.setNodesChanged();

        node.iBalance = b;

        row.keepInMemory(false);

        return node;
    }

    NodeAVL setLeft(PersistentStore store, NodeAVL n) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, true);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        row.setNodesChanged();

        node.iLeft = n == null ? NO_POS
                               : n.getPos();

        row.keepInMemory(false);

        return node;
    }

    NodeAVL setRight(PersistentStore store, NodeAVL n) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) store.get(this.row, true);

        node = (NodeAVLDiskLarge) row.getNode(iId);

        row.setNodesChanged();

        node.iRight = n == null ? NO_POS
                                : n.getPos();

        row.keepInMemory(false);

        return node;
    }

    public NodeAVL set(PersistentStore store, boolean isLeft, NodeAVL n) {

        NodeAVL x;

        if (isLeft) {
            x = setLeft(store, n);
        } else {
            x = setRight(store, n);
        }

        if (n != null) {
            n.setParent(store, this);
        }

        return x;
    }

    public void replace(PersistentStore store, Index index, NodeAVL n) {

        NodeAVLDiskLarge node = this;
        RowAVLDisk       row  = (RowAVLDisk) this.row;

        if (!row.keepInMemory(true)) {
            row  = (RowAVLDisk) store.get(this.row, true);
            node = (NodeAVLDiskLarge) row.getNode(iId);
        }

        if (node.iParent == NO_POS) {
            if (n != null) {
                n = n.setParent(store, null);
            }

            store.setAccessor(index, n);
        } else {
            boolean isFromLeft = node.isFromLeft(store);

            node.getParent(store).set(store, isFromLeft, n);
        }

        row.keepInMemory(false);
    }

    boolean equals(NodeAVL n) {

        if (n instanceof NodeAVLDiskLarge) {
            return this == n || row.getPos() == n.getPos();
        }

        return false;
    }

    public int getRealSize(RowOutputInterface out) {
        return NodeAVLDiskLarge.SIZE_IN_BYTE;
    }

    public void setInMemory(boolean in) {}

    public void write(RowOutputInterface out) {
        write(out, null);
    }

    public void write(RowOutputInterface out, LongLookup lookup) {

        long leftTemp   = getTranslatePointer(iLeft, lookup);
        long rightTemp  = getTranslatePointer(iRight, lookup);
        long parentTemp = getTranslatePointer(iParent, lookup);
        int  ext        = 0;

        ext |= (int) ((parentTemp & 0xff00000000L) >> 8);
        ext |= (int) ((leftTemp & 0xff00000000L) >> 16);
        ext |= (int) ((rightTemp & 0xff00000000L) >> 24);

        if (ext == 0) {
            ext = iBalance;
        } else {
            ext |= (iBalance & 0xff);
        }

        out.writeInt(ext);
        out.writeInt((int) leftTemp);
        out.writeInt((int) rightTemp);
        out.writeInt((int) parentTemp);
    }

    private static long getTranslatePointer(long pointer, LongLookup lookup) {

        long newPointer = 0;

        if (pointer != NodeAVL.NO_POS) {
            if (lookup == null) {
                newPointer = pointer;
            } else {
                newPointer = lookup.lookup(pointer);
            }
        }

        return newPointer;
    }

    public void restore() {}

    public void destroy() {}

    public void updateAccessCount(int count) {}

    public int getAccessCount() {
        return 0;
    }

    public void setStorageSize(int size) {}

    public int getStorageSize() {
        return 0;
    }

    public void setPos(long pos) {}

    public boolean hasChanged() {
        return false;
    }

    public void setChanged(boolean flag) {}

    public boolean isKeepInMemory() {
        return false;
    }

    public boolean keepInMemory(boolean keep) {
        return false;
    }
}

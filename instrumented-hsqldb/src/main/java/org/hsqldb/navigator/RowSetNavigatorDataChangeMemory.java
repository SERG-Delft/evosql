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


package org.hsqldb.navigator;

import java.io.IOException;

import org.hsqldb.Row;
import org.hsqldb.Session;
import org.hsqldb.TableBase;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.OrderedLongKeyHashMap;
import org.hsqldb.result.ResultMetaData;
import org.hsqldb.rowio.RowInputInterface;
import org.hsqldb.rowio.RowOutputInterface;
import org.hsqldb.types.Type;

/*
 * All-in-memory implementation of RowSetNavigator for delete and update
 * operations.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class RowSetNavigatorDataChangeMemory
implements RowSetNavigatorDataChange {

    public static final RowSetNavigatorDataChangeMemory emptyRowSet =
        new RowSetNavigatorDataChangeMemory(null);
    int                   size;
    int                   currentPos = -1;
    OrderedLongKeyHashMap list;
    Session               session;

    public RowSetNavigatorDataChangeMemory(Session session) {
        this.session = session;
        list         = new OrderedLongKeyHashMap(64, true);
    }

    public void release() {

        beforeFirst();
        list.clear();

        size = 0;
    }

    public int getSize() {
        return size;
    }

    public int getRowPosition() {
        return currentPos;
    }

    public boolean next() {

        if (currentPos < size - 1) {
            currentPos++;

            return true;
        }

        currentPos = size - 1;

        return false;
    }

    public boolean beforeFirst() {

        currentPos = -1;

        return true;
    }

    public Row getCurrentRow() {
        return (Row) list.getValueByIndex(currentPos);
    }

    public Object[] getCurrentChangedData() {
        return (Object[]) list.getSecondValueByIndex(currentPos);
    }

    public int[] getCurrentChangedColumns() {
        return (int[]) list.getThirdValueByIndex(currentPos);
    }

    // reading and writing
    public void write(RowOutputInterface out,
                      ResultMetaData meta) throws IOException {}

    public void read(RowInputInterface in,
                     ResultMetaData meta) throws IOException {}

    public void endMainDataSet() {}

    public boolean addRow(Row row) {

        int lookup = list.getLookup(row.getId());

        if (lookup == -1) {
            list.put(row.getId(), row, null);

            size++;

            return true;
        } else {
            if (list.getSecondValueByIndex(lookup) != null) {
                if (session.database.sqlEnforceTDCD) {
                    throw Error.error(ErrorCode.X_27000);
                }

                list.setSecondValueByIndex(lookup, null);
                list.setThirdValueByIndex(lookup, null);

                return true;
            }

            return false;
        }
    }

    public boolean addUpdate(Row row, Object[] data, int[] columnMap) {

        int lookup = list.getLookup(row.getId());

        if (lookup == -1) {
            return false;
        }

        list.put(row.getId(), row, data);
        list.setThirdValueByIndex(lookup, columnMap);

        return true;
    }

    public Object[] addRow(Session session, Row row, Object[] data,
                           Type[] types, int[] columnMap) {

        long rowId  = row.getId();
        int  lookup = list.getLookup(rowId);

        if (lookup == -1) {
            list.put(rowId, row, data);
            list.setThirdValueByIndex(size, columnMap);

            size++;

            return data;
        } else {
            Object[] rowData = ((Row) list.getFirstByLookup(lookup)).getData();
            Object[] currentData =
                (Object[]) list.getSecondValueByIndex(lookup);

            if (currentData == null) {
                if (session.database.sqlEnforceTDCD) {
                    throw Error.error(ErrorCode.X_27000);
                } else {
                    return null;
                }
            }

            for (int i = 0; i < columnMap.length; i++) {
                int j = columnMap[i];

                if (types[j].compare(session, data[j], currentData[j]) != 0) {
                    if (types[j].compare(session, rowData[j], currentData[j])
                            != 0) {
                        if (session.database.sqlEnforceTDCU) {
                            throw Error.error(ErrorCode.X_27000);
                        }
                    } else {
                        currentData[j] = data[j];
                    }
                }
            }

            int[] currentMap = (int[]) list.getThirdValueByIndex(lookup);

            currentMap = ArrayUtil.union(currentMap, columnMap);

            list.setThirdValueByIndex(lookup, currentMap);

            return currentData;
        }
    }

    public boolean containsDeletedRow(Row refRow) {

        int lookup = list.getLookup(refRow.getId());

        if (lookup == -1) {
            return false;
        }

        Object[] currentData = (Object[]) list.getSecondValueByIndex(lookup);

        return currentData == null;
    }

    public boolean containsUpdatedRow(Row row, Row refRow, int[] keys) {

        int lookup = list.getLookup(refRow.getId());

        if (lookup > -1) {
            return true;
        }

        Object[] rowData = row.getData();

        outerloop:
        for (int i = 0; i < size; i++) {
            Row oldRow = (Row) list.getValueByIndex(i);

            if (oldRow.getTable() != row.getTable()) {
                continue;
            }

            Type[]   types = row.getTable().getColumnTypes();
            Object[] data  = (Object[]) list.getSecondValueByIndex(i);

            for (int j = 0; j < keys.length; j++) {
                int pos = keys[j];

                if (types[pos].compare(session, rowData[pos], data[pos])
                        != 0) {
                    continue outerloop;
                }
            }

            return true;
        }

        return false;
    }

    public Row getNextRow() {

        if (next()) {
            return getCurrentRow();
        }

        return null;
    }

    public Object[] getNext() {

        if (next()) {
            Row row = getCurrentRow();

            return row.getData();
        }

        return null;
    }

    public boolean hasNext() {
        return currentPos < size - 1;
    }

    public void removeCurrent() {}

    public long getRowId() {
        return getCurrentRow().getId();
    }

    public TableBase getCurrentTable() {
        return getCurrentRow().getTable();
    }

    public boolean isBeforeFirst() {
        return currentPos == -1;
    }

    public Object[] getCurrent() {
        return getCurrentRow().getData();
    }

    public Object getCurrent(int i) {
        return getCurrentRow().getData()[i];
    }

    public void setCurrent(Object[] data) {}

    public Object getRowidObject() {
        return Long.valueOf(getRowId());
    }

    public void reset() {
        beforeFirst();
    }

    public int getRangePosition() {
        return 1;
    }

    public RangeIterator getUpdateRowIterator() {
        return new UpdateRowIterator();
    }

    class UpdateRowIterator implements RangeIterator {

        public Row getNextRow() {
            return null;
        }

        public Object[] getNext() {

            if (RowSetNavigatorDataChangeMemory.this.next()) {
                return RowSetNavigatorDataChangeMemory.this
                    .getCurrentChangedData();
            }

            return null;
        }

        public boolean hasNext() {
            return RowSetNavigatorDataChangeMemory.this.hasNext();
        }

        public void removeCurrent() {}

        public void release() {}

        public long getRowId() {
            return 0;
        }

        public boolean beforeFirst() {
            return RowSetNavigatorDataChangeMemory.this.beforeFirst();
        }

        public Row getCurrentRow() {
            return null;
        }

        public boolean next() {
            return RowSetNavigatorDataChangeMemory.this.next();
        }

        public boolean isBeforeFirst() {
            return RowSetNavigatorDataChangeMemory.this.isBeforeFirst();
        }

        public Object[] getCurrent() {
            return RowSetNavigatorDataChangeMemory.this
                .getCurrentChangedData();
        }

        public Object getCurrent(int i) {
            return RowSetNavigatorDataChangeMemory.this
                .getCurrentChangedData()[i];
        }

        public TableBase getCurrentTable() {
            return null;
        }

        public void setCurrent(Object[] data) {}

        public Object getRowidObject() {
            return Long.valueOf(getRowId());
        }

        public void reset() {
            beforeFirst();
        }

        public int getRangePosition() {
            return 1;
        }
    }
}

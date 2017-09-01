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


package org.hsqldb.lib;

/**
 * Maintains an ordered  integer index. Equal keys are allowed.
 *
 * findXXX() methods return the array index into the list
 * containing a matching key, or  or -1 if not found.<p>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 2.3.3
 */
public class IntIndex {

    private int           count = 0;
    private int           capacity;
    private boolean       sorted       = true;
    private boolean       sortOnValues = true;
    private boolean       hasChanged;
    private final boolean fixedSize;
    private int[]         keys;

//
    private int targetSearchValue;

    public IntIndex(int capacity, boolean fixedSize) {

        this.capacity  = capacity;
        keys           = new int[capacity];
        this.fixedSize = fixedSize;
        hasChanged     = true;
    }

    public synchronized int getKey(int i) {

        if (i < 0 || i >= count) {
            throw new IndexOutOfBoundsException();
        }

        return keys[i];
    }

    /**
     * Modifies an existing pair.
     * @param i the index
     * @param key the key
     */
    public synchronized void setKey(int i, int key) {

        if (i < 0 || i >= count) {
            throw new IndexOutOfBoundsException();
        }

        if (!sortOnValues) {
            sorted = false;
        }

        keys[i] = key;
    }

    public synchronized int size() {
        return count;
    }

    public synchronized int capacity() {
        return capacity;
    }

    public int[] getKeys() {
        return keys;
    }

    public long getTotalValues() {

        long total = 0;

        for (int i = 0; i < count; i++) {
            total += keys[i];
        }

        return total;
    }

    public void setSize(int newSize) {
        count = newSize;
    }

    /**
     * Adds a key into the table.
     *
     * @param key the key
     * @return true or false depending on success
     */
    public synchronized boolean addUnsorted(int key) {

        if (count == capacity) {
            if (fixedSize) {
                return false;
            } else {
                doubleCapacity();
            }
        }

        if (sorted && count != 0) {
            if (key < keys[count - 1]) {
                sorted = false;
            }
        }

        hasChanged  = true;
        keys[count] = key;

        count++;

        return true;
    }

    /**
     * Adds a key into the table with the guarantee that the key
     * is equal or larger than the largest existing key. This prevents a sort
     * from taking place on next call to find()
     *
     * @param key the key
     * @return true or false depending on success
     */
    public synchronized boolean addSorted(int key) {

        if (count == capacity) {
            if (fixedSize) {
                return false;
            } else {
                doubleCapacity();
            }
        }

        if (count != 0) {
            if (key < keys[count - 1]) {
                return false;
            }
        }

        hasChanged  = true;
        keys[count] = key;

        count++;

        return true;
    }

    /**
     * Adds a key, ensuring no duplicate key already exists in the
     * current search target column.
     * @param key the key
     * @return true or false depending on success
     */
    public synchronized boolean addUnique(int key) {

        if (count == capacity) {
            if (fixedSize) {
                return false;
            } else {
                doubleCapacity();
            }
        }

        if (!sorted) {
            fastQuickSort();
        }

        targetSearchValue = key;

        int i = binaryEmptySlotSearch();

        if (i == -1) {
            return false;
        }

        hasChanged = true;

        if (count != i) {
            moveRows(i, i + 1, count - i);
        }

        keys[i] = key;

        count++;

        return true;
    }

    /**
     * Adds a key, maintaining sort order on
     * current search target column.
     * @param key the key
     * @return index of added key or -1 if full
     */
    public synchronized int add(int key) {

        if (count == capacity) {
            if (fixedSize) {
                return -1;
            } else {
                doubleCapacity();
            }
        }

        if (!sorted) {
            fastQuickSort();
        }

        targetSearchValue = key;

        int i = binarySlotSearch();

        if (i == -1) {
            return i;
        }

        hasChanged = true;

        if (count != i) {
            moveRows(i, i + 1, count - i);
        }

        keys[i] = key;

        count++;

        return i;
    }

    public void clear() {
        removeAll();
    }

    /**
     * @param value the value
     * @return the index
     */
    public synchronized int findFirstGreaterEqualKeyIndex(int value) {

        int index = findFirstGreaterEqualSlotIndex(value);

        return index == count ? -1
                              : index;
    }

    /**
     * @param value the value
     * @return the index
     */
    public synchronized int findFirstEqualKeyIndex(int value) {

        if (!sorted) {
            fastQuickSort();
        }

        targetSearchValue = value;

        return binaryFirstSearch();
    }

    /**
     * @param number the number of consecutive keys required
     * @return the index or -1 if not found
     */
    public synchronized int findFirstConsecutiveKeys(int number) {

        int baseIndex = -1;

        if (count == 0) {
            return -1;
        }

        if (!sorted) {
            fastQuickSort();
        }

        if (number == 1) {
            return 0;
        }

        for (int i = 1; i < count; i++) {
            if (keys[i - 1] == keys[i] - 1) {
                if (baseIndex == -1) {
                    baseIndex = i - 1;
                }

                if (i - baseIndex + 1 == count) {
                    return baseIndex;
                }
            } else {
                baseIndex = -1;
            }
        }

        return baseIndex;
    }

    /**
     * @param number the number of consecutive keys required
     * @return the first key in series or def if not found
     */
    public synchronized int removeFirstConsecutiveKeys(int number, int def) {

        int baseIndex = findFirstConsecutiveKeys(number);

        if (baseIndex == -1) {
            return def;
        }

        int result = keys[baseIndex];

        this.removeRange(baseIndex, baseIndex + number);

        return result;
    }

    /**
     * This method is similar to findFirstGreaterEqualKeyIndex(int) but
     * returns the index of the empty row past the end of the array if
     * the search value is larger than all the values / keys in the searched
     * column.
     * @param value the value
     * @return the index
     */
    public synchronized int findFirstGreaterEqualSlotIndex(int value) {

        if (!sorted) {
            fastQuickSort();
        }

        targetSearchValue = value;

        return binarySlotSearch();
    }

    /**
     * Returns the index of the lowest element == the given search target,
     * or -1
     * @return index or -1 if not found
     */
    private int binaryFirstSearch() {

        int low     = 0;
        int high    = count;
        int mid     = 0;
        int compare = 0;
        int found   = count;

        while (low < high) {
            mid     = (low + high) >>> 1;
            compare = compare(mid);

            if (compare < 0) {
                high = mid;
            } else if (compare > 0) {
                low = mid + 1;
            } else {
                high  = mid;
                found = mid;
            }
        }

        return found == count ? -1
                              : found;
    }

    /**
     * Returns the index of the lowest element >= the given search target,
     * or count
     *     @return the index
     */
    private int binarySlotSearch() {

        int low     = 0;
        int high    = count;
        int mid     = 0;
        int compare = 0;

        while (low < high) {
            mid     = (low + high) >>> 1;
            compare = compare(mid);

            if (compare <= 0) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }

        return low;
    }

    /**
     * Returns the index of the lowest element > the given search target
     * or count or -1 if target is found
     * @return the index
     */
    private int binaryEmptySlotSearch() {

        int low     = 0;
        int high    = count;
        int mid     = 0;
        int compare = 0;

        while (low < high) {
            mid     = (low + high) >>> 1;
            compare = compare(mid);

            if (compare < 0) {
                high = mid;
            } else if (compare > 0) {
                low = mid + 1;
            } else {
                return -1;
            }
        }

        return low;
    }

    public synchronized void sort() {
        fastQuickSort();
    }

    /**
     * fast quicksort using a stack on the heap to reduce stack use
     */
    private synchronized void fastQuickSort() {

        DoubleIntIndex indices   = new DoubleIntIndex(32, false);
        int            threshold = 16;

        indices.push(0, count - 1);

        while (indices.size() > 0) {
            int start = indices.peekKey();
            int end   = indices.peekValue();

            indices.pop();

            if (end - start >= threshold) {
                int pivot = partition(start, end, start + ((end - start) >>> 1));

                indices.push(start, pivot - 1);
                indices.push(pivot + 1, end);
            } else {
                insertionSort(start, end);
            }
        }

        sorted = true;
    }

    private int partition(int start, int end, int pivot) {

        int store = start;

        swap(pivot, end);

        for (int i = start; i <= end - 1; i++) {
            if (lessThan(i, end)) {
                swap(i, store);

                store++;
            }
        }

        swap(store, end);

        return store;
    }

    /**
     * fast quicksort with recursive quicksort implementation
     */
    private synchronized void fastQuickSortRecursive() {

        quickSort(0, count - 1);
        insertionSort(0, count - 1);

        sorted = true;
    }

    private void quickSort(int l, int r) {

        int M = 16;
        int i;
        int j;
        int v;

        if ((r - l) > M) {
            i = (r + l) >>> 1;

            if (lessThan(i, l)) {
                swap(l, i);    // Tri-Median Methode!
            }

            if (lessThan(r, l)) {
                swap(l, r);
            }

            if (lessThan(r, i)) {
                swap(i, r);
            }

            j = r - 1;

            swap(i, j);

            i = l;
            v = j;

            for (;;) {
                while (lessThan(++i, v)) {}

                while (lessThan(v, --j)) {}

                if (j < i) {
                    break;
                }

                swap(i, j);
            }

            swap(i, r - 1);
            quickSort(l, j);
            quickSort(i + 1, r);
        }
    }

    private void insertionSort(int lo0, int hi0) {

        int i;
        int j;

        for (i = lo0 + 1; i <= hi0; i++) {
            j = i;

            while ((j > lo0) && lessThan(i, j - 1)) {
                j--;
            }

            if (i != j) {
                moveAndInsertRow(i, j);
            }
        }
    }

    protected void moveAndInsertRow(int i, int j) {

        int col1 = keys[i];

        moveRows(j, j + 1, i - j);

        keys[j] = col1;
    }

    protected void swap(int i1, int i2) {

        int col1 = keys[i1];

        keys[i1] = keys[i2];
        keys[i2] = col1;
    }

    /**
     * Check if targeted column value in the row indexed i is less than the
     * search target object.
     * @param i the index
     * @return -1, 0 or +1
     */
    protected int compare(int i) {

        if (targetSearchValue > keys[i]) {
            return 1;
        } else if (targetSearchValue < keys[i]) {
            return -1;
        }

        return 0;
    }

    /**
     * Check if row indexed i is less than row indexed j
     * @param i the first index
     * @param j the second index
     * @return true or false
     */
    protected boolean lessThan(int i, int j) {

        if (keys[i] < keys[j]) {
            return true;
        }

        return false;
    }

    protected void moveRows(int fromIndex, int toIndex, int rows) {
        System.arraycopy(keys, fromIndex, keys, toIndex, rows);
    }

    protected void doubleCapacity() {
        keys     = (int[]) ArrayUtil.resizeArray(keys, capacity * 2);
        capacity *= 2;
    }

    public void removeRange(int start, int limit) {

        ArrayUtil.adjustArray(ArrayUtil.CLASS_CODE_INT, keys, count, start,
                              start - limit);

        count -= (limit - start);
    }

    public void removeAll() {

        hasChanged = true;

        ArrayUtil.clearArray(ArrayUtil.CLASS_CODE_INT, keys, 0, count);

        count = 0;
    }

    public void copyTo(IntIndex other) {
        System.arraycopy(keys, 0, other.keys, 0, count);
        other.setSize(count);
    }

    public final synchronized void remove(int position) {

        hasChanged = true;

        moveRows(position + 1, position, count - position - 1);

        count--;

        keys[count]   = 0;
    }

    /**
     * peek the key at top of stack. Uses the data structure as a stack.
     * @return int key
     */
    private int peek() {
        return getKey(count - 1);
    }

    /**
     * pop the pair at top of stack
     * @return boolean if there was an element
     */
    private boolean pop() {

        if (count > 0) {
            count--;

            return true;
        }

        return false;
    }

    /**
     * push key, value pair
     * @return boolean true if successful
     */
    private boolean push(int key) {
        return addUnsorted(key);
    }
}

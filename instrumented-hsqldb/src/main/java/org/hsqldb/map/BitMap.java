/* Copyright (c) 2001-2014, The HSQL Development Group
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


package org.hsqldb.map;

import org.hsqldb.lib.ArrayUtil;

/**
 * Implementation of a bit map of any size. The map is initialised with
 * the given size with no bits set. The map is fixed length depending on
 * the constructor argument.
 *
 * Static methods to manipulate int, byte and byte[] values as bit maps.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.8.0
*/
public class BitMap {

    private boolean canChangeSize;
    private int     initialSize;
    private int[]   map;
    private int     limitPos;

    public BitMap(int size, boolean extend) {

        int words = size / 32;

        if (size == 0 || size % 32 != 0) {
            words++;
        }

        map           = new int[words];
        canChangeSize = extend;
        limitPos      = size;
        initialSize   = size;
    }

    public BitMap(int[] map) {

        this.map      = map;
        initialSize   = map.length * 32;
        limitPos      = initialSize;
        canChangeSize = false;
    }

    public BitMap duplicate() {

        BitMap newMap = new BitMap((int[]) ArrayUtil.duplicateArray(this.map));

        newMap.canChangeSize = this.canChangeSize;
        newMap.initialSize   = this.initialSize;
        newMap.limitPos      = this.limitPos;

        return newMap;
    }

    public int size() {
        return limitPos;
    }

    public void setSize(int newSize) {

        if (!canChangeSize) {
            throw new UnsupportedOperationException("BitMap");
        }

        ensureCapacity(newSize);

        // if newSize is smaller
        if (limitPos > newSize) {
            unsetRange(newSize, limitPos - newSize);

            limitPos = newSize;
        }
    }

    /**
     * Resets to bits not set with original size
     */
    public void reset() {

        for (int i = 0; i < map.length; i++) {
            map[i] = 0;
        }

        limitPos = initialSize;
    }

    /**
     * Counts the bit positions that are set both in this and the other map.
     */
    public int countSetMatches(BitMap other) {

        int matchCount = 0;

        for (int i = 0; i < map.length; i++) {
            int matches = this.map[i] & other.map[i];

            if (matches != 0) {
                matchCount += Integer.bitCount(matches);
            }
        }

        return matchCount;
    }

    public int setRange(int pos, int count) {
        return setOrUnsetRange(pos, count, true);
    }

    public int unsetRange(int pos, int count) {
        return setOrUnsetRange(pos, count, false);
    }

    /**
     * returns count of bits that change
     */
    private int setOrUnsetRange(int pos, int count, boolean set) {

        if (count == 0) {
            return 0;
        }

        ensureCapacity(pos + count);

        int windex    = pos >> 5;
        int windexend = (pos + count - 1) >> 5;
        int mask      = 0xffffffff >>> (pos & 0x1F);
        int maskend   = 0x80000000 >> ((pos + count - 1) & 0x1F);
        int word;
        int setCount;

        if (windex == windexend) {
            mask &= maskend;
        }

        word     = map[windex];
        setCount = Integer.bitCount(word & mask);

        if (set) {
            map[windex] = (word | mask);
        } else {
            mask        = ~mask;
            map[windex] = (word & mask);
        }

        if (windex != windexend) {
            word     = map[windexend];
            setCount += Integer.bitCount(word & maskend);

            if (set) {
                map[windexend] = (word | maskend);
            } else {
                maskend        = ~maskend;
                map[windexend] = (word & maskend);
            }

            for (int i = windex + 1; i < windexend; i++) {
                setCount += Integer.bitCount(map[i]);
                map[i]   = set ? 0xffffffff
                               : 0;
            }
        }

        return set ? count - setCount
                   : setCount;
    }

    public int setValue(int pos, boolean set) {
        return set ? set(pos)
                   : unset(pos);
    }

    /**
     * Sets pos and returns old value
     */
    public int set(int pos) {

        ensureCapacity(pos + 1);

        int windex = pos >> 5;
        int mask   = 0x80000000 >>> (pos & 0x1F);
        int word   = map[windex];
        int result = (word & mask) == 0 ? 0
                                        : 1;

        map[windex] = (word | mask);

        return result;
    }

    /**
     * Unsets pos and returns old value
     */
    public int unset(int pos) {

        ensureCapacity(pos + 1);

        int windex = pos >> 5;
        int mask   = 0x80000000 >>> (pos & 0x1F);
        int word   = map[windex];
        int result = (word & mask) == 0 ? 0
                                        : 1;

        mask        = ~mask;
        map[windex] = (word & mask);

        return result;
    }

    public int get(int pos) {

        if (pos >= limitPos) {
            throw new ArrayIndexOutOfBoundsException(pos);
        }

        int windex = pos >> 5;
        int mask   = 0x80000000 >>> (pos & 0x1F);
        int word   = map[windex];

        return (word & mask) == 0 ? 0
                                  : 1;
    }

    public boolean isSet(int pos) {
        return get(pos) == 1;
    }

    /**
     * Sets all bits that are set in the other map.
     */
    public void set(BitMap other) {

        for (int windex = 0; windex < map.length; windex++) {
            int word = other.map[windex];

            map[windex] |= word;
        }
    }

    public int countSet(int pos, int count) {

        int set = 0;

        for (int i = pos; i < pos + count; i++) {
            if (isSet(i)) {
                set++;
            }
        }

        return set;
    }

    public int countSetBits() {

        int setCount = 0;

        for (int windex = 0; windex < limitPos / 32; windex++) {
            int word = map[windex];

            if (word == 0) {
                continue;
            }

            if (word == -1) {
                setCount += 32;

                continue;
            }

            setCount += Integer.bitCount(word);
        }

        if (limitPos % 32 != 0) {
            int maskend = 0x80000000 >> ((limitPos - 1) & 0x1F);
            int word    = map[limitPos / 32] & maskend;

            setCount += Integer.bitCount(word);
        }

        return setCount;
    }

    /**
     * Only for word boundary map size
     */
    public int countSetBitsEnd() {

        int count  = 0;
        int windex = (limitPos / 32) - 1;

        for (; windex >= 0; windex--) {
            if (map[windex] == 0xffffffff) {
                count += 32;

                continue;
            }

            int val = countSetBitsEnd(map[windex]);

            count += val;

            break;
        }

        return count;
    }

    public int[] getIntArray() {
        return map;
    }

    public byte[] getBytes() {

        byte[] buf = new byte[(limitPos + 7) / 8];

        if (buf.length == 0) {
            return buf;
        }

        for (int i = 0; ; ) {
            int v = map[i / 4];

            buf[i++] = (byte) (v >>> 24);

            if (i == buf.length) {
                break;
            }

            buf[i++] = (byte) (v >>> 16);

            if (i == buf.length) {
                break;
            }

            buf[i++] = (byte) (v >>> 8);

            if (i == buf.length) {
                break;
            }

            buf[i++] = (byte) v;

            if (i == buf.length) {
                break;
            }
        }

        return buf;
    }

    /**
     * Ensures capacity by enlarging the array if necessary.
     * Sets limitPos if capacity is increased.
     */
    private void ensureCapacity(int newSize) {

        if (newSize > limitPos) {
            if (!canChangeSize) {
                throw new ArrayStoreException("BitMap extend");
            }
        }

        if (newSize <= map.length * 32) {
            if (newSize > limitPos) {
                limitPos = newSize;
            }

            return;
        }

        int newMapLength = map.length;

        while (newSize > newMapLength * 32) {
            newMapLength *= 2;
        }

        int[] newmap = new int[newMapLength];

        System.arraycopy(map, 0, newmap, 0, map.length);

        map      = newmap;
        limitPos = newSize;
    }

    /**
     * count the set bits at the low end
     */
    public static int countSetBitsEnd(int map) {

        int mask  = 0x01;
        int count = 0;

        for (; count < 32; count++) {
            if ((map & mask) == 0) {
                break;
            }

            map >>= 1;
        }

        return count;
    }

    /**
     * count the unset bits at the high end
     */
    public static int countUnsetBitsStart(int map) {

        int mask  = 0x80000000;
        int count = 0;

        if (map == 0) {
            return 32;
        }

        for (; count < 32; count++) {
            if ((map & mask) != 0) {
                break;
            }

            mask >>>= 1;
        }

        return count;
    }

    /**
     * copy the byte value into the map at given position (0, 24)
     */
    public static int setByte(int map, byte value, int pos) {

        int intValue = (value & 0xff) << (24 - pos);
        int mask     = 0xff000000 >>> pos;

        mask = ~mask;
        map  &= mask;

        return (map | intValue);
    }

    public static int set(int map, int pos) {

        int mask = 0x80000000 >>> pos;

        return (map | mask);
    }

    public static byte set(byte map, int pos) {

        int mask = 0x00000080 >>> pos;

        return (byte) (map | mask);
    }

    public static int unset(int map, int pos) {

        int mask = 0x80000000 >>> pos;

        mask = ~mask;

        return (map & mask);
    }

    public static boolean isSet(int map, int pos) {

        int mask = 0x80000000 >>> pos;

        return (map & mask) == 0 ? false
                                 : true;
    }

    public static boolean isSet(byte map, int pos) {

        int mask = 0x00000080 >>> pos;

        return (map & mask) == 0 ? false
                                 : true;
    }

    public static boolean isSet(byte[] map, int pos) {

        int mask  = 0x00000080 >>> (pos & 0x07);
        int index = pos / 8;

        if (index >= map.length) {
            return false;
        }

        byte b = map[index];

        return (b & mask) == 0 ? false
                               : true;
    }

    public static void unset(byte[] map, int pos) {

        int mask = 0x00000080 >>> (pos & 0x07);

        mask = ~mask;

        int index = pos / 8;

        if (index >= map.length) {
            return;
        }

        byte b = map[index];

        map[index] = (byte) (b & mask);
    }

    public static void set(byte[] map, int pos) {

        int mask  = 0x00000080 >>> (pos & 0x07);
        int index = pos / 8;

        if (index >= map.length) {
            return;
        }

        byte b = map[index];

        map[index] = (byte) (b | mask);
    }

    /**
     * AND count bits from source with map contents starting at pos
     */
    public static void and(byte[] map, int pos, byte source, int count) {

        int shift     = pos & 0x07;
        int mask      = (source & 0xff) >>> shift;
        int innermask = 0xff >> shift;
        int index     = pos / 8;

        if (count < 8) {
            innermask = innermask >>> (8 - count);
            innermask = innermask << (8 - count);
        }

        mask      &= innermask;
        innermask = ~innermask;

        if (index >= map.length) {
            return;
        }

        byte b = map[index];

        map[index] = (byte) (b & innermask);
        b          = (byte) (b & mask);
        map[index] = (byte) (map[index] | b);

        if (shift == 0) {
            return;
        }

        shift = 8 - shift;

        if (count > shift) {
            mask           = ((source & 0xff) << 8) >>> shift;
            innermask      = 0xff00 >>> shift;
            innermask      = ~innermask;
            b              = map[index + 1];
            map[index + 1] = (byte) (b & innermask);
            b              = (byte) (b & mask);
            map[index + 1] = (byte) (map[index + 1] | b);
        }
    }

    /**
     * OR count bits from source with map contents starting at pos
     */
    public static void or(byte[] map, int pos, byte source, int count) {

        int shift = pos & 0x07;
        int mask  = (source & 0xff) >>> shift;
        int index = pos / 8;

        if (index >= map.length) {
            return;
        }

        byte b = (byte) (map[index] | mask);

        map[index] = b;

        if (shift == 0) {
            return;
        }

        shift = 8 - shift;

        if (count > shift) {
            mask           = ((source & 0xff) << 8) >>> shift;
            b              = (byte) (map[index + 1] | mask);
            map[index + 1] = b;
        }
    }

    /**
     * overlay count bits from source on map contents starting at pos
     */
    public static void overlay(byte[] map, int pos, byte source, int count) {

        int shift     = pos & 0x07;
        int mask      = (source & 0xff) >>> shift;
        int innermask = 0xff >> shift;
        int index     = pos / 8;

        if (count < 8) {
            innermask = innermask >>> (8 - count);
            innermask = innermask << (8 - count);
        }

        mask      &= innermask;
        innermask = ~innermask;

        if (index >= map.length) {
            return;
        }

        byte b = map[index];

        b          = (byte) (b & innermask);
        map[index] = (byte) (b | mask);

        if (shift == 0) {
            return;
        }

        shift = 8 - shift;

        if (count > shift) {
            mask           = ((source & 0xff) << 8) >>> shift;
            innermask      = 0xff00 >>> shift;
            innermask      = ~innermask;
            b              = map[index + 1];
            b              = (byte) (b & innermask);
            map[index + 1] = (byte) (b | mask);
        }
    }

    public static byte[] and(byte[] a, byte[] b) {

        int    length      = a.length > b.length ? a.length
                                                 : b.length;
        int    shortLength = a.length > b.length ? b.length
                                                 : a.length;
        byte[] map         = new byte[length];

        for (int i = 0; i < shortLength; i++) {
            map[i] = (byte) (a[i] & b[i]);
        }

        return map;
    }

    public static byte[] or(byte[] a, byte[] b) {

        int    length      = a.length > b.length ? a.length
                                                 : b.length;
        int    shortLength = a.length > b.length ? b.length
                                                 : a.length;
        byte[] map         = new byte[length];

        if (length != shortLength) {
            byte[] source = a.length > b.length ? a
                                                : b;

            System.arraycopy(source, shortLength, map, shortLength,
                             length - shortLength);
        }

        for (int i = 0; i < shortLength; i++) {
            map[i] = (byte) (a[i] | b[i]);
        }

        return map;
    }

    public static byte[] xor(byte[] a, byte[] b) {

        int    length      = a.length > b.length ? a.length
                                                 : b.length;
        int    shortLength = a.length > b.length ? b.length
                                                 : a.length;
        byte[] map         = new byte[length];

        if (length != shortLength) {
            byte[] source = a.length > b.length ? a
                                                : b;

            System.arraycopy(source, shortLength, map, shortLength,
                             length - shortLength);
        }

        for (int i = 0; i < shortLength; i++) {
            map[i] = (byte) (a[i] ^ b[i]);
        }

        return map;
    }

    public static byte[] not(byte[] a) {

        byte[] map = new byte[a.length];

        for (int i = 0; i < a.length; i++) {
            map[i] = (byte) ~a[i];
        }

        return map;
    }

    public static boolean hasAnyBitSet(byte[] map) {

        for (int i = 0; i < map.length; i++) {
            if (map[i] != 0) {
                return true;
            }
        }

        return false;
    }

    public static byte[] leftShift(byte[] map, int shiftBits) {

        byte[] newMap     = new byte[map.length];
        int    shiftBytes = shiftBits / 8;

        if (shiftBytes >= map.length) {
            return newMap;
        }

        shiftBits = shiftBits % 8;

        if (shiftBits == 0) {
            for (int i = 0, j = shiftBytes; j < map.length; i++, j++) {
                newMap[i] = map[j];
            }
        } else {
            for (int i = 0, j = shiftBytes; j < map.length; i++, j++) {
                int shifted = (map[j] & 0xff) << shiftBits;

                newMap[i] = (byte) shifted;

                if (i > 0) {
                    newMap[i - 1] |= (byte) (shifted >>> 8);
                }
            }
        }

        return newMap;
    }
}

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


package org.hsqldb.types;

import java.util.UUID;

import org.hsqldb.Session;
import org.hsqldb.SessionInterface;
import org.hsqldb.Tokens;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.StringConverter;

/**
 * Type implementation for BINARY UUID.<p>

 * A binary UUID is exactly 16 bytes.<p>
 *
 * Cast from CHARACTER types to BINARY converts a hexadecimal UUID string with
 * or without the dashes.<p>
 *
 * Cast to CHARACTER types converts to a hexadecimal UUID string.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 2.3.4
 */
public class BinaryUUIDType extends BinaryType {

    public static final int binaryUUIDPrecision = 16;

    protected BinaryUUIDType() {
        super(Types.SQL_GUID, binaryUUIDPrecision);
    }

    public int displaySize() {
        return 36;
    }

    public int getJDBCTypeCode() {
        return Types.BINARY;
    }

    public Class getJDBCClass() {
        return byte[].class;
    }

    public String getJDBCClassName() {
        return "[B";
    }

    public String getNameString() {
        return Tokens.T_UUID;
    }

    public String getNameFullString() {
        return Tokens.T_UUID;
    }

    public String getDefinition() {
        return getNameString();
    }

    public boolean isBinaryType() {
        return true;
    }

    public boolean acceptsPrecision() {
        return false;
    }

    public long getMaxPrecision() {
        return binaryUUIDPrecision;
    }

    public boolean requiresPrecision() {
        return false;
    }

    /**
     * relaxes the SQL standard list to avoid problems with conversion of
     * literals and java method parameter type issues
     */
    public int precedenceDegree(Type other) {

        if (other.typeCode == typeCode) {
            return 0;
        }

        if (!other.isBinaryType()) {
            return Integer.MIN_VALUE;
        }

        return other.typeCode == Types.SQL_BLOB ? 4
                                                : 2;
    }

    public Type getAggregateType(Type other) {

        if (other == null) {
            return this;
        }

        if (other == SQL_ALL_TYPES) {
            return this;
        }

        if (typeCode == other.typeCode) {
            return this;
        }

        if (other.isCharacterType()) {
            return this;
        }

        switch (other.typeCode) {

            case Types.SQL_GUID :
            case Types.SQL_BINARY :
            case Types.SQL_VARBINARY :
            case Types.SQL_BLOB :
                return this;

            default :
                throw Error.error(ErrorCode.X_42562);
        }
    }

    /**
     * Returns type for concat
     */
    public Type getCombinedType(Session session, Type other, int operation) {
        return Type.SQL_VARBINARY_DEFAULT;
    }

    public int compare(Session session, Object a, Object b) {

        if (a == b) {
            return 0;
        }

        if (a == null) {
            return -1;
        }

        if (b == null) {
            return 1;
        }

        if (a instanceof BinaryData && b instanceof BinaryData) {
            byte[] data1  = ((BinaryData) a).getBytes();
            byte[] data2  = ((BinaryData) b).getBytes();
            int    length = data1.length > data2.length ? data2.length
                                                        : data1.length;

            for (int i = 0; i < length; i++) {
                if (data1[i] == data2[i]) {
                    continue;
                }

                return (((int) data1[i]) & 0xff) > (((int) data2[i]) & 0xff)
                       ? 1
                       : -1;
            }

            if (data1.length == data2.length) {
                return 0;
            }

            return data1.length > data2.length ? 1
                                               : -1;
        }

        throw Error.runtimeError(ErrorCode.U_S0500, "BinaryUUIDType");
    }

    public Object convertToTypeLimits(SessionInterface session, Object a) {
        return castOrConvertToType(session, a, this, false);
    }

    public Object castToType(SessionInterface session, Object a,
                             Type otherType) {
        return castOrConvertToType(session, a, otherType, true);
    }

    public Object convertToType(SessionInterface session, Object a,
                                Type otherType) {
        return castOrConvertToType(session, a, otherType, false);
    }

    public Object convertJavaToSQL(SessionInterface session, Object a) {

        if (a == null) {
            return null;
        }

        if (a instanceof byte[]) {
            return new BinaryData((byte[]) a, true);
        }

        throw Error.error(ErrorCode.X_42561);
    }

    public Object convertSQLToJava(SessionInterface session, Object a) {

        if (a == null) {
            return null;
        }

        return ((BlobData) a).getBytes();
    }

    Object castOrConvertToType(SessionInterface session, Object a,
                               Type otherType, boolean cast) {

        BlobData b;

        if (a == null) {
            return null;
        }

        switch (otherType.typeCode) {

            case Types.SQL_CLOB :
                a = Type.SQL_VARCHAR.convertToType(session, a, otherType);
            case Types.SQL_VARCHAR :
            case Types.SQL_CHAR : {
                b = session.getScanner().convertToBinary((String) a, true);
                otherType = this;

                break;
            }
            case Types.SQL_GUID :
            case Types.SQL_BINARY :
            case Types.SQL_VARBINARY :
            case Types.SQL_BLOB :
                b = (BlobData) a;
                break;

            default :
                throw Error.error(ErrorCode.X_22501);
        }

        if (otherType.typeCode == Types.SQL_BLOB) {
            long blobLength = b.length(session);

            if (blobLength != precision) {
                throw Error.error(ErrorCode.X_22001);
            }

            byte[] bytes = b.getBytes(session, 0, (int) precision);

            b = new BinaryData(bytes, false);

            return b;
        } else {
            if (b.length(session) != precision) {
                throw Error.error(ErrorCode.X_22001);
            }

            return b;
        }
    }

    public Object convertToDefaultType(SessionInterface session, Object a) {

        if (a == null) {
            return a;
        }

        if (a instanceof byte[]) {
            BinaryData b = new BinaryData((byte[]) a, false);

            castOrConvertToType(session, b, Type.SQL_VARBINARY, false);
        } else if (a instanceof BinaryData) {
            return castOrConvertToType(session, a, Type.SQL_VARBINARY, false);
        } else if (a instanceof String) {
            return castOrConvertToType(session, a, Type.SQL_VARCHAR, false);
        }

        throw Error.error(ErrorCode.X_22501);
    }

    public String convertToString(Object a) {

        if (a == null) {
            return null;
        }

        return StringConverter.toStringUUID(((BlobData) a).getBytes());
    }

    public String convertToSQLString(Object a) {

        if (a == null) {
            return Tokens.T_NULL;
        }

        return StringConverter.toStringUUID(((BlobData) a).getBytes());
    }

    public boolean canConvertFrom(Type otherType) {
        return otherType.typeCode == Types.SQL_ALL_TYPES
               || otherType.isBinaryType() || otherType.isCharacterType();
    }

    public int canMoveFrom(Type otherType) {

        if (otherType == this) {
            return 0;
        }

        if (!otherType.isBinaryType()) {
            return -1;
        }

        switch (otherType.typeCode) {

            case Types.SQL_VARBINARY : {
                return 1;
            }
            case Types.SQL_BIT :
            case Types.SQL_BIT_VARYING :
            case Types.SQL_BLOB : {
                return -1;
            }
            case Types.SQL_GUID :
            case Types.SQL_BINARY : {
                return precision == otherType.precision ? 0
                                                        : -1;
            }
            default :
                return -1;
        }
    }

    public long position(SessionInterface session, BlobData data,
                         BlobData otherData, Type otherType, long offset) {

        if (data == null || otherData == null) {
            return -1L;
        }

        long otherLength = data.length(session);

        if (offset + otherLength > data.length(session)) {
            return -1;
        }

        return data.position(session, otherData, offset);
    }

    public BlobData substring(SessionInterface session, BlobData data,
                              long offset, long length, boolean hasLength) {

        long end;
        long dataLength = data.length(session);

        if (hasLength) {
            end = offset + length;
        } else {
            end = dataLength > offset ? dataLength
                                      : offset;
        }

        if (offset > end) {
            throw Error.error(ErrorCode.X_22011);
        }

        if (offset > end || end < 0) {

            // return zero length data
            offset = 0;
            end    = 0;
        }

        if (offset < 0) {
            offset = 0;
        }

        if (end > dataLength) {
            end = dataLength;
        }

        length = end - offset;

        // change method signature to take long
        byte[] bytes = data.getBytes(session, offset, (int) length);

        return new BinaryData(bytes, false);
    }

    int getRightTrimSize(BlobData data) {

        byte[] bytes    = data.getBytes();
        int    endindex = bytes.length;

        for (--endindex; endindex >= 0 && bytes[endindex] == 0; endindex--) {}

        return ++endindex;
    }

    public BlobData trim(Session session, BlobData data, int trim,
                         boolean leading, boolean trailing) {

        if (data == null) {
            return null;
        }

        long length = data.length(session);

        if (length > Integer.MAX_VALUE) {
            throw Error.error(ErrorCode.X_22027);
        }

        byte[] bytes    = data.getBytes(session, 0, (int) length);
        int    endindex = bytes.length;

        if (trailing) {
            for (--endindex; endindex >= 0 && bytes[endindex] == trim;
                    endindex--) {}

            endindex++;
        }

        int startindex = 0;

        if (leading) {
            while (startindex < endindex && bytes[startindex] == trim) {
                startindex++;
            }
        }

        byte[] newBytes = bytes;

        if (startindex != 0 || endindex != bytes.length) {
            newBytes = new byte[endindex - startindex];

            System.arraycopy(bytes, startindex, newBytes, 0,
                             endindex - startindex);
        }

        return new BinaryData(newBytes, newBytes == bytes);
    }

    public BlobData overlay(Session session, BlobData data, BlobData overlay,
                            long offset, long length, boolean hasLength) {

        if (data == null || overlay == null) {
            return null;
        }

        if (!hasLength) {
            length = overlay.length(session);
        }

        BinaryData binary =
            new BinaryData(session, substring(session, data, 0, offset, true),
                           overlay);

        binary = new BinaryData(session, binary,
                                substring(session, data, offset + length, 0,
                                          false));

        return binary;
    }

    public Object concat(Session session, Object a, Object b) {

        if (a == null || b == null) {
            return null;
        }

        long length = ((BlobData) a).length(session)
                      + ((BlobData) b).length(session);

        if (length > precision) {
            throw Error.error(ErrorCode.X_22001);
        }

        return new BinaryData(session, (BlobData) a, (BlobData) b);
    }

    public long getLongColumnValue(Object value, int compareType) {

        if (value == null) {
            return Long.MIN_VALUE;
        }

        BinaryData binary    = (BinaryData) value;
        byte[]     bytes     = binary.getBytes();
        long       longValue = 0;

        if (bytes.length == 0) {
            return Long.MIN_VALUE;
        }

        byte byteValue = bytes[0];

        byteValue += Byte.MIN_VALUE;
        longValue |= (byteValue & 0x000000ff);

        for (int i = 1; i < 8; i++) {
            longValue <<= 8;

            if (i < bytes.length) {
                longValue |= (bytes[i] & 0x000000ff);
            }
        }

        return longValue;
    }

    public static BinaryData getBinary(long hi, long lo) {
        return new BinaryData(ArrayUtil.toByteArray(hi, lo), false);
    }

    public static BinaryData getBinary(UUID uuid) {
        return getBinary(uuid.getMostSignificantBits(),
                         uuid.getLeastSignificantBits());
    }
}

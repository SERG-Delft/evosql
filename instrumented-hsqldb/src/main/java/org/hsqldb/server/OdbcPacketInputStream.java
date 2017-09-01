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


package org.hsqldb.server;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.hsqldb.HsqlException;
import org.hsqldb.types.BinaryData;

/**
 * An atomic transfer packet received from a HyperSQL client.
 *
 * Since we read and cache all data for the packet upon instantiation, the
 * available method is reliable and may be relied upon.
 *
 * @see #available()
 */
class OdbcPacketInputStream extends DataInputStream {

    char                packetType;
    private InputStream bufferStream;

    /**
     * Instantiate a packet of the specified type and size.
     */
    static OdbcPacketInputStream newOdbcPacketInputStream(char cType,
            InputStream streamSource, int sizeInt) throws IOException {
        return newOdbcPacketInputStream(cType, streamSource,
                                        Integer.valueOf(sizeInt));
    }

    /**
     * Instantiate a packet of the specified type, with size determined by
     * the first int read from the given stream.
     */
    static OdbcPacketInputStream newOdbcPacketInputStream(char cType,
            InputStream streamSource) throws IOException {
        return newOdbcPacketInputStream(cType, streamSource, null);
    }

    static private OdbcPacketInputStream newOdbcPacketInputStream(char cType,
            InputStream streamSource,
            Integer packetSizeObj) throws IOException {

        int bytesRead, i;
        int packetSize = 0;

        if (packetSizeObj == null) {
            byte[] fourBytes = new byte[4];

            bytesRead = 0;

            while ((i =
                    streamSource.read(fourBytes, bytesRead, fourBytes.length
                                      - bytesRead)) > 0) {
                bytesRead += i;
            }

            if (bytesRead != fourBytes.length) {
                throw new EOFException("Failed to read size header int");
            }

            packetSize = ((fourBytes[0] & 0xff) << 24)
                         + ((fourBytes[1] & 0xff) << 16)
                         + ((fourBytes[2] & 0xff) << 8)
                         + (fourBytes[3] & 0xff) - 4;

            // Minus 4 because this counts the size int itself.
        } else {
            packetSize = packetSizeObj.intValue();
        }

        byte[] xferBuffer = new byte[packetSize];

        bytesRead = 0;

        while ((i = streamSource.read(xferBuffer, bytesRead, xferBuffer.length
                                      - bytesRead)) > 0) {
            bytesRead += i;
        }

        if (bytesRead != xferBuffer.length) {
            throw new EOFException(
                "Failed to read packet contents from given stream");
        }

        return new OdbcPacketInputStream(cType,
                                         new ByteArrayInputStream(xferBuffer));
    }

    private OdbcPacketInputStream(char packetType, InputStream bufferStream) {

        super(bufferStream);

        this.packetType = packetType;
    }

    /**
     * Generate a String/String Map from null-terminated String pairs, until
     * a '\0' character is read in place of the first key character.
     *
     * @return the generated Map
     * @throws EOFException if the rest of packet does not contained the
     *                   required, well-formed null-terminated string pairs.
     */
    Map readStringPairs() throws IOException {

        String key;
        Map    map = new HashMap();

        while (true) {
            key = readString();

            if (key.length() < 1) {
                break;
            }

            map.put(key, readString());
        }

        return map;
    }

    /**
     * Reads a NULL-TERMINATED String.
     *
     * @throws IOException if attempt to read past end of packet.
     */
    String readString() throws IOException {

        /* Would be MUCH easier to do this with Java6's String
         * encoding/decoding operations */
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        baos.write((byte) 'X');
        baos.write((byte) 'X');

        // Place-holders to be replaced with short length
        int i;

        while ((i = readByte()) > 0) {
            baos.write((byte) i);
        }

        byte[] ba = baos.toByteArray();

        baos.close();

        int len = ba.length - 2;

        ba[0] = (byte) (len >>> 8);
        ba[1] = (byte) len;

        DataInputStream dis =
            new DataInputStream(new ByteArrayInputStream(ba));
        String s = dis.readUTF();

        //String s = DataInputStream.readUTF(dis);
        // TODO:  Test the previous two to see if one works better for
        // high-order characters.
        dis.close();

        return s;
    }

    BinaryData readSizedBinaryData() throws IOException {

        int len = readInt();

        try {
            return (len < 0) ? null
                             : new BinaryData((long) len, this);
        } catch (HsqlException he) {
            throw new IOException(he.getMessage());
        }
    }

    String readSizedString() throws IOException {

        int len = readInt();

        return (len < 0) ? null
                         : readString(len);
    }

    /**
     * These Strings are not null-terminated.
     *
     * @param len Bytes to read (not necessarily characters to be returned!
     * @throws IOException if attempt to read past end of packet.
     */
    String readString(int len) throws IOException {

        /* Would be MUCH easier to do this with Java6's String
         * encoding/decoding operations */
        int    bytesRead = 0;
        int    i;
        byte[] ba = new byte[len + 2];

        ba[0] = (byte) (len >>> 8);
        ba[1] = (byte) len;

        while ((i = read(ba, 2 + bytesRead, len - bytesRead)) > -1
                && bytesRead < len) {
            bytesRead += i;
        }

        if (bytesRead != len) {
            throw new EOFException("Packet ran dry");
        }

        for (i = 2; i < ba.length - 1; i++) {
            if (ba[i] == 0) {
                throw new RuntimeException("Null internal to String at offset "
                                           + (i - 2));
            }
        }

        DataInputStream dis =
            new DataInputStream(new ByteArrayInputStream(ba));
        String s = dis.readUTF();

        //String s = DataInputStream.readUTF(dis);
        // TODO:  Test the previous two to see if one works better for
        // high-order characters.
        dis.close();

        return s;
    }

    public char readByteChar() throws IOException {
        return (char) readByte();
    }
}

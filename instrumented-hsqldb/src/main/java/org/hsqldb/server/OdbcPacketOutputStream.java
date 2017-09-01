/* Copyright (c) 2001-2015, The HSQL Development Group
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

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;

/**
 * Atomic transmission packet from HyperSQL server to ODBC client.
 *
 * Sample usage
 * <CODE>
 *     outPacket = OdbcPacketOutputStream.newOdbcPacketOutputStream();
 *     ...
 *     // For each packet you need to transmit:
 *     outPacket.reset();
 *     outPacket.write(this);
 *     outPacket.write(that);
 *     outPacket.xmit('X', hsqlDataOutputStream);
 * </CODE>
 */
class OdbcPacketOutputStream extends DataOutputStream {

    private ByteArrayOutputStream byteArrayOutputStream;
    private ByteArrayOutputStream stringWriterOS = new ByteArrayOutputStream();
    private DataOutputStream stringWriterDos =
        new DataOutputStream(stringWriterOS);
    private int packetStart = 0;    // Stream's "written" at start of packet.

    public int getSize() {
        return written - packetStart;
    }

    /**
     * Wrapper method to write a null-terminated String.
     */
    synchronized void write(String s) throws IOException {
        write(s, true);
    }

    synchronized void write(String s, boolean nullTerm) throws IOException {

        stringWriterDos.writeUTF(s);
        write(stringWriterOS.toByteArray(), 2, stringWriterOS.size() - 2);
        stringWriterOS.reset();

        if (nullTerm) {
            writeByte(0);
        }
    }

    synchronized void writeSized(String s) throws IOException {

        stringWriterDos.writeUTF(s);

        byte[] ba = stringWriterOS.toByteArray();

        stringWriterOS.reset();
        writeInt(ba.length - 2);
        write(ba, 2, ba.length - 2);
    }

    synchronized void reset() throws IOException {

        byteArrayOutputStream.reset();

        packetStart = written;

        writeInt(-1);    // length placeholder
    }

    static OdbcPacketOutputStream newOdbcPacketOutputStream()
    throws IOException {
        return new OdbcPacketOutputStream(new ByteArrayOutputStream());
    }

    protected OdbcPacketOutputStream(
            ByteArrayOutputStream byteArrayOutputStream) throws IOException {

        super(byteArrayOutputStream);

        this.byteArrayOutputStream = byteArrayOutputStream;

        reset();
    }

    /**
     * @return packet size (which does not count the type byte).
     */
    synchronized int xmit(char packetType,
                          org.hsqldb.lib.DataOutputStream destinationStream)
                          throws IOException {

        byte[] ba = byteArrayOutputStream.toByteArray();

        ba[0] = (byte) (ba.length >> 24);
        ba[1] = (byte) (ba.length >> 16);
        ba[2] = (byte) (ba.length >> 8);
        ba[3] = (byte) ba.length;

        reset();
        destinationStream.writeByte(packetType);
        destinationStream.write(ba);
        destinationStream.flush();

        return ba.length;
    }

    synchronized public void close() throws IOException {
        super.close();
        stringWriterDos.close();
    }

    /**
     * The behavior here is purposefully different from
     * java.io.DataOutputStream.writeChar(int), which writes 2 bytes.
     *
     * We are supporting only 1-byte characters, or don't care about the
     * high bits.
     */
    synchronized public void writeByteChar(char c) throws IOException {
        writeByte(c);
    }
}

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


package org.hsqldb.persist;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

import org.hsqldb.Database;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;

/**
 * This class is a simple wrapper for a random access file such as used
 * for backup and lobs.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version  2.3.3
 * @since  1.9.0
 */
final class RAFileSimple implements RandomAccessInterface {

    final RandomAccessFile  file;
    final boolean           readOnly;
    final EventLogInterface logger;

    RAFileSimple(EventLogInterface logger, String name,
                 String openMode) throws FileNotFoundException, IOException {

        this.file   = new RandomAccessFile(name, openMode);
        this.logger = logger;
        readOnly    = openMode.equals("r");
    }

    public long length() throws IOException {
        return file.length();
    }

    public void seek(long position) throws IOException {
        file.seek(position);
    }

    public long getFilePointer() throws IOException {
        return file.getFilePointer();
    }

    public int read() throws IOException {
        return file.read();
    }

    public long readLong() throws IOException {
        return file.readLong();
    }

    public int readInt() throws IOException {
        return file.readInt();
    }

    public void read(byte[] b, int offset, int length) throws IOException {
        file.readFully(b, offset, length);
    }

    public void write(byte[] b, int off, int len) throws IOException {
        file.write(b, off, len);
    }

    public void writeInt(int i) throws IOException {
        file.writeInt(i);
    }

    public void writeLong(long i) throws IOException {
        file.writeLong(i);
    }

    public void close() throws IOException {
        file.close();
    }

    public boolean isReadOnly() {
        return readOnly;
    }

    public boolean ensureLength(long newLength) {

        try {
            if (!readOnly && file.length() < newLength) {
                file.seek(newLength - 1);
                file.writeByte(0);
            }
        } catch (IOException e) {
            logger.logWarningEvent("data file enlarge failed ", e);

            return false;
        }

        return true;
    }

    public boolean setLength(long newLength) {

        try {
            file.setLength(newLength);

            return true;
        } catch (Throwable t) {
            return false;
        }
    }

    public Database getDatabase() {
        return null;
    }

    public void synch() {

        try {
            file.getFD().sync();
        } catch (Throwable t) {
            try {
                file.getFD().sync();
            } catch (Throwable tt) {
                logger.logSevereEvent("RA file sync error ", t);

                throw Error.error(t, ErrorCode.FILE_IO_ERROR, null);
            }
        }
    }
}

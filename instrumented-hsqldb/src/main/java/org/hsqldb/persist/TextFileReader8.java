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

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.CharArrayWriter;
import org.hsqldb.lib.HsqlByteArrayOutputStream;
import org.hsqldb.rowio.RowInputInterface;
import org.hsqldb.rowio.RowInputText;

// fredt@users - 2.3.4 - patch for user-defined quote char by Damjan Jovanovic

/**
 * Reader for 8-bit text files.
 *
 * @author Bob Preston (sqlbob@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 2.2.7
*/
public class TextFileReader8 implements TextFileReader {

    RandomAccessInterface dataFile;
    RowInputInterface     rowIn;
    TextFileSettings      textFileSettings;
    String                header;
    boolean               isReadOnly;
    StringCreator         buffer;
    long                  position = 0;

    TextFileReader8() {}

    TextFileReader8(RandomAccessInterface dataFile,
                    TextFileSettings textFileSettings,
                    RowInputInterface rowIn, boolean isReadOnly) {

        this.dataFile         = dataFile;
        this.textFileSettings = textFileSettings;
        this.rowIn            = rowIn;
        this.isReadOnly       = isReadOnly;
        this.buffer = StringCreator.getStringCreator(byte.class,
                textFileSettings.charEncoding);

        skipBOM();
    }

    static TextFileReader newTextFileReader(RandomAccessInterface dataFile,
            TextFileSettings textFileSettings, RowInputInterface rowIn,
            boolean isReadOnly) {

        if (textFileSettings.isUTF16) {
            return new TextFileReader16(dataFile, textFileSettings, rowIn,
                                        isReadOnly);
        } else {
            return new TextFileReader8(dataFile, textFileSettings, rowIn,
                                       isReadOnly);
        }
    }

    private void skipBOM() {

        try {
            if (textFileSettings.isUTF8) {
                dataFile.seek(0);

                if (dataFile.read() == 0xEF && dataFile.read() == 0xBB
                        && dataFile.read() == 0xBF) {
                    position = 3;
                }
            }
        } catch (IOException e) {
            throw Error.error(ErrorCode.TEXT_FILE_IO, e);
        }
    }

    public RowInputInterface readObject() {

        boolean hasQuote  = false;
        boolean complete  = false;
        boolean wasCR     = false;
        boolean wasNormal = false;
        long    currentPos;
        long    fieldPos;
        boolean quotedField = false;

        buffer.reset();

        position = findNextUsedLinePos();

        if (position == -1) {
            return null;
        }

        try {
            dataFile.seek(position);

            currentPos = 0;
            fieldPos   = 0;

            while (!complete) {
                int c = readChar();

                wasNormal = false;

                if (c == -1) {
                    if (buffer.size() == 0) {
                        return null;
                    }

                    complete = true;

                    if (wasCR) {
                        break;
                    }

                    if (!isReadOnly) {
                        dataFile.write(
                            textFileSettings.bytesForLineEnd, 0,
                            textFileSettings.bytesForLineEnd.length);

                        for (int i = 0;
                                i < textFileSettings.bytesForLineEnd.length;
                                i++) {
                            buffer.write(textFileSettings.bytesForLineEnd[i]);
                        }
                    }

                    break;
                }

                if (c == textFileSettings.singleSeparator) {

                    // quoted field reset
                    if (!hasQuote) {
                        fieldPos    = currentPos;
                        quotedField = false;
                        hasQuote    = false;
                    }
                } else if (c == textFileSettings.quoteChar) {
                    wasNormal = true;
                    complete  = wasCR;
                    wasCR     = false;

                    // quoted field can begin only after separator
                    // or anywhere when separator is multibyte
                    if (textFileSettings.isQuoted) {
                        if (textFileSettings.singleSeparator == 0
                                || currentPos == fieldPos + 1) {
                            quotedField = true;
                        }
                    }

                    if (quotedField) {
                        hasQuote = !hasQuote;
                    }
                } else {
                    switch (c) {

                        case TextFileSettings.CR_CHAR :
                            wasCR = !hasQuote;
                            break;

                        case TextFileSettings.LF_CHAR :
                            complete = !hasQuote;
                            break;

                        default :
                            wasNormal = true;
                            complete  = wasCR;
                            wasCR     = false;
                    }
                }

                buffer.write(c);

                currentPos++;
            }

            if (complete) {
                if (wasNormal) {
                    buffer.setSize(buffer.size() - 1);
                }

                String rowString;

                try {
                    rowString = buffer.getString();
                } catch (UnsupportedEncodingException e) {
                    throw Error.error(ErrorCode.X_S0531);
                }

                ((RowInputText) rowIn).setSource(rowString, position,
                                                 buffer.getByteSize());

                position += rowIn.getSize();

                return rowIn;
            }

            return null;
        } catch (IOException e) {
            throw Error.error(ErrorCode.TEXT_FILE_IO, e);
        }
    }

    public void readHeaderLine() {

        boolean complete  = false;
        boolean wasCR     = false;
        boolean wasNormal = false;

        buffer.reset();

        try {
            dataFile.seek(position);
        } catch (IOException e) {
            throw Error.error(ErrorCode.TEXT_FILE_IO, e);
        }

        while (!complete) {
            wasNormal = false;

            int c;

            try {
                c = readChar();

                if (c == -1) {
                    if (buffer.size() == 0) {
                        return;
                    }

                    complete = true;

                    if (!isReadOnly) {
                        dataFile.write(
                            textFileSettings.bytesForLineEnd, 0,
                            textFileSettings.bytesForLineEnd.length);

                        for (int i = 0;
                                i < textFileSettings.bytesForLineEnd.length;
                                i++) {
                            buffer.write(textFileSettings.bytesForLineEnd[i]);
                        }
                    }

                    break;
                }
            } catch (IOException e) {
                throw Error.error(ErrorCode.TEXT_FILE);
            }

            switch (c) {

                case TextFileSettings.CR_CHAR :
                    wasCR = true;
                    break;

                case TextFileSettings.LF_CHAR :
                    complete = true;
                    break;

                default :
                    wasNormal = true;
                    complete  = wasCR;
                    wasCR     = false;
            }

            if (wasCR || complete) {
                continue;
            }

            buffer.write(c);
        }

        if (wasNormal) {
            buffer.setSize(buffer.size() - 1);
        }

        try {
            header = buffer.getString();
        } catch (UnsupportedEncodingException e) {
            throw Error.error(ErrorCode.X_S0531);
        }

        position += buffer.getByteSize();
    }

    /**
     * Searches from file pointer, pos, and finds the beginning of the first
     * line that contains any non-space character. Increments the row counter
     * when a blank line is skipped.
     *
     * If none found return -1
     */
    private long findNextUsedLinePos() {

        try {
            long    firstPos   = position;
            long    currentPos = position;
            boolean wasCR      = false;

            dataFile.seek(position);

            while (true) {
                int c = readChar();

                currentPos += getByteSizeForChar();

                switch (c) {

                    case TextFileSettings.CR_CHAR :
                        wasCR = true;
                        break;

                    case TextFileSettings.LF_CHAR :
                        wasCR = false;

                        ((RowInputText) rowIn).skippedLine();

                        firstPos = currentPos;
                        break;

                    case ' ' :
                        if (wasCR) {
                            wasCR = false;

                            ((RowInputText) rowIn).skippedLine();
                        }
                        break;

                    case -1 :
                        return -1;

                    default :
                        if (wasCR) {
                            wasCR = false;

                            ((RowInputText) rowIn).skippedLine();
                        }

                        return firstPos;
                }
            }
        } catch (IOException e) {
            throw Error.error(ErrorCode.TEXT_FILE_IO, e);
        }
    }

    int getByteSizeForChar() {
        return 1;
    }

    int readChar() {

        try {
            int c1 = dataFile.read();

            return c1;
        } catch (IOException e) {
            throw Error.error(ErrorCode.TEXT_FILE_IO, e);
        }
    }

    public String getHeaderLine() {
        return header;
    }

    public long getLineNumber() {
        return ((RowInputText) rowIn).getLineNumber();
    }

    static abstract class StringCreator {

        static StringCreator getStringCreator(Class cl, String encoding) {

            if (byte.class.equals(cl)) {
                return new StringCreatorBytes(encoding);
            } else if (char.class.equals(cl)) {
                return new StringCreatorChars();
            } else {
                throw Error.runtimeError(ErrorCode.U_S0500, "StringCreator");
            }
        }

        abstract void reset();

        abstract void write(int c);

        abstract int size();

        abstract void setSize(int size);

        abstract String getString() throws UnsupportedEncodingException;

        abstract int getByteSize();
    }

    static class StringCreatorBytes extends StringCreator {

        private HsqlByteArrayOutputStream buffer;
        private String                    encoding;

        StringCreatorBytes(String encoding) {
            this.buffer   = new HsqlByteArrayOutputStream(128);
            this.encoding = encoding;
        }

        void reset() {
            buffer.reset();
        }

        void write(int c) {
            buffer.write(c);
        }

        int size() {
            return buffer.size();
        }

        void setSize(int size) {
            buffer.setSize(size);
        }

        String getString() throws UnsupportedEncodingException {
            return buffer.toString(encoding);
        }

        int getByteSize() {
            return buffer.size();
        }
    }

    static class StringCreatorChars extends StringCreator {

        private CharArrayWriter buffer;

        StringCreatorChars() {
            this.buffer = new CharArrayWriter(128);
        }

        void reset() {
            buffer.reset();
        }

        void write(int c) {
            buffer.write(c);
        }

        int size() {
            return buffer.size();
        }

        void setSize(int size) {
            buffer.setSize(size);
        }

        String getString() {

            String string = new String(buffer.getBuffer(), 0, buffer.size());

            return string;
        }

        int getByteSize() {
            return buffer.size() * 2;
        }
    }
}

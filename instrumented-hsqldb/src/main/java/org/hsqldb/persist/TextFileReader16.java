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

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.rowio.RowInputInterface;
import org.hsqldb.rowio.RowInputText;

/**
 * Reader for UTF-16 text files.
 *
 * @author Bob Preston (sqlbob@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 2.3.4
*/
public class TextFileReader16 extends TextFileReader8
implements TextFileReader {

    TextFileReader16(RandomAccessInterface dataFile,
                     TextFileSettings textFileSettings,
                     RowInputInterface rowIn, boolean isReadOnly) {

        super();

        this.dataFile         = dataFile;
        this.textFileSettings = textFileSettings;
        this.rowIn            = rowIn;
        this.buffer = StringCreator.getStringCreator(char.class,
                textFileSettings.charEncoding);

        skipBOM();
    }

    private void skipBOM() {

        try {
            if (textFileSettings.isUTF16) {
                dataFile.seek(0);

                if (dataFile.read() == 0xFE && dataFile.read() == 0xFF) {
                    position = 2;
                } else {
                    dataFile.seek(0);

                    if (dataFile.read() == 0xFF && dataFile.read() == 0xFE) {
                        position = 2;

                        textFileSettings.setLittleEndianByteOrderMark();
                    }
                }
            }
        } catch (IOException e) {
            throw Error.error(ErrorCode.TEXT_FILE_IO, e);
        }
    }

    int getByteSizeForChar() {
        return 2;
    }

    int readChar() {

        try {
            int c1 = dataFile.read();

            if (c1 == -1) {
                return -1;
            }

            int c2 = dataFile.read();

            if (c2 == -1) {
                return -1;
            }

            if (textFileSettings.isLittleEndian) {
                int temp = c1;

                c1 = c2;
                c2 = temp;
            }

            return (char) ((c1 << 8) + c2);
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
}

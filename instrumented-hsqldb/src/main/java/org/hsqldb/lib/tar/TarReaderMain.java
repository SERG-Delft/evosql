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


package org.hsqldb.lib.tar;

import java.io.File;
import java.io.IOException;

public class TarReaderMain {

    /**
     * Reads a specified tar file or stdin in order to either list or extract
     * the file tar entries, depending on the first argument being "t" or "x",
     * using default read buffer blocks.
     */
    public static void main(String[] sa)
    throws IOException, TarMalformatException {

        if (sa.length < 1) {
            System.out.println(
                RB.TarReader_syntax.getString(TarReader.class.getName()));
            System.out.println(RB.listing_format.getString());
            System.exit(0);
        }

        File exDir = (sa.length > 1 && sa[1].startsWith("--directory="))
                     ? (new File(sa[1].substring("--directory=".length())))
                     : null;
        int firstPatInd = (exDir == null) ? 2
                                          : 3;

        if (sa.length < firstPatInd
                || ((!sa[0].equals("t")) && !sa[0].equals("x"))) {
            throw new IllegalArgumentException(
                RB.tarreader_syntaxerr.getString(TarReader.class.getName()));
        }

        String[] patternStrings = null;

        if (sa.length > firstPatInd) {
            patternStrings = new String[sa.length - firstPatInd];

            for (int i = firstPatInd; i < sa.length; i++) {
                patternStrings[i - firstPatInd] = sa[i];
            }
        }

        if (sa[0].equals("t") && exDir != null) {
            throw new IllegalArgumentException(RB.dir_x_conflict.getString());
        }

        int dirIndex      = (exDir == null) ? 1
                                            : 2;
        int tarReaderMode = sa[0].equals("t") ? TarReader.LIST_MODE
                                              : TarReader.EXTRACT_MODE;

        new TarReader(new File(sa[dirIndex]), tarReaderMode, patternStrings,
                      null, exDir).read();
    }
}

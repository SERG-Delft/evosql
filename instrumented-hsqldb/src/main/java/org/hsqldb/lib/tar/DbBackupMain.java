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

public class DbBackupMain {

/**
 * Command line invocation to create, examine, or extract HSQLDB database
 * backup tar archives.
 * <P>
 * This class stores tar entries as relative files without specifying
 * parent directories, in what is commonly referred to as <I>tar bomb</I>
 * format.
 * The set of files is small, with known extensions, and the potential
 * inconvenience of messing up the user's current directory is more than
 * compensated by making it easier for the user to restore to a new
 * database URL location at a peer level to the original.
 * </P> <P>
 * Automatically calculates buffer sizes based on the largest component
 * file (for "save" mode) or tar file size (for other modes).
 * </P> <P>
 * Run<CODE><PRE>
 *     java -cp path/to/hsqldb.jar org.hsqldb.lib.tar.DbBackupMain
 * </PRE></CODE> for syntax help.
 * </P>
 */
    public static void main(String[] sa)
    throws IOException, TarMalformatException {

        try {
            if (sa.length < 1) {
                System.out.println(
                    RB.DbBackup_syntax.getString(DbBackup.class.getName()));
                System.out.println();
                System.out.println(RB.listing_format.getString());
                System.exit(0);
            }

            if (sa[0].equals("--save")) {
                boolean overWrite = sa.length > 1
                                    && sa[1].equals("--overwrite");

                if (sa.length != (overWrite ? 4
                                            : 3)) {
                    throw new IllegalArgumentException();
                }

                DbBackup backup = new DbBackup(new File(sa[sa.length - 2]),
                                               sa[sa.length - 1]);

                backup.setOverWrite(overWrite);
                backup.write();
            } else if (sa[0].equals("--list")) {
                if (sa.length < 2) {
                    throw new IllegalArgumentException();
                }

                String[] patternStrings = null;

                if (sa.length > 2) {
                    patternStrings = new String[sa.length - 2];

                    for (int i = 2; i < sa.length; i++) {
                        patternStrings[i - 2] = sa[i];
                    }
                }

                new TarReader(new File(sa[1]), TarReader
                    .LIST_MODE, patternStrings, Integer.valueOf(DbBackup
                        .generateBufferBlockValue(new File(sa[1]))), null)
                            .read();
            } else if (sa[0].equals("--extract")) {
                boolean overWrite = sa.length > 1
                                    && sa[1].equals("--overwrite");
                int firstPatInd = overWrite ? 4
                                            : 3;

                if (sa.length < firstPatInd) {
                    throw new IllegalArgumentException();
                }

                String[] patternStrings = null;

                if (sa.length > firstPatInd) {
                    patternStrings = new String[sa.length - firstPatInd];

                    for (int i = firstPatInd; i < sa.length; i++) {
                        patternStrings[i - firstPatInd] = sa[i];
                    }
                }

                File tarFile       = new File(sa[overWrite ? 2
                                                           : 1]);
                int  tarReaderMode = overWrite ? TarReader.OVERWRITE_MODE
                                               : TarReader.EXTRACT_MODE;

                new TarReader(
                    tarFile, tarReaderMode, patternStrings,
                    Integer.valueOf(DbBackup.generateBufferBlockValue(tarFile)),
                    new File(sa[firstPatInd - 1])).read();
            } else {
                throw new IllegalArgumentException();
            }
        } catch (IllegalArgumentException iae) {
            System.out.println(
                RB.DbBackup_syntaxerr.getString(DbBackup.class.getName()));
            System.exit(2);
        }
    }
}

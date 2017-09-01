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


package org.hsqldb.cmdline;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;

/* $Id: SqlToolSprayer.java 5337 2014-01-24 19:26:47Z fredt $ */

/**
 * Sql Tool Sprayer.
 * Invokes SqlTool.objectMain() multiple times with the same SQL.
 * Invokes for multiple urlids and/or retries.
 *
 * See JavaDocs for the main method for syntax of how to run.
 *
 * System properties used if set:
 * <UL>
 *      <LI>sqltoolsprayer.period (in ms.)</LI>
 *      <LI>sqltoolsprayer.maxtime (in ms.)</LI>
 *      <LI>sqltoolsprayer.rcfile (filepath)</LI>
 * </UL>
 *
 * @see #main(String[])
 * @version $Revision: 5337 $, $Date: 2014-01-24 14:26:47 -0500 (Fri, 24 Jan 2014) $
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 */
public class SqlToolSprayer {

    public static final String LS = System.getProperty("line.separator");
    private static String SYNTAX_MSG =
        "SYNTAX:  java [-D...] SqlToolSprayer 'SQL;' [urlid1 urlid2...]\n"
        + "System properties you may use [default values]:\n"
        + "    sqltoolsprayer.period (in ms.) [500]\n"
        + "    sqltoolsprayer.maxtime (in ms.) [0]\n"
        + "    sqltoolsprayer.monfile (filepath) [none]\n"
        + "    sqltoolsprayer.rcfile (filepath) [none.  SqlTool default used.]";
    static {
        if (!LS.equals("\n")) {
            SYNTAX_MSG = SYNTAX_MSG.replaceAll("\n", LS);
        }
    }

    public static void main(String[] sa) {

        if (sa.length < 1) {
            System.err.println(SYNTAX_MSG);
            System.exit(4);
        }

        long period = ((System.getProperty("sqltoolsprayer.period") == null)
                       ? 500
                       : Integer.parseInt(
                           System.getProperty("sqltoolsprayer.period")));
        long maxtime = ((System.getProperty("sqltoolsprayer.maxtime") == null)
                        ? 0
                        : Integer.parseInt(
                            System.getProperty("sqltoolsprayer.maxtime")));
        String rcFile   = System.getProperty("sqltoolsprayer.rcfile");
        File monitorFile =
            (System.getProperty("sqltoolsprayer.monfile") == null) ? null
                                                                   : new File(
                                                                       System.getProperty(
                                                                           "sqltoolsprayer.monfile"));
        ArrayList<String> urlids = new ArrayList<String>();

        for (int i = 1; i < sa.length; i++) {
            urlids.add(sa[i]);
        }

        if (urlids.size() < 1) {
            System.err.println("No urlids specified.  Nothing to spray.");
            System.exit(5);
        }

        boolean[] status = new boolean[urlids.size()];

        String[] withRcArgs    = {
            "--sql=" +  sa[0], "--rcfile=" + rcFile, null
        };
        String[] withoutRcArgs = {
            "--sql=" + sa[0], null
        };
        String[] sqlToolArgs   = (rcFile == null) ? withoutRcArgs
                                                  : withRcArgs;
        boolean  onefailed     = false;
        long     startTime     = (new Date()).getTime();

        while (true) {
            if (monitorFile != null && !monitorFile.exists()) {
                System.err.println("Required file is gone:  " + monitorFile);
                System.exit(2);
            }

            onefailed = false;

            for (int i = 0; i < status.length; i++) {
                if (status[i]) {
                    continue;
                }

                sqlToolArgs[sqlToolArgs.length - 1] = urlids.get(i);
                // System.err.println("ARGS:"
                //      + java.util.Arrays.asList(sqlToolArgs));

                try {
                    SqlTool.objectMain(sqlToolArgs);

                    status[i] = true;

                    System.err.println("Success for instance '"
                                       + urlids.get(i) + "'");
                } catch (SqlTool.SqlToolException se) {
                    onefailed = true;
                }
            }

            if (!onefailed) {
                break;
            }

            if (maxtime == 0 || (new Date()).getTime() > startTime + maxtime) {
                break;
            }

            try {
                Thread.sleep(period);
            } catch (InterruptedException ie) {
                // Purposefully doing nothing
            }
        }

        ArrayList<String> failedUrlids = new ArrayList<String>();

        // If all statuses true, then System.exit(0);
        for (int i = 0; i < status.length; i++) {
            if (status[i] != true) {
                failedUrlids.add(urlids.get(i));
            }
        }

        if (failedUrlids.size() > 0) {
            System.err.println("Failed instances:   " + failedUrlids);
            System.exit(1);
        }

        System.exit(0);
    }
}

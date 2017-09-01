/* Copyright (c) 2001-2011, The HSQL Development Group
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


package org.hsqldb.test;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Runs test scripts against a single database, using persistent connection(s)
 * across multiple test script(s).
 *
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 */
class TestScripts extends TestUtil {

    /**
     * Run java org.hsqldb.util.TestScripts --help.
     * For each script run, the connection will be closed or persisted
     * depending on whether "--ephConnId=x" or "--persistConnId=x" preceded
     * the file name (defaulting to closing).
     * So, by default, for each script file, a new connection will be made
     * and closed immediately after the script runs.
     */
    public static void main(String[] argv) {

        if (argv.length > 0 && argv[0].equals("--help")) {
            System.err.println(SYNTAX_MSG);
            System.exit(2);
        }

        ArrayList scripts   = new ArrayList();
        ArrayList connIds   = new ArrayList();
        ArrayList retains   = new ArrayList();
        int       i         = -1;
        int       curscript = 0;

        // java.util.ArrayLists may contain null elements.
        connIds.add(null);
        retains.add(null);

        String newName = null;

        while (++i < argv.length) {
            if (argv[i].startsWith("--ephConnId=")) {
                newName = getIdName(argv[i]);

                if (newName == null
                        || connIds.set(connIds.size() - 1, getIdName(argv[i]))
                           != null) {
                    System.err.println(SYNTAX_MSG);
                    System.exit(2);
                }

                if (retains.set(retains.size() - 1, Boolean.FALSE) != null) {
                    System.err.println(SYNTAX_MSG);
                    System.exit(2);
                }
            } else if (argv[i].startsWith("--persistConnId=")) {
                newName = getIdName(argv[i]);

                if (newName == null
                        || connIds.set(connIds.size() - 1, newName) != null) {
                    System.err.println(SYNTAX_MSG);
                    System.exit(2);
                }

                if (retains.set(retains.size() - 1, Boolean.TRUE) != null) {
                    System.err.println(SYNTAX_MSG);
                    System.exit(2);
                }
            } else if (argv[i].startsWith("-")) {
                System.err.println(SYNTAX_MSG);
                System.exit(2);
            } else {
                scripts.add(argv[i]);
                connIds.add(null);
                retains.add(null);
            }
        }

        test(DEF_URL, DEF_USER, DEF_PASSWORD, DEF_DB,
             (String[]) scripts.toArray(new String[0]),
             (String[]) connIds.toArray(new String[0]),
             (Boolean[]) retains.toArray(new Boolean[0]));
    }

    private static String getIdName(String s) {

        int nameStart = s.indexOf('=') + 1;

        if (nameStart < 1) {
            return null;
        }

        if (nameStart == s.length()) {
            throw new RuntimeException(
                "Leave off '=' if you do not want to name a connection");
        }

        return s.substring(nameStart);
    }

    private static final String SYNTAX_MSG = "SYNTAX  java "
        + TestScripts.class.getName()
        + " [--ephConnId=x | --persistConnId=x] file1.txt...";

    static String DEF_DB = "test3";
    static String DEF_URL = "jdbc:hsqldb:" + DEF_DB
                            + ";sql.enforce_strict_size=true";
    static String DEF_USER     = "SA";
    static String DEF_PASSWORD = "";

    static void test(String url, String user, String password, String db,
                     String[] scriptList, String[] idList,
                     Boolean[] persistList) {

        if (scriptList.length < 1) {
            System.err.println("Nothing to do.  No scripts specified.");

            return;
        }

        HashMap connMap = new HashMap();

        if (db != null) {
            deleteDatabase(db);
        }

        try {
            DriverManager.registerDriver(new org.hsqldb.jdbc.JDBCDriver());

            Connection cConnection = null;
            String     id;

            for (int i = 0; i < scriptList.length; i++) {
                id = idList[i];

                System.out.println("ID: " + id);

                cConnection = ((id == null) ? null
                                            : (Connection) connMap.get(id));

                if (cConnection == null) {
                    System.out.println("Getting NEW conn");

                    cConnection = DriverManager.getConnection(url, user,
                            password);

                    if (id != null) {

                        // If new named conn., then store it.
                        connMap.put(id, cConnection);
                        System.out.println("Storing NEW conn");
                    }
                }

                testScript(cConnection, scriptList[i]);

                if (persistList[i] == null ||!persistList[i].booleanValue()) {
                    if (id != null) {
                        connMap.remove(id);
                        System.out.println("Removed conn");
                    }

                    cConnection.close();
                    System.out.println("Closed conn");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            print("TestSelf init error: " + e.getMessage());
        }
    }
}

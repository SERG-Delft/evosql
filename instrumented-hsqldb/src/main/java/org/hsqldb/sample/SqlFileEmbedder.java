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


package org.hsqldb.sample;

import java.sql.Connection;
import java.sql.SQLException;
import org.hsqldb.lib.RCData;
import org.hsqldb.cmdline.SqlFile;
import org.hsqldb.cmdline.SqlToolError;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Sample class which executes SQL files, by embedding SqlFile.
 * <P/>
 * Suitable for using as a template.
 * <P/>
 * This class also serves as an example of using RCData to allow your
 * application users to store JDBC access information in a convenient
 * text file.
 *
 * @see #main(String[])
 * @see SqlFile
 * @see RCData
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 */
public class SqlFileEmbedder {
    private Connection conn;

    /**
     * For applications that use a persistent JDBC connection, this class can
     * be used to encapsulate that connection.  (Just strip out the SqlFile
     * stuff if you don't need that).
     *
     * @return The encapsulated JDBC Connection.
     */
    public Connection getConn() {
        return conn;
    }

    /**
     * Run<PRE>
     *     java SqlFileEmbedder</PRE>
     * to see Syntax message.
     */
    public static void main(String[] sa) throws Exception {
        if (sa.length < 3) {
            System.err.println("SYNTAX:  " + SqlFileEmbedder.class.getName()
                    + " path/ro/file.rc URLID file1.sql...");
            System.exit(2);
        }
        SqlFileEmbedder embedder =
                new SqlFileEmbedder(new File(sa[0]), sa[1]);
        String[] files = new String[sa.length - 2];
        for (int i = 0; i < sa.length - 2; i++) {
            files[i] = sa[i + 2];
        }
        try {
            embedder.executeFiles(files);
        } finally {
            try {
                embedder.getConn().close();
            } catch (SQLException se) {
                // Purposefully ignoring.
                // We have done what we want and are now going to exit, so
                // who cares.
            }
        }
    }

    /**
     * Instantiates SqlFileEmbedder object and connects to specified database.
     * <P/>
     * N.b., you do not need to use RCData to use SqlFile.
     * All SqlFile needs is a live Connection.
     * I'm using RCData because it is a convenient way for a non-contained
     * app (i.e. one that doesn't run in a 3rd party container) to get a
     * Connection.
     */
    public SqlFileEmbedder(File rcFile, String urlid) throws Exception {
        conn = (new RCData(rcFile, urlid)).getConnection();
        conn.setAutoCommit(false);
    }

    /**
     * Your own classes can use this method to execute SQL files.
     * <P/>
     * See source code for the main(String[]) method for an example of calling
     * this method.
     *
     * @see #main(String[])
     */
    public void executeFiles(String[] fileStrings)
            throws IOException, SqlToolError, SQLException {
        Map<String, String> sqlVarMap = new HashMap<String, String>();
        sqlVarMap.put("invoker", getClass().getName());
        // This variable is pretty useless, but this should show you how to
        // set variables which you can access inside of scripts like *{this}.

        File file;
        SqlFile sqlFile;
        for (String fileString : fileStrings) {
            file = new File(fileString);
            if (!file.isFile())
                throw new IOException("SQL file not present: "
                        + file.getAbsolutePath());
            sqlFile = new SqlFile(file);
            sqlFile.setConnection(conn);
            sqlFile.addUserVars(sqlVarMap);
            sqlFile.execute();

            // The only reason for the following two statements is so that
            // changes made by one .sql file will effect the future SQL files.
            // Has no effect if you only execute one SQL file.
            conn = sqlFile.getConnection();
            sqlVarMap = sqlFile.getUserVars();
        }
    }
}

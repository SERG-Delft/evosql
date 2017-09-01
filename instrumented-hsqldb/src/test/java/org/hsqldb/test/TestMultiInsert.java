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


package org.hsqldb.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import junit.framework.TestCase;
import junit.framework.TestResult;

/**
 * Test multiple row insert statements via jdbc against in-memory database
 * @author Justin Spadea
 */
public class TestMultiInsert extends TestBase {

    Statement         stmnt;
    PreparedStatement pstmnt;
    Connection        connection;

    public TestMultiInsert(String name) {
        super(name);
    }

    protected void setUp() throws Exception {

        super.setUp();

        try {
            connection = super.newConnection();
            stmnt      = connection.createStatement();
        } catch (Exception e) {}
    }

    private void printTable(String table, String cols, int expected) throws SQLException {
        int rows = 0;
        ResultSet rs = stmnt.executeQuery("SELECT " + cols + " FROM " + table);

        ResultSetMetaData rsmd = rs.getMetaData();
        String result = "Table " + table + ", expecting "
            + expected + " rows total:\n";

        while (rs.next()) {
            for (int i = 0; i < rsmd.getColumnCount(); i++) {
                result += rsmd.getColumnLabel(i + 1) + ":"
                           + rs.getString(i + 1) + ":";
            }
            result += "\n";
            rows++;
        }
        rs.close();
        System.out.println(result);
        assertEquals(expected, rows);
    }

    public void testMultiInsert() {

        try {

            // create table T and insert two rows simultaneously
            stmnt.execute("DROP TABLE T IF EXISTS;");
            stmnt.execute(
                "CREATE TABLE T (I IDENTITY, A CHAR(10), B CHAR(10));");
            stmnt.execute(
                "INSERT INTO T VALUES (NULL, 'A', 'a'),(NULL, 'B', 'b');");

            // print table out - should have two rows
            printTable("T", "*", 2);

            // 3 inserts - a normal standard syntax, multi-row syntax for
            //             single row, and multi-row syntax for two rows
            stmnt.execute("INSERT INTO T VALUES(NULL,'single1','s1');");
            stmnt.execute("INSERT INTO T VALUES((NULL,'single2','s2'));");
            stmnt.execute(
                "INSERT INTO T VALUES((NULL,'double1','d1'),(NULL,'double2','d2'));");

            // print table out - should have 6 rows
            printTable("T", "*", 6);

            // insert via a prepared statement - both single and multi rows
            pstmnt = connection.prepareStatement("INSERT INTO T VALUES (?,?,?)");
            pstmnt.setString(1, null);
            pstmnt.setString(2, "prepared1");
            pstmnt.setString(3, "test1");
            pstmnt.executeUpdate();
            pstmnt = connection.prepareStatement("INSERT INTO T VALUES (?,?,?),(null,?,?)");
            pstmnt.setString(1, null);
            pstmnt.setString(2, "prepared2");
            pstmnt.setString(3, "test2");
            pstmnt.setString(4, "prepared3");
            pstmnt.setString(5, "test3");
            pstmnt.executeUpdate();

            // print table out - should have 9 rows
            printTable("T", "*", 9);

        } catch (SQLException e) {
            fail(e.getMessage());
        }

        System.out.println("testMultiInsert complete");

    }

    protected void tearDown() {

        try {
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("TestSql.tearDown() error: " + e.getMessage());
        }
        super.tearDown();
    }

    public static void main(String[] argv) {

        TestResult result = new TestResult();
        TestCase   testA  = new TestMultiInsert("testMultiInsert");

        testA.run(result);
        System.out.println("TestMultiInsert error count: " + result.failureCount());
        Enumeration e = result.failures();
        while(e.hasMoreElements()) System.out.println(e.nextElement());
    }
}

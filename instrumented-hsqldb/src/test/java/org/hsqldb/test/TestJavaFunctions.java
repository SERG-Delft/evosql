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

import java.math.BigInteger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.hsqldb.jdbc.JDBCConnection;
import org.hsqldb.jdbc.JDBCResultSet;
import org.hsqldb.navigator.RowSetNavigator;
import org.hsqldb.navigator.RowSetNavigatorClient;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultMetaData;
import org.hsqldb.types.BinaryData;
import org.hsqldb.types.Type;

public class TestJavaFunctions extends TestBase {

    public TestJavaFunctions() {
        super("TestJavaFunction", "jdbc:hsqldb:file:test3", false, false);
    }

    protected void setUp() throws Exception {

        super.setUp();

        try {
            prepareDatabase();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    void prepareDatabase() throws SQLException {

        Connection c = newConnection();
        Statement  s = c.createStatement();

        s.executeUpdate("DROP FUNCTION TEST_QUERY IF EXISTS");
        s.executeUpdate("DROP FUNCTION TEST_CUSTOM_RESULT IF EXISTS");
        s.executeUpdate("DROP TABLE T IF EXISTS");
        s.executeUpdate("CREATE TABLE T(C VARCHAR(20), I INT)");
        s.executeUpdate("INSERT INTO T VALUES 'Thames', 10");
        s.executeUpdate("INSERT INTO T VALUES 'Fleet', 12");
        s.executeUpdate("INSERT INTO T VALUES 'Brent', 14");
        s.executeUpdate("INSERT INTO T VALUES 'Westbourne', 16");
        s.executeUpdate(
            "CREATE FUNCTION TEST_QUERY(INT) RETURNS TABLE(N VARCHAR(20), I INT) "
            + " READS SQL DATA LANGUAGE JAVA EXTERNAL NAME 'CLASSPATH:org.hsqldb.test.TestJavaFunctions.getQueryResult'");
        s.executeUpdate(
            "CREATE FUNCTION TEST_CUSTOM_RESULT(BIGINT, BIGINT) RETURNS TABLE(I BIGINT, N VARBINARY(1000)) "
            + " READS SQL DATA LANGUAGE JAVA EXTERNAL NAME 'CLASSPATH:org.hsqldb.test.TestJavaFunctions.getCustomResult'");
        s.executeUpdate("CHECKPOINT");
        c.close();
    }

    public void testOne() throws SQLException {

        Connection        c = newConnection();
        CallableStatement s = c.prepareCall("CALL TEST_QUERY(16)");

        s.execute();

        ResultSet r = s.getResultSet();

        while (r.next()) {
            String temp = "" + r.getInt(2) + " " + r.getString(1);

            System.out.println(temp);
        }

        s = c.prepareCall("CALL TEST_CUSTOM_RESULT(6, 19)");

        s.execute();

        r = s.getResultSet();

        while (r.next()) {
            String temp =
                "" + r.getLong(1) + " "
                + org.hsqldb.lib.StringConverter.byteArrayToSQLHexString(
                    r.getBytes(2));

            System.out.println(temp);
        }

        r = s.executeQuery();

        s = c.prepareCall("CALL TEST_CUSTOM_RESULT(6, 1900)");

        try {
            s.execute();

            r = s.getResultSet();

            fail("exception not thrown");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        c.close();
    }

    public static void main(String[] args) throws SQLException {}

    public static ResultSet getQueryResult(Connection connection,
                                           int i) throws SQLException {

        Statement st = connection.createStatement();

        return st.executeQuery("SELECT * FROM T WHERE I < " + i);
    }

    public static ResultSet getQueryResult(Connection connection,
                                           String p1) throws SQLException {
        return getQueryResult(connection, 13);
    }

    public static ResultSet getQueryResult(Connection connection, String p1,
                                           String p2) throws SQLException {
        return getQueryResult(connection, 20);
    }

    private static Result newTwoColumnResult() {

        Type[] types = new Type[2];

        types[0] = Type.SQL_BIGINT;
        types[1] = Type.SQL_VARBINARY_DEFAULT;

        ResultMetaData  meta = ResultMetaData.newSimpleResultMetaData(types);
        RowSetNavigator navigator = new RowSetNavigatorClient();
        Result          result    = Result.newDataResult(meta);

        result.setNavigator(navigator);

        return result;
    }

    public static ResultSet getCustomResult(Connection connection, long start,
            long end) throws SQLException {

        Result result = newTwoColumnResult();

        if (end < start) {
            long temp = start;

            start = end;
            end   = temp;
        }

        if (end > 1000) {
            throw org.hsqldb.jdbc.JDBCUtil.invalidArgument(
                "value larger than 100");
        }

        if (end > start + 100) {
            end = start + 100;
        }

        for (long i = start; i < end; i++) {
            Object[] row = new Object[2];

            row[0] = Long.valueOf(i);
            row[1] = new BinaryData(BigInteger.valueOf(i).toByteArray(),
                                    false);

            result.navigator.add(row);
        }

        result.navigator.reset();

        return new JDBCResultSet((JDBCConnection) connection, null, result,
                                 result.metaData);
    }
}

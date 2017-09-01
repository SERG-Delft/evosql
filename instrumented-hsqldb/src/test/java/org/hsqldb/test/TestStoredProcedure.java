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

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import junit.framework.TestCase;
import junit.framework.TestResult;

/**
 * Tests for stored procedures.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 2.0.1
 */
public class TestStoredProcedure extends TestBase {

    public TestStoredProcedure(String name) {
        super(name);
    }

    protected void setUp() throws Exception {
        super.setUp();
    }

    public void testOne() throws Exception {

        Connection conn = newConnection();
        Statement  statement;

        try {
            statement = conn.createStatement();

            ResultSet rs = statement.executeQuery(
                "call \"org.hsqldb.test.TestStoredProcedure.procTest1\"()");

            rs.next();

            int cols = rs.getInt(1);

            assertFalse("test result not correct", false);
        } catch (Exception e) {}

        try {
            statement = conn.createStatement();

            statement.execute(
                "CREATE temp TABLE MYTABLE(COL1 INTEGER,COL2 VARCHAR(10));");
            statement.execute(
                "CREATE PROCEDURE proc1(IN P1 INT, IN P2 INT, OUT P3 INT) "
                + "SPECIFIC P2 LANGUAGE JAVA DETERMINISTIC MODIFIES SQL DATA EXTERNAL NAME 'CLASSPATH:org.hsqldb.test.TestStoredProcedure.procTest2'");

            CallableStatement c = conn.prepareCall("call proc1(1,2,?)");

            c.execute();

            int value = c.getInt(1);

            c.close();
            statement.execute(
                "CREATE FUNCTION func1(IN P1 INT, IN P2 INT) "
                + "RETURNS TABLE(C1 INT, C2 INT) "
                + "SPECIFIC F1 LANGUAGE JAVA DETERMINISTIC EXTERNAL NAME 'CLASSPATH:org.hsqldb.test.TestStoredProcedure.funcTest1'");

            c = conn.prepareCall("call func1(1,2)");

            boolean isResult = c.execute();

            assertTrue(isResult);

            ResultSet rs = c.getResultSet();

            rs.next();
            assertEquals(value, 2);

            rs = c.executeQuery();

            rs.next();
            assertEquals(value, 2);
        } catch (Exception e) {
            assertTrue("unexpected error", false);
        } finally {
            conn.close();
        }
    }

    public void testTwo() throws Exception {

        Connection conn = newConnection();
        Statement  statement;
        int        updateCount;

        try {
            statement = conn.createStatement();

            statement.execute("create user testuser password 'test'");
            statement.execute("create table testtable(v varchar(20))");
            statement.execute(
                "insert into testtable values ('tennis'), ('tent'), ('television'), ('radio')");

            ResultSet rs = statement.executeQuery(
                "call \"org.hsqldb.test.TestStoredProcedure.funcTest2\"('test')");

            rs.next();

            boolean b = rs.getBoolean(1);

            rs.close();
            assertTrue("test result not correct", b);
            statement.execute(
                "create function func2(varchar(20)) returns boolean "
                + "SPECIFIC F2 LANGUAGE JAVA DETERMINISTIC NO SQL CALLED ON NULL INPUT EXTERNAL NAME 'CLASSPATH:org.hsqldb.test.TestStoredProcedure.funcTest2'");

            rs = statement.executeQuery("call func2('test')");

            rs.next();

            b = rs.getBoolean(1);

            rs.close();
            assertTrue("test result not correct", b);

            rs = statement.executeQuery(
                "select count(*) from testtable where func2(v)");

            rs.next();

            int count = rs.getInt(1);

            assertTrue("test result not correct", count == 3);
            statement.execute(
                "grant execute on specific function public.f2 to testuser");

            boolean isResult = statement.execute("call func2('test')");

            assertTrue(isResult);

            rs = statement.getResultSet();

            rs.next();

            b = rs.getBoolean(1);

            assertTrue("test result not correct", b);
        } catch (Exception e) {
            assertTrue("unable to execute call to procedure", false);
        } finally {
            conn.close();
        }
    }

    public void testThree() throws SQLException {

        Connection conn = newConnection();
        Statement  st   = conn.createStatement();

        st.execute("declare varone int default 0;");
        st.execute(
            "create procedure proc_inout_result (inout intp int) "
            + " language java reads sql data external name 'CLASSPATH:org.hsqldb.test.TestStoredProcedure.procWithResultOne'");

        CallableStatement cs =
            conn.prepareCall("call proc_inout_result(varone)");
        boolean isResult = cs.execute();

        assertFalse(isResult);
        cs.getMoreResults();

        ResultSet rs = cs.getResultSet();

        rs.next();
        assertEquals(rs.getString(1), "SYSTEM_LOBS");
        assertEquals(rs.getString(2), "LOB_IDS");
        rs.close();
    }

    public void testFour() throws SQLException {

        Connection conn = newConnection();
        Statement  st   = conn.createStatement();

        st.execute("declare varone int default 0;");
        st.execute(
            "create procedure proc_inout_result_two (inout intp int) "
            + " language java reads sql data dynamic result sets 2 external name 'CLASSPATH:org.hsqldb.test.TestStoredProcedure.procWithResultTwo'");

        CallableStatement cs =
            conn.prepareCall("call proc_inout_result_two(varone)");
        boolean isResult = cs.execute();

        assertFalse(isResult);
        cs.getMoreResults();

        ResultSet rs = cs.getResultSet();

        rs.next();
        assertEquals(rs.getString(1), "SYSTEM_LOBS");
        assertEquals(rs.getString(2), "LOB_IDS");
        rs.close();

        if (cs.getMoreResults()) {
            rs = cs.getResultSet();

            rs.next();
            assertEquals(rs.getString(1), "SYSTEM_LOBS");
            assertEquals(rs.getString(2), "LOBS");
            rs.close();
        }
    }

    public void testFourParams() throws SQLException {

        Connection conn = newConnection();
        Statement  st   = conn.createStatement();

        st.execute(
            "create procedure proc_inout_result_two_params (inout intp int) "
            + " language java reads sql data dynamic result sets 2 external name 'CLASSPATH:org.hsqldb.test.TestStoredProcedure.procWithResultTwo'");

        CallableStatement cs =
            conn.prepareCall("{call proc_inout_result_two_params(?)}");

        cs.setInt(1, 0);

        boolean isResult = cs.execute();

        assertFalse(isResult);
        cs.getMoreResults();

        ResultSet rs = cs.getResultSet();

        rs.next();
        assertEquals(rs.getString(1), "SYSTEM_LOBS");
        assertEquals(rs.getString(2), "LOB_IDS");
        rs.close();

        if (cs.getMoreResults()) {
            rs = cs.getResultSet();

            rs.next();
            assertEquals(rs.getString(1), "SYSTEM_LOBS");
            assertEquals(rs.getString(2), "LOBS");
            rs.close();
        }

        rs = cs.executeQuery();

        rs.next();
        assertEquals(rs.getString(1), "SYSTEM_LOBS");
        assertEquals(rs.getString(2), "LOB_IDS");
        rs.close();
    }

    public void testFive() throws SQLException {

        Connection conn = newConnection();
        Statement  st   = conn.createStatement();

        st.execute(
            "create function func_table (in namep varchar(128)) returns table(cola varchar(128), colb varchar(128)) "
            + "return table(select schema_name, schema_owner from information_schema.schemata where schema_owner=namep);");

        CallableStatement cs = conn.prepareCall("call func_table('_SYSTEM')");
        boolean           isResult = cs.execute();

        assertTrue(isResult);

        ResultSet rs = cs.getResultSet();

        rs.next();
        assertEquals(rs.getString(1), "INFORMATION_SCHEMA");
        assertEquals(rs.getString(2), "_SYSTEM");
        rs.close();

        //
        isResult = st.execute("call func_table('_SYSTEM')");

        assertTrue(isResult);

        rs = st.getResultSet();

        rs.next();
        assertEquals(rs.getString(1), "INFORMATION_SCHEMA");
        assertEquals(rs.getString(2), "_SYSTEM");
        rs.close();
    }

    String testSixProcedure =
        "CREATE PROCEDURE get_columns_and_table(tname VARCHAR(128), sname VARCHAR(128)) "
        + "READS SQL DATA DYNAMIC RESULT SETS 2 " + "BEGIN ATOMIC "
        + "DECLARE result1 CURSOR FOR SELECT * FROM information_schema.columns "
        + "WHERE table_name = tname AND table_schema = sname; "
        + "DECLARE result2 CURSOR FOR SELECT * FROM information_schema.tables "
        + "WHERE table_name = tname AND table_schema = sname; "
        + "OPEN result1; " + "OPEN result2; " + "END";

    public void testSix() throws SQLException {

        Connection conn = newConnection();
        Statement  st   = conn.createStatement();

        st.execute(testSixProcedure);

        CallableStatement cs = conn.prepareCall(
            "call get_columns_and_table('TABLES', 'INFORMATION_SCHEMA')");
        boolean isResult = cs.execute();

        assertFalse(isResult);

        isResult = cs.getMoreResults();

        ResultSet rs = cs.getResultSet();

        rs.next();
        assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        rs.close();

        boolean more = cs.getMoreResults();

        if (more) {
            rs = cs.getResultSet();

            rs.next();
            assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        }

        cs = conn.prepareCall("call get_columns_and_table(?, ?)");

        cs.setString(1, "TABLES");
        cs.setString(2, "INFORMATION_SCHEMA");

        isResult = cs.execute();

        assertFalse(isResult);
        cs.getMoreResults();

        rs = cs.getResultSet();

        rs.next();
        assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        rs.close();

        more = cs.getMoreResults();

        if (more) {
            rs = cs.getResultSet();

            rs.next();
            assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        }

        st = conn.createStatement();
        isResult = st.execute(
            "call get_columns_and_table('TABLES', 'INFORMATION_SCHEMA')");

        assertFalse(isResult);
        st.getMoreResults();

        rs = st.getResultSet();

        rs.next();
        assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        rs.close();

        more = st.getMoreResults();

        if (more) {
            rs = st.getResultSet();

            rs.next();
            assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        }

        PreparedStatement ps = conn.prepareStatement(
            "call get_columns_and_table('TABLES', 'INFORMATION_SCHEMA')");

        isResult = ps.execute();

        assertFalse(isResult);
        ps.getMoreResults();

        rs = ps.getResultSet();

        rs.next();
        assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        rs.close();

        more = ps.getMoreResults();

        if (more) {
            rs = ps.getResultSet();

            rs.next();
            assertEquals("INFORMATION_SCHEMA", rs.getString(2));
        }

    }

    public static void procWithResultOne(Integer[] intparam,
                                         ResultSet[] resultparam)
                                         throws SQLException {

        Connection conn =
            DriverManager.getConnection("jdbc:default:connection");

        conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(
            "select count(*) from information_schema.columns where table_name='LOB_IDS' and table_schema='SYSTEM_LOBS'");

        if (rs.next()) {
            intparam[0] = rs.getInt(1);

            rs.close();
        }

        resultparam[0] = st.executeQuery(
            "select table_schema, table_name from information_schema.tables where table_name='LOB_IDS' and table_schema='SYSTEM_LOBS'");
    }

    public static void procWithResultTwo(Connection conn, Integer[] intparam,
                                         ResultSet[] resultparamOne,
                                         ResultSet[] resultparamTwo)
                                         throws SQLException {

        conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(
            "select count(*) from information_schema.columns where table_name='LOB_IDS' and table_schema='SYSTEM_LOBS'");

        if (rs.next()) {
            intparam[0] = rs.getInt(1);

            rs.close();
        }

        resultparamOne[0] = st.executeQuery(
            "select table_schema, table_name from information_schema.tables where table_name='LOB_IDS' and table_schema='SYSTEM_LOBS'");
        resultparamTwo[0] = st.executeQuery(
            "select table_schema, table_name from information_schema.tables where table_name='LOBS' and table_schema='SYSTEM_LOBS'");
    }

    public static void procTest1(Connection conn)
    throws java.sql.SQLException {

        int                cols;
        java.sql.Statement stmt = conn.createStatement();

        stmt.execute("insert into mytable values(1,'test1');");
        stmt.execute("insert into mytable values(2,'test2');");

        java.sql.ResultSet rs = stmt.executeQuery("select * from mytable");
        java.sql.ResultSetMetaData meta = rs.getMetaData();

        cols = meta.getColumnCount();

        rs.close();
        stmt.close();
    }

    public static void procTest2(int p1, int p2,
                                 Integer[] p3) throws java.sql.SQLException {

        Connection conn =
            DriverManager.getConnection("jdbc:default:connection");
        java.sql.Statement stmt = conn.createStatement();

        stmt.execute("insert into mytable values(" + p1 + ",'test1')");
        stmt.execute("insert into mytable values(" + p2 + ",'test2')");

        java.sql.ResultSet rs = stmt.executeQuery("select * from mytable");
        java.sql.ResultSetMetaData meta = rs.getMetaData();
        int                        cols = meta.getColumnCount();

        p3[0] = Integer.valueOf(cols);

        rs.close();
        stmt.close();
    }

    public static ResultSet funcTest1(int p1,
                                      int p2) throws java.sql.SQLException {

        Connection conn =
            DriverManager.getConnection("jdbc:default:connection");
        java.sql.PreparedStatement stmt = conn.prepareStatement(
            "select * from mytable where col1 = ? or col1 = ?");

        stmt.setInt(1, p1);
        stmt.setInt(2, p2);

        java.sql.ResultSet rs = stmt.executeQuery();

        return rs;
    }

    public static boolean funcTest2(Connection conn,
                                    String value)
                                    throws java.sql.SQLException {

        if (value != null && value.startsWith("te")) {
            return true;
        }

        return false;
    }

    public static void procTest3(Integer value) throws java.sql.SQLException {}

    public static void main(String[] args) throws Exception {

        TestResult            result;
        TestCase              test;
        java.util.Enumeration failures;
        int                   count;

        result = new TestResult();
        test   = new TestStoredProcedure("test");

        test.run(result);

        count = result.failureCount();

        System.out.println("TestStoredProcedure failure count: " + count);

        failures = result.failures();

        while (failures.hasMoreElements()) {
            System.out.println(failures.nextElement());
        }
    }
}

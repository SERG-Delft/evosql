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
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import junit.framework.TestCase;
import junit.framework.TestResult;

import java.sql.Date;

/**
 * Test sql statements via jdbc against in-memory database
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 */
public class TestSql extends TestBase {

    Statement         stmnt;
    PreparedStatement pstmnt;
    Connection        connection;
    String            getColumnName = "false";

    public TestSql(String name) {
        super(name);
    }

    protected void setUp() throws Exception {

        super.setUp();

        connection = super.newConnection();
        stmnt      = connection.createStatement();
    }

    public void testMetaData() {

        String ddl0 =
            "DROP TABLE ADDRESSBOOK IF EXISTS; DROP TABLE ADDRESSBOOK_CATEGORY IF EXISTS; DROP TABLE USER IF EXISTS;";
        String ddl1 =
            "CREATE TABLE USER(USER_ID INTEGER NOT NULL PRIMARY KEY,LOGIN_ID VARCHAR(128) NOT NULL,USER_NAME VARCHAR(254) DEFAULT ' ' NOT NULL,CREATE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,UPDATE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,LAST_ACCESS_DATE TIMESTAMP,CONSTRAINT IXUQ_LOGIN_ID0 UNIQUE(LOGIN_ID))";
        String ddl2 =
            "CREATE TABLE ADDRESSBOOK_CATEGORY(USER_ID INTEGER NOT NULL,CATEGORY_ID INTEGER DEFAULT 0 NOT NULL,CATEGORY_NAME VARCHAR(60) DEFAULT '' NOT NULL,CONSTRAINT SYS_PK_ADDRESSBOOK_CATEGORY PRIMARY KEY(USER_ID,CATEGORY_ID),CONSTRAINT FK_ADRBKCAT1 FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE)";
        String ddl3 =
            "CREATE TABLE ADDRESSBOOK(USER_ID INTEGER NOT NULL,ADDRESSBOOK_ID INTEGER NOT NULL,CATEGORY_ID INTEGER DEFAULT 0 NOT NULL,FIRST VARCHAR(64) DEFAULT '' NOT NULL,LAST VARCHAR(64) DEFAULT '' NOT NULL,NOTE VARCHAR(128) DEFAULT '' NOT NULL,CONSTRAINT SYS_PK_ADDRESSBOOK PRIMARY KEY(USER_ID,ADDRESSBOOK_ID),CONSTRAINT FK_ADRBOOK1 FOREIGN KEY(USER_ID,CATEGORY_ID) REFERENCES ADDRESSBOOK_CATEGORY(USER_ID,CATEGORY_ID) ON DELETE CASCADE)";
        String result1 = "1";
        String result2 = "2";
        String result3 = "3";
        String result4 = "4";
        String result5 = "5";

        try {
            stmnt.execute(ddl0);
            stmnt.execute(ddl1);
            stmnt.execute(ddl2);
            stmnt.execute(ddl3);

            DatabaseMetaData md = connection.getMetaData();

            {
                System.out.println("Testing DatabaseMetaData methods");
                System.out.println(md.getDatabaseMajorVersion());
                System.out.println(md.getDatabaseMinorVersion());
                System.out.println(md.getDatabaseProductName());
                System.out.println(md.getDatabaseProductVersion());
                System.out.println(md.getDefaultTransactionIsolation());
                System.out.println(md.getDriverMajorVersion());
                System.out.println(md.getDriverMinorVersion());
                System.out.println(md.getDriverName());
                System.out.println(md.getDriverVersion());
                System.out.println(md.getExtraNameCharacters());
                System.out.println(md.getIdentifierQuoteString());
                System.out.println(md.getJDBCMajorVersion());
                System.out.println(md.getJDBCMinorVersion());
                System.out.println(md.getMaxBinaryLiteralLength());
                System.out.println(md.getMaxCatalogNameLength());
                System.out.println(md.getMaxColumnsInGroupBy());
                System.out.println(md.getMaxColumnsInIndex());
                System.out.println(md.getMaxColumnsInOrderBy());
                System.out.println(md.getMaxColumnsInSelect());
                System.out.println(md.getMaxColumnsInTable());
                System.out.println(md.getMaxConnections());
                System.out.println(md.getMaxCursorNameLength());
                System.out.println(md.getMaxIndexLength());
                System.out.println(md.getMaxProcedureNameLength());
                System.out.println(md.getMaxRowSize());
                System.out.println(md.getMaxSchemaNameLength());
                System.out.println(md.getMaxStatementLength());
                System.out.println(md.getMaxStatements());
                System.out.println(md.getMaxTableNameLength());
                System.out.println(md.getMaxUserNameLength());
                System.out.println(md.getNumericFunctions());
                System.out.println(md.getProcedureTerm());
                System.out.println(md.getResultSetHoldability());
                System.out.println(md.getSchemaTerm());
                System.out.println(md.getSearchStringEscape());
                System.out.println(
                    "Testing DatabaseMetaData.getSQLKeywords()");
                System.out.println(md.getSQLKeywords());
                System.out.println(md.getSQLStateType());
                System.out.println(
                    "Testing DatabaseMetaData.getStringFunctions()");
                System.out.println(md.getStringFunctions());
                System.out.println(
                    "Testing DatabaseMetaData.getSystemFunctions()");
                System.out.println(md.getSystemFunctions());
                System.out.println(
                    "Testing DatabaseMetaData.getTimeDateFunctions()");
                System.out.println(md.getTimeDateFunctions());
                System.out.println(md.getURL());
                System.out.println(md.getUserName());
                System.out.println(DatabaseMetaData.importedKeyCascade);
                System.out.println(md.isCatalogAtStart());
                System.out.println(md.isReadOnly());

                ResultSet rs;

                rs = md.getPrimaryKeys(null, null, "USER");

                ResultSetMetaData rsmd    = rs.getMetaData();
                String            result0 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result0 += rs.getString(i + 1) + ":";
                    }

                    result0 += "\n";
                }

                rs.close();
                System.out.println(result0);
            }

            {
                ResultSet rs;

                rs = md.getBestRowIdentifier(null, null, "USER", 0, true);

                ResultSetMetaData rsmd    = rs.getMetaData();
                String            result0 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result0 += rs.getString(i + 1) + ":";
                    }

                    result0 += "\n";
                }

                rs.close();
                System.out.println(result0);
            }

            {
                ResultSet rs = md.getImportedKeys(null, null, "ADDRESSBOOK");
                ResultSetMetaData rsmd = rs.getMetaData();

                result1 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result1 += rs.getString(i + 1) + ":";
                    }

                    result1 += "\n";
                }

                rs.close();
                System.out.println(result1);
            }

            {
                ResultSet rs = md.getCrossReference(null, null,
                                                    "ADDRESSBOOK_CATEGORY",
                                                    null, null, "ADDRESSBOOK");
                ResultSetMetaData rsmd = rs.getMetaData();

                result2 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result2 += rs.getString(i + 1) + ":";
                    }

                    result2 += "\n";
                }

                rs.close();
                System.out.println(result2);
            }

            {
                ResultSet         rs = md.getExportedKeys(null, null, "USER");
                ResultSetMetaData rsmd = rs.getMetaData();

                result3 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result3 += rs.getString(i + 1) + ":";
                    }

                    result3 += "\n";
                }

                rs.close();
                System.out.println(result3);
            }

            {
                ResultSet rs = md.getCrossReference(null, null, "USER", null,
                                                    null,
                                                    "ADDRESSBOOK_CATEGORY");
                ResultSetMetaData rsmd = rs.getMetaData();

                result4 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result4 += rs.getString(i + 1) + ":";
                    }

                    result4 += "\n";
                }

                rs.close();
                System.out.println(result4);
            }

            {
                stmnt.execute("DROP TABLE T IF EXISTS;");
                stmnt.execute(
                    "CREATE TABLE T (I IDENTITY, A CHAR(20), B CHAR(20));");
                stmnt.execute(
                    "INSERT INTO T VALUES (NULL, 'get_column_name', '"
                    + getColumnName + "');");

                ResultSet rs = stmnt.executeQuery(
                    "SELECT I, A, B, A \"aliasA\", B \"aliasB\", 1 FROM T;");
                ResultSetMetaData rsmd = rs.getMetaData();

                result5 = "";

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result5 += rsmd.getColumnName(i + 1) + ":"
                                   + rs.getString(i + 1) + ":";
                    }

                    result5 += "\n";
                }

                rs.close();

                rs = stmnt.executeQuery(
                    "SELECT I, A, B, A \"aliasA\", B \"aliasB\", 1 FROM T;");
                rsmd = rs.getMetaData();

                for (; rs.next(); ) {
                    for (int i = 0; i < rsmd.getColumnCount(); i++) {
                        result5 += rsmd.getColumnLabel(i + 1) + ":"
                                   + rs.getString(i + 1) + ":";
                    }

                    result5 += "\n";
                }

                System.out.println(result5);
                System.out.println("first column identity: "
                                   + rsmd.isAutoIncrement(1));
                rsmd.isCaseSensitive(1);
                rsmd.isCurrency(1);
                rsmd.isDefinitelyWritable(1);
                rsmd.isNullable(1);
                rsmd.isReadOnly(1);
                rsmd.isSearchable(1);
                rsmd.isSigned(1);
                rsmd.isWritable(1);
                rs.close();

                // test identity with PreparedStatement
                pstmnt = connection.prepareStatement(
                    "INSERT INTO T VALUES (?,?,?)");

                pstmnt.setString(1, null);
                pstmnt.setString(2, "test");
                pstmnt.setString(3, "test2");
                pstmnt.executeUpdate();

                pstmnt = connection.prepareStatement("call identity()");

                ResultSet rsi = pstmnt.executeQuery();

                rsi.next();

                int identity = rsi.getInt(1);

                System.out.println("call identity(): " + identity);
                rsi.close();
            }
        } catch (SQLException e) {
            fail(e.getMessage());
        }

        System.out.println("testMetaData complete");

        // assert equality of exported and imported with xref
        assertEquals(result1, result2);
        assertEquals(result3, result4);
    }

    /**
     * Demonstration of a reported bug.<p>
     * Because all values were turned into strings with toString before
     * PreparedStatement.executeQuery() was called, special values such as
     * NaN were not accepted.
     *
     * This test can be extended to cover various conversions through JDBC
     *
     */
    public void testDoubleNaN() {

        double  value    = 0;
        boolean wasEqual = false;
        String  message  = "DB operation completed";
        String ddl1 =
            "DROP TABLE t1 IF EXISTS;"
            + "CREATE TABLE t1 ( d DECIMAL, f DOUBLE, l BIGINT, i INTEGER, s SMALLINT, t TINYINT, "
            + "dt DATE DEFAULT CURRENT_DATE, ti TIME DEFAULT CURRENT_TIME, ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP );";

        try {
            stmnt.execute(ddl1);

            PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t1 (d,f,l,i,s,t,dt,ti,ts) VALUES (?,?,?,?,?,?,?,?,?)");

            ps.setString(1, "0.2");
            ps.setDouble(2, 0.2);
            ps.setLong(3, java.lang.Long.MAX_VALUE);
            ps.setInt(4, Integer.MAX_VALUE);
            ps.setInt(5, Short.MAX_VALUE);
            ps.setInt(6, 0);
            ps.setDate(7, new java.sql.Date(System.currentTimeMillis()));
            ps.setTime(8, new java.sql.Time(System.currentTimeMillis()));
            ps.setTimestamp(
                9, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.execute();
            ps.setInt(1, 0);
            ps.setDouble(2, java.lang.Double.NaN);
            ps.setLong(3, java.lang.Long.MIN_VALUE);
            ps.setInt(4, Integer.MIN_VALUE);
            ps.setInt(5, Short.MIN_VALUE);
            ps.setInt(6, 0);

            // allowed conversions
            ps.setTimestamp(
                7, new java.sql.Timestamp(System.currentTimeMillis() + 1));
            ps.setTime(8, new java.sql.Time(System.currentTimeMillis() + 1));
            ps.setDate(9, new java.sql.Date(System.currentTimeMillis() + 1));
            ps.execute();

            //
            ps.setInt(1, 0);
            ps.setDouble(2, java.lang.Double.POSITIVE_INFINITY);
            ps.setInt(4, Integer.MIN_VALUE);

            // test conversion
            // ps.setObject(5, Boolean.TRUE); // no longer converts boolean to int
            // ps.setBoolean(5, true);
            ps.setObject(5, new Short((short) 2), Types.SMALLINT);
            ps.setObject(6, new Integer(2), Types.TINYINT);

            // allowed conversions
            ps.setObject(7, new java.sql.Date(System.currentTimeMillis() + 2));
            ps.setObject(8, new java.sql.Time(System.currentTimeMillis() + 2));
            ps.setObject(9, new java.sql.Timestamp(System.currentTimeMillis()
                                                   + 2));
            ps.execute();
            ps.setObject(1, new Float(0), Types.INTEGER);
            ps.setObject(4, new Float(1), Types.INTEGER);
            ps.setDouble(2, java.lang.Double.NEGATIVE_INFINITY);
            ps.execute();

            ResultSet rs =
                stmnt.executeQuery("SELECT d, f, l, i, s*2, t FROM t1");
            boolean result = rs.next();

            value = rs.getDouble(2);

//            int smallintValue = rs.getShort(3);
            int integerValue = rs.getInt(4);

            if (rs.next()) {
                value        = rs.getDouble(2);
                wasEqual     = Double.isNaN(value);
                integerValue = rs.getInt(4);

                // tests for conversion
                // getInt on DECIMAL
                integerValue = rs.getInt(1);
            }

            if (rs.next()) {
                value    = rs.getDouble(2);
                wasEqual = wasEqual && value == Double.POSITIVE_INFINITY;
            }

            if (rs.next()) {
                value    = rs.getDouble(2);
                wasEqual = wasEqual && value == Double.NEGATIVE_INFINITY;
            }

            rs = stmnt.executeQuery("SELECT MAX(i) FROM t1");

            if (rs.next()) {
                int max = rs.getInt(1);

                System.out.println("Max value for i: " + max);
            }

            try {

                // cause errors
                ps.setString(5, "three");
                fail("update did not fail");
            } catch (SQLException e) {}

            {
                stmnt.execute("drop table CDTYPE if exists");

                // test for the value MAX(column) in an empty table
                stmnt.execute(
                    "CREATE TABLE cdType (ID INTEGER NOT NULL, name VARCHAR(50), PRIMARY KEY(ID))");

                rs = stmnt.executeQuery("SELECT MAX(ID) FROM cdType");

                if (rs.next()) {
                    int max = rs.getInt(1);

                    System.out.println("Max value for ID: " + max);
                } else {
                    System.out.println("Max value for ID not returned");
                }

                stmnt.executeUpdate(
                    "INSERT INTO cdType VALUES (10,'Test String');");
                stmnt.execute("CALL IDENTITY();");

                try {
                    stmnt.executeUpdate(
                        "INSERT INTO cdType VALUES (10,'Test String');");
                } catch (SQLException e1) {
                    stmnt.execute("ROLLBACK");
                    connection.rollback();
                }
            }
        } catch (SQLException e) {
            fail(e.getMessage());
        }

        System.out.println("testDoubleNaN complete");

        // assert new behaviour
        assertEquals(true, wasEqual);
    }

    public void testAny() {

        try {
            String ddl =
                "drop table PRICE_RELATE_USER_ORDER_V2 if exists;"
                + "create table PRICE_RELATE_USER_ORDER_V2 "
                + "(ID_ORDER_V2 BIGINT, ID_USER NUMERIC, DATE_CREATE TIMESTAMP)";
            String sql = "insert into PRICE_RELATE_USER_ORDER_V2 "
                         + "(ID_ORDER_V2, ID_USER, DATE_CREATE) " + "values "
                         + "(?, ?, ?)";
            Statement st = connection.createStatement();

            st.execute(ddl);

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setLong(1, 1);
            ps.setNull(2, Types.NUMERIC);
            ps.setTimestamp(
                3, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("TestSql.testAny() error: " + e.getMessage());
        }

        System.out.println("testAny complete");
    }

    /**
     * Fix for bug #1201135
     */
    public void testBinds() {

        try {
            PreparedStatement pstmt =
                connection.prepareStatement("drop table test if exists");

            pstmt.execute();

            pstmt =
                connection.prepareStatement("create table test (id integer)");

            pstmt.execute();

            pstmt =
                connection.prepareStatement("insert into test values (10)");

            pstmt.execute();

            pstmt =
                connection.prepareStatement("insert into test values (20)");

            pstmt.execute();

            pstmt = connection.prepareStatement(
                "select count(*) from test where id is null");

            ResultSet rs = pstmt.executeQuery();

            rs.next();

            int count = rs.getInt(1);

            assertEquals(0, count);

            pstmt =
                connection.prepareStatement("select limit ? 2  id from test");

            pstmt.setInt(1, 0);

            rs = pstmt.executeQuery();

            rs.next();

            count = rs.getInt(1);

            assertEquals(10, count);
            pstmt.setInt(1, 1);

            rs = pstmt.executeQuery();

            rs.next();

            count = rs.getInt(1);

            assertEquals(20, count);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("TestSql.testBinds() error: " + e.getMessage());
        }
    }

    // miscellaneous tests
    public void testX1() {

        String tableDDL =
            "create table lo_attribute ( "
            + "learningid varchar(15) not null, "
            + "ordering integer not null,"
            + "attribute_value_data varchar(85),"
            + "constraint PK_LO_ATTR primary key (learningid, ordering))";

        try {
            Statement stmt = connection.createStatement();

            stmt.execute("drop table lo_attribute if exists");
            stmt.execute(tableDDL);
            stmt.execute(
                "insert into lo_attribute values('abcd', 10, 'cdef')");
            stmt.execute(
                "insert into lo_attribute values('bcde', 20, 'cdef')");
        } catch (SQLException e) {
            assertEquals(0, 1);
        }

        try {
            String prepared =
                "update lo_attribute set "
                + " ordering = (ordering - 1) where ordering > ?";
            PreparedStatement ps = connection.prepareStatement(prepared);

            ps.setInt(1, 10);
            ps.execute();
        } catch (SQLException e) {
            assertEquals(0, 1);
        }

        try {
            connection.setAutoCommit(false);

            java.sql.Savepoint savepoint =
                connection.setSavepoint("savepoint");

            connection.createStatement().executeQuery("CALL true;");
            connection.rollback(savepoint);
        } catch (SQLException e) {
            assertEquals(0, 1);
        }
    }

    /**
     * In 1.8.0.2, this fails in client / server due to column type of the
     * second select for b1 being boolean, while the first select is interpreted
     * as varchar. The rowOutputBase class attempts to cast the Java Boolean
     * into String.
     */
    public void testUnionColumnTypes() {

        try {
            Connection conn = newConnection();
            Statement  stmt = conn.createStatement();

            stmt.execute("DROP TABLE test1 IF EXISTS");
            stmt.execute("DROP TABLE test2 IF EXISTS");
            stmt.execute("CREATE TABLE test1 (id int, b1 boolean)");
            stmt.execute("CREATE TABLE test2 (id int)");
            stmt.execute("INSERT INTO test1 VALUES(1,true)");
            stmt.execute("INSERT INTO test2 VALUES(2)");

            ResultSet rs = stmt.executeQuery(
                "select id,null as b1 from test2 union select id, b1 from test1");
            Boolean[] array = new Boolean[2];

            for (int i = 0; rs.next(); i++) {
                boolean boole = rs.getBoolean(2);

                array[i] = Boolean.valueOf(boole);

                if (rs.wasNull()) {
                    array[i] = null;
                }
            }

            boolean result = (array[0] == null && array[1] == Boolean.TRUE)
                             || (array[0] == Boolean.TRUE && array[1] == null);

            assertTrue(result);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("TestSql.testUnionColumnType() error: "
                               + e.getMessage());
        }
    }

    public void testUnionSubquery() throws Exception {

        Statement st = connection.createStatement();

        st.execute("DROP TABLE t1 if exists;");
        st.execute("DROP TABLE t2 if exists;");
        st.execute(
            "CREATE TABLE t1 (id int not null, v1 int, v2 int, primary key(id))");
        st.execute(
            "CREATE TABLE t2 (id int not null, v1 int, v3 int, primary key(id))");
        st.execute("INSERT INTO t1 values(1,1,1)");
        st.execute("INSERT INTO t1 values(2,2,2)");
        st.execute("INSERT INTO t2 values(1,3,3)");

        ResultSet rs = st.executeQuery(
            "select t as atable, a as idvalue, b as value1, c as value2, d as value3 from("
            + "(select 't1' as t, t1.id as a, t1.v1 as b, t1.v2 as c, null as d from t1) union"
            + "(select 't2' as t, t2.id as a, t2.v1 as b, null as c, t2.v3 as d from t2)) order by atable, idvalue");

        assertTrue(rs.next());
        assertEquals("t1", rs.getObject("atable"));
        assertEquals(1, rs.getInt("idvalue"));
        assertEquals(1, rs.getInt("value1"));
        assertEquals(1, rs.getInt("value2"));
        assertEquals(null, rs.getObject("value3"));
        assertTrue(rs.next());
        assertEquals("t1", rs.getObject("atable"));
        assertEquals(2, rs.getInt("idvalue"));
        assertEquals(2, rs.getInt("value1"));
        assertEquals(2, rs.getInt("value2"));
        assertEquals(null, rs.getObject("value3"));
        assertTrue(rs.next());
        assertEquals("t2", rs.getObject("atable"));
        assertEquals(1, rs.getInt("idvalue"));
        assertEquals(3, rs.getInt("value1"));
        assertEquals(null, rs.getObject("value2"));
        assertEquals(3, rs.getInt("value3"));    //this fails!
        assertFalse(rs.next());
    }

    public void testPreparedWithManyParams() throws Exception {

        int    count    = 40;
        String tabledef = "CREATE TABLE T1 (";

        for (int i = 0; i < count; i++) {
            if (i != 0) {
                tabledef = tabledef + ',';
            }

            tabledef = tabledef + "COL_" + i + " INT NOT NULL";
        }

        tabledef += ");";

        String querydef = "INSERT INTO T1(";

        for (int i = 0; i < count; i++) {
            if (i != 0) {
                querydef = querydef + ',';
            }

            querydef = querydef + "COL_" + i;
        }

        querydef += ") VALUES (";

        for (int i = 0; i < count; i++) {
            if (i != 0) {
                querydef = querydef + ',';
            }

            querydef = querydef + "?";
        }

        querydef += ");";

        Statement st = connection.createStatement();

        st.execute("DROP TABLE T1 IF EXISTS;");
        st.execute(tabledef);

        PreparedStatement ps = connection.prepareStatement(querydef);

        for (int i = 0; i < count; i++) {
            ps.setInt(i + 1, i + 311);
        }

        ps.executeUpdate();
    }

    static byte[] b1 = {
        0, 1, -128, 44, 12
    };
    static byte[] b2 = {
        10, 127
    };

    public void testBinaryFunction() throws Exception {

        Statement sStatement = null;
        ResultSet r;
        boolean   mismatch;

        sStatement = connection.createStatement();

        try {

            // prepared statements
            String s =
                "create table bintest(id int primary key, bin varbinary(100))";

            sStatement.execute(s);

            s = "insert into bintest values ( ?, ?)";

            PreparedStatement p = connection.prepareStatement(s);

            p.clearParameters();
            p.setInt(1, 10);
            p.setBytes(2, b1);
            p.executeUpdate();
            p.clearParameters();
            p.setInt(1, 20);
            p.setBytes(2, b2);
            p.executeUpdate();

            byte[] b1n;
            byte[] b2n;

            s = "select \"org.hsqldb.lib.ArrayUtil.countStartElementsAt\"(bin,0, ?) "
                + "from bintest";
            p = connection.prepareStatement(s);

            p.setBytes(1, b2);

            r = p.executeQuery();

            r.next();

            int integer1 = r.getInt(1);

            r.next();

            int integer2 = r.getInt(1);

            s = "select \"org.hsqldb.lib.StringConverter.hexStringToByteArray\""
                + "(\"org.hsqldb.lib.StringConverter.byteArrayToHexString\"(x'abcd')) "
                + "from bintest";
            r = sStatement.executeQuery(s);

            r.next();

            b1n = r.getBytes(1);

            r.next();

            b1n = r.getBytes(1);

            //--
            s = "select \"org.hsqldb.lib.StringConverter.byteArrayToHexString\"(bin) "
                + "from bintest";
            r = sStatement.executeQuery(s);

            r.next();

            b1n = r.getBytes(1);

            r.next();

            b1n = r.getBytes(1);
            s   = "create table obj(id int,o object)";

            sStatement.execute(s);

            s = "insert into obj values(?,?)";
            p = connection.prepareStatement(s);

            p.setInt(1, 1);

            int[] ia1 = {
                1, 2, 3
            };

            p.setObject(2, ia1);
            p.executeUpdate();
            p.clearParameters();
            p.setInt(1, 2);

            java.awt.Rectangle r1 = new java.awt.Rectangle(10, 11, 12, 13);

            p.setObject(2, r1);
            p.executeUpdate();

            r = sStatement.executeQuery("SELECT o FROM obj ORDER BY id DESC");

            r.next();

            java.awt.Rectangle r2 = (java.awt.Rectangle) r.getObject(1);

            if (r2.x != 10 || r2.y != 11 || r2.width != 12
                    || r2.height != 13) {
                throw new Exception("Object data error: Rectangle");
            }

            r.next();

            int[] ia2 = (int[]) (r.getObject(1));

            if (ia2[0] != 1 || ia2[1] != 2 || ia2[2] != 3 || ia2.length != 3) {
                throw new Exception("Object data error: int[]");
            }

            sStatement.close();
        } catch (Exception e) {
            assertEquals(0, 1);
        }
    }

    protected void tearDown() {

        try {
            stmnt.execute("SHUTDOWN");
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("TestSql.tearDown() error: " + e.getMessage());
        }

        super.tearDown();
    }

    public static void main(String[] argv) {

        TestResult result = new TestResult();
        TestCase   testA  = new TestSql("testMetaData");
        TestCase   testB  = new TestSql("testDoubleNaN");
        TestCase   testC  = new TestSql("testAny");

        testA.run(result);
        testB.run(result);
        testC.run(result);
        System.out.println("TestSql error count: " + result.failureCount());
    }
}

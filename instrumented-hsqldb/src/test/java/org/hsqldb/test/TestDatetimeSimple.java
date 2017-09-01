/* Copyright (c) 2001-2015, The HSQL Development Group
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
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.TimeZone;

import junit.framework.TestCase;

import java.util.Calendar;

/**
 * Date Test Case.
 */
public class TestDatetimeSimple extends TestCase {

    static String connectionURL =
        "jdbc:hsqldb:file:/hsql/tests/testdatetimesimple";

    static {
        try {
            Class.forName("org.hsqldb.jdbcDriver");
        } catch (ClassNotFoundException cnfe) {
            throw new RuntimeException(
                "<clinit> failed.  JDBC Driver class not in CLASSPATH");
        }
    }

    public void testTimestampParam() throws SQLException {

        Connection c = DriverManager.getConnection("jdbc:hsqldb:mem:db", "sa",
            "");
        Statement stmt = c.createStatement();

        stmt.execute("create table dual (c0 integer)");
        stmt.executeUpdate("insert into dual values (2)");

        ResultSet set = stmt.executeQuery(
            "select to_number(to_char((select current_timestamp + c0  day from dual), 'YYYYMMDD')) from dual");

        if (set.next()) {
            System.out.println("stmt res=" + set.getInt(1));
        }

        set.close();

        PreparedStatement pstmt = c.prepareStatement(
            "select to_number(to_char((select ? + c0  day from dual), 'YYYYMMDD')) from dual");

        pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));

        set = pstmt.executeQuery();

        if (set.next()) {
            System.out.println("pstmt res=" + set.getInt(1));
        }

        pstmt = c.prepareStatement(
            "select to_number(to_char((select ? - c0  day from dual), 'YYYYMMDD')) from dual");

        pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));

        set = pstmt.executeQuery();

        if (set.next()) {
            System.out.println("pstmt res=" + set.getInt(1));
        }

        pstmt = c.prepareStatement(
            "select extract(hour from ((localtimestamp + 26 hour) - ?) day to hour ) from dual");

        pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));

        set = pstmt.executeQuery();

        if (set.next()) {
            System.out.println("pstmt res=" + set.getInt(1));
        }

        pstmt = c.prepareStatement(
            "select extract(hour from (localtimestamp + 27 hour) - cast(? as timestamp) ) from dual");

        pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));

        set = pstmt.executeQuery();

        if (set.next()) {
            System.out.println("pstmt res=" + set.getInt(1));
        }

        c.close();
    }

    public void testSimple() throws SQLException {

        TestUtil.deleteDatabase("/hsql/tests/testdatetimesimple");

        Connection conn = DriverManager.getConnection(connectionURL, "SA", "");
        ResultSet         rs;
        PreparedStatement ps;
        Statement         st = conn.createStatement();

        st.executeUpdate("SET TIME ZONE INTERVAL '-5:00' HOUR TO MINUTE");
        st.executeUpdate("DROP TABLE t IF EXISTS");
        st.executeUpdate("CREATE TABLE t(i int, d date)");
        st.executeUpdate("INSERT INTO t VALUES(1, '2008-11-27')");

        rs = st.executeQuery("SELECT d FROM t");

        rs.next();
        System.out.println("Object: " + rs.getObject("d")               //
                           + " ; Timestamp: " + rs.getTimestamp("d")    //
                           + " ; Date: " + rs.getDate("d")              //
                           + " ; String: " + rs.getString("d"));
        rs.close();

        rs = st.executeQuery("SELECT count(*) c FROM t WHERE d = "
                             + "'2008-11-27'");

        rs.next();
        System.out.println("Match? " + (rs.getInt("c") > 0));
        st.executeUpdate("DELETE FROM t");

        /* This is prohibited:

        st.executeUpdate("INSERT INTO t VALUES(2, '2008-11-27 0:00:00')");

        Q: Do we want to prohibit this, even though we permit the same
        usage with PreparedStatement using a Timestamp, as follows?

        A: In the disallowed case, a String that is not a data string is used,
           while in the other case, a timestamp object is used. It follows the
           cast specification, which requires the String to be a valid date
           string, and allows casting from a TIMESTAMP object to DATE

        */
        ps = conn.prepareStatement("INSERT INTO t VALUES(3, ?)");

        ps.setTimestamp(1, java.sql.Timestamp.valueOf("2008-10-27 0:00:00"));
        ps.execute();
        ps.close();

        rs = st.executeQuery("SELECT d FROM t");

        rs.next();
        System.out.println("Object: " + rs.getObject("d")                 //
                           + " ; Date: " + rs.getDate("d")                //
                           + " ; Timestamp: " + rs.getTimestamp("d") +    //
                               "; String: " + rs.getString("d"));
        rs.close();

        rs = st.executeQuery("SELECT count(*) c FROM t WHERE d = "
                             + "'2008-10-27'");

        /* FRED:  When the DATE value is inserted with a TIMESTAMP,
         * all matches using a date fail.  The query here fails regardless
         * of what date I use. */
        rs.next();
        System.out.println("Match? " + (rs.getInt("c") > 0));

        /** ********  TIMESTAMP COL BELOW ********* */
        st.executeUpdate("DROP TABLE t2 IF EXISTS");
        st.executeUpdate("CREATE TABLE t2(i int, ts timestamp)");
        /* These all fail:
        st.executeUpdate("INSERT INTO t2 VALUES(1, '2008-11-27')");
        st.executeUpdate("INSERT INTO t2 VALUES(1, timestamp '2008-11-27')");
        in both cases, the string is not a valid timestamp string
        */
        st.executeUpdate(
            "INSERT INTO t2 VALUES(1, timestamp '2008-11-27 12:30:00')");
        st.executeUpdate("INSERT INTO t2 VALUES(1, '2008-11-27 12:30:00')");

        /** FOLLOWING ALL WORK AS EXPECTED: */
        ps = conn.prepareStatement("INSERT INTO t2 VALUES(2, ?)");

        ps.setTimestamp(1, java.sql.Timestamp.valueOf("2008-10-27 0:00:00"));
        ps.execute();
        ps.close();

        rs = st.executeQuery("SELECT ts FROM t2");

        rs.next();
        System.out.println("Object: " + rs.getObject("ts")               //
                           + " ; Timestamp: " + rs.getTimestamp("ts")    //
                           + " ; Date: " + rs.getObject("ts")            //
                           + "; String: " + rs.getString("ts"));
        rs.close();
        st.executeUpdate("SHUTDOWN");
        conn.close();
    }

    public void testValues() throws SQLException {

        TestUtil.deleteDatabase("/hsql/tests/testdatetimesimple");

        Connection conn = DriverManager.getConnection(connectionURL, "SA", "");
        ResultSet          rs;
        PreparedStatement  ps;
        String             s;
        Object             o;
        java.sql.Date      d;
        java.sql.Timestamp ts;
        Statement          st = conn.createStatement();

        st.executeUpdate("SET TIME ZONE INTERVAL '-5:00' HOUR TO MINUTE");
        st.executeUpdate("DROP TABLE t3 IF EXISTS");
        st.executeUpdate("CREATE TABLE t3(d date)");
        st.executeUpdate("INSERT INTO t3 VALUES('2008-11-27')");

        rs = st.executeQuery("SELECT d FROM t3");

        rs.next();

        s  = rs.getString("d");
        o  = rs.getObject("d");
        d  = rs.getDate("d");
        ts = rs.getTimestamp("d");

        System.out.println("2008-11-27 INSERTED" + "\n    String: " + s
                           + "\n    Object: " + o + "\n    Date: " + dump(d)
                           + "\n    Timestamp: " + dump(ts) + '\n');
        rs.close();
        st.executeUpdate("DROP TABLE ts IF EXISTS");
        st.executeUpdate(
            "CREATE TABLE ts(id integer generated by default as identity (start with 1), ts timestamp, tsz timestamp with time zone)");
        st.executeUpdate(
            "INSERT INTO ts VALUES DEFAULT, LOCALTIMESTAMP, CURRENT_TIMESTAMP");

        rs = st.executeQuery("CALL CURRENT_DATE");

        rs.next();

        o  = rs.getObject(1);
        d  = rs.getDate(1);
        s  = rs.getString(1);
        ts = rs.getTimestamp(1);

        System.out.println("CURRENT_DATE @" + new java.util.Date()
                           + "\n    String: " + s + "\n    Object: " + o
                           + "\n    Date: " + dump(d) + "\n    Timestamp: "
                           + dump(ts) + '\n');
        rs.close();

        rs = st.executeQuery("CALL LOCALTIMESTAMP");

        rs.next();

        o  = rs.getObject(1);
        s  = rs.getString(1);
        ts = rs.getTimestamp(1);

        System.out.println("LOCALTIMESTAMP @" + new java.util.Date()
                           + "\n    String: " + s + "\n    Object: " + o
                           + "\n    Timestamp: " + dump(ts) + '\n');
        rs.close();

        rs = st.executeQuery("CALL CURRENT_TIMESTAMP");

        rs.next();

        s  = rs.getString(1);
        o  = rs.getObject(1);
        ts = rs.getTimestamp(1);

        System.out.println("CURRENT_TIMESTAMP @" + new java.util.Date()
                           + "\n    String: " + s + "\n    Object: " + o
                           + "\n    Timestamp: " + dump(ts) + '\n');
        rs.close();
        st.executeUpdate("SHUTDOWN");
        conn.close();
    }

    public void testDateRangeCheck() throws SQLException {

        Connection c = DriverManager.getConnection("jdbc:hsqldb:mem:db", "sa",
            "");
        Statement stmt = c.createStatement();

        stmt.execute("create table testdate (d date)");
        stmt.executeUpdate("insert into testdate values DATE'2017-01-19'");

        PreparedStatement pstmt =
            c.prepareStatement("insert into testdate values ?");

        try {
            pstmt.setDate(1, new Date(25000, 1, 1));
            pstmt.executeUpdate();
            fail("invalid date beyond 9999CE accepted");
        } catch (SQLException e) {}
    }

    public static String dump(java.sql.Timestamp t) {
        return "String (" + t.toString() + "), GMTString (" + t.toGMTString()
               + "), LocalString (" + t.toLocaleString() + ')';
    }

    public static String dump(java.sql.Date d) {
        return "String (" + d.toString() + "), GMTString (" + d.toGMTString()
               + "), LocalString (" + d.toLocaleString() + ')';
    }

    public static void main(String[] argv) {

        TestDatetimeSimple testA = new TestDatetimeSimple();
        String[]           zones = { "GMT-05:00" };

        try {
            for (int i = 0; i < zones.length; i++) {
                TimeZone timeZone = TimeZone.getTimeZone(zones[i]);

                TimeZone.setDefault(timeZone);
                testA.testSimple();
                testA.testValues();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

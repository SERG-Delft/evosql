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
import java.sql.Statement;

import junit.framework.TestCase;
import junit.framework.TestResult;

/**
 * HSQLDB TestLikePredicate Junit test case. <p>
 *
 * @author  boucherb@users
 * @version 1.9.0
 * @since 1.7.2
 */
public class TestLikePredicateOptimizations extends TestBase {

    public TestLikePredicateOptimizations(String name) {
        super(name);
    }

    /* Implements the TestLikePredicate test */
    public void test() throws Exception {

        Connection        conn = newConnection();
        Statement         stmt = conn.createStatement();
        PreparedStatement pstmt;
        ResultSet         rs;
        String            sql;
        int               expectedCount;
        int               actualCount;

        stmt.execute("drop table test if exists");
        stmt.execute("drop table empty if exists");

        sql = "create table test(name varchar(255))";

        stmt.execute(sql);

        sql = "create index idx on test(name)";

        stmt.execute(sql);

        sql = "create table empty(name varchar(255))";

        stmt.execute(sql);

        sql = "insert into empty values 'name10'";

        stmt.execute(sql);

        sql = "insert into empty values 'name11'";

        stmt.execute(sql);

        sql   = "insert into test values(?)";
        pstmt = conn.prepareStatement(sql);

        for (int i = 0; i < 10000; i++) {
            pstmt.setString(1, "name" + i);
            pstmt.addBatch();
        }

        pstmt.executeBatch();

        sql = "select TOP 20 * from test where name like '%me4%' order by name";
        rs = stmt.executeQuery(sql);

        int countOne = 0;
        int countTwo = 0;

        while (rs.next()) {
            countOne++;
        }

        sql   = "select TOP 20 * from test where name like ? order by name";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, "%me4%");

        rs = pstmt.executeQuery();

        while (rs.next()) {
            countTwo++;
        }

        assertEquals("\"" + sql + "\"", countOne, countTwo );

//
        sql = "select count(*) from test where name = (select max(name) from empty)";
        rs = stmt.executeQuery(sql);

        rs.next();

        expectedCount = rs.getInt(1);
        sql = "select count(*) from test where name like (select min(name) from empty)";
        pstmt = conn.prepareStatement(sql);
        rs    = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

        sql = "select count(*) from test where (select max(name) from empty where empty.name = test.name and empty.name > ?) like '%ame11%'";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, "n");

        rs = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

// --
        sql = "select count(*) from test where name = ''";
        rs  = stmt.executeQuery(sql);

        rs.next();

        expectedCount = rs.getInt(1);
        sql           = "select count(*) from test where name like ''";
        pstmt         = conn.prepareStatement(sql);
        rs            = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

        // --
        sql = "SELECT t.name FROM test t WHERE ((SELECT t2.name from test t2 where t2.name=?) like '%name5000%')";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, "name5000");

        rs = pstmt.executeQuery();

        assertEquals(rs.next(), true);

        String actual = rs.getString(1);

        assertEquals(actual, "name0");

// --
// --
        sql = "select count(*) from test where name is not null";
        rs  = stmt.executeQuery(sql);

        rs.next();

        expectedCount = rs.getInt(1);
        sql           = "select count(*) from test where name like '%'";
        pstmt         = conn.prepareStatement(sql);
        rs            = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

// --
        sql = "select count(*) from test where substring(name from 1 for 6) = 'name44'";
        rs = stmt.executeQuery(sql);

        rs.next();

        expectedCount = rs.getInt(1);
        sql           = "select count(*) from test where name like 'name44%'";
        pstmt         = conn.prepareStatement(sql);
        rs            = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

// --
        sql = "select count(*) from test where left(name,5) = 'name4' and right(name,1) = '5'";
        rs = stmt.executeQuery(sql);

        rs.next();

        expectedCount = rs.getInt(1);
        sql           = "select count(*) from test where name like 'name4%5'";
        pstmt         = conn.prepareStatement(sql);
        rs            = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

        sql = "select count(*) from test";
        rs  = stmt.executeQuery(sql);

        rs.next();

        expectedCount = rs.getInt(1);
        sql           = "select count(*) from test where name like '%'";
        pstmt         = conn.prepareStatement(sql);
        rs            = pstmt.executeQuery();

        rs.next();

        actualCount = rs.getInt(1);

        assertEquals("\"" + sql + "\"", expectedCount, actualCount);

// --
        String result  = "true";
        String presult = "false";

        stmt.execute("drop table test1 if exists");

        sql   = "CREATE TABLE test1 (col CHAR(30))";
        pstmt = conn.prepareStatement(sql);

        pstmt.execute();

        sql   = "INSERT INTO test1 (col) VALUES ('one')";
        pstmt = conn.prepareStatement(sql);

        pstmt.execute();

        sql   = "SELECT * FROM test1 WHERE ( col LIKE ? )";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, "on%");

        rs = pstmt.executeQuery();

        if (rs.next()) {
            presult = rs.getString("COL");
        }

        sql   = "SELECT * FROM test1 WHERE ( col LIKE 'one' )";
        pstmt = conn.prepareStatement(sql);
        rs    = pstmt.executeQuery();

        if (rs.next()) {
            result = rs.getString("COL");
        }

        assertEquals("\"" + sql + "\"", result, presult);

        sql   = "SELECT * FROM test1 WHERE ( col LIKE 'one' ESCAPE CAST(? AS CHAR) )";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%");
        rs    = pstmt.executeQuery();

        if (rs.next()) {
            result = rs.getString("COL");
        }

        assertEquals("\"" + sql + "\"", result, presult);

        sql   = "SELECT * FROM test1 WHERE ( col LIKE 'one' ESCAPE ? )";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%");
        rs    = pstmt.executeQuery();

        if (rs.next()) {
            result = rs.getString("COL");
        }

        assertEquals("\"" + sql + "\"", result, presult);
    }

    /* Runs TestLikePredicate test from the command line*/
    public static void main(String[] args) throws Exception {

        TestResult            result;
        TestCase              test;
        java.util.Enumeration failures;
        int                   count;

        result = new TestResult();
        test   = new TestLikePredicateOptimizations("test");

        test.run(result);

        count = result.failureCount();

        System.out.println("TestLikePredicateOptimizations failure count: "
                           + count);

        failures = result.failures();

        while (failures.hasMoreElements()) {
            System.out.println(failures.nextElement());
        }
    }
}

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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

import junit.framework.TestCase;

/**
 * @author kloska@users
 * @author fredt@users
 */
public class TestPreparedSubQueries extends TestCase {

    private Connection con = null;

    private class sqlStmt {

        boolean prepare;
        boolean update;
        String  command;

        sqlStmt(String c, boolean p, boolean u) {

            prepare = p;
            command = c;
            update  = u;
        }
    }
    ;

    private sqlStmt[] stmtArray = {
        new sqlStmt("drop table a if exists cascade", false, false),
        new sqlStmt("create cached table a (a int identity,b int)", false,
                    false),
        new sqlStmt("create index bIdx on a(b)", false, false),
        new sqlStmt("insert into a(b) values(1)", true, true),
        new sqlStmt("insert into a(b) values(2)", true, true),
        new sqlStmt("insert into a(b) values(3)", true, true),
        new sqlStmt("insert into a(b) values(4)", true, true),
        new sqlStmt("insert into a(b) values(5)", true, true),
        new sqlStmt("insert into a(b) values(6)", true, true),
        new sqlStmt(
            "update a set b=100 where b>(select b from a X where X.a=2)",
            true, true),
        new sqlStmt("update a set b=200 where b>(select b from a where a=?)",
                    true, true),
        new sqlStmt(
            "update a set b=300 where b>(select b from a X where X.a=?)",
            true, true)
    };
    private Object[][] stmtArgs = {
        {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, { new Integer(2) },
        { new Integer(2) }
    };

    public TestPreparedSubQueries(String name) {
        super(name);
    }

    protected void setUp() {

        String url = "jdbc:hsqldb:test";

        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver");

            con = java.sql.DriverManager.getConnection(url, "sa", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void testA() {

        try {
            int i = 0;

            for (i = 0; i < stmtArray.length; i++) {
                int j;

                System.out.println(" -- #" + i + " ----------------------- ");

                if (stmtArray[i].prepare) {
                    PreparedStatement ps = null;

                    System.out.println(" -- preparing\n<<<\n"
                                       + stmtArray[i].command + "\n>>>\n");

                    ps = con.prepareStatement(stmtArray[i].command);

                    System.out.print(" -- setting " + stmtArgs[i].length
                                     + " Args [");

                    for (j = 0; j < stmtArgs[i].length; j++) {
                        System.out.print((j > 0 ? "; "
                                                : "") + stmtArgs[i][j]);
                        ps.setObject(j + 1, stmtArgs[i][j]);
                    }

                    System.out.println("]");
                    System.out.println(" -- executing ");

                    if (stmtArray[i].update) {
                        int r = ps.executeUpdate();

                        System.out.println(" ***** ps.executeUpdate gave me "
                                           + r);
                    } else {
                        boolean b = ps.execute();

                        System.out.print(" ***** ps.execute gave me " + b);
                    }
                } else {
                    System.out.println(" -- executing directly\n<<<\n"
                                       + stmtArray[i].command + "\n>>>\n");

                    Statement s = con.createStatement();
                    boolean   b = s.execute(stmtArray[i].command);

                    System.out.println(" ***** st.execute gave me " + b);
                }
            }
        } catch (Exception e) {
            System.out.println(" ?? Caught Exception " + e);
            assertTrue(false);
        }

        assertTrue(true);
    }

    public void testGenerated() {

        boolean valid = false;

        try {
            Statement s = con.createStatement();

            s.execute("drop table a if exists");
            s.execute("create cached table a (a int identity,b int)");
            s.execute("insert into a(b) values(1)",
                      Statement.RETURN_GENERATED_KEYS);

            ResultSet r = s.getGeneratedKeys();

            while (r.next()) {
                r.getInt(1);

                valid = true;
            }

            r.close();
            assertTrue(valid);
            s.execute("insert into a(b) values(2)", new int[]{ 1 });

            r = s.getGeneratedKeys();

            while (r.next()) {
                r.getInt(1);

                valid = true;
            }

            assertTrue(valid);

            s.execute("insert into a(b) values(2)", new String[]{ "A" });

            r = s.getGeneratedKeys();

            while (r.next()) {
                r.getInt(1);

                valid = true;
            }

            assertTrue(valid);

            s.execute("drop table a if exists");
            s.execute("create cached table a (g int generated always as (a + b), a int generated always as identity (start with 5), b int, c timestamp default current_timestamp)");
            s.execute("insert into a(b) values(1)",
                      Statement.RETURN_GENERATED_KEYS);

            r = s.getGeneratedKeys();

            while (r.next()) {
                int v = r.getInt(2);

                valid = true;

                assertEquals(v, 5);

            }

            r.close();
            assertTrue(valid);
            s.execute("insert into a(b) values(2)", new int[]{ 1 });

            r = s.getGeneratedKeys();

            while (r.next()) {
                int v = r.getInt(1);

                valid = true;

                assertEquals(v, 8);
            }

            assertTrue(valid);

            s.execute("insert into a(b) values(2)", new String[]{ "A", "G", "C" });

            r = s.getGeneratedKeys();

            while (r.next()) {
                Timestamp tv = r.getTimestamp(3);

                int iv = r.getInt(1);

                valid = true;

                assertEquals(iv, 7);

                long diff = System.currentTimeMillis() -  tv.getTime();

                if (diff > 100 || diff <0) {
                    fail("timestamp not correct");
                }

            }

            assertTrue(valid);

        } catch (Exception e) {
            assertTrue(false);
        }
    }

    public void testIdentity() {

        boolean valid = false;

        try {
            Statement s = con.createStatement();

            s.execute("drop table a if exists");
            s.execute("create cached table a (a int identity, b int)");

            PreparedStatement p1 =
                con.prepareStatement("insert into a(b) values ?");

            p1.setInt(1, 10);
            p1.executeUpdate();

            PreparedStatement p2 = con.prepareStatement("call identity()");
            ResultSet         r  = p2.executeQuery();

            while (r.next()) {
                r.getInt(1);

                valid = true;
            }

            p1.setInt(1, 11);
            p1.executeUpdate();

            PreparedStatement ps3 = con.prepareStatement(
                "select count(*) from a where a in ((select a from a where b = ?) union (select ? from a))");

            ps3.setInt(1, 10);
            ps3.setInt(2, 1);

            r = ps3.executeQuery();

            while (r.next()) {
                int value = r.getInt(1);

                valid = value == 2;
            }

            assertTrue(valid);
        } catch (Exception e) {
            assertTrue(false);
        }
    }
}

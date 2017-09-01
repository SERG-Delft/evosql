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
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.DriverManager;

public class TestUpdatableResultSets extends TestBase {

    //
    Connection connection;
    Statement  statement;

    public TestUpdatableResultSets(String name) {
        super(name);
    }

    protected void setUp() throws Exception {

        super.setUp();

        connection = super.newConnection();
        statement = connection.createStatement(ResultSet.TYPE_FORWARD_ONLY,
                                               ResultSet.CONCUR_UPDATABLE);
    }

    public void testUpdatable() {

        try {
            statement.execute("SET DATABASE EVENT LOG SQL LEVEL 3");
            statement.execute("drop table t1 if exists");
            statement.execute(
                "create table t1 (i int primary key, c varchar(10), t varbinary(3))");

            String            insert = "insert into t1 values(?,?,?)";
            String            select = "select i, c, t from t1 where i > ?";
            PreparedStatement ps     = connection.prepareStatement(insert);

            for (int i = 0; i < 10; i++) {
                ps.setInt(1, i);
                ps.setString(2, String.valueOf(i) + " s");
                ps.setBytes(3, new byte[] {
                    (byte) i, ' ', (byte) i
                });
                ps.execute();
            }

            ps.close();
            connection.setAutoCommit(false);

            ps = connection.prepareStatement(select,
                                             ResultSet.TYPE_SCROLL_INSENSITIVE,
                                             ResultSet.CONCUR_UPDATABLE);

            ps.setInt(1, -1);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String s = rs.getString(2);

                rs.updateString(2, s + s);
                rs.updateRow();
            }

            rs.close();

            rs = ps.executeQuery();

            while (rs.next()) {
                String s = rs.getString(2);

                System.out.println(s);
            }

            connection.rollback();

            rs = ps.executeQuery();

            while (rs.next()) {
                String s = rs.getString(2);

                System.out.println(s);
            }

            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void testDeletable() {

        try {
            statement.execute("drop table t1 if exists");
            statement.execute(
                "create table t1 (i int primary key, c varchar(10), t varbinary(3))");

            String            insert = "insert into t1 values(?,?,?)";
            String            select = "select i, c, t from t1";
            PreparedStatement ps     = connection.prepareStatement(insert);

            for (int i = 0; i < 10; i++) {
                ps.setInt(1, i);
                ps.setString(2, String.valueOf(i) + " s");
                ps.setBytes(3, new byte[] {
                    (byte) i, ' ', (byte) i
                });
                ps.execute();
            }

            connection.setAutoCommit(false);

            ResultSet rs = statement.executeQuery(select);

            while (rs.next()) {
                String s = rs.getString(2);

                rs.deleteRow();
            }

            rs.close();

            rs = statement.executeQuery(select);

            while (rs.next()) {
                super.fail("rows not deleted");
            }

            connection.rollback();

            rs = statement.executeQuery(select);

            while (rs.next()) {
                String s = rs.getString(2);

                System.out.println(s);
            }

            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void testDeletable2() {

        try {
            Connection c =
                DriverManager.getConnection("jdbc:hsqldb:mem:mytestdb", "SA",
                                            "");
            String createSQL =
                "create table test (num INTEGER PRIMARY KEY, str VARCHAR(25))";
            Statement createStmt = c.createStatement();

            createStmt.execute(createSQL);
            createStmt.close();

            String            ins = "insert into test (num,str) values (?,?)";
            PreparedStatement pStmt = c.prepareStatement(ins);

            for (int i = 0; i < 100; i++) {
                pStmt.setInt(1, i);
                pStmt.setString(2, "String" + i);
                pStmt.execute();
            }

            // there should now be 100 rows in the table
            String select = "SELECT * FROM test";
            PreparedStatement stmt = c.prepareStatement(select,
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery();

            rs.beforeFirst();

            while (rs.next()) {
                int num = rs.getInt("num");

                if ((num % 7) == 0) {
                    System.out.println("Deleting row:" + num);
                    rs.deleteRow();
                }
            }

            Statement dropStmt = c.createStatement();

            dropStmt.execute("drop table test;");
            dropStmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void testScrollable() {

        try {
            statement.execute("drop table t1 if exists");
            statement.execute(
                "create table t1 (i int primary key, c varchar(10), t varbinary(3))");
            statement.close();

            String            insert = "insert into t1 values(?,?,?)";
            String            select = "select i, c, t from t1";
            PreparedStatement ps     = connection.prepareStatement(insert);

            for (int i = 0; i < 10; i++) {
                ps.setInt(1, i);
                ps.setString(2, String.valueOf(i) + " s");
                ps.setBytes(3, new byte[] {
                    (byte) i, ' ', (byte) i
                });
                ps.execute();
            }

            connection.setAutoCommit(false);

            statement =
                connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                           ResultSet.CONCUR_READ_ONLY);

            ResultSet srs = statement.executeQuery("select * from t1 limit 2");

            srs.afterLast();

            while (srs.previous()) {
                String name = srs.getString(2);
                float  id   = srs.getFloat(1);

                System.out.println(name + "   " + id);
            }

            srs.close();

            srs = statement.executeQuery("select * from t1 limit 2");

            srs.absolute(3);

            while (srs.previous()) {
                String name = srs.getString(2);
                float  id   = srs.getFloat(1);

                System.out.println(name + "   " + id);
            }

            srs.absolute(2);

            while (srs.previous()) {
                String name = srs.getString(2);
                float  id   = srs.getFloat(1);

                System.out.println(name + "   " + id);
            }

            srs.absolute(-1);

            while (srs.previous()) {
                String name = srs.getString(2);
                float  id   = srs.getFloat(1);

                System.out.println(name + "   " + id);
            }

            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

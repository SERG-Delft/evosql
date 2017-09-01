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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import org.hsqldb.lib.StopWatch;
import java.math.BigDecimal;

/**
 * Test large tables containing columns of different types.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 */
public class TestAllTypes {

    protected String url = "jdbc:hsqldb:g:/hsql/testalltypes/test;hsqldb.sqllog=0";

//    protected String url = "jdbc:hsqldb:hsql://localhost/yourtest";
    boolean    network = false;
    String     user;
    String     password;
    Statement  sStatement;
    Connection cConnection;

    // prameters
    boolean reportProgress  = true;
    boolean cachedTable     = true;
    int     cacheScale      = 12;
    int     logType         = 1;
    int     writeDelay      = 60;
    boolean indexZip        = true;
    boolean indexLastName   = false;
    boolean addForeignKey   = false;
    boolean refIntegrity    = true;
    boolean createTempTable = false;

    // introduces fragmentation to the .data file
    boolean deleteWhileInsert         = false;
    int     deleteWhileInsertInterval = 10000;

    //
    int bigrows = 1024 * 1024;

    protected void setUp() {

        user     = "sa";
        password = "";

        try {
            sStatement  = null;
            cConnection = null;

            Class.forName("org.hsqldb.jdbc.JDBCDriver");

            boolean createDatabase = true;

            if (createDatabase) {
                cConnection = DriverManager.getConnection(url, user, password);
                sStatement  = cConnection.createStatement();

                sStatement.execute("SET DATABASE EVENT LOG LEVEL 3");
                sStatement.execute("SET FILES LOG SIZE " + 100);
                sStatement.execute("SET FILES LOG TRUE");
                sStatement.execute("SET FILES WRITE DELAY " + writeDelay);
                sStatement.execute("SET FILES CACHE ROWS 600000");
                sStatement.execute("SET FILES CACHE SIZE 240000");
                sStatement.execute("SHUTDOWN");
                cConnection.close();

                cConnection = DriverManager.getConnection(url, user, password);
                sStatement  = cConnection.createStatement();
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("TestSql.setUp() error: " + e.getMessage());
        }
    }

    /**
     * Fill up the cache
     *
     *
     */
    public void testFillUp() {

        StopWatch sw        = new StopWatch();
        int       smallrows = 0xfff;
        double    value     = 0;
        String ddl1 = "DROP TABLE test IF EXISTS;"
                      + "DROP TABLE zip IF EXISTS;";
        String ddl2 = "CREATE TABLE zip( zip INT IDENTITY );";
        String ddl3 = "CREATE " + (cachedTable ? "CACHED "
                                               : "") + "TABLE test( id INT IDENTITY,"
                                                   + " firstname VARCHAR(128), "
                                                   + " lastname VARCHAR(128), "
                                                   + " zip SMALLINT, "
                                                   + " longfield BIGINT, "
                                                   + " doublefield DOUBLE, "
                                                   + " bigdecimalfield DECIMAL(19), "
                                                   + " bigdecimal2field DECIMAL(20,4), "
                                                   + " datefield DATE, "
                                                   + " filler VARCHAR(128)); ";

        // adding extra index will slow down inserts a bit
        String ddl4 = "CREATE INDEX idx1 ON TEST (lastname);";

        // adding this index will slow down  inserts a lot
        String ddl5 = "CREATE INDEX idx2 ON TEST (zip);";

        // adding this index will slow down  inserts a lot
        String ddl6 = "CREATE INDEX idx3 ON TEST (longfield);";

        // adding this index will slow down  inserts a lot
        String ddl7 = "CREATE INDEX idx4 ON TEST (bigdecimalfield);";

        String ddl8 = "CREATE INDEX idx5 ON TEST (bigdecimal2field);";
        String ddl9 = "CREATE INDEX idx6 ON TEST (datefield);";
        // referential integrity checks will slow down inserts a bit
        String ddl26 =
            "ALTER TABLE test add constraint c1 FOREIGN KEY (zip) REFERENCES zip(zip);";
        String filler = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";

        try {
            System.out.println("Connecting");
            sw.zero();

            cConnection = null;
            sStatement  = null;
            cConnection = DriverManager.getConnection(url, user, password);

            System.out.println("connected: " + sw.elapsedTime());
            sw.zero();

            sStatement = cConnection.createStatement();

            java.util.Random randomgen = new java.util.Random();

            sStatement.execute(ddl1);
            sStatement.execute(ddl2);
            sStatement.execute(ddl3);
            System.out.println("test table with no index");

            if (indexLastName) {
                sStatement.execute(ddl4);
                System.out.println("create index on lastname");
            }

            if (indexZip) {
                sStatement.execute(ddl5);
                System.out.println("create index on zip");
            }

            if (addForeignKey) {
                sStatement.execute(ddl26);
                System.out.println("add foreign key");
            }

            //

            sStatement.execute(ddl6);
            sStatement.execute(ddl7);
            sStatement.execute(ddl8);
            sStatement.execute(ddl9);

            int i;

            for (i = 0; i <= smallrows; i++) {
                sStatement.execute("INSERT INTO zip VALUES(null);");
            }

            PreparedStatement ps = cConnection.prepareStatement(
                "INSERT INTO test (firstname,lastname,zip,longfield,doublefield,bigdecimalfield,bigdecimal2field,datefield, filler) VALUES (?,?,?,?,?,?,?,?, ?)");

            ps.setString(1, "Julia                 ");
            ps.setString(2, "Clancy");

            for (i = 0; i < bigrows; i++) {
                ps.setInt(3, nextIntRandom(randomgen, smallrows));

                int nextrandom   = nextIntRandom(randomgen, filler.length());
                int randomlength = nextIntRandom(randomgen, filler.length());

                ps.setLong(4, randomgen.nextLong());
                ps.setDouble(5, randomgen.nextDouble());
                ps.setBigDecimal(6, new BigDecimal(randomgen.nextLong()));

                ps.setBigDecimal(7, new BigDecimal(randomgen.nextDouble()));
                ps.setDate(8, new java.sql.Date(nextIntRandom(randomgen, 1000)
                                                * 24L * 3600 * 1000));

                String varfiller = filler.substring(0, randomlength);

                ps.setString(9, nextrandom + varfiller);
                ps.execute();

                if (reportProgress && (i + 1) % 10000 == 0) {
                    System.out.println("Insert " + (i + 1) + " : "
                                       + sw.elapsedTime());
                }

                // delete and add 4000 rows to introduce fragmentation
                if (deleteWhileInsert && i != 0
                        && i % deleteWhileInsertInterval == 0) {
                    sStatement.execute("CALL IDENTITY();");

                    ResultSet rs = sStatement.getResultSet();

                    rs.next();

                    int lastId = rs.getInt(1);

                    sStatement.execute(
                        "SELECT * INTO TEMP tempt FROM test WHERE id > "
                        + (lastId - 4000) + " ;");
                    sStatement.execute("DELETE FROM test WHERE id > "
                                       + (lastId - 4000) + " ;");
                    sStatement.execute(
                        "INSERT INTO test SELECT * FROM tempt;");
                    sStatement.execute("DROP TABLE tempt;");
                }
            }

//            sStatement.execute("INSERT INTO test SELECT * FROM temptest;");
//            sStatement.execute("DROP TABLE temptest;");
//            sStatement.execute(ddl7);
            System.out.println("Total insert: " + i);
            System.out.println("Insert time: " + sw.elapsedTime() + " rps: "
                               + (i * 1000 / sw.elapsedTime()));
            sw.zero();

            if (!network) {
                sStatement.execute("SHUTDOWN");
            }

            cConnection.close();
            System.out.println("Shutdown Time: " + sw.elapsedTime());
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    protected void tearDown() {}

    protected void checkResults() {

        try {
            StopWatch sw = new StopWatch();
            ResultSet rs;

            cConnection = DriverManager.getConnection(url, user, password);

            System.out.println("Reopened database: " + sw.elapsedTime());
            sw.zero();

            sStatement = cConnection.createStatement();

            sStatement.execute("SET FILES WRITE DELAY " + writeDelay);
//            sStatement.execute("SET DATABASE EVENT LOG SQL LEVEL 3");

            // the tests use different indexes
            // use primary index
            sStatement.execute("SELECT count(*) from TEST");

            rs = sStatement.getResultSet();

            rs.next();
            System.out.println("Row Count: " + rs.getInt(1));
            System.out.println("Time to count: " + sw.elapsedTime());

            // use index on zip
            sw.zero();
            sStatement.execute("SELECT count(*) from TEST where zip > -1");

            rs = sStatement.getResultSet();

            rs.next();
            System.out.println("Row Count: " + rs.getInt(1));
            System.out.println("Time to count: " + sw.elapsedTime());
            checkSelects();
            checkUpdates();
            sw.zero();
            cConnection.close();
            System.out.println("Closed connection: " + sw.elapsedTime());
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private void checkSelects() {

        StopWatch        sw        = new StopWatch();
        int              smallrows = 0xfff;
        java.util.Random randomgen = new java.util.Random();
        int              i         = 0;
        boolean          slow      = false;

        try {
            for (; i < bigrows / 4; i++) {
                PreparedStatement ps = cConnection.prepareStatement(
                    "SELECT TOP 1 firstname,lastname,zip,filler FROM test WHERE zip = ?");

                ps.setInt(1, nextIntRandom(randomgen, smallrows));
                ps.execute();

                if ((i + 1) == 100 && sw.elapsedTime() > 5000) {
                    slow = true;
                }

                if (reportProgress && (i + 1) % 10000 == 0
                        || (slow && (i + 1) % 100 == 0)) {
                    System.out.println("Select " + (i + 1) + " : "
                                       + sw.elapsedTime() + " rps: "
                                       + (i * 1000 / sw.elapsedTime()));
                }
            }
        } catch (SQLException e) {}

        System.out.println("Select random zip " + i + " rows : "
                           + sw.elapsedTime() + " rps: "
                           + (i * 1000 / sw.elapsedTime()));
        sw.zero();

        try {
            for (i = 0; i < bigrows / 4; i++) {
                PreparedStatement ps = cConnection.prepareStatement(
                    "SELECT firstname,lastname,zip,filler FROM test WHERE id = ?");

                ps.setInt(1, nextIntRandom(randomgen, bigrows - 1));
                ps.execute();

                if (reportProgress && (i + 1) % 10000 == 0
                        || (slow && (i + 1) % 100 == 0)) {
                    System.out.println("Select " + (i + 1) + " : "
                                       + sw.elapsedTime());
                }
            }
        } catch (SQLException e) {}

        System.out.println("Select random id " + i + " rows : "
                           + sw.elapsedTime() + " rps: "
                           + (i * 1000 / sw.elapsedTime()));
    }

    private void checkUpdates() {

        StopWatch        sw        = new StopWatch();
        int              smallrows = 0xfff;
        java.util.Random randomgen = new java.util.Random();
        int              i         = 0;
        boolean          slow      = false;
        int              count     = 0;

        try {
            for (; i < smallrows; i++) {
                PreparedStatement ps = cConnection.prepareStatement(
                    "UPDATE test SET filler = filler || zip WHERE zip = ?");
                int random = nextIntRandom(randomgen, smallrows - 1);

                ps.setInt(1, random);

                count += ps.executeUpdate();

                if (reportProgress && count % 10000 < 20) {
                    System.out.println("Update " + count + " : "
                                       + sw.elapsedTime());
                }
            }
        } catch (SQLException e) {}

        System.out.println("Update with random zip " + i
                           + " UPDATE commands, " + count + " rows : "
                           + sw.elapsedTime() + " rps: "
                           + (count * 1000 / (sw.elapsedTime() + 1)));
        sw.zero();

        try {
            for (i = 0; i < bigrows / 8; i++) {
                PreparedStatement ps = cConnection.prepareStatement(
                    "UPDATE test SET zip = zip + 1 WHERE id = ?");
                int random = nextIntRandom(randomgen, bigrows - 1);

                ps.setInt(1, random);
                ps.execute();

                if (reportProgress && (i + 1) % 10000 == 0
                        || (slow && (i + 1) % 100 == 0)) {
                    System.out.println("Update " + (i + 1) + " : "
                                       + sw.elapsedTime() + " rps: "
                                       + (i * 1000 / sw.elapsedTime()));
                }
            }
        } catch (SQLException e) {}

        System.out.println("Update with random id " + i + " rows : "
                           + sw.elapsedTime() + " rps: "
                           + (i * 1000 / (sw.elapsedTime() + 1)));
    }

    int nextIntRandom(Random r, int range) {

        int b = r.nextInt();

        if (b == Integer.MIN_VALUE) {
            b = Integer.MAX_VALUE;
        }

        b = Math.abs(b);

        return b % range;
    }

    public static void main(String[] argv) {

        StopWatch    sw   = new StopWatch();
        TestAllTypes test = new TestAllTypes();

        test.setUp();
        test.testFillUp();

//        test.tearDown();
        test.checkResults();
        System.out.println("Total Test Time: " + sw.elapsedTime());
    }
}

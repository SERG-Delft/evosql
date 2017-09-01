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

// nbazin@users - enhancements to the original code
// fredt@users - 20050202 - corrected getRandomID(int) to return a randomly distributed value
/*
 *  This is a sample implementation of the Transaction Processing Performance
 *  Council Benchmark B coded in Java and ANSI SQL2.
 *
 *  This version is using one connection per thread to parallellize
 *  server operations.
 * @author Mark Matthews (mark@mysql.com)
 */
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Vector;
import java.sql.CallableStatement;

class TestBench {

    /* tpc bm b scaling rules */
    public static int tps       = 1;                     /* the tps scaling factor: here it is 1 */
    public static int nbranches = 1;                     /* number of branches in 1 tps db       */
    public static int ntellers  = 10;                    /* number of tellers in  1 tps db       */
    public static int naccounts = 100000;                /* number of accounts in 1 tps db       */
    public static int nhistory = 864000;                 /* number of history recs in 1 tps db   */
    public static int       rounds              = 10;    /* number of rounds to run the test     */
    public static final int TELLER              = 0;
    public static final int BRANCH              = 1;
    public static final int ACCOUNT             = 2;
    int                     failed_transactions = 0;
    int                     transaction_count   = 0;
    static int              n_clients           = 10;
    static int              n_txn_per_client    = 10;
    static boolean          count_results       = false;
    long                    start_time          = 0;
    static String           tableExtension      = "";
    static String           createExtension     = "";
    static String           ShutdownCommand     = "";
    static boolean          useStoredProcedure  = false;
    static boolean          verbose             = true;
    MemoryWatcherThread     MemoryWatcher;

    /* main program,    creates a 1-tps database:  i.e. 1 branch, 10 tellers,...
     *                    runs one TPC BM B transaction
     * example command line:
     * -driver  org.hsqldb.jdbc.JDBCDriver -url jdbc:hsqldb:/hsql/jdbcbench/test -user SA -clients 20 -tpc 10000
     */
    public static void main(String[] Args) {

        String  DriverName         = "";
        String  DBUrl              = "";
        String  DBUser             = "";
        String  DBPassword         = "";
        boolean initialize_dataset = true;

        for (int i = 0; i < Args.length; i++) {
            if (Args[i].equals("-clients")) {
                if (i + 1 < Args.length) {
                    i++;

                    n_clients = Integer.parseInt(Args[i]);
                }
            } else if (Args[i].equals("-driver")) {
                if (i + 1 < Args.length) {
                    i++;

                    DriverName = Args[i];
                }
            } else if (Args[i].equals("-url")) {
                if (i + 1 < Args.length) {
                    i++;

                    DBUrl = Args[i];
                }
            } else if (Args[i].equals("-user")) {
                if (i + 1 < Args.length) {
                    i++;

                    DBUser = Args[i];
                }
            } else if (Args[i].equals("-password")) {
                if (i + 1 < Args.length) {
                    i++;

                    DBPassword = Args[i];
                }
            } else if (Args[i].equals("-tpc")) {
                if (i + 1 < Args.length) {
                    i++;

                    n_txn_per_client = Integer.parseInt(Args[i]);
                }
            } else if (Args[i].equals("-init")) {
                initialize_dataset = true;
            } else if (Args[i].equals("-tps")) {
                if (i + 1 < Args.length) {
                    i++;

                    tps = Integer.parseInt(Args[i]);
                }
            } else if (Args[i].equals("-rounds")) {
                if (i + 1 < Args.length) {
                    i++;

                    rounds = Integer.parseInt(Args[i]);
                }
            } else if (Args[i].equals("-sp")) {
                useStoredProcedure = true;
            } else if (Args[i].equals("-v")) {
                verbose = true;
            }
        }

        if (DriverName.length() == 0 || DBUrl.length() == 0) {
            System.out.println(
                "usage: java TestBench -driver [driver_class_name] -url [url_to_db] -user [username] -password [password] [-v] [-init] [-tpc n] [-clients n]");
            System.out.println();
            System.out.println("-v          verbose error messages");
            System.out.println("-init       initialize the tables");
            System.out.println("-tpc        transactions per client");
            System.out.println("-clients    number of simultaneous clients");
            System.exit(-1);
        }

        System.out.println(
            "*********************************************************");
        System.out.println(
            "* TestBench v1.1                                        *");
        System.out.println(
            "*********************************************************");
        System.out.println();
        System.out.println("Driver: " + DriverName);
        System.out.println("URL:" + DBUrl);
        System.out.println();
        System.out.println("Scale factor value: " + tps);
        System.out.println("Number of clients: " + n_clients);
        System.out.println("Number of transactions per client: "
                           + n_txn_per_client);
        System.out.println("Execution rounds: " + rounds);
        System.out.println();

        if (DriverName.equals("org.hsqldb.jdbc.JDBCDriver")
                || DriverName.equals("org.hsqldb.jdbcDriver")) {
            if (!DBUrl.contains("mem:")) {
                ShutdownCommand = "SHUTDOWN";
            }
        }

        try {
            Class.forName(DriverName);

            TestBench Me = new TestBench(DBUrl, DBUser, DBPassword,
                                         initialize_dataset);
        } catch (Exception E) {
            System.out.println(E.getMessage());
            E.printStackTrace();
        }
    }

    public TestBench(String url, String user, String password, boolean init) {

        Vector      vClient  = new Vector();
        Thread      Client   = null;
        Enumeration e        = null;
        Connection  guardian = null;

        try {
            java.util.Date start = new java.util.Date();

            if (init) {
                System.out.println("Start: " + start.toString());
                System.out.print("Initializing dataset...");
                createDatabase(url, user, password);

                double seconds = (System.currentTimeMillis() - start.getTime())
                                 / 1000D;

                System.out.println("done. in " + seconds + " seconds\n");
                System.out.println("Complete: "
                                   + (new java.util.Date()).toString());
            }

            System.out.println("* Starting Benchmark Run *");

            MemoryWatcher = new MemoryWatcherThread();

            MemoryWatcher.start();

            guardian  = connect(url, user, password);
            checkSums(guardian);

            long startTime = System.currentTimeMillis();

            for (int i = 0; i < rounds; i++) {
                oneRound(url, user, password);
            }

            long tempTime = System.currentTimeMillis() - startTime;

            startTime = System.currentTimeMillis();
            guardian  = connect(url, user, password);

            checkSums(guardian);
            connectClose(guardian);
            System.out.println("Total time: " + tempTime / 1000D + " seconds");
            System.out.println(
                "sum check time: "
                + (System.currentTimeMillis() - startTime)
                + " milliseconds");
        } catch (Exception E) {
            System.out.println(E.getMessage());
            E.printStackTrace();
        } finally {
            MemoryWatcher.end();

            try {
                MemoryWatcher.join();

                if (ShutdownCommand.length() > 0) {
                    guardian = connect(url, user, password);

                    Statement Stmt = guardian.createStatement();

                    Stmt.execute(ShutdownCommand);
                    Stmt.close();
                    connectClose(guardian);
                }
            } catch (Exception E1) {}

//            System.exit(0);
        }
    }

    void oneRound(String url, String user,
                  String password) throws InterruptedException, SQLException {

        Vector      vClient  = new Vector();
        Thread      Client   = null;
        Enumeration e        = null;
        Connection  guardian = null;

        //
        start_time = System.currentTimeMillis();

        for (int i = 0; i < n_clients; i++) {
            if (useStoredProcedure) {
                Client = new ClientThreadProcedure(
                    n_txn_per_client, url, user, password,
                    Connection.TRANSACTION_READ_COMMITTED);
            } else {
                Client =
                    new ClientThread(n_txn_per_client, url, user, password,
                                     Connection.TRANSACTION_READ_COMMITTED);
            }

            Client.start();
            vClient.addElement(Client);
        }

        /*
         ** Barrier to complete this test session
         */
        e = vClient.elements();

        while (e.hasMoreElements()) {
            Client = (Thread) e.nextElement();

            Client.join();
        }

        vClient.removeAllElements();
        reportDone();

        guardian = connect(url, user, password);

        if (count_results) {
            checkSums(guardian);
        }

        connectClose(guardian);
    }

    public void reportDone() {

        long end_time = System.currentTimeMillis();
        double completion_time = ((double) end_time - (double) start_time)
                                 / 1000;

        System.out.println("\n* Benchmark Report *");
        System.out.println("\n--------------------");
        System.out.println("Time to execute " + transaction_count
                           + " transactions: " + completion_time
                           + " seconds.");
        System.out.println("Max/Min memory usage: "
                           + (MemoryWatcher.max / 1024) + " / "
                           + (MemoryWatcher.min / 1024) + " kb");
        System.out.println(failed_transactions + " / " + transaction_count
                           + " failed to complete.");

        double rate = (transaction_count - failed_transactions)
                      / completion_time;

        System.out.println("Transaction rate: " + rate + " txn/sec.");
        System.out.print((MemoryWatcher.max / 1024) + ";"
                         + (MemoryWatcher.min / 1024) + ";"
                         + failed_transactions + ";" + rate + "\n");

        transaction_count   = 0;
        failed_transactions = 0;

        MemoryWatcher.reset();
    }

    public synchronized void incrementTransactionCount() {
        transaction_count++;
    }

    public synchronized void incrementFailedTransactionCount() {
        failed_transactions++;
    }

    void createDatabase(String url, String user,
                        String password) throws Exception {

        Connection Conn = connect(url, user, password);
        String     s    = Conn.getMetaData().getDatabaseProductName();

        System.out.println("DBMS: " + s);

        try {
            Conn.setAutoCommit(false);
            System.out.println("In transaction mode");
        } catch (SQLException Etrxn) {}

        try {
            int       accountsnb = 0;
            Statement Stmt       = Conn.createStatement();
            String    Query;

//
//            Stmt.execute("SET WRITE_DELAY 1000 MILLIS;");
//            Stmt.execute("SET DATABASE DEFAULT TABLE TYPE CACHED");
//
            Query = "SELECT count(*) ";
            Query += "FROM   accounts";

            ResultSet RS = Stmt.executeQuery(Query);

            Stmt.clearWarnings();

            while (RS.next()) {
                accountsnb = RS.getInt(1);
            }

            Conn.commit();
            Stmt.close();

            if (accountsnb == (naccounts * tps)) {
                System.out.println("Already initialized");
                connectClose(Conn);

                return;
            }
        } catch (Exception E) {}

        System.out.println("Drop old tables if they exist");

        try {
            Statement Stmt = Conn.createStatement();
            String    Query;

            if (url.contains("hsqldb")) {
                try {
                    Query = "DROP PROCEDURE UPDATE_PROC";

                    Stmt.execute(Query);
                } catch (Exception e) {}
            }

            Query = "DROP TABLE history";

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "DROP TABLE accounts";

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "DROP TABLE tellers";

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "DROP TABLE branches";

            Stmt.execute(Query);
            Stmt.clearWarnings();
            Conn.commit();
            Stmt.close();
        } catch (Exception e) {
        }

        System.out.println("Creates tables");

        try {
            Statement Stmt = Conn.createStatement();
            String    Query;

            Query = "CREATE TABLE branches ( "
                    + "Bid         INTEGER NOT NULL PRIMARY KEY, "
                    + "Bbalance    INTEGER," + "filler      VARCHAR(88))";    /* pad to 100 bytes */

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "CREATE TABLE tellers ("
                    + "Tid         INTEGER NOT NULL PRIMARY KEY,"
                    + "Bid         INTEGER," + "Tbalance    INTEGER,"
                    + "filler      VARCHAR(84))";                             /* pad to 100 bytes */

            if (createExtension.length() > 0) {
                Query += createExtension;
            }

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "CREATE TABLE accounts ("
                    + "Aid         INTEGER NOT NULL PRIMARY KEY, "
                    + "Bid         INTEGER, " + "Abalance    INTEGER, "
                    + "filler      VARCHAR(84))";                             /* pad to 100 bytes */

            if (createExtension.length() > 0) {
                Query += createExtension;
            }

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "CREATE TABLE history (" + "Tid         INTEGER, "
                    + "Bid         INTEGER, " + "Aid         INTEGER, "
                    + "delta       INTEGER, " + "tstime        TIMESTAMP, "
                    + "filler      VARCHAR(22))";                             /* pad to 50 bytes  */

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query =
                "CREATE PROCEDURE UPDATE_PROC(IN paid INT, IN ptid INT, IN pbid INT, IN pdelta INT, OUT pbalance INT) "
                + "MODIFIES SQL DATA BEGIN ATOMIC "
                + "DECLARE account CURSOR WITH RETURN FOR SELECT Abalance FROM accounts WHERE  Aid = paid;"
                + "UPDATE accounts SET Abalance = abalance + pdelta WHERE  aid = paid;"
                + "OPEN account;"
                + "SELECT Abalance INTO pbalance FROM  accounts WHERE  Aid = paid;"
                + "UPDATE tellers SET Tbalance = Tbalance + pdelta WHERE  Tid = ptid;"
                + "UPDATE branches SET Bbalance = Bbalance + pdelta WHERE  Bid = pbid;"
                + "INSERT INTO history(Tid, Bid, Aid, delta) VALUES (ptid,pbid,paid,pdelta);"
                + "END";

            try {
                if (url.contains("hsqldb")) {
                    Stmt.execute(Query);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

/*
            Stmt.execute("SET TABLE ACCOUNTS SOURCE \"ACCOUNTS.TXT\"");
            Stmt.execute("SET TABLE BRANCHES SOURCE \"BBRANCHES.TXT\"");
            Stmt.execute("SET TABLE TELLERS SOURCE \"TELLERS.TXT\"");
            Stmt.execute("SET TABLE HISTORY SOURCE \"HISTORY.TXT\"");
*/
            Conn.commit();
            Stmt.close();
        } catch (Exception E) {
            System.out.println(
                "Delete elements in table in case Drop didn't work");
        }

        try {
            Statement Stmt = Conn.createStatement();
            String    Query;

            Query = "DELETE FROM history";

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "DELETE FROM accounts";

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "DELETE FROM tellers";

            Stmt.execute(Query);
            Stmt.clearWarnings();

            Query = "DELETE FROM branches";

            Stmt.execute(Query);
            Stmt.clearWarnings();
            Conn.commit();

            /* prime database using TPC BM B scaling rules.
             **  Note that for each branch and teller:
             **      branch_id = teller_id  / ntellers
             **      branch_id = account_id / naccounts
             */
            PreparedStatement pstmt = null;

            Query = "INSERT INTO branches(Bid,Bbalance) VALUES (?,0)";
            pstmt = Conn.prepareStatement(Query);

            System.out.println("Insert data in branches table");

            for (int i = 0; i < nbranches * tps; i++) {
                pstmt.setInt(1, i);
                pstmt.executeUpdate();
                pstmt.clearWarnings();

                if (i % 100 == 0) {
                    Conn.commit();
                }
            }

            pstmt.close();
            Conn.commit();

            Query = "INSERT INTO tellers(Tid,Bid,Tbalance) VALUES (?,?,0)";
            pstmt = Conn.prepareStatement(Query);

            System.out.println("Insert data in tellers table");

            for (int i = 0; i < ntellers * tps; i++) {
                pstmt.setInt(1, i);
                pstmt.setInt(2, i / ntellers);
                pstmt.executeUpdate();
                pstmt.clearWarnings();

                if (i % 100 == 0) {
                    Conn.commit();
                }
            }

            pstmt.close();
            Conn.commit();

            Query = "INSERT INTO accounts(Aid,Bid,Abalance) VALUES (?,?,0)";
            pstmt = Conn.prepareStatement(Query);

            System.out.println("Insert data in accounts table");

            for (int i = 0; i < naccounts * tps; i++) {
                pstmt.setInt(1, i);
                pstmt.setInt(2, i / naccounts);
                pstmt.executeUpdate();
                pstmt.clearWarnings();

                if (i % 10000 == 0) {
                    Conn.commit();
                }

                if ((i > 0) && ((i % 100000) == 0)) {
                    System.out.println("\t" + i + "\t records inserted");
                }
            }

            pstmt.close();
            Conn.commit();
            System.out.println("\t" + (naccounts * tps)
                               + "\t records inserted");

            // for tests
            if (ShutdownCommand.length() > 0) {
                Stmt.execute(ShutdownCommand);
                System.out.println("database shutdown");
            }

            Stmt.close();
        } catch (Exception E) {
            System.out.println(E.getMessage());
            E.printStackTrace();
        }

        connectClose(Conn);
    }    /* end of CreateDatabase    */

    public static int getRandomInt(int lo, int hi) {

        int ret = 0;

        ret = (int) (Math.random() * (hi - lo + 1));
        ret += lo;

        return ret;
    }

    public static int getRandomID(int type) {

        int min = 0,
            max = 0;

        switch (type) {

            case TELLER :
                max = ntellers * tps - 1;
                break;

            case BRANCH :
                max = nbranches * tps - 1;
                break;

            case ACCOUNT :
                max = naccounts * tps - 1;
                break;
        }

        return (getRandomInt(min, max));
    }

    public static Connection connect(String DBUrl, String DBUser,
                                     String DBPassword) {

        try {
            Connection conn = DriverManager.getConnection(DBUrl, DBUser,
                DBPassword);

            return conn;
        } catch (Exception E) {
            System.out.println(E.getMessage());
            E.printStackTrace();
        }

        return null;
    }

    public static void connectClose(Connection c) {

        if (c == null) {
            return;
        }

        try {
            c.close();
        } catch (Exception E) {
            System.out.println(E.getMessage());
            E.printStackTrace();
        }
    }

    void checkSums(Connection conn) throws SQLException {

        Statement st1 = null;
        ResultSet rs  = null;
        int       bbalancesum;
        int       tbalancesum;
        int       abalancesum;
        int       abalancecount;
        int       deltasum;

        try {
            st1 = conn.createStatement();
            rs  = st1.executeQuery("select sum(bbalance) from branches");

            rs.next();

            bbalancesum = rs.getInt(1);

            rs.close();

            rs = st1.executeQuery("select sum(tbalance) from tellers");

            rs.next();

            tbalancesum = rs.getInt(1);

            rs.close();

            rs = st1.executeQuery(
                "select sum(abalance), count(abalance) from accounts");

            rs.next();

            abalancesum   = rs.getInt(1);
            abalancecount = rs.getInt(2);

            rs.close();

            rs = st1.executeQuery("select sum(delta) from history");

            rs.next();

            deltasum = rs.getInt(1);

            rs.close();

            rs = null;

            st1.close();

            st1 = null;

            conn.commit();

            if (abalancesum != bbalancesum || bbalancesum != tbalancesum
                    || tbalancesum != deltasum) {
                System.out.println("sums don't match!");
            } else {
                System.out.println("sums match!");
            }

            System.out.println("AC " + abalancecount + " A " + abalancesum
                               + " B " + bbalancesum + " T " + tbalancesum
                               + " H " + deltasum);
        } finally {
            if (st1 != null) {
                st1.close();
            }
        }
    }

    class ClientThread extends Thread {

        int               ntrans = 0;
        Connection        Conn;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        PreparedStatement pstmt4 = null;
        PreparedStatement pstmt5 = null;

        public ClientThread(int number_of_txns, String url, String user,
                            String password, int transactionMode) {

            System.out.println(number_of_txns);

            ntrans = number_of_txns;
            Conn   = connect(url, user, password);

            if (Conn == null) {
                return;
            }

            try {
                Conn.setAutoCommit(false);
                Conn.setTransactionIsolation(transactionMode);
                prepareStatements();
            } catch (Exception E) {
                System.out.println(E.getMessage());
                E.printStackTrace();
            }
        }

        void prepareStatements() throws SQLException {

            String Query;

            Query =
                "UPDATE accounts SET Abalance = Abalance + ? WHERE  Aid = ?";
            pstmt1 = Conn.prepareStatement(Query);
            Query  = "SELECT Abalance FROM   accounts WHERE  Aid = ?";
            pstmt2 = Conn.prepareStatement(Query);
            Query =
                "UPDATE tellers SET Tbalance = Tbalance + ? WHERE  Tid = ?";
            pstmt3 = Conn.prepareStatement(Query);
            Query =
                "UPDATE branches SET Bbalance = Bbalance + ? WHERE  Bid = ?";
            pstmt4 = Conn.prepareStatement(Query);
            Query =
                "INSERT INTO history(Tid, Bid, Aid, delta) VALUES (?,?,?,?)";
            pstmt5 = Conn.prepareStatement(Query);
        }

        public void run() {

            int count = ntrans;

            while (count-- > 0) {
                int account = TestBench.getRandomID(ACCOUNT);
                int branch  = TestBench.getRandomID(BRANCH);
                int teller  = TestBench.getRandomID(TELLER);
                int delta   = TestBench.getRandomInt(-1000, 1000);

                doOne(branch, teller, account, delta);
                incrementTransactionCount();
            }

/*
            count = ntrans * 20;

            try {
                Conn.setReadOnly(true);
                while (count-- > 0) {
                    int account = TestBench.getRandomID(ACCOUNT);

                    pstmt2.setInt(1, account);
                    pstmt2.executeQuery();
                    Conn.commit();
                    incrementTransactionCount();
                }
            } catch (SQLException e) {}
*/
            try {
                if (pstmt1 != null) {
                    pstmt1.close();
                }

                if (pstmt2 != null) {
                    pstmt2.close();
                }

                if (pstmt3 != null) {
                    pstmt3.close();
                }

                if (pstmt4 != null) {
                    pstmt4.close();
                }

                if (pstmt5 != null) {
                    pstmt5.close();
                }
            } catch (Exception E) {
                System.out.println(E.getMessage());
                E.printStackTrace();
            }

            connectClose(Conn);

            Conn = null;
        }

        /*
         **  doOne() - Executes a single TPC BM B transaction.
         */
        int doOne(int bid, int tid, int aid, int delta) {

            int aBalance = 0;

            if (Conn == null) {
                incrementFailedTransactionCount();

                return 0;
            }

            try {
                pstmt1.setInt(1, delta);
                pstmt1.setInt(2, aid);
                pstmt1.executeUpdate();
                pstmt1.clearWarnings();
                pstmt2.setInt(1, aid);

                ResultSet RS = pstmt2.executeQuery();

                pstmt2.clearWarnings();

                while (RS.next()) {
                    aBalance = RS.getInt(1);
                }

                pstmt3.setInt(1, delta);
                pstmt3.setInt(2, tid);
                pstmt3.executeUpdate();
                pstmt3.clearWarnings();
                pstmt4.setInt(1, delta);
                pstmt4.setInt(2, bid);
                pstmt4.executeUpdate();
                pstmt4.clearWarnings();
                pstmt5.setInt(1, tid);
                pstmt5.setInt(2, bid);
                pstmt5.setInt(3, aid);
                pstmt5.setInt(4, delta);
                pstmt5.executeUpdate();
                pstmt5.clearWarnings();
                Conn.commit();

                return aBalance;
            } catch (Exception E) {
                if (verbose) {
                    System.out.println("Transaction failed: "
                                       + E.getMessage());
                    E.printStackTrace();
                }

                incrementFailedTransactionCount();

                try {
                    Conn.rollback();
                } catch (SQLException E1) {}
            }

            return 0;
        }    /* end of DoOne         */
    }    /* end of class ClientThread */

    class ClientThreadProcedure extends Thread {

        int               ntrans = 0;
        Connection        Conn;
        CallableStatement pstmt1 = null;

        public ClientThreadProcedure(int number_of_txns, String url,
                                     String user, String password,
                                     int transactionMode) {

            System.out.println(number_of_txns);

            ntrans = number_of_txns;
            Conn   = connect(url, user, password);

            if (Conn == null) {
                return;
            }

            try {
                Conn.setAutoCommit(false);
                Conn.setTransactionIsolation(transactionMode);
                prepareStatements();
            } catch (Exception E) {
                System.out.println(E.getMessage());
                E.printStackTrace();
            }
        }

        void prepareStatements() throws SQLException {

            String Query;

            Query  = "CALL UPDATE_PROC(?, ?, ?, ?, ?)";
            pstmt1 = Conn.prepareCall(Query);
        }

        public void run() {

            int count = ntrans;

            while (count-- > 0) {
                int account = TestBench.getRandomID(ACCOUNT);
                int branch  = TestBench.getRandomID(BRANCH);
                int teller  = TestBench.getRandomID(TELLER);
                int delta   = TestBench.getRandomInt(-1000, 1000);

                doOne(branch, teller, account, delta);
                incrementTransactionCount();
            }

            try {
                if (pstmt1 != null) {
                    pstmt1.close();
                }
            } catch (Exception E) {
                System.out.println(E.getMessage());
                E.printStackTrace();
            }

            connectClose(Conn);

            Conn = null;
        }

        /*
         **  doOne() - Executes a single TPC BM B transaction.
         */
        int doOne(int bid, int tid, int aid, int delta) {

            int aBalance = 0;

            if (Conn == null) {
                incrementFailedTransactionCount();

                return 0;
            }

            try {
                pstmt1.setInt(1, aid);
                pstmt1.setInt(2, tid);
                pstmt1.setInt(3, bid);
                pstmt1.setInt(4, delta);
                pstmt1.execute();

                ResultSet rs = pstmt1.getResultSet();

                while (rs.next()) {
                    aBalance = rs.getInt(1);
                }

                rs.close();
                pstmt1.clearWarnings();
                Conn.commit();

                return aBalance;
            } catch (Exception E) {
                if (verbose) {
                    System.out.println("Transaction failed: "
                                       + E.getMessage());
                    E.printStackTrace();
                }

                incrementFailedTransactionCount();

                try {
                    Conn.rollback();
                } catch (SQLException E1) {}
            }

            return 0;
        }    /* end of DoOne         */
    }    /* end of class ClientThread */

    class MemoryWatcherThread extends Thread {

        long    min          = 0;
        long    max          = 0;
        boolean keep_running = true;

        public MemoryWatcherThread() {

            this.reset();

            keep_running = true;
        }

        public void reset() {

            System.gc();

            long currentFree  = Runtime.getRuntime().freeMemory();
            long currentAlloc = Runtime.getRuntime().totalMemory();

            min = max = (currentAlloc - currentFree);
        }

        public void end() {
            keep_running = false;
        }

        public void run() {

            while (keep_running) {
                long currentFree  = Runtime.getRuntime().freeMemory();
                long currentAlloc = Runtime.getRuntime().totalMemory();
                long used         = currentAlloc - currentFree;

                if (used < min) {
                    min = used;
                }

                if (used > max) {
                    max = used;
                }

                try {
                    sleep(100);
                } catch (InterruptedException E) {}
            }
        }
    }    /* end of class MemoryWatcherThread */
}

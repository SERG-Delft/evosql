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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import junit.framework.TestCase;
import junit.framework.TestResult;

/**
 * This tests simply executes more than 2^16 times a 'SELECT *' on a 2-row
 * table. If no Keep-Alive is used your OS will run out of ports for connections
 * being repeatedly opened for each SELECT that is executed. If Keep-Alive is
 * being used, this test will complete in a about 5 seconds on an ivy-bridge
 * class machine
 *
 * @author Aart de Vries
 */
public class TestHTTPKeepAlive extends TestBase {

    static Integer     failCount    = 0;
    static Integer     executeCount = 0;
    private Statement  stmnt;
    private Connection connection;

    public TestHTTPKeepAlive(String name) {
        super(name);
    }

    protected void setUp() throws Exception {

        super.setUp();

        connection = newConnection();
        stmnt      = connection.createStatement();

        stmnt.execute(
            "CREATE TABLE IF NOT EXISTS link_table (id INTEGER PRIMARY KEY NOT NULL, other TINYINT NOT NULL)");
        stmnt.execute("INSERT INTO link_table VALUES ((0, 1),(1, 2))");
    }

    protected void tearDown() {

        try {
            stmnt.execute("DROP TABLE IF EXISTS link_table");
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("TestSql.tearDown() error: " + e.getMessage());
        }

        super.tearDown();
    }

    class KeepAliveThread extends Thread {

        public void run() {

            Connection c = null;

            try {
                c = newConnection();

                final Statement statement = c.createStatement();

                for (int i = 0; i <= 16500; i++) {
                    statement.executeQuery("SELECT * FROM link_table");

                    synchronized (executeCount) {
                        executeCount++;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            } finally {
                try {
                    c.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    class TimeoutThread extends Thread {

        public void run() {

            Thread t = new KeepAliveThread();

            t.start();

            try {
                t.join(15000);

                if (t.isAlive()) {    // If thread still running, then it's probably blocked because the ports are exhausted
                    synchronized (failCount) {
                        if (failCount == 0) {
                            failCount++;

                            fail("Keep-Alive is probably not being used");
                        }
                    }
                }
            } catch (InterruptedException ex) {}
        }
    }

    public void testKeepAlive() {

        Thread t1 = new TimeoutThread();

        t1.start();

        Thread t2 = new TimeoutThread();

        t2.start();

        Thread t3 = new TimeoutThread();

        t3.start();

        Thread t4 = new TimeoutThread();

        t4.start();

        try {
            t1.join();
            t2.join();
            t3.join();
            t4.join();
        } catch (InterruptedException e) {}

        System.out.println("testKeepAlive completed " + executeCount
                           + "connections.\n");
    }

    public static void main(String[] argv) {

        TestResult result        = new TestResult();
        TestCase   testKeepAlive = new TestHTTPKeepAlive("testKeepAlive");

        testKeepAlive.run(result);
        System.out.println("TestKeepAlive error count: "
                           + result.failureCount());

        Enumeration e = result.failures();

        while (e.hasMoreElements()) {
            System.out.println(e.nextElement());
        }
    }
}

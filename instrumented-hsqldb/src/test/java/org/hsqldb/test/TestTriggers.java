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
import java.sql.SQLException;
import java.sql.Statement;

import org.hsqldb.Trigger;
import org.hsqldb.lib.ArrayUtil;

/**
 *
 * @author fredt
 */
public class TestTriggers extends TestBase {

    Connection conn;
    private static String dbPath = "/hsql/testtrig/trigs";

    public TestTriggers(String testName) {
        super(testName, "jdbc:hsqldb:file:" + dbPath, false, false);
        TestUtil.deleteDatabase(dbPath);
    }

    public void setUp() throws Exception {

        super.setUp();

        try {
            openConnection();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public void tearDown() {

        try {
            conn.close();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }

        super.tearDown();
    }

    public void testTriggerAction() {

        runScript();

        try {
            runStatements();
        } catch (SQLException e) {
            e.printStackTrace();
            assertTrue(false);
        }

        try {
            shutdownDatabase();
        } catch (SQLException e) {
            e.printStackTrace();
            assertTrue(false);
        }

        try {
            openConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            assertTrue(false);
        }

        try {
            runStatements();
        } catch (SQLException e) {
            e.printStackTrace();
            assertTrue(false);
        }
    }

    private void openConnection() throws SQLException {
        conn = newConnection();
    }

    private void runScript() {
        TestUtil.testScript(conn, "testrun/hsqldb/TestTriggers.txt");
    }

    private void shutdownDatabase() throws SQLException {

        Statement st = conn.createStatement();

        st.execute("shutdown");
        st.close();
    }

    private void runStatements() throws SQLException {

        Statement st = conn.createStatement();

        st.execute("delete from testtrig");
        st.execute("alter table testtrig alter column c1 restart with 0");
        clearCalls();
        st.execute(
            "insert into testtrig values (default, 'inserted val 1', 100)");
        checkCallCount(3);
        checkCalls(Trigger.INSERT_AFTER, 1);
        checkCalls(Trigger.INSERT_BEFORE_ROW, 1);
        checkCalls(Trigger.INSERT_AFTER_ROW, 1);
        clearCalls();
        st.execute(
            "insert into testtrig (c2, c3) select c2, c3 from testtrig where c1 < 0");
        checkCallCount(1);
        checkCalls(Trigger.INSERT_AFTER, 1);
        checkCalls(Trigger.INSERT_BEFORE_ROW, 0);
        checkCalls(Trigger.INSERT_AFTER_ROW, 0);
        clearCalls();
        st.execute("update testtrig set c2 = c2 || ' updated' where c1 = 0");
        checkCallCount(3);
        checkCalls(Trigger.UPDATE_AFTER, 1);
        checkCalls(Trigger.UPDATE_BEFORE_ROW, 1);
        checkCalls(Trigger.UPDATE_AFTER_ROW, 1);
        clearCalls();
        st.execute("update testtrig set c2 = c2 || ' updated' where c1 < 0");
        checkCallCount(1);
        checkCalls(Trigger.UPDATE_AFTER, 1);
        checkCalls(Trigger.UPDATE_BEFORE_ROW, 0);
        checkCalls(Trigger.UPDATE_AFTER_ROW, 0);
        st.close();
    }

    void checkCalls(int trigType, int callCount) {
        assertEquals("call count mismatch", TriggerClass.callCounts[trigType],
                     callCount);
    }

    void clearCalls() {

        TriggerClass.callCount = 0;

        ArrayUtil.fillArray(TriggerClass.callCounts, 0);
    }

    void checkCallCount(int count) {
        assertEquals("trigger call mismatch", count, TriggerClass.callCount);
    }
}

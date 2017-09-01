/* Copyright (c) 2001-2016, The HSQL Development Group
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

import java.lang.reflect.Constructor;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.hsqldb.Database;
import org.hsqldb.server.Server;
import org.hsqldb.server.WebServer;

import junit.framework.TestCase;
import junit.framework.TestResult;

/**
 * HSQLDB TestBugBase Junit test case. <p>
 *
 * By setting the booleans isNetwork, isHTTP, isUseTestServlet below, you can execute all tests that derive from this TestBase class
 * using either the embedded HSQL server mode in both HSQL or HTTP protocol, or target the HSQL-Servlet mode running in for example
 * Tomcat.
 *
 * When running against the Servlet: This assumes you have a WebApplication called HSQLwebApp running in for example Tomcat, with hsqldb.jar
 * (or better hsqldbtest.jar renamed to hsqldb.jar) in the WEB-INF/lib directory and web.xml containing something like this:<p>
 *      <code>
 * {@literal
 *    <servlet>
 *      <servlet-name>test</servlet-name>
 *      <servlet-class>org.hsqldb.server.Servlet</servlet-class>
 *      <init-param>
 *            <param-name>hsqldb.server.database</param-name>
 *            <param-value>mem:test</param-value>
 *      </init-param>
 *      <load-on-startup>1</load-on-startup>
 *    </servlet>
 *
 *    <servlet-mapping>
 *      <servlet-name>test</servlet-name>
 *      <url-pattern>/test</url-pattern>
 *    </servlet-mapping>
 * }</code>
 * @author  boucherb@users
 * @version 1.7.2
 * @since 1.7.2
 */
public abstract class TestBase extends TestCase {

    String  dbPath = "mem:test;sql.enforce_strict_size=true";
    String  serverProps;
    String  url;
    String  user     = "sa";
    String  password = "";
    Server  server;
    boolean isNetwork = true;
    boolean isHTTP    = false;    // Set false to test HSQL protocol, true to test HTTP, in which case you can use isUseTestServlet to target either HSQL's webserver, or the Servlet server-mode
    boolean isServlet = false;

    public TestBase(String name) {
        super(name);
    }

    public TestBase(String name, boolean isNetwork,
                    boolean isHTTP) {

        super(name);

        this.isNetwork = isNetwork;
        this.isHTTP    = isHTTP;
    }

    public TestBase(String name, String url, boolean isNetwork,
                    boolean isHTTP) {

        super(name);

        if (url != null) {
            this.url = url;
        }

        this.isNetwork = isNetwork;
        this.isHTTP    = isHTTP;
    }

    protected void setUp() throws Exception {

        if (isNetwork) {

            //  change the url to reflect your preferred db location and name
            if (url == null) {
                if (isServlet) {
                    url = "jdbc:hsqldb:http://localhost:8080/HSQLwebApp/test";
                } else if (isHTTP) {
                    url = "jdbc:hsqldb:http://localhost:8085/test";
                } else {
                    url = "jdbc:hsqldb:hsql://localhost/test";
                }
            }

            if (!isServlet) {
                server = isHTTP ? new WebServer()
                                : new Server();

                if (isHTTP) {
                    server.setPort(8085);
                }

                server.setDatabaseName(0, "test");
                server.setDatabasePath(0, dbPath);
                server.setLogWriter(null);
                server.setErrWriter(null);
                server.start();
            }
        } else {
            if (url == null) {
                url = "jdbc:hsqldb:" + dbPath;
            }
        }

        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(this + ".setUp() error: " + e.getMessage());
        }
    }

    protected void tearDown() {

        if (isNetwork && !isServlet) {
            server.shutdownWithCatalogs(Database.CLOSEMODE_IMMEDIATELY);

            server = null;
        }
    }

    protected Connection newConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    public static void runWithResult(Class testCaseClass, String testName) {

        try {
            Constructor ctor = testCaseClass.getConstructor(new Class[]{
                String.class });
            TestBase theTest = (TestBase) ctor.newInstance(new Object[]{
                testName });

            theTest.runWithResult();
        } catch (Exception ex) {
            System.err.println("couldn't execute test:");
            ex.printStackTrace(System.err);
        }
    }

    public void runWithResult() {

        TestResult result   = run();
        String     testName = this.getClass().getName();

        if (testName.startsWith("org.hsqldb.test.")) {
            testName = testName.substring(16);
        }

        testName += "." + getName();

        int failureCount = result.failureCount();

        System.out.println(testName + " failure count: " + failureCount);

        java.util.Enumeration failures = result.failures();

        while (failures.hasMoreElements()) {
            System.err.println(failures.nextElement());
        }
    }
}

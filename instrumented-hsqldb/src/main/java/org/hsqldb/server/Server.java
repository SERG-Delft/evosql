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


package org.hsqldb.server;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.StringTokenizer;

import org.hsqldb.DatabaseManager;
import org.hsqldb.DatabaseURL;
import org.hsqldb.HsqlDateTime;
import org.hsqldb.HsqlException;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.FileUtil;
import org.hsqldb.lib.HashSet;
import org.hsqldb.lib.IntKeyHashMap;
import org.hsqldb.lib.Iterator;
import org.hsqldb.lib.Notified;
import org.hsqldb.lib.StopWatch;
import org.hsqldb.lib.StringUtil;
import org.hsqldb.lib.java.JavaSystem;
import org.hsqldb.persist.HsqlDatabaseProperties;
import org.hsqldb.persist.HsqlProperties;
import org.hsqldb.resources.ResourceBundleHandler;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultConstants;

// fredt@users 20020215 - patch 1.7.0
// methods reorganised to use new HsqlProperties class
// fredt@users 20020424 - patch 1.7.0 - shutdown without exit
// see the comments in ServerConnection.java
// unsaved@users 20021113 - patch 1.7.2 - SSL support
// boucherb@users 20030510-14 - 1.7.2 - SSL support moved to factory interface
// boucherb@users 20030510-14 - 1.7.2 - service control, JavaBean API
// fredt@users 20030916 - 1.7.2 - review, simplification and multiple DB's
// fredt@users 20040320 - 1.7.2 - review and correction
// fredt@users 20050225 - 1.8.0 - minor corrections
// fredt@users 20051231 - 1.8.1 - support for remote opening of databases
// fredt@users 20080531 - 1.8.1 - removed synchronized from print methods
// unnecessary and could cause deadlock

/**
 * The HSQLDB HSQL protocol network database server. <p>
 *
 * A Server object acts as a network database server and is one way of using
 * the client-server mode of HSQLDB Database Engine. Instances of this
 * class handle native HSQL protocol connections exclusively, allowing database
 * queries to be performed efficiently across the network.  Server's direct
 * descendant, WebServer, handles HTTP protocol connections exclusively,
 * allowing HSQL protocol to be tunnelled over HTTP to avoid sandbox and
 * firewall issues, albeit less efficiently. <p>
 *
 * There are a number of ways to configure and start a Server instance. <p>
 *
 * When started from the command line or programatically via the main(String[])
 * method, configuration occurs in three phases, with later phases overriding
 * properties set by previous phases:
 *
 * <ol>
 *   <li>Upon construction, a Server object is assigned a set of default
 *       properties. <p>
 *
 *   <li>If it exists, properties are loaded from a file named
 *       'server.properties' in the present working directory. <p>
 *
 *   <li>The command line arguments (alternatively, the String[] passed to
 *       main()) are parsed and used to further configure the Server's
 *       properties. <p>
 *
 * </ol> <p>
 *
 * From the command line, the options are as follows: <p>
 * <pre>
 * +-----------------+-------------+----------+------------------------------+
 * |    OPTION       |    TYPE     | DEFAULT  |         DESCRIPTION          |
 * +-----------------+-------------+----------+------------------------------|
 * | --help          |             |          | prints this message          |
 * | --address       | name|number | any      | server inet address          |
 * | --port          | number      | 9001/544 | port at which server listens |
 * | --database.i    | [type]spec  | 0=test   | path of database i           |
 * | --dbname.i      | alias       |          | url alias for database i     |
 * | --silent        | true|false  | true     | false => display all queries |
 * | --trace         | true|false  | false    | display JDBC trace messages  |
 * | --tls           | true|false  | false    | TLS/SSL (secure) sockets     |
 * | --no_system_exit| true|false  | false    | do not issue System.exit()   |
 * | --remote_open   | true|false  | false    | can open databases remotely  |
 * | --props         | filepath    |          | file path of properties file |
 * +-----------------+-------------+----------+------------------------------+
 * </pre>
 *
 * The <em>database.i</em> and <em>dbname.i</em> options need further
 * explanation:
 *
 * <ul>
 *   <li>Multiple databases can be served by each instance of the Server.
 *       The value of <em>i</em> is currently limited to the range 0..9,
 *       allowing up to 10 different databases. Any number is this range
 *       can be used.<p>
 *
 *   <li>The value assigned to <em>database.i</em> is interpreted using the
 *       format <b>'[type]spec'</b>, where the optional <em>type</em> component
 *       is one of <b>'file:'</b>, <b>'res:'</b> or <b>'mem:'</b> and the
 *       <em>spec</em> component is interpreted in the context of the
 *       <em>type</em> component.  <p>
 *
 *       If omitted, the <em>type</em> component is taken to be
 *       <b>'file:'</b>.  <p>
 *
 *        A full description of how
 *       <b>'[type]spec'</b> values are interpreted appears in the overview for
 *       {@link org.hsqldb.jdbc.JDBCConnection JDBCConnection}. <p>
 *
 *   <li>The value assigned to <em>dbname.i</em> is taken to be the key used to
 *       look up the desired database instance and thus corresponds to the
 *       <b>&lt;alias&gt;</b> component of the HSQLDB HSQL protocol database
 *       connection url:
 *       'jdbc:hsqldb:hsql[s]://host[port][/<b>&lt;alias&gt;</b>]'. <p>
 *
 *   <li>The value of <em>database.0</em> is special. If  <em>dbname.0</em>
 *       is not specified, then this defaults to an empty string and
 *       a connection is made to <em>database.0</em> path when
 *       the <b>&lt;alias&gt;</b> component of an HSQLDB HSQL protocol database
 *       connection url is omitted. If a <em>database</em> key/value pair is
 *       found in the properties when the main method is called, this
 *       pair is supersedes the <em>database.0</em> setting<p>
 *
 *       This behaviour allows the previous
 *       database connection url format to work with essentially unchanged
 *       semantics.<p>
 *
 *   <li>When the  <em>remote_open</em> property is true, a connection attempt
 *       to an unopened database results in the database being opened. The URL
 *       for connection should include the property filepath to specify the path.
 *       'jdbc:hsqldb:hsql[s]://host[port]/<b>&lt;alias&gt;;filepath=hsqldb:file:&lt;database path&gt;</b>'.
 *       the given alias and filepath value will be associated together. The
 *       database user and password to start this connection must be valid.
 *       If this form of connection is used again, after the database has been
 *       opened, the filepath property is ignored.<p>
 *
 *   <li>Once an alias such as "mydb" has been associated with a path, it cannot
 *       be  reassigned to a different path.<p>
 *
 *   <li>If a database is closed with the SHUTDOWN command, its
 *       alias is removed. It is then possible to connect to this database again
 *       with a different (or the same) alias.<p>
 *
 *   <li>If the same database is connected to via two different
 *       aliases, and then one of the is closed with the SHUTDOWN command, the
 *       other is also closed.<p>
 * </ul>
 *
 * From the 'server.properties' file, options can be set similarly, using a
 * slightly different format. <p>
 *
 * Here is an example 'server.properties' file:
 *
 * <pre>
 * server.port=9001
 * server.database.0=test
 * server.dbname.0=...
 * ...
 * server.database.n=...
 * server.dbname.n=...
 * server.silent=true
 * </pre>
 *
 * Starting with 1.7.2, Server has been refactored to become a simple JavaBean
 * with non-blocking start() and stop() service methods.  It is possible to
 * configure a Server instance through the JavaBean API as well, but this
 * part of the public interface is still under review and will not be finalized
 * or documented fully until the final 1.7.2 release. <p>
 *
 * <b>Note:</b> <p>
 *
 * The 'no_system_exit' property is of particular interest. <p>
 *
 * If a Server instance is to run embedded in, say, an application server,
 * such as when the JDBCDataSource or HsqlServerFactory classes are used, it
 * is typically necessary to avoid calling System.exit() when the Server
 * instance shuts down. <p>
 *
 * By default, 'no_system_exit' is set: <p>
 *
 * <ol>
 *    <li><b>true</b> when a Server is started directly from the start()
 *        method. <p>
 *
 *    <li><b>false</b> when a Server is started from the main(String[])
 *         method.
 * </ol> <p>
 *
 * These values are natural to their context because the first case allows
 * the JVM to exit by default on Server shutdown when a Server instance is
 * started from a command line environment, whereas the second case prevents
 * a typically unwanted JVM exit on Server shutdown when a Server intance
 * is started as part of a larger framework. <p>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.2
 * @since 1.7.2
 *
 * @jmx.mbean
 *    description="HSQLDB Server"
 *    extends="org.hsqldb.mx.mbean.RegistrationSupportBaseMBean"
 *
 * @jboss.xmbean
 */
public class Server implements HsqlSocketRequestHandler, Notified {

//
    protected static final int serverBundleHandle =
        ResourceBundleHandler.getBundleHandle(
            "org_hsqldb_server_Server_messages", null);

//
    ServerProperties serverProperties;

//
    HashSet serverConnSet;

//  As of HSQLDB 1.9.0, the following arrays are used starting from 0.
//  The indexes do not correspond to the user-specified indexes.
    protected String[]         dbAlias;
    protected String[]         dbType;
    protected String[]         dbPath;
    protected HsqlProperties[] dbProps;
    protected int[]            dbID;
    protected long[]           dbActionSequence;

// set of aliases
    HashSet aliasSet = new HashSet();

//  Currently unused
    protected int maxConnections;
    volatile long actionSequence;

//
    protected String                serverId;
    protected int                   serverProtocol;
    protected ThreadGroup           serverConnectionThreadGroup;
    protected HsqlSocketFactory     socketFactory;
    protected volatile ServerSocket socket;

//
    private Thread             serverThread;
    private Throwable          serverError;
    private volatile int       serverState;
    private volatile boolean   isSilent;
    protected volatile boolean isRemoteOpen;
    protected boolean          isDaemon;
    private PrintWriter        logWriter;
    private PrintWriter        errWriter;
    private ServerAcl          acl = null;    // null means no access tests
    private volatile boolean   isShuttingDown;

//

    /**
     * A specialized Thread inner class in which the run() method of this
     * server executes.
     */
    private class ServerThread extends Thread {

        /**
         * Constructs a new thread in which to execute the run method
         * of this server.
         *
         * @param name The thread name
         */
        ServerThread(String name) {

            super(name);

            setName(name + '@' + Integer.toString(Server.this.hashCode(), 16));
        }

        /**
         * Executes the run() method of this server
         */
        public void run() {
            Server.this.run();
            printWithThread("ServerThread.run() exited");
        }
    }

    /**
     * Returns thread object for "HSQLDB Server" thread
     */
    public Thread getServerThread() {
        return serverThread;
    }

    /**
     * Creates a new Server instance handling HSQL protocol connections.
     */
    public Server() {
        this(ServerConstants.SC_PROTOCOL_HSQL);
    }

    /**
     * Creates a new Server instance handling the specified connection
     * protocol. <p>
     *
     * For example, the no-args WebServer constructor invokes this constructor
     * with ServerConstants.SC_PROTOCOL_HTTP, while the Server() no args
     * contructor invokes this constructor with
     * ServerConstants.SC_PROTOCOL_HSQL. <p>
     *
     * @param protocol the ServerConstants code indicating which
     *      connection protocol to handle
     */
    protected Server(int protocol) {
        init(protocol);
    }

    /**
     * Checks if this Server object is or is not running and throws if the
     * current state does not match the specified value.
     *
     * @param running if true, ensure the server is running, else ensure the
     *      server is not running
     * @throws HsqlException if the supplied value does not match the
     *      current running status
     */
    public void checkRunning(boolean running) {

        int     state;
        boolean error;

        printWithThread("checkRunning(" + running + ") entered");

        state = getState();
        error = (running && state != ServerConstants.SERVER_STATE_ONLINE)
                || (!running
                    && state != ServerConstants.SERVER_STATE_SHUTDOWN);

        if (error) {
            String msg = "server is " + (running ? "not "
                                                 : "") + "running";

            throw Error.error(ErrorCode.GENERAL_ERROR, msg);
        }

        printWithThread("checkRunning(" + running + ") exited");
    }

    /**
     * Closes all connections to this Server.
     *
     * @jmx.managed-operation
     *  impact="ACTION"
     *  description="Closes all open connections"
     */
    public synchronized void signalCloseAllServerConnections() {

        Iterator           it;
        ServerConnection[] array;

        printWithThread("signalCloseAllServerConnections() entered");

        synchronized (serverConnSet) {

            // snapshot
            array = new ServerConnection[serverConnSet.size()];

            serverConnSet.toArray(array);
        }

        for (int i = 0; i < array.length; i++) {
            ServerConnection sc = array[i];

            printWithThread("Closing " + sc);

            // also removes all but one connection from serverConnSet
            sc.signalClose();
        }

        printWithThread("signalCloseAllServerConnections() exited");
    }

    protected void finalize() {

        if (serverThread != null) {
            releaseServerSocket();
        }
    }

    /**
     * Retrieves, in string form, this server's host address.
     *
     * @return this server's host address
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="Host InetAddress"
     */
    public String getAddress() {

        return socket == null
               ? serverProperties.getProperty(ServerProperties.sc_key_address)
               : socket.getInetAddress().getHostAddress();
    }

    /**
     * Retrieves the url alias (network name) of the i'th database
     * that this Server hosts.
     *
     * @param index the index of the url alias upon which to report
     * @param asconfigured if true, report the configured value, else
     *      the live value
     * @return the url alias component of the i'th database
     *      that this Server hosts, or null if no such name exists.
     *
     * @jmx.managed-operation
     *  impact="INFO"
     *  description="url alias component of the i'th hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="index"
     *      type="int"
     *      position="0"
     *      description="This Server's index for the hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="asconfigured"
     *      type="boolean"
     *      position="1"
     *      description="if true, the configured value, else the live value"
     */
    public String getDatabaseName(int index, boolean asconfigured) {

        if (asconfigured) {
            return serverProperties.getProperty(ServerProperties.sc_key_dbname
                                                + "." + index);
        } else if (getState() == ServerConstants.SERVER_STATE_ONLINE) {
            return (dbAlias == null || index < 0 || index >= dbAlias.length)
                   ? null
                   : dbAlias[index];
        } else {
            return null;
        }
    }

    /**
     * Retrieves the HSQLDB path descriptor (uri) of the i'th
     * Database that this Server hosts.
     *
     * @param index the index of the uri upon which to report
     * @param asconfigured if true, report the configured value, else
     *      the live value
     * @return the HSQLDB database path descriptor of the i'th database
     *      that this Server hosts, or null if no such path descriptor
     *      exists
     *
     * @jmx.managed-operation
     *  impact="INFO"
     *  description="For i'th hosted database"
     *
     * @jmx.managed-operation-parameter
     *      name="index"
     *      type="int"
     *      position="0"
     *      description="This Server's index for the hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="asconfigured"
     *      type="boolean"
     *      position="1"
     *      description="if true, the configured value, else the live value"
     */
    public String getDatabasePath(int index, boolean asconfigured) {

        if (asconfigured) {
            return serverProperties.getProperty(
                ServerProperties.sc_key_database + "." + index);
        } else if (getState() == ServerConstants.SERVER_STATE_ONLINE) {
            return (dbPath == null || index < 0 || index >= dbPath.length)
                   ? null
                   : dbPath[index];
        } else {
            return null;
        }
    }

    public String getDatabaseType(int index) {
        return (dbType == null || index < 0 || index >= dbType.length) ? null
                                                                       : dbType[index];
    }

    /**
     * Retrieves the name of the web page served when no page is specified.
     * This attribute is relevant only when server protocol is HTTP(S).
     *
     * @return the name of the web page served when no page is specified
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="Used when server protocol is HTTP(S)"
     */
    public String getDefaultWebPage() {
        return "[IGNORED]";
    }

    /**
     * Retrieves a String object describing the command line and
     * properties options for this Server.
     *
     * @return the command line and properties options help for this Server
     */
    public String getHelpString() {
        return ResourceBundleHandler.getString(serverBundleHandle,
                                               "server.help");
    }

    /**
     * Retrieves the PrintWriter to which server errors are printed.
     *
     * @return the PrintWriter to which server errors are printed.
     */
    public PrintWriter getErrWriter() {
        return errWriter;
    }

    /**
     * Retrieves the PrintWriter to which server messages are printed.
     *
     * @return the PrintWriter to which server messages are printed.
     */
    public PrintWriter getLogWriter() {
        return logWriter;
    }

    /**
     * Retrieves this server's host port.
     *
     * @return this server's host port
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="At which ServerSocket listens for connections"
     */
    public int getPort() {

        return serverProperties.getIntegerProperty(
            ServerProperties.sc_key_port,
            ServerConfiguration.getDefaultPort(serverProtocol, isTls()));
    }

    /**
     * Retrieves this server's product name.  <p>
     *
     * Typically, this will be something like: "HSQLDB xxx server".
     *
     * @return the product name of this server
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="Of Server"
     */
    public String getProductName() {
        return "HSQLDB server";
    }

    /**
     * Retrieves the server's product version, as a String.  <p>
     *
     * Typically, this will be something like: "1.x.x" or "2.x.x" and so on.
     *
     * @return the product version of the server
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="Of Server"
     */
    public String getProductVersion() {
        return HsqlDatabaseProperties.THIS_VERSION;
    }

    /**
     * Retrieves a string respresentaion of the network protocol
     * this server offers, typically one of 'HTTP', HTTPS', 'HSQL' or 'HSQLS'.
     *
     * @return string representation of this server's protocol
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="Used to handle connections"
     */
    public String getProtocol() {
        return isTls() ? "HSQLS"
                       : "HSQL";
    }

    /**
     * Retrieves a Throwable indicating the last server error, if any. <p>
     *
     * @return a Throwable indicating the last server error
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="Indicating last exception state"
     */
    public Throwable getServerError() {
        return serverError;
    }

    /**
     * Retrieves a String identifying this Server object.
     *
     * @return a String identifying this Server object
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="Identifying Server"
     */
    public String getServerId() {
        return serverId;
    }

    /**
     * Retrieves current state of this server in numerically coded form. <p>
     *
     * Typically, this will be one of: <p>
     *
     * <ol>
     * <li>ServerProperties.SERVER_STATE_ONLINE (1)
     * <li>ServerProperties.SERVER_STATE_OPENING (4)
     * <li>ServerProperties.SERVER_STATE_CLOSING (8)
     * <li>ServerProperties.SERVER_STATE_SHUTDOWN (16)
     * </ol>
     *
     * @return this server's state code.
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="1:ONLINE 4:OPENING 8:CLOSING, 16:SHUTDOWN"
     */
    public int getState() {
        return serverState;
    }

    /**
     * Retrieves a character sequence describing this server's current state,
     * including the message of the last exception, if there is one and it
     * is still in context.
     *
     * @return this server's state represented as a character sequence.
     *
     * @jmx.managed-attribute
     *  access="read-only"
     *  description="State as string"
     */
    public String getStateDescriptor() {

        String    state;

        switch (serverState) {

            case ServerConstants.SERVER_STATE_SHUTDOWN :
                state = "SHUTDOWN";
                break;

            case ServerConstants.SERVER_STATE_OPENING :
                state = "OPENING";
                break;

            case ServerConstants.SERVER_STATE_CLOSING :
                state = "CLOSING";
                break;

            case ServerConstants.SERVER_STATE_ONLINE :
                state = "ONLINE";
                break;

            default :
                state = "UNKNOWN";
                break;
        }

        return state;
    }

    /**
     * Retrieves the root context (directory) from which web content
     * is served.  This property is relevant only when the server
     * protocol is HTTP(S).  Although unlikely, it may be that in the future
     * other contexts, such as jar urls may be supported, so that pages can
     * be served from the contents of a jar or from the JVM class path.
     *
     * @return the root context (directory) from which web content is served
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="Context (directory)"
     */
    public String getWebRoot() {
        return "[IGNORED]";
    }

    /**
     * Assigns the specified socket to a new connection handler and
     * starts the handler in a new Thread.
     *
     * @param s the socket to connect
     */
    public void handleConnection(Socket s) {

        Thread   t;
        Runnable r;
        String   ctn;

        printWithThread("handleConnection(" + s + ") entered");

        if (!allowConnection(s)) {
            try {
                s.close();
            } catch (Exception e) {}

            printWithThread("allowConnection(): connection refused");
            printWithThread("handleConnection() exited");

            return;
        }

        // Maybe set up socket options, SSL
        // Session tracing/callbacks, etc.
        if (socketFactory != null) {
            socketFactory.configureSocket(s);
        }

        if (serverProtocol == ServerConstants.SC_PROTOCOL_HSQL) {
            r   = new ServerConnection(s, this);
            ctn = ((ServerConnection) r).getConnectionThreadName();
        } else {
            r   = new WebServerConnection(s, (WebServer) this);
            ctn = ((WebServerConnection) r).getConnectionThreadName();
        }

        t = new Thread(serverConnectionThreadGroup, r, ctn);

        t.start();
        printWithThread("handleConnection() exited");
    }

    /**
     * Retrieves whether this server calls System.exit() when shutdown.
     *
     * @return true if this server does not call System.exit()
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="When Shutdown"
     */
    public boolean isNoSystemExit() {
        return serverProperties.isPropertyTrue(
            ServerProperties.sc_key_no_system_exit);
    }

    /**
     * Retrieves whether this server restarts on shutdown.
     *
     * @return true this server restarts on shutdown
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="Automatically?"
     */
    public boolean isRestartOnShutdown() {
        return serverProperties.isPropertyTrue(
            ServerProperties.sc_key_autorestart_server);
    }

    /**
     * Retrieves whether silent mode operation was requested in
     * the server properties.
     *
     * @return if true, silent mode was requested, else trace messages
     *      are to be printed
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="No trace messages?"
     */
    public boolean isSilent() {
        return isSilent;
    }

    /**
     * Retrieves whether the use of secure sockets was requested in the
     * server properties.
     *
     * @return if true, secure sockets are requested, else not
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="Use TLS/SSL sockets?"
     */
    public boolean isTls() {
        return serverProperties.isPropertyTrue(ServerProperties.sc_key_tls);
    }

    /**
     * Retrieves whether JDBC trace messages are to go to System.out or the
     * DriverManger PrintStream/PrintWriter, if any.
     *
     * @return true if tracing is on (JDBC trace messages to system out)
     *
     * @jmx.managed-attribute
     *  access="read-write"
     *  description="JDBC trace messages to System.out?"
     */
    public boolean isTrace() {
        return serverProperties.isPropertyTrue(ServerProperties.sc_key_trace);
    }

    /**
     * Attempts to put properties from the file
     * with the specified path. The file
     * extension '.properties' is implicit and should not
     * be included in the path specification.
     *
     * @param path the path of the desired properties file, without the
     *      '.properties' file extension
     * @throws HsqlException if this server is running
     * @return true if the indicated file was read successfully, else false
     *
     * @jmx.managed-operation
     *  impact="ACTION"
     *  description="Reads in properties"
     *
     * @jmx.managed-operation-parameter
     *   name="path"
     *   type="java.lang.String"
     *   position="0"
     *   description="(optional) returns false if path is empty"
     */
    public boolean putPropertiesFromFile(String path) {
        return putPropertiesFromFile(path, ".properties");
    }

    /**
     * Attempts to put properties from the file with given extension.
     *
     * @param path the path of the desired properties file.
     * @param extension extension to add to path
     * @throws HsqlException if this server is running
     * @return true if the indicated file was read successfully, else false
     *
     */
    public boolean putPropertiesFromFile(String path, String extension) {

        if (getState() != ServerConstants.SERVER_STATE_SHUTDOWN) {
            throw Error.error(ErrorCode.GENERAL_ERROR, "server properties");
        }

        path = FileUtil.getFileUtil().canonicalOrAbsolutePath(path);

        ServerProperties p = ServerConfiguration.getPropertiesFromFile(
            ServerConstants.SC_PROTOCOL_HSQL, path, extension);

        if (p == null || p.isEmpty()) {
            return false;
        }

        printWithThread("putPropertiesFromFile(): [" + path + ".properties]");

        try {
            setProperties(p);
        } catch (Exception e) {
            throw Error.error(e, ErrorCode.GENERAL_ERROR,
                              ErrorCode.M_Message_Pair,
                              new String[]{ "Failed to set properties" });
        }

        return true;
    }

    /**
     * Puts properties from the supplied string argument.  The relevant
     * key value pairs are the same as those for the (web)server.properties
     * file format, except that the 'server.' prefix should not be specified.
     *
     * @param s semicolon-delimited key=value pair string,
     *      e.g. silent=false;port=8080;...
     * @throws HsqlException if this server is running
     *
     * @jmx.managed-operation
     *   impact="ACTION"
     *   description="'server.' key prefix automatically supplied"
     *
     * @jmx.managed-operation-parameter
     *   name="s"
     *   type="java.lang.String"
     *   position="0"
     *   description="semicolon-delimited key=value pairs"
     */
    public void putPropertiesFromString(String s) {

        if (getState() != ServerConstants.SERVER_STATE_SHUTDOWN) {
            throw Error.error(ErrorCode.GENERAL_ERROR);
        }

        if (StringUtil.isEmpty(s)) {
            return;
        }

        printWithThread("putPropertiesFromString(): [" + s + "]");

        HsqlProperties p = HsqlProperties.delimitedArgPairsToProps(s, "=",
            ";", ServerProperties.sc_key_prefix);

        try {
            setProperties(p);
        } catch (Exception e) {
            throw Error.error(e, ErrorCode.GENERAL_ERROR,
                              ErrorCode.M_Message_Pair,
                              new String[]{ "Failed to set properties" });
        }
    }

    /**
     * Sets the InetAddress with which this server's ServerSocket will be
     * constructed.  A null or empty string or the special value "0.0.0.0"
     * can be used to bypass explicit selection, causing the ServerSocket
     * to be constructed without specifying an InetAddress.
     *
     * @param address A string representing the desired InetAddress as would
     *    be retrieved by InetAddres.getByName(), or a null or empty string
     *    or "0.0.0.0" to signify that the server socket should be constructed
     *    using the signature that does not specify the InetAddress.
     * @throws HsqlException if this server is running
     *
     * @jmx.managed-attribute
     */
    public void setAddress(String address) {

        checkRunning(false);

        if (StringUtil.isEmpty(address)) {
            address = ServerConstants.SC_DEFAULT_ADDRESS;
        }

        printWithThread("setAddress(" + address + ")");
        serverProperties.setProperty(ServerProperties.sc_key_address, address);
    }

    /**
     * Sets the external name (url alias) of the i'th hosted database.
     *
     * @param name external name (url alias) of the i'th HSQLDB database
     *      instance this server is to host.
     * @throws HsqlException if this server is running
     *
     * @jmx.managed-operation
     *      impact="ACTION"
     *      description="Sets the url alias by which is known the i'th hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="index"
     *      type="int"
     *      position="0"
     *      description="This Server's index for the hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="name"
     *      type="java.lang.String"
     *      position="1"
     *      description="url alias component for the hosted Database"
     */
    public void setDatabaseName(int index, String name) {

        checkRunning(false);
        printWithThread("setDatabaseName(" + index + "," + name + ")");
        serverProperties.setProperty(ServerProperties.sc_key_dbname + "."
                                     + index, name);
    }

    /**
     * Sets the path of the hosted database. The path always starts with the
     * catalog type. Examples of the path include: "file:mydir/mydb",
     * "mem:mymemdb", "res:org/mydomain/mydbs/settingsdb".
     *
     * @param path The path of the i'th HSQLDB database instance this server
     *      is to host.
     *
     * @jmx.managed-operation
     *      impact="ACTION"
     *      description="Sets the database uri path for the i'th hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="index"
     *      type="int"
     *      position="0"
     *      description="This Server's index for the hosted Database"
     *
     * @jmx.managed-operation-parameter
     *      name="path"
     *      type="java.lang.String"
     *      position="1"
     *      description="database uri path of the hosted Database"
     */
    public void setDatabasePath(int index, String path) {

        checkRunning(false);
        printWithThread("setDatabasePath(" + index + "," + path + ")");
        serverProperties.setProperty(ServerProperties.sc_key_database + "."
                                     + index, path);
    }

    /**
     * Sets the name of the web page served when no page is specified.
     *
     * @param file the name of the web page served when no page is specified
     *
     * @jmx.managed-attribute
     */
    public void setDefaultWebPage(String file) {

        checkRunning(false);
        printWithThread("setDefaultWebPage(" + file + ")");

        if (serverProtocol != ServerConstants.SC_PROTOCOL_HTTP) {
            return;
        }

        serverProperties.setProperty(ServerProperties.sc_key_web_default_page,
                                     file);
    }

    /**
     * Sets the server listen port.
     *
     * @param port the port at which this server listens
     *
     * @jmx.managed-attribute
     */
    public void setPort(int port) {

        checkRunning(false);
        printWithThread("setPort(" + port + ")");
        serverProperties.setProperty(ServerProperties.sc_key_port, port);
    }

    /**
     * Sets the PrintWriter to which server errors are logged. <p>
     *
     * Setting this attribute to null disables server error logging
     *
     * @param pw the PrintWriter to which server messages are logged
     */
    public void setErrWriter(PrintWriter pw) {
        errWriter = pw;
    }

    /**
     * Sets the PrintWriter to which server messages are logged. <p>
     *
     * Setting this attribute to null disables server message logging
     *
     * @param pw the PrintWriter to which server messages are logged
     */
    public void setLogWriter(PrintWriter pw) {
        logWriter = pw;
    }

    /**
     * Sets whether this server calls System.exit() when shutdown.
     *
     * @param noExit if true, System.exit() will not be called.
     *
     * @jmx.managed-attribute
     */
    public void setNoSystemExit(boolean noExit) {

        printWithThread("setNoSystemExit(" + noExit + ")");
        serverProperties.setProperty(ServerProperties.sc_key_no_system_exit,
                                     noExit);
    }

    /**
     * Sets whether this server restarts on shutdown.
     *
     * @param restart if true, this server restarts on shutdown
     *
     * @jmx.managed-attribute
     */
    public void setRestartOnShutdown(boolean restart) {

        printWithThread("setRestartOnShutdown(" + restart + ")");
        serverProperties.setProperty(
            ServerProperties.sc_key_autorestart_server, restart);
    }

    /**
     * Sets silent mode operation
     *
     * @param silent if true, then silent mode, else trace messages
     *  are to be printed
     *
     * @jmx.managed-attribute
     */
    public void setSilent(boolean silent) {

        printWithThread("setSilent(" + silent + ")");
        serverProperties.setProperty(ServerProperties.sc_key_silent, silent);

        isSilent = silent;
    }

    /**
     * Sets whether to use secure sockets
     *
     * @param tls true for secure sockets, else false
     * @throws HsqlException if this server is running
     *
     * @jmx.managed-attribute
     */
    public void setTls(boolean tls) {

        checkRunning(false);
        printWithThread("setTls(" + tls + ")");
        serverProperties.setProperty(ServerProperties.sc_key_tls, tls);
    }

    /**
     * Sets whether trace messages go to System.out or the
     * DriverManger PrintStream/PrintWriter, if any.
     *
     * @param trace if true, route JDBC trace messages to System.out
     *
     * @jmx.managed-attribute
     */
    public void setTrace(boolean trace) {

        printWithThread("setTrace(" + trace + ")");
        serverProperties.setProperty(ServerProperties.sc_key_trace, trace);
        JavaSystem.setLogToSystem(trace);
    }

    /**
     * Sets whether server thread is a daemon. Used before starting.
     * The default is false.
     *
     * @param daemon if true, start the thread as a daemon thread
     *
     * @jmx.managed-attribute
     */
    public void setDaemon(boolean daemon) {

        checkRunning(false);
        printWithThread("setDaemon(" + daemon + ")");
        serverProperties.setProperty(ServerProperties.sc_key_daemon, daemon);
    }

    /**
     * Sets the path of the root directory from which web content is served.
     *
     * @param root the root (context) directory from which web content
     *      is served
     *
     * @jmx.managed-attribute
     */
    public void setWebRoot(String root) {

        checkRunning(false);

        root = (new File(root)).getAbsolutePath();

        printWithThread("setWebRoot(" + root + ")");

        if (serverProtocol != ServerConstants.SC_PROTOCOL_HTTP) {
            return;
        }

        serverProperties.setProperty(ServerProperties.sc_key_web_root, root);
    }

    /**
     * Sets server properties using the specified properties object
     *
     * @param props The object containing properties to set
     * @throws ServerAcl.AclFormatException
     *          ACL list was requested but problem loading ACL.
     * @throws IOException
     *          ACL list was requested but I/O problem loading ACL.
     */
    public void setProperties(HsqlProperties props)
    throws IOException, ServerAcl.AclFormatException {

        checkRunning(false);

        if (props != null) {
            props.validate();

            String[] errors = props.getErrorKeys();

            if (errors.length > 0) {
                throw Error.error(ErrorCode.SERVER_NO_DATABASE, errors[0]);
            }

            serverProperties.addProperties(props);
        }

        maxConnections = serverProperties.getIntegerProperty(
            ServerProperties.sc_key_max_connections, 16);

        JavaSystem.setLogToSystem(isTrace());

        isSilent =
            serverProperties.isPropertyTrue(ServerProperties.sc_key_silent);
        isRemoteOpen = serverProperties.isPropertyTrue(
            ServerProperties.sc_key_remote_open_db);
        isDaemon =
            serverProperties.isPropertyTrue(ServerProperties.sc_key_daemon);

        String aclFilepath =
            serverProperties.getProperty(ServerProperties.sc_key_acl);

        if (aclFilepath != null) {
            acl = new ServerAcl(new File(aclFilepath));

            if (logWriter != null && !isSilent) {
                acl.setPrintWriter(logWriter);
            }
        }
    }

    /**
     * Starts this server synchronously. <p>
     *
     * This method waits for current state to change from
     * SERVER_STATE_OPENNING. In order to discover the success or failure
     * of this operation, server state must be polled or a subclass of Server
     * must be used that overrides the setState method to provide state
     * change notification.
     *
     * @return the server state noted at entry to this method
     *
     * @jmx.managed-operation
     *  impact="ACTION_INFO"
     *  description="Invokes asynchronous startup sequence; returns previous state"
     */
    public int start() {

        printWithThread("start() entered");

        int previousState = getState();

        if (serverThread != null) {
            printWithThread("start(): serverThread != null; no action taken");

            return previousState;
        }

        setState(ServerConstants.SERVER_STATE_OPENING);

        serverThread = new ServerThread("HSQLDB Server ");

        if (isDaemon) {
            serverThread.setDaemon(true);
        }

        serverThread.start();

        // call synchronized getState() to become owner of the Server Object's monitor
        while (getState() == ServerConstants.SERVER_STATE_OPENING) {
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {}
        }

        printWithThread("start() exiting");

        return previousState;
    }

    /**
     * Stops this server asynchronously. <p>
     *
     * This method returns immediately, regardless of current state.  In order
     * to discover the success or failure of this operation, server state must
     * be polled or a subclass of Server must be used that overrides the
     * setState method to provide state change notification.
     *
     * @return the server state noted at entry to this method
     *
     * @jmx.managed-operation
     *  impact="ACTION_INFO"
     *  description="Invokes asynchronous shutdown sequence; returns previous state"
     */
    public int stop() {

        printWithThread("stop() entered");

        int previousState = getState();

        if (serverThread == null) {
            printWithThread("stop() serverThread is null; no action taken");

            return previousState;
        }

        releaseServerSocket();
        printWithThread("stop() exiting");

        return previousState;
    }

    /**
     * Retrieves whether the specified socket should be allowed
     * to make a connection.
     *
     * @param socket the socket to test.
     */
    protected boolean allowConnection(Socket socket) {

        if (isShuttingDown) {
            return false;
        }

        return (acl == null) ? true
                             : acl.permitAccess(
                                 socket.getInetAddress().getAddress());
    }

    /**
     * Initializes this server, setting the accepted connection protocol.
     *
     * @param protocol typically either SC_PROTOCOL_HTTP or SC_PROTOCOL_HSQL
     */
    protected void init(int protocol) {

        // PRE:  This method is only called from the constructor
        serverState      = ServerConstants.SERVER_STATE_SHUTDOWN;
        serverConnSet    = new HashSet();
        serverId         = toString();
        serverId         = serverId.substring(serverId.lastIndexOf('.') + 1);
        serverProtocol   = protocol;
        serverProperties = ServerConfiguration.newDefaultProperties(protocol);
        logWriter        = new PrintWriter(System.out);
        errWriter        = new PrintWriter(System.err);

        JavaSystem.setLogToSystem(isTrace());
    }

    /**
     * Sets the server state value.
     *
     * @param state the new value
     */
    protected synchronized void setState(int state) {
        serverState = state;
    }

    /**
     * This is called from org.hsqldb.DatabaseManager when a database is
     * shutdown. This shuts the server down if it is the last database
     *
     * @param id database id
     */
    public final void notify(int id) {

        printWithThread("notify( database shutdown," + id + ") entered");
        releaseDatabase(id);

        boolean shutdown = true;

        for (int i = 0; i < dbID.length; i++) {
            if (dbAlias[i] != null) {
                shutdown = false;
            }
        }

        if (!isRemoteOpen && shutdown) {
            stop();
        }
    }

    /**
     * This releases the resources used for a database.
     * Is called with id 0 multiple times for non-existent databases
     */
    final synchronized void releaseDatabase(int id) {

        Iterator           it;
        boolean            found = false;
        ServerConnection[] array;

        printWithThread("releaseDatabase(" + id + ") entered");

        // check all slots as a database may be opened by multiple aliases
        for (int i = 0; i < dbID.length; i++) {
            if (dbID[i] == id && dbAlias[i] != null) {
                dbID[i]             = 0;
                dbActionSequence[i] = 0;
                dbAlias[i]          = null;
                dbPath[i]           = null;
                dbType[i]           = null;
                dbProps[i]          = null;
            }
        }

        synchronized (serverConnSet) {
            array = new ServerConnection[serverConnSet.size()];

            serverConnSet.toArray(array);
        }

        for (int i = 0; i < array.length; i++) {
            ServerConnection sc = array[i];

            if (sc.dbID == id) {
                sc.signalClose();
            }
        }

        printWithThread("releaseDatabase(" + id + ") exiting");
    }

    /**
     * Prints the specified message, s, formatted to identify that the print
     * operation is against this server instance.
     *
     * @param msg The message to print
     */
    protected void print(String msg) {

        PrintWriter writer = logWriter;

        if (writer != null) {
            writer.println("[" + serverId + "]: " + msg);
            writer.flush();
        }
    }

    /**
     * Prints value from server's resource bundle, formatted to
     * identify that the print operation is against this server instance.
     * Value may be localized according to the default JVM locale
     *
     * @param key the resource key
     */
    final void printResource(String key) {

        String          resource;
        StringTokenizer st;

        if (serverBundleHandle < 0) {
            return;
        }

        resource = ResourceBundleHandler.getString(serverBundleHandle, key);

        if (resource == null) {
            return;
        }

        st = new StringTokenizer(resource, "\n\r");

        while (st.hasMoreTokens()) {
            print(st.nextToken());
        }
    }

    /**
     * Prints the stack trace of the Throwable, t, to this Server object's
     * errWriter. <p>
     *
     * @param t the Throwable whose stack trace is to be printed
     */
    protected void printStackTrace(Throwable t) {

        if (errWriter != null) {
            t.printStackTrace(errWriter);
            errWriter.flush();
        }
    }

    /**
     * Prints the specified message, s, prepended with a timestamp representing
     * the current date and time, formatted to identify that the print
     * operation is against this server instance.
     *
     * @param msg the message to print
     */
    final void printWithTimestamp(String msg) {
        print(HsqlDateTime.getSystemTimeString() + " " + msg);
    }

    /**
     * Prints a message formatted similarly to print(String), additionally
     * identifying the current (calling) thread. Replaces old method
     * trace(String msg).
     *
     * @param msg the message to print
     */
    protected void printWithThread(String msg) {

        if (!isSilent()) {
            print("[" + Thread.currentThread() + "]: " + msg);
        }
    }

    /**
     * Prints an error message to this Server object's errWriter.
     * The message is formatted similarly to print(String),
     * additionally identifying the current (calling) thread.
     *
     * @param msg the message to print
     */
    protected void printError(String msg) {

        PrintWriter writer = errWriter;

        if (writer != null) {
            writer.print("[" + serverId + "]: ");
            writer.print("[" + Thread.currentThread() + "]: ");
            writer.println(msg);
            writer.flush();
        }
    }

    /**
     * Prints a description of the request encapsulated by the
     * Result argument, r.
     *
     * Printing occurs iff isSilent() is false. <p>
     *
     * The message is formatted similarly to print(String), additionally
     * indicating the connection identifier.  <p>
     *
     * For Server instances, cid is typically the value assigned to each
     * ServerConnection object that is unique amongst all such identifiers
     * in each distinct JVM session / class loader
     * context. <p>
     *
     * For WebServer instances, a single logical connection actually spawns
     * a new physical WebServerConnection object for each request, so the
     * cid is typically the underlying session id, since that does not
     * change for the duration of the logical connection.
     *
     * @param cid the connection identifier
     * @param r the request whose description is to be printed
     */
    final void printRequest(int cid, Result r) {

        if (isSilent()) {
            return;
        }

        StringBuffer sb = new StringBuffer();

        sb.append(cid);
        sb.append(':');

        switch (r.getType()) {

            case ResultConstants.PREPARE : {
                sb.append("SQLCLI:SQLPREPARE ");
                sb.append(r.getMainString());

                break;
            }
            case ResultConstants.EXECDIRECT : {
                sb.append(r.getMainString());

                break;
            }
            case ResultConstants.EXECUTE_INVALID :
            case ResultConstants.EXECUTE : {
                sb.append("SQLCLI:SQLEXECUTE:");
                sb.append(r.getStatementID());

/**
 * @todo 1.9.0 - fredt - fix this without appendStringValueOf - use type to convert to string
 */
/*
                if (r.getSize() == 1) {
                    sb.append('\n');
                    StringUtil.appendStringValueOf(r.getParameterData(), sb, true);
                }
*/
                break;
            }
            case ResultConstants.BATCHEXECUTE :
                sb.append("SQLCLI:SQLEXECUTE:");
                sb.append("BATCHMODE:");
                sb.append(r.getStatementID());
                break;

            case ResultConstants.UPDATE_RESULT : {
                sb.append("SQLCLI:RESULTUPDATE:");
                sb.append(r.getStatementID());

                break;
            }
            case ResultConstants.FREESTMT : {
                sb.append("SQLCLI:SQLFREESTMT:");
                sb.append(r.getStatementID());

                break;
            }
            case ResultConstants.GETSESSIONATTR : {
                sb.append("HSQLCLI:GETSESSIONATTR");

                break;
            }
            case ResultConstants.SETSESSIONATTR : {
                sb.append("HSQLCLI:SETSESSIONATTR:");

                break;
            }
            case ResultConstants.ENDTRAN : {
                sb.append("SQLCLI:SQLENDTRAN:");

                switch (r.getActionType()) {

                    case ResultConstants.TX_COMMIT :
                        sb.append("COMMIT");
                        break;

                    case ResultConstants.TX_ROLLBACK :
                        sb.append("ROLLBACK");
                        break;

                    case ResultConstants.TX_SAVEPOINT_NAME_RELEASE :
                        sb.append("SAVEPOINT_NAME_RELEASE ");
                        sb.append(r.getMainString());
                        break;

                    case ResultConstants.TX_SAVEPOINT_NAME_ROLLBACK :
                        sb.append("SAVEPOINT_NAME_ROLLBACK ");
                        sb.append(r.getMainString());
                        break;

                    default :
                        sb.append(r.getActionType());
                }

                break;
            }
            case ResultConstants.STARTTRAN : {
                sb.append("SQLCLI:SQLSTARTTRAN");

                break;
            }
            case ResultConstants.DISCONNECT : {
                sb.append("SQLCLI:SQLDISCONNECT");

                break;
            }
            case ResultConstants.SETCONNECTATTR : {
                sb.append("SQLCLI:SQLSETCONNECTATTR:");

                switch (r.getConnectionAttrType()) {

                    case ResultConstants.SQL_ATTR_SAVEPOINT_NAME : {
                        sb.append("SQL_ATTR_SAVEPOINT_NAME ");
                        sb.append(r.getMainString());

                        break;
                    }
                    default : {
                        sb.append(r.getConnectionAttrType());
                    }
                }

                break;
            }
            case ResultConstants.CLOSE_RESULT : {
                sb.append("HQLCLI:CLOSE_RESULT:RESULT_ID ");
                sb.append(r.getResultId());

                break;
            }
            case ResultConstants.REQUESTDATA : {
                sb.append("HQLCLI:REQUESTDATA:RESULT_ID ");
                sb.append(r.getResultId());
                sb.append(" ROWOFFSET ");
                sb.append(r.getUpdateCount());
                sb.append(" ROWCOUNT ");
                sb.append(r.getFetchSize());

                break;
            }
            default : {
                sb.append("SQLCLI:MODE:");
                sb.append(r.getType());

                break;
            }
        }

        print(sb.toString());
    }

    /**
     * return database ID
     */
    synchronized final int getDBIndex(String aliasPath) {

        int    semipos  = aliasPath.indexOf(';');
        String alias    = aliasPath;
        String filepath = null;

        if (semipos != -1) {
            alias    = aliasPath.substring(0, semipos);
            filepath = aliasPath.substring(semipos + 1);
        }

        int dbIndex = ArrayUtil.find(dbAlias, alias);

        if (dbIndex == -1) {
            if (filepath == null) {
                HsqlException e = Error.error(ErrorCode.GENERAL_ERROR,
                                              "database alias does not exist");

                printError("database alias=" + alias + " does not exist");
                setServerError(e);

                throw e;
            } else {
                return openDatabase(alias, filepath);
            }
        } else {
            return dbIndex;
        }
    }

    /**
     * Open and return database index
     */
    final int openDatabase(String alias, String datapath) {

        if (!isRemoteOpen) {
            HsqlException e = Error.error(ErrorCode.GENERAL_ERROR,
                                          "remote open not allowed");

            printError("Remote database open not allowed");
            setServerError(e);

            throw e;
        }

        int i = getFirstEmptyDatabaseIndex();

        if (i < -1) {
            i = closeOldestDatabase();

            if (i < -1) {
                HsqlException e =
                    Error.error(ErrorCode.GENERAL_ERROR,
                                "limit of open databases reached");

                printError("limit of open databases reached");
                setServerError(e);

                throw e;
            }
        }

        HsqlProperties newprops = DatabaseURL.parseURL(datapath, false, false);

        if (newprops == null) {
            HsqlException e = Error.error(ErrorCode.GENERAL_ERROR,
                                          "invalid database path");

            printError("invalid database path");
            setServerError(e);

            throw e;
        }

        String path = newprops.getProperty(DatabaseURL.url_database);
        String type = newprops.getProperty(DatabaseURL.url_connection_type);

        try {
            int dbid = DatabaseManager.getDatabase(type, path, this, newprops);

            dbID[i]             = dbid;
            dbActionSequence[i] = actionSequence;
            dbAlias[i]          = alias;
            dbPath[i]           = path;
            dbType[i]           = type;
            dbProps[i]          = newprops;

            return i;
        } catch (HsqlException e) {
            printError("Database [index=" + i + ", db=" + dbType[i]
                       + dbPath[i] + ", alias=" + dbAlias[i]
                       + "] did not open: " + e.toString());
            setServerError(e);

            throw e;
        }
    }

    final int getFirstEmptyDatabaseIndex() {

        for (int i = 0; i < dbAlias.length; i++) {
            if (dbAlias[i] == null) {
                return i;
            }
        }

        return -1;
    }

    /**
     * Opens this server's database instances. This method returns true If
     * at least one database goes online, otherwise it returns false.
     *
     * If opening any of the databases is attempted and an exception is
     * thrown, the server error is set to this exception.
     */
    final boolean openDatabases() {

        printWithThread("openDatabases() entered");

        boolean success = false;

        setDBInfoArrays();

        for (int i = 0; i < dbAlias.length; i++) {
            if (dbAlias[i] == null) {
                continue;
            }

            printWithThread("Opening database: [" + dbType[i] + dbPath[i]
                            + "]");

            StopWatch sw = new StopWatch();
            int       id;

            try {
                id = DatabaseManager.getDatabase(dbType[i], dbPath[i], this,
                                                 dbProps[i]);
                dbID[i] = id;
                success = true;
            } catch (HsqlException e) {
                printError("Database [index=" + i + ", db=" + dbType[i]
                           + dbPath[i] + ", alias=" + dbAlias[i]
                           + "] did not open: " + e.toString());
                setServerError(e);

                dbAlias[i] = null;
                dbPath[i]  = null;
                dbType[i]  = null;
                dbProps[i] = null;

                continue;
            }

            sw.stop();

            String msg = "Database [index=" + i + ", id=" + id + ", db="
                         + dbType[i] + dbPath[i] + ", alias=" + dbAlias[i]
                         + "] opened successfully";

            print(sw.elapsedTimeToMessage(msg));
        }

        printWithThread("openDatabases() exiting");

        if (isRemoteOpen) {
            success = true;
        }

        if (!success && getServerError() == null) {

            // database alias / path list is empty or without full info for any DB
            setServerError(Error.error(ErrorCode.SERVER_NO_DATABASE));
        }

        return success;
    }

    /**
     * Initialises the database attributes lists from the server properties object.
     */
    private void setDBInfoArrays() {

        IntKeyHashMap dbNumberMap  = getDBNameArray();
        int           maxDatabases = dbNumberMap.size();

        if (serverProperties.isPropertyTrue(
                ServerProperties.sc_key_remote_open_db)) {
            int max = serverProperties.getIntegerProperty(
                ServerProperties.sc_key_max_databases,
                ServerConstants.SC_DEFAULT_MAX_DATABASES);

            if (maxDatabases < max) {
                maxDatabases = max;
            }
        }

        dbAlias          = new String[maxDatabases];
        dbPath           = new String[dbAlias.length];
        dbType           = new String[dbAlias.length];
        dbID             = new int[dbAlias.length];
        dbActionSequence = new long[dbAlias.length];
        dbProps          = new HsqlProperties[dbAlias.length];

        Iterator it = dbNumberMap.keySet().iterator();

        for (int i = 0; it.hasNext(); ) {
            int    dbNumber = it.nextInt();
            String path     = getDatabasePath(dbNumber, true);

            if (path == null) {
                printWithThread("missing database path: "
                                + dbNumberMap.get(dbNumber));

                continue;
            }

            HsqlProperties dbURL = DatabaseURL.parseURL(path, false, false);

            if (dbURL == null) {
                printWithThread("malformed database path: " + path);

                continue;
            }

            dbAlias[i] = (String) dbNumberMap.get(dbNumber);
            dbPath[i]  = dbURL.getProperty("database");
            dbType[i]  = dbURL.getProperty("connection_type");
            dbProps[i] = dbURL;

            i++;
        }
    }

    /**
     * Returns a map of n values from server.dbname.n values to database names
     * from the properties object.
     */
    private IntKeyHashMap getDBNameArray() {

        final String  prefix       = ServerProperties.sc_key_dbname + ".";
        final int     prefixLen    = prefix.length();
        IntKeyHashMap idToAliasMap = new IntKeyHashMap();
        Enumeration   en           = serverProperties.propertyNames();

        for (; en.hasMoreElements(); ) {
            String key = (String) en.nextElement();

            if (!key.startsWith(prefix)) {
                continue;
            }

            int dbNumber;

            try {
                dbNumber = Integer.parseInt(key.substring(prefixLen));
            } catch (NumberFormatException e1) {
                printWithThread("malformed database enumerator: " + key);

                continue;
            }

            String alias = serverProperties.getProperty(key).toLowerCase();

            if (!aliasSet.add(alias)) {
                printWithThread("duplicate alias: " + alias);
            }

            Object existing = idToAliasMap.put(dbNumber, alias);

            if (existing != null) {
                printWithThread("duplicate database enumerator: " + key);
            }
        }

        return idToAliasMap;
    }

    /**
     * Constructs and installs a new ServerSocket instance for this server.
     *
     * @throws Exception if it is not possible to construct and install
     *      a new ServerSocket
     */
    private void openServerSocket() throws Exception {

        String    address;
        int       port;
        String[]  candidateAddrs;
        String    emsg;
        StopWatch sw;

        printWithThread("openServerSocket() entered");

        if (isTls()) {
            printWithThread("Requesting TLS/SSL-encrypted JDBC");
        }

        sw            = new StopWatch();
        socketFactory = HsqlSocketFactory.getInstance(isTls());
        address       = getAddress();
        port          = getPort();

        if (StringUtil.isEmpty(address)
                || ServerConstants.SC_DEFAULT_ADDRESS.equalsIgnoreCase(
                    address.trim())) {
            socket = socketFactory.createServerSocket(port);
        } else {
            try {
                socket = socketFactory.createServerSocket(port, address);
            } catch (UnknownHostException e) {
                candidateAddrs =
                    ServerConfiguration.listLocalInetAddressNames();

                int      messageID;
                Object[] messageParameters;

                if (candidateAddrs.length > 0) {
                    messageID = ErrorCode.M_SERVER_OPEN_SERVER_SOCKET_1;

                    StringBuffer sb = new StringBuffer();

                    for (int i = 0; i < candidateAddrs.length; i++) {
                        if (sb.length() > 0) {
                            sb.append(", ");
                        }

                        sb.append(candidateAddrs[i]);
                    }

                    messageParameters = new Object[] {
                        address, sb.toString()
                    };
                } else {
                    messageID = ErrorCode.M_SERVER_OPEN_SERVER_SOCKET_2;
                    messageParameters = new Object[]{ address };
                }

                throw new UnknownHostException(Error.getMessage(messageID, 0,
                        messageParameters));
            }
        }

        /*
         * Following line necessary for Java 1.3 on UNIX.  See accept()
         * comment elsewhere in this file.
         */
        socket.setSoTimeout(1000);
        printWithThread("Got server socket: " + socket);
        print(sw.elapsedTimeToMessage("Server socket opened successfully"));

        if (socketFactory.isSecure()) {
            print("Using TLS/SSL-encrypted JDBC");
        }

        printWithThread("openServerSocket() exiting");
    }

    /** Prints a timestamped message indicating that this server is online */
    private void printServerOnlineMessage() {

        String s = getProductName() + " " + getProductVersion()
                   + " is online on port " + this.getPort();

        printWithTimestamp(s);
        printResource("online.help");
    }

    /**
     * Prints a description of the server properties iff !isSilent().
     */
    protected void printProperties() {

        Enumeration e;
        String      key;
        String      value;

        // Avoid the waste of generating each description,
        // only for trace() to silently discard it
        if (isSilent()) {
            return;
        }

        e = serverProperties.propertyNames();

        while (e.hasMoreElements()) {
            key   = (String) e.nextElement();
            value = serverProperties.getProperty(key);

            printWithThread(key + "=" + value);
        }
    }

    /**
     * Puts this server into the SERVER_CLOSING state, closes the ServerSocket
     * and nullifies the reference to it. If the ServerSocket is already null,
     * this method exists immediately, otherwise, the result is to fully
     * shut down the server.
     */
    private synchronized void releaseServerSocket() {

        printWithThread("releaseServerSocket() entered");

        if (socket != null) {
            printWithThread("Releasing server socket: [" + socket + "]");
            setState(ServerConstants.SERVER_STATE_CLOSING);

            try {
                socket.close();
            } catch (IOException e) {
                printError("Exception closing server socket");
                printError("releaseServerSocket(): " + e);
            }

            socket = null;
        }

        printWithThread("releaseServerSocket() exited");
    }

    /**
     * Attempts to bring this server fully online by opening
     * a new ServerSocket, obtaining the hosted databases,
     * notifying the status waiter thread (if any) and
     * finally entering the listen loop if all else succeeds.
     * If any part of the process fails, then this server enters
     * its shutdown sequence.
     */
    private void run() {

        StopWatch   sw;
        ThreadGroup tg;
        String      tgName;

        printWithThread("run() entered");
        print("Initiating startup sequence...");
        printProperties();

        sw = new StopWatch();

        setServerError(null);

        try {

            // Faster init first:
            // It is huge waste to fully open the databases, only
            // to find that the socket address is already in use
            openServerSocket();
        } catch (Exception e) {
            setServerError(e);
            printError("run()/openServerSocket(): ");
            printStackTrace(e);
            shutdown(true);

            return;
        }

        tgName = "HSQLDB Connections @"
                 + Integer.toString(this.hashCode(), 16);
        tg = new ThreadGroup(tgName);

        tg.setDaemon(false);

        serverConnectionThreadGroup = tg;

        // Mount the databases this server is supposed to host.
        // This may take some time if the databases are not all
        // already open.
        if (!openDatabases()) {
            setServerError(null);
            printError("Shutting down because there are no open databases");
            shutdown(true);

            return;
        }

        // At this point, we have a valid server socket and
        // a valid hosted database set, so its OK to start
        // listening for connections.
        setState(ServerConstants.SERVER_STATE_ONLINE);
        print(sw.elapsedTimeToMessage("Startup sequence completed"));
        printServerOnlineMessage();

        // isShuttingDown is only read after socket connections are 'accept'ed.
        isShuttingDown = false;    // In case shutdown was aborted previously.

        try {
            /*
             * This loop is necessary for UNIX w/ Sun Java 1.3 because
             * in that case the socket.close() elsewhere will not
             * interrupt this accept().
             */
            while (socket != null) {
                try {
                    handleConnection(socket.accept());
                } catch (java.io.InterruptedIOException iioe) {}
            }
        } catch (IOException ioe) {
            if (getState() == ServerConstants.SERVER_STATE_ONLINE) {
                setServerError(ioe);
                printError(this + ".run()/handleConnection(): ");
                printStackTrace(ioe);
            }
        } catch (Throwable t) {
            printWithThread(t.toString());
        } finally {
            shutdown(false);    // or maybe getServerError() != null?
        }
    }

    /**
     * Sets this Server's last encountered error state.
     *
     * @param t The new value for the server error
     */
    protected void setServerError(Throwable t) {
        serverError = t;
    }

    /**
     * Shuts down all the database served by this server. As a consequence,
     * this server and any other server that is serving a subset of the
     * databases will be shutdown, unless the server was started with
     * server.remote_open property.
     *
     * The shutdownMode must be one of:
     *
     * <ul>
     * <li>org.hsqldb.Database.CLOSEMODE_IMMEDIATELY
     * <li>org.hsqldb.Database.CLOSEMODE_NORMAL
     * <li>org.hsqldb.Database.CLOSEMODE_COMPACT
     * <li>org.hsqldb.Database.CLOSEMODE_SCRIPT
     * </ul>
     * @param shutdownMode a value between 0-4, usually 0 or 1.
     */
    public void shutdownCatalogs(int shutdownMode) {
        DatabaseManager.shutdownDatabases(this, shutdownMode);
    }

    /**
     * Shuts down this server and all the database served by this server. As a
     * consequence, any other server that is serving a subset of the databases
     * will be shutdown, unless the server was started with server.remote_open
     * property.
     *
     * The shutdownMode must be one of:
     *
     * <ul>
     * <li>org.hsqldb.Database.CLOSEMODE_IMMEDIATELY
     * <li>org.hsqldb.Database.CLOSEMODE_NORMAL
     * <li>org.hsqldb.Database.CLOSEMODE_COMPACT
     * <li>org.hsqldb.Database.CLOSEMODE_SCRIPT
     * </ul>
     * @param shutdownMode a value between 0-4, usually 0 or 1.
     */
    public void shutdownWithCatalogs(int shutdownMode) {

        // If an unchecked exception is thrown, isShuttingDown will be left true,
        // which is good from a security standpoint.
        isShuttingDown = true;

        // make handleConnection() reject new connection attempts
        DatabaseManager.shutdownDatabases(this, shutdownMode);
        shutdown(false);

        isShuttingDown = false;
    }

    /**
     * External method to shut down this server.
     */
    public void shutdown() {
        shutdown(false);
    }

    /**
     * Shuts down this server.
     *
     * @param error true if shutdown is in response to an error
     *      state, else false
     */
    protected synchronized void shutdown(boolean error) {

        if (serverState == ServerConstants.SERVER_STATE_SHUTDOWN) {
            return;
        }

        StopWatch sw;

        printWithThread("shutdown() entered");

        sw = new StopWatch();

        print("Initiating shutdown sequence...");
        releaseServerSocket();
        DatabaseManager.deRegisterServer(this);

        if (dbPath != null) {
            for (int i = 0; i < dbPath.length; i++) {
                releaseDatabase(dbID[i]);
            }
        }

        // Be nice and let applications exit if there are no
        // running connection threads - wait at most 100 ms per active thread
        if (serverConnectionThreadGroup != null) {
            if (!serverConnectionThreadGroup.isDestroyed()) {
                int count = serverConnectionThreadGroup.activeCount();

                for (int i = 0;
                        serverConnectionThreadGroup.activeCount() > 0
                        && i < count;
                        i++) {
                    try {
                        Thread.sleep(100);
                    } catch (Exception e) {

                        // e.getMessage();
                    }
                }

                try {
                    serverConnectionThreadGroup.destroy();
                    printWithThread(serverConnectionThreadGroup.getName()
                                    + " destroyed");
                } catch (Throwable t) {
                    printWithThread(serverConnectionThreadGroup.getName()
                                    + " not destroyed");
                    printWithThread(t.toString());
                }
            }

            serverConnectionThreadGroup = null;
        }

        serverThread = null;

        setState(ServerConstants.SERVER_STATE_SHUTDOWN);
        print(sw.elapsedTimeToMessage("Shutdown sequence completed"));

        if (isNoSystemExit()) {
            printWithTimestamp("SHUTDOWN : System.exit() was not called");
            printWithThread("shutdown() exited");
        } else {
            printWithTimestamp("SHUTDOWN : System.exit() is called next");
            printWithThread("shutdown() exiting...");

            try {
                System.exit(0);
            } catch (Throwable t) {
                printWithThread(t.toString());
            }
        }
    }

    /**
     * Used by Connection object
     */
    synchronized void setActionSequence(int dbIndex) {
        dbActionSequence[dbIndex] = actionSequence++;
    }

    /**
     * Feature is turned off by, pending a property to allow it.
     */
    protected int closeOldestDatabase() {

        return -1;
/*
        int      index = -1;
        Database db;

        synchronized (this) {
            long min = Long.MAX_VALUE;

            for (int i = 0; i < dbActionSequence.length; i++) {
                if (min > dbActionSequence[i]) {
                    min   = dbActionSequence[i];
                    index = i;
                }
            }

            if (index == -1) {
                return -1;
            }

            db = DatabaseManager.lookupDatabaseObject(dbType[index],
                    dbPath[index]);

            if (db == null) {
                return -1;
            }
        }

        db.close(Database.CLOSEMODE_IMMEDIATELY);

        return index;
 */
    }

    /**
     * Prints message for the specified key, without any special
     * formatting. The message content comes from the server
     * resource bundle and thus may localized according to the default
     * JVM locale.<p>
     *
     * Uses System.out directly instead of Trace.printSystemOut() so it
     * always prints, regardless of Trace settings.
     *
     * @param key for message
     */
    protected static void printHelp(String key) {
        System.out.println(ResourceBundleHandler.getString(serverBundleHandle,
                key));
    }

    /**
     * Creates and starts a new Server.  <p>
     *
     * Allows starting a Server via the command line interface. <p>
     *
     * @param args the command line arguments for the Server instance
     */
    public static void main(String[] args) {

        HsqlProperties argProps = null;

        argProps = HsqlProperties.argArrayToProps(args,
                ServerProperties.sc_key_prefix);

        String[] errors = argProps.getErrorKeys();

        if (errors.length != 0) {
            System.out.println("no value for argument:" + errors[0]);
            printHelp("server.help");

            return;
        }

        String propsPath = argProps.getProperty(ServerProperties.sc_key_props);
        String propsExtension = "";

        if (propsPath == null) {
            propsPath      = "server";
            propsExtension = ".properties";
        } else {
            argProps.removeProperty(ServerProperties.sc_key_props);
        }

        propsPath = FileUtil.getFileUtil().canonicalOrAbsolutePath(propsPath);

        ServerProperties fileProps = ServerConfiguration.getPropertiesFromFile(
            ServerConstants.SC_PROTOCOL_HSQL, propsPath, propsExtension);
        ServerProperties props =
            fileProps == null
            ? new ServerProperties(ServerConstants.SC_PROTOCOL_HSQL)
            : fileProps;

        props.addProperties(argProps);
        ServerConfiguration.translateDefaultDatabaseProperty(props);

        // Standard behaviour when started from the command line
        // is to halt the VM when the server shuts down.  This may, of
        // course, be overridden by whatever, if any, security policy
        // is in place.
        ServerConfiguration.translateDefaultNoSystemExitProperty(props);
        ServerConfiguration.translateAddressProperty(props);

        // finished setting up properties;
        Server server = new Server();

        try {
            server.setProperties(props);
        } catch (Exception e) {
            server.printError("Failed to set properties");
            server.printStackTrace(e);

            return;
        }

        // now messages go to the channel specified in properties
        server.print("Startup sequence initiated from main() method");

        if (fileProps != null) {
            server.print("Loaded properties from [" + propsPath
                         + propsExtension + "]");
        } else {
            server.print("Could not load properties from file");
            server.print("Using cli/default properties only");
        }

        server.start();
    }
}

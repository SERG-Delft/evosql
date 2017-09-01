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


package org.hsqldb.jdbc;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Wrapper;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicIntegerArray;
import javax.naming.NamingException;
import javax.naming.Reference;
import javax.naming.Referenceable;
import javax.naming.StringRefAddr;
import javax.sql.ConnectionEvent;
import javax.sql.ConnectionEventListener;
import javax.sql.DataSource;
import javax.sql.PooledConnection;
import javax.sql.StatementEvent;
import javax.sql.StatementEventListener;

import org.hsqldb.jdbc.pool.JDBCPooledConnection;
import org.hsqldb.jdbc.pool.JDBCPooledDataSource;

/**
 * <!-- start Release-specific documentation -->
 * <div class="ReleaseSpecificDocumentation">
 * <h3>HSQLDB-Specific Information:</h3> <p>
 *
 * A connection pool for HyperSQL connections. This implementation of
 * {@link javax.sql.DataSource DataSource} is dedicated to HyperSQL and
 * guarantees all connection states are automatically reset when a connection
 * is reused.<p>
 *
 * The methods of the parent class,
 * {@link JDBCCommonDataSource} are used to specify the database URL, user,
 * password, and / or connection properties.<p>
 *
 * </div>
 * <!-- end Release-specific documentation -->
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 2.2.9
 */
@SuppressWarnings("serial")
public class JDBCPool implements DataSource,
                   Referenceable, ConnectionEventListener,
                   StatementEventListener, Wrapper {

    /**
     * Retrieves a new connection using the properties that have already been
     * set.
     *
     * @return  a connection to the data source
     * @exception SQLException if a database access error occurs
     */
    public Connection getConnection() throws SQLException {

        int retries = 300;

        if (source.loginTimeout != 0){
            retries = source.loginTimeout * 10;
        }

        if (closed) {
            throw new SQLException("connection pool is closed");
        }

        for (int count = 0; count < retries; count++) {
            for (int i = 0; i < states.length(); i++) {
                if (states.compareAndSet(i, RefState.available,
                                        RefState.allocated)) {
                    return connections[i].getConnection();
                }

                if (states.compareAndSet(i, RefState.empty,
                                        RefState.allocated)) {
                    try {
                        JDBCPooledConnection connection =
                            (JDBCPooledConnection) source.getPooledConnection();

                        connection.addConnectionEventListener(this);
                        connection.addStatementEventListener(this);
                        connections[i] = connection;

                        return connections[i].getConnection();
                    } catch (SQLException e) {
                        states.set(i, RefState.empty);
                    }
                }
            }

            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {}
        }

        throw JDBCUtil.invalidArgument();
    }

    /**
     * Retrieves a new connection using the given username and password,
     * and the database url that has been set. No other properties are
     * used for the connection.
     *
     * This method can be used only with the same username and password used
     * for the connection pool. The first call to this method sets the user name
     * and password for the connection pool.
     *
     * @param username the database user on whose behalf the connection is
     *  being made
     * @param password the user's password
     * @return  a connection to the data source
     * @exception SQLException if a database access error occurs
     */
    public Connection getConnection(String username, String password)
            throws SQLException {

        String user = getUser();

        if (username == null || password == null) {
            throw JDBCUtil.nullArgument();
        }

        if ( user == null) {
            setUser(username);
            setPassword(password);
        } else if (!user.equals(username)) {
            throw JDBCUtil.invalidArgument("user name does not match");
        }

        return getConnection();
    }

    // ------------------------- JDBC 4.0 -----------------------------------
    // ------------------- java.sql.Wrapper implementation ---------------------

    /**
     * Returns an object that implements the given interface to allow access to
     * non-standard methods, or standard methods not exposed by the proxy.
     *
     * If the receiver implements the interface then the result is the receiver
     * or a proxy for the receiver. If the receiver is a wrapper
     * and the wrapped object implements the interface then the result is the
     * wrapped object or a proxy for the wrapped object. Otherwise return the
     * the result of calling <code>unwrap</code> recursively on the wrapped object
     * or a proxy for that result. If the receiver is not a
     * wrapper and does not implement the interface, then an <code>SQLException</code> is thrown.
     *
     * @param iface A Class defining an interface that the result must implement.
     * @return an object that implements the interface. May be a proxy for the actual implementing object.
     * @throws java.sql.SQLException If no object found that implements the interface
     * @since JDK 1.6, HSQLDB 2.0
     */
    @SuppressWarnings("unchecked")
    public <T>T unwrap(java.lang.Class<T> iface) throws java.sql.SQLException {
        if (isWrapperFor(iface)) {
            return (T) this;
        }

        throw JDBCUtil.invalidArgument("iface: " + iface);
    }

    /**
     * Returns true if this either implements the interface argument or is directly or indirectly a wrapper
     * for an object that does. Returns false otherwise. If this implements the interface then return true,
     * else if this is a wrapper then return the result of recursively calling <code>isWrapperFor</code> on the wrapped
     * object. If this does not implement the interface and is not a wrapper, return false.
     * This method should be implemented as a low-cost operation compared to <code>unwrap</code> so that
     * callers can use this method to avoid expensive <code>unwrap</code> calls that may fail. If this method
     * returns true then calling <code>unwrap</code> with the same argument should succeed.
     *
     * @param iface a Class defining an interface.
     * @return true if this implements the interface or directly or indirectly wraps an object that does.
     * @throws java.sql.SQLException  if an error occurs while determining whether this is a wrapper
     * for an object with the given interface.
     * @since JDK 1.6, HSQLDB 2.0
     */
    public boolean isWrapperFor(java.lang.Class<?> iface)
            throws java.sql.SQLException {
        return ((iface != null) && iface.isAssignableFrom(this.getClass()));
    }

    /**
     * Retrieves the Reference of this object.
     *
     * @return The non-null Reference of this object.
     * @exception NamingException If a naming exception was encountered
     *          while retrieving the reference.
     */
    public Reference getReference() throws NamingException {
        String    cname = "org.hsqldb.jdbc.JDBCDataSourceFactory";
        Reference ref   = new Reference(getClass().getName(), cname, null);

        ref.add(new StringRefAddr("database", source.getDatabase()));
        ref.add(new StringRefAddr("user", source.getUser()));
        ref.add(new StringRefAddr("password", source.password));
        ref.add(new StringRefAddr("loginTimeout",
                                  Integer.toString(source.loginTimeout)));
        ref.add(new StringRefAddr("poolSize", Integer.toString(connections.length)));

        return ref;
    }

    // ------------------------ event listener ------------------------
    public void connectionClosed(ConnectionEvent event) {
        PooledConnection connection = (PooledConnection) event.getSource();

        for (int i = 0; i < connections.length; i++) {
            if (connections[i] == connection) {
                states.set(i, RefState.available);

                break;
            }
        }
    }

    public void connectionErrorOccurred(ConnectionEvent event) {
        PooledConnection connection = (PooledConnection) event.getSource();

        for (int i = 0; i < connections.length; i++) {
            if (connections[i] == connection) {
                states.set(i, RefState.allocated);
                connections[i] = null;
                states.set(i, RefState.empty);
                break;
            }
        }
    }

    public void statementClosed(StatementEvent event) {}

    public void statementErrorOccurred(StatementEvent event) {}


    // ------------------------ event listener ------------------------
    /**
     * <p>Retrieves the log writer for this <code>DataSource</code>
     * object.
     *
     * <p>The log writer is a character output stream to which all logging
     * and tracing messages for this data source will be
     * printed.  This includes messages printed by the methods of this
     * object, messages printed by methods of other objects manufactured
     * by this object, and so on.  Messages printed to a data source
     * specific log writer are not printed to the log writer associated
     * with the <code>java.sql.DriverManager</code> class.  When a
     * <code>DataSource</code> object is
     * created, the log writer is initially null; in other words, the
     * default is for logging to be disabled.
     *
     * @return the log writer for this data source or null if
     *        logging is disabled
     * @exception java.sql.SQLException if a database access error occurs
     * @see #setLogWriter
     * @since 1.4
     */
    public PrintWriter getLogWriter() throws SQLException {
        return source.getLogWriter();
    }

    /**
     * <p>Sets the log writer for this <code>DataSource</code>
     * object to the given <code>java.io.PrintWriter</code> object.
     *
     * <p>The log writer is a character output stream to which all logging
     * and tracing messages for this data source will be
     * printed.  This includes messages printed by the methods of this
     * object, messages printed by methods of other objects manufactured
     * by this object, and so on.  Messages printed to a data source-
     * specific log writer are not printed to the log writer associated
     * with the <code>java.sql.DriverManager</code> class. When a
     * <code>DataSource</code> object is created the log writer is
     * initially null; in other words, the default is for logging to be
     * disabled.
     *
     * @param out the new log writer; to disable logging, set to null
     * @exception SQLException if a database access error occurs
     * @see #getLogWriter
     * @since 1.4
     */
    public void setLogWriter(java.io.PrintWriter out) throws SQLException {
        source.setLogWriter(out);
    }

    /**
     * <p>Sets the maximum time in seconds that this data source will wait
     * while attempting to connect to a database.  A value of zero
     * specifies that the timeout is the default system timeout
     * if there is one; otherwise, it specifies that there is no timeout.
     * When a <code>DataSource</code> object is created, the login timeout is
     * initially zero.
     *
     * @param seconds the data source login time limit
     * @exception SQLException if a database access error occurs.
     * @see #getLoginTimeout
     * @since 1.4
     */
    public void setLoginTimeout(int seconds) throws SQLException {
        source.setLoginTimeout(seconds);
    }

    /**
     * Gets the maximum time in seconds that this data source can wait
     * while attempting to connect to a database.  A value of zero
     * means that the timeout is the default system timeout
     * if there is one; otherwise, it means that there is no timeout.
     * When a <code>DataSource</code> object is created, the login timeout is
     * initially zero.
     *
     * @return the data source login time limit
     * @exception SQLException if a database access error occurs.
     * @see #setLoginTimeout
     * @since 1.4
     */
    public int getLoginTimeout() throws SQLException {
        return source.getLoginTimeout();
    }

    // ------------------------ custom public methods ------------------------

    /**
     * Retrieves the description of the data source. <p>
     *
     * @return the description
     */
    public String getDescription() {
        return "org.hsqldb.jdbc.JDBCPool max size " + connections.length;
    }

    /**
     * Retrieves the name of the data source. <p>
     *
     * @return the description
     */
    public String getDataSourceName() {
        return "org.hsqldb.jdbc.JDBCPool";
    }

    /**
     * Synonym for getUrl().
     *
     * @return the jdbc database connection url attribute
     */
    public String getDatabaseName() {
        return source.getUrl();
    }

    /**
     * Synonym for getUrl().
     *
     * @return the jdbc database connection url attribute
     */
    public String getDatabase() {
        return source.getDatabase();
    }

    /**
     * Retrieves the jdbc database connection url attribute. <p>
     *
     * @return the jdbc database connection url attribute
     */
    public String getUrl() {
        return source.getUrl();
    }

    /**
     * Retrieves the jdbc database connection url attribute. <p>
     *
     * @return the jdbc database connection url attribute
     */
    public String getURL() {
        return source.getUrl();
    }

    /**
     * Retrieves the user name for the connection. <p>
     *
     * @return the username for the connection
     */
    public String getUser() {
        return source.getUser();
    }

    /**
     * Synonym for setUrl(String). <p>
     *
     * @param databaseName the new value for the attribute
     */
    public void setDatabaseName(String databaseName) {
        source.setDatabaseName(databaseName);
    }

    /**
     * Synonym for setUrl(String). <p>
     *
     * @param database the new value for the attribute
     */
    public void setDatabase(String database) {
        source.setDatabase(database);
    }

    /**
     * Sets the jdbc database URL. <p>
     *
     * @param url the new value of this object's jdbc database connection
     *      url attribute
     */
    public void setUrl(String url) {
        source.setUrl(url);
    }

    /**
     * Sets the jdbc database URL. <p>
     *
     * @param url the new value of this object's jdbc database connection
     *      url attribute
     */
    public void setURL(String url) {
        source.setUrl(url);
    }

    /**
     * Sets the password for the user name.
     *
     * @param password the password
     */
    public void setPassword(String password) {
        source.setPassword(password);
    }

    /**
     * Sets the user name.
     *
     * @param user the user id
     */
    public void setUser(String user) {
        source.setUser(user);
    }

    /**
     * Sets connection properties. If user / password / loginTimeout has been
     * set with one of the setXXX() methods it will be added to the Properties
     * object.
     *
     * @param props properties.  If null, then existing properties will be
     *                           cleared/replaced.
     */
    public void setProperties(Properties props) {
        source.setProperties(props);
    }

    //------------------------- JDBC 4.1 -----------------------------------

    /**
     * Return the parent Logger of all the Loggers used by this data source. This
     * should be the Logger farthest from the root Logger that is
     * still an ancestor of all of the Loggers used by this data source. Configuring
     * this Logger will affect all of the log messages generated by the data source.
     * In the worst case, this may be the root Logger.
     *
     * @return the parent Logger for this data source
     * @throws SQLFeatureNotSupportedException if the data source does not use <code>java.util.logging<code>.
     * @since JDK 1.7 M11 2010/09/10 (b123), HSQLDB 2.2.9
     */
//#ifdef JAVA6
    public java.util.logging.Logger getParentLogger()
    throws java.sql.SQLFeatureNotSupportedException {
        throw (java.sql.SQLFeatureNotSupportedException) JDBCUtil.notSupported();
    }

    // ------------------------ custom public methods ------------------------

    /**
     * Creates a connection pool with the maximum size of 8. The database and
     * connection settings are made before the {@link #getConnection()} is called.
     */
    public JDBCPool() {
        this(10);
    }

    /**
     * Creates a connection pool with the given maximum size. The database and
     * connection settings are made before the {@link #getConnection()} is called.
     *
     * @param size int maximum size of the pool
     */
    public JDBCPool(int size) {
        source = new JDBCPooledDataSource();
        connections = new JDBCPooledConnection[size];
        states = new AtomicIntegerArray(size);    }

    /**
     * Closes the pool immediately. Waits the given number of seconds before
     * closing all existing connections in the pool.
     *
     * @param wait int number of seconds to wait before closing the connections, maximum 60 seconds
     * @throws SQLException
     */
    public void close(int wait) throws SQLException {

        if (wait <0 || wait > 60) {
            throw JDBCUtil.outOfRangeArgument();
        }
        if (closed) {
            return;
        }

        closed = true;

        try {
            Thread.sleep(1000 * wait);
        } catch (Throwable t) {}

        for (int i = 0; i < connections.length; i++) {
            if (connections[i] != null) {
                connections[i].release();
            }
        }

        for (int i = 0; i < connections.length; i++) {
            connections[i] = null;
        }

    }
    // ------------------------ internal ------------------------
    interface RefState {
        int empty     = 0;
        int available = 1;
        int allocated = 2;
    }


    AtomicIntegerArray       states;
    JDBCPooledConnection[]   connections;
    JDBCPooledDataSource     source;
    volatile boolean         closed;
}

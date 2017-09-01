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


package org.hsqldb.auth;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hsqldb.jdbc.JDBCArrayBasic;
import org.hsqldb.lib.FrameworkLogger;
import org.hsqldb.types.Type;

/**
 * This class provides a method which can be used directly as a HyperSQL static
 * Java function method.
 * Manages a set of AuthFunctionBean implementations
 *
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 * @since 2.0.1
 */
public class AuthBeanMultiplexer {
    private static FrameworkLogger logger =
            FrameworkLogger.getLog(AuthBeanMultiplexer.class);

    /**
     * This sole constructor is purposefully private, so users or frameworks
     * that want to work with instances will be forced to use the singleton
     * instead of creating useless extra instance copies.
     */
    private AuthBeanMultiplexer() {
        // Intentionally empty
    }

    private static AuthBeanMultiplexer singleton = new AuthBeanMultiplexer();

    /**
     * @see #setAuthFunctionBeans(List)
     */
    private static Map<String, List<AuthFunctionBean>> beans =
            new HashMap<String, List<AuthFunctionBean>>();

    public static AuthBeanMultiplexer getSingleton() {
        return singleton;
    }

    /**
     * Clear the set of AuthFunctionBeans
     */
    public void clear() {
        AuthBeanMultiplexer.beans.clear();
    }

    /**
     * Primary purpose of this class is to manage this static map.
     * From dbNames to ordered-lists-of-AuthFunctionBeans.
     * This is not an "adder" function, but a "setter" function, so do not use
     * this to add to a partial set, but to assign the entire set.
     * <P>
     * The given entries are copied, to limit side-effects and concurrency
     * issues.
     * </P>
     */
    public void setAuthFunctionBeans(
            Map<String, List<AuthFunctionBean>> authFunctionBeanMap) {
        if (AuthBeanMultiplexer.beans.size() > 0)
            throw new IllegalStateException(
                    "Use setAuthFunctionBeans(Map) only when the set is empty");
        AuthBeanMultiplexer.beans.putAll(authFunctionBeanMap);
    }

    protected static String getUniqueNameFor(Connection c) throws SQLException {
        Statement st = c.createStatement();
        ResultSet rs = null;
        try {
            rs = st.executeQuery("CALL database_name()");
            if (!rs.next()) {
                throw new SQLException(
                        "Engine did not reveal unique database name");
            }
            return rs.getString(1);
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException se) {
                logger.error(
                        "Failed to close ResultSet for retrieving db name");
            }
            rs = null;  // Encourage GC
            try {
                st.close();
            } catch (SQLException se) {
                logger.error(
                        "Failed to close Statement for retrieving db name");
            }
            st = null;  // Encourage GC
        }
    }

    /**
     * Wrapper for setAuthFunctionBeans(String, List<AuthFunctionBean>)
     *
     * @param c  An open Connection to the desired database.
     * @throws SQLException if failed to obtain unique name from given
     *                      Connection.
     */
    public void setAuthFunctionBeans(Connection c,
            List<AuthFunctionBean> authFunctionBeans) throws SQLException {
        setAuthFunctionBeans(getUniqueNameFor(c), authFunctionBeans);
    }

    /**
     * This is not an "adder" function, but a "setter" function for the
     * specified dbName , so do not use this to add to a database's
     * FunctionBeans, but to assign the entire list for that database.
     * <P>
     * The given entries are copied, to limit side-effects and concurrency
     * issues.
     * </P> <P>
     * Use this method instead of setAuthFunctionBean(String, AuthFunctionBean)
     * in order to set up multiple authenticators for a single database for
     * redundancy purposes.
     * </P>
     *
     * @see #setAuthFunctionBeans(Map)
     * @see #setAuthFunctionBean(String, AuthFunctionBean)
     */
    public void setAuthFunctionBeans(String dbName,
            List<AuthFunctionBean> authFunctionBeans) {
        if (dbName == null || dbName.length() != 16) {
            throw new IllegalArgumentException(
                    "Database name not exactly 16 characters long: "
                    + dbName);
        }
        List<AuthFunctionBean> dbsBeans = AuthBeanMultiplexer.beans.get(dbName);
        if (dbsBeans == null) {
            dbsBeans = new ArrayList<AuthFunctionBean>();
            AuthBeanMultiplexer.beans.put(dbName, dbsBeans);
        } else {
            if (dbsBeans.size() > 0)
                throw new IllegalStateException(
                        "Use setAuthFunctionBeans(String, List) only when the "
                        + "db's AuthFunctionBean list is empty");
        }
        dbsBeans.addAll(authFunctionBeans);
    }

    /**
     * Exactly the same as setAuthFunctionBeans(String, List) other than taking
     * an open Connection to identify the database.
     */
    public void setAuthFunctionBean(Connection c,
            AuthFunctionBean authFunctionBean) throws SQLException {
        setAuthFunctionBeans(getUniqueNameFor(c),
                Collections.singletonList(authFunctionBean));
    }

    /**
     * This is not an "adder" function, but a "setter" function for the
     * specified dbName , so do not use this to add to a database's
     * FunctionBeans, but to assign ths single given AuthFunctionBean as the
     * specified database's authenticator.
     * <P>
     * To set up multiple authenticators for a single database for redundancy
     * purposes, use the method setAuthFunctionBeans(String, List) instead.
     * </P>
     *
     * @see #setAuthFunctionBeans(String, List)
     */
    public void setAuthFunctionBean(String dbName,
            AuthFunctionBean authFunctionBean) {
        setAuthFunctionBeans(
                dbName, Collections.singletonList(authFunctionBean));
    }

    /**
     * HyperSQL Java Function Method.
     * <P>
     * Registered AuthFunctionBeans matching the specified database and password
     * will be tried in order.
     * <OL>
     *   <li>If the AuthFunctionBean being tried throws a non-runtime Exception,
     *       then that RuntimeException is passed through (re-thrown), resulting
     *       in a SQLException for the authenticating application.
     *   <li>If the AuthFunctionBean being tried doesn't throw anything, then
     *       the return value is passed through (returned) and HyperSQL will
     *       allow access and set roles according to HyperSQL's authentication
     *       function contract.
     *   <LI>If the AuthFunctionBean being tried throws a RuntimeException, then
     *       the next AuthFunctionBean in turn will be tried.
     *       If all matching AuthFunctionBeans throw RuntimeExceptions, then the
     *       first RuntimeException that was thrown will be passed through
     *       (re-thrown), resulting in a SQLException for the authenticating
     *       application.
     *   <LI>If there are no AuthFunctionBeans registered for the specified
     *       dbName, then this method will throw an IllegalArgumentException,
     *       resulting in a SQLException for the authenticating application.
     * </OL>
     *
     * @see "HyperSQL User Guide, System Management chapter, Authentication Settings subsection."
     * @throws IllegalArgumentException if no AuthFunctionBean has been set for
     *         specified dbName.
     * @throws RuntimeException if all matching AuthFunctionBeans threw
     *         RuntimeExceptions.  (This indicates that no matching
     *         AuthFunctionBean functioned properly, not that authentication was
     *         purposefully denied by any AuthFunctionBean).
     * @throws Exception (non-runtime).  A matching AuthFunctionBean threw this
     *         Exception.
     * @return Null or java.sql.Array to indicate successful authentication
     *         according to the contract for HyperSQL authentication functions.
     */
    public static java.sql.Array authenticate(
            String database, String user, String password)
            throws Exception {
        /* This method both logs and throws because due to JDBC requirements,
         * the Exception messages will not make it to applications.
         * Though these messages won't make it to the end user, at least the
         * application administer will have access to problem details. */
        if (database == null || database.length() != 16) {
            throw new IllegalStateException("Internal problem.  "
                    + "Database name not exactly 16 characters long: "
                    + database);
        }
        List<AuthFunctionBean> beanList =
                AuthBeanMultiplexer.beans.get(database);
        if (beanList == null) {
            logger.error("Database '" + database
                    + "' has not been set up with "
                    + AuthBeanMultiplexer.class.getName());
            throw new IllegalArgumentException("Database '" + database
                    + "' has not been set up with "
                    + AuthBeanMultiplexer.class.getName());
        }
        Exception firstRTE = null;
        String[] beanRet;
        for (AuthFunctionBean nextBean : beanList) try {
            beanRet = nextBean.authenticate(user, password);
            return (beanRet == null)
                    ? null : new JDBCArrayBasic(beanRet, Type.SQL_VARCHAR);
        } catch (RuntimeException re) {
            if (firstRTE == null) {
                firstRTE = re;
            }
            logger.error("System failure of an AuthFunctionBean: "
                    + ((re.getMessage() == null)
                      ? re.toString() : re.getMessage()));
        } catch (Exception e) {
            throw e;
        }
        throw firstRTE;
    }
}

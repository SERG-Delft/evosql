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


package org.hsqldb.auth;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Set;

import org.hsqldb.lib.FrameworkLogger;

/**
 * Delegates authentication decisions, and optionally determination of user
 * roles and schema, to a different HyperSQL catalog, which may be in the same
 * JVM or remote.
 *
 * For now, at least, this class uses DriverManager to make the ephemeral
 * database connections.
 *
 * @see AuthFunctionBean
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 * @since 2.0.1
 */
public class HsqldbSlaveAuthBean implements AuthFunctionBean {
    private static FrameworkLogger logger =
            FrameworkLogger.getLog(HsqldbSlaveAuthBean.class);

    private String masterJdbcUrl, validationUser, validationPassword;
    private boolean delegateRolesSchema = true;
    protected boolean initialized;

    /**
     * Use this method and setValidationPassword if you want access to the
     * master database to be verified upon instance initialization.
     */
    public void setValidationUser(String validationUser) {
        this.validationUser = validationUser;
    }

    /**
     * Use this method and setValidationUser if you want access to the
     * master database to be verified upon instance initialization.
     */
    public void setValidationPassword(String validationPassword) {
        this.validationPassword = validationPassword;
    }

    public void setMasterJdbcUrl(String masterJdbcUrl) {
        this.masterJdbcUrl = masterJdbcUrl;
    }

    /**
     * Defaults to true.
     *
     * Whether roles and initial schema for the new session will be determined
     * by what they are for this user in the master database.
     */
    public void setDelegateRolesSchema(boolean doDelegateRolesSchema) {
        delegateRolesSchema = doDelegateRolesSchema;
    }

    public HsqldbSlaveAuthBean() {
        // Intentionally empty
    }

    /**
     * @throws IllegalStateException if any required setting has not been set.
     * @throws SQLException if properties 'validationUser' and
     *    'validationPassword' have been set, but we fail to connect to the
     *    master database.
     */
    public void init() throws SQLException {
        if (masterJdbcUrl == null) {
            throw new IllegalStateException(
                    "Required property 'masterJdbcUrl' not set");
        }
        if (validationUser != null || validationPassword != null) {
            if (validationUser == null || validationPassword == null) {
                throw new IllegalStateException(
                        "If you set one property of 'validationUser' or "
                        + "'validationPassword', then you must set both.");
            }
            Connection c = null;
            SQLException problem = null;
            try {
                c = DriverManager.getConnection(
                        masterJdbcUrl, validationUser, validationPassword);
            } catch (SQLException se) {
                logger.error("Master/slave Connection validation failure", se);
                problem = se;  // Just indicates to let the original exception
                  // percolate through in the finally block, to prevent an
                  // exception in the finally block from obscuring the ultimate
                  // cause of the problem.
            } finally {
                if (c != null) try {
                    c.close();
                    c = null;  // Encourage GC
                } catch (SQLException nestedSe) {
                    logger.error(
                            "Failed to close test master/slave Connection",
                            nestedSe);
                    if (problem == null) {
                        throw nestedSe;
                    }
                }
            }
        }
        initialized = true;
    }

    /**
     * @see AuthFunctionBean#authenticate(String, String)
     */
    public String[] authenticate(String userName, String password)
            throws DenyException {
        if (!initialized) {
            throw new IllegalStateException(
                "You must invoke the 'init' method to initialize the "
                + HsqldbSlaveAuthBean.class.getName() + " instance.");
        }
        Connection c = null;
        try {
            c = DriverManager.getConnection(masterJdbcUrl, userName, password);
            if (delegateRolesSchema) {
                Set<String> schemaAndRoles = AuthUtils.getEnabledRoles(c);
                String schemaOnMaster = AuthUtils.getInitialSchema(c);
                if (schemaOnMaster != null) {
                    schemaAndRoles.add(schemaOnMaster);
                }
                logger.finer("Slave delegating schema+roles: "
                        + schemaAndRoles);
                return schemaAndRoles.toArray(new String[0]);
            }
            return null;
        } catch (SQLException se) {
            throw new DenyException();
        } finally {
            if (c != null) try {
                c.close();
                c = null;  // Encourage GC
            } catch (SQLException nestedSe) {
                logger.severe(
                        "Failed to close master/slave Connection", nestedSe);
            }
        }
    }
}

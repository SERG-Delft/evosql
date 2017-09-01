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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Set;

import org.hsqldb.lib.FrameworkLogger;

/**
 * Static external-auth-related utilities.
 *
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 * @since 2.0.1
 */
public class AuthUtils {
    private static FrameworkLogger logger =
            FrameworkLogger.getLog(AuthUtils.class);

    /**
     * Do not instantiate an AuthUtils, because the only purpose of
     * this class is to provide static methods.
     */
    private AuthUtils() {
        // Intentionally empty
    }

    static String getInitialSchema(Connection c) throws SQLException {
        Statement st = c.createStatement();
        ResultSet rs = null;
        try {
            rs = st.executeQuery(
                "SELECT initial_schema FROM information_schema.system_users\n"
                + "WHERE user_name = current_user");
            if (!rs.next()) {
                throw new IllegalStateException(
                        "Failed to retrieve initial_schema for current user");
            }
            return rs.getString(1);
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException se) {
                logger.error("Failed "
                        + "to close ResultSet for retrieving initial schema");
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

    static Set getEnabledRoles(Connection c) throws SQLException {
        Set roles = new HashSet<String>();
        Statement st = c.createStatement();
        ResultSet rs = null;
        try {
            rs = st.executeQuery(
                    "SELECT * FROM information_schema.enabled_roles");
            while (rs.next()) roles.add(rs.getString(1));
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
        return roles;
    }
}

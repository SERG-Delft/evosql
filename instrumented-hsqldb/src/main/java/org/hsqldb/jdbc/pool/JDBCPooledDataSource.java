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


package org.hsqldb.jdbc.pool;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Properties;

import javax.naming.NamingException;
import javax.naming.Reference;
import javax.naming.Referenceable;
import javax.naming.StringRefAddr;
import javax.sql.ConnectionPoolDataSource;
import javax.sql.PooledConnection;

//#ifdef JAVA6
import javax.sql.CommonDataSource;

//#endif JAVA6
import org.hsqldb.jdbc.JDBCCommonDataSource;
import org.hsqldb.jdbc.JDBCConnection;
import org.hsqldb.jdbc.JDBCDriver;

/**
 * A data source that implements {@link javax.sql.ConnectionPoolDataSource}.<p>
 * For use by connection pooling software, not by end users.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.2.9
 * @since JDK 1.2, HSQLDB 2.0
 */
public class JDBCPooledDataSource extends JDBCCommonDataSource
implements ConnectionPoolDataSource, Serializable, Referenceable

//#ifdef JAVA6
, CommonDataSource

//#endif JAVA6
{

    public PooledConnection getPooledConnection() throws SQLException {

        JDBCConnection connection =
            (JDBCConnection) JDBCDriver.getConnection(url, connectionProps);

        return new JDBCPooledConnection(connection);
    }

    public PooledConnection getPooledConnection(String user,
            String password) throws SQLException {

        Properties props = new Properties();

        props.setProperty("user", user);
        props.setProperty("password", password);

        JDBCConnection connection =
            (JDBCConnection) JDBCDriver.getConnection(url, props);

        return new JDBCPooledConnection(connection);
    }

    /**
     * Retrieves the Reference of this object.
     *
     * @return The non-null javax.naming.Reference of this object.
     * @exception NamingException If a naming exception was encountered
     *          while retrieving the reference.
     */
    public Reference getReference() throws NamingException {

        String    cname = "org.hsqldb.jdbc.JDBCDataSourceFactory";
        Reference ref   = new Reference(getClass().getName(), cname, null);

        ref.add(new StringRefAddr("database", getDatabase()));
        ref.add(new StringRefAddr("user", getUser()));
        ref.add(new StringRefAddr("password", password));
        ref.add(new StringRefAddr("loginTimeout",
                                  Integer.toString(loginTimeout)));

        return ref;
    }
}

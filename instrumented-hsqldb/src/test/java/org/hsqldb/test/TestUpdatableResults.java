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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class TestUpdatableResults extends TestBase {

    public TestUpdatableResults(String name) {
        super(name);
    }

    public void testQuery() {

        try {
            Connection c = newConnection();
            Statement st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                             ResultSet.CONCUR_UPDATABLE);
            String s =
                "CREATE TABLE T (I INTEGER, C CHARACTER(10) DEFAULT 'def', B BIT(4) DEFAULT B'1010')";

            st.execute(s);

            s = "INSERT INTO T VALUES(?,?, DEFAULT)";

            PreparedStatement ps = c.prepareStatement(s);

            for (int i = 1; i <= 20; i++) {
                ps.setInt(1, i);
                ps.setString(2, "TEST " + i);
                ps.execute();
            }

            c.setAutoCommit(false);

            s = "SELECT * FROM T";

            ResultSet rs = st.executeQuery(s);

            rs.absolute(10);
            rs.updateString(2, "UPDATE10");
            rs.updateRow();
            rs.absolute(11);
            rs.deleteRow();
            rs.moveToInsertRow();
            rs.updateInt(1, 1011);
            rs.updateString(2, "INSERT1011");
            rs.updateString(3, "0101");
            rs.insertRow();
            try {
                rs.moveToInsertRow();
                rs.updateInt(1, 1012);
                rs.updateString(2, "INSERT1011");
                rs.insertRow();
                rs.moveToInsertRow();
                rs.updateInt(1, 1012);
                rs.insertRow();
                rs.close();
            } catch (SQLException e) {

            }
            rs = st.executeQuery(s);

            while (rs.next()) {
                System.out.println("" + rs.getInt(1) + "      "
                                   + rs.getString(2) + "      "
                                   + rs.getString(3));
            }

            s = "SELECT I FROM T";

            rs = st.executeQuery(s);

            rs.moveToInsertRow();
            rs.updateInt(1, 1012);
            rs.insertRow();

            s = "SELECT I, B FROM T";

            rs = st.executeQuery(s);

            rs.moveToInsertRow();
            rs.updateInt(1, 1013);
            rs.updateString(2, "1111");
            rs.insertRow();

            s = "SELECT * FROM T WHERE I > 1011";
            rs = st.executeQuery(s);

            while (rs.next()) {
                System.out.println("" + rs.getInt(1) + "      "
                                   + rs.getString(2) + "      "
                                   + rs.getString(3));
            }

            st.execute("SHUTDOWN");

            if (!isNetwork) {
                c.close();
            }
        } catch (Exception e) {
            System.out.print(e);
        }
    }
}

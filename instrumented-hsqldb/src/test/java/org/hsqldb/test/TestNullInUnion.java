/* Copyright (c) 2001-2009, The HSQL Development Group
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
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import junit.framework.TestCase;

public class TestNullInUnion extends TestCase {

    public void testUnionSubquery() throws Exception {

        Class.forName("org.hsqldb.jdbcDriver").newInstance();

        Connection con = DriverManager.getConnection("jdbc:hsqldb:mem:test",
            "sa", "");
        Statement st = con.createStatement();

        st.execute(
            "CREATE TABLE t1 (id int not null, v1 int, v2 int, primary key(id))");
        st.execute(
            "CREATE TABLE t2 (id int not null, v1 int, v3 int, primary key(id))");
        st.execute("INSERT INTO t1 values(1,1,1)");
        st.execute("INSERT INTO t1 values(2,2,2)");
        st.execute("INSERT INTO t2 values(1,3,3)");

        ResultSet rs = st.executeQuery(
            "select t as atable, a as idvalue, b as value1, c as value2, d as value3 from("
            + "(select 't1' as t, t1.id as a, t1.v1 as b, t1.v2 as c, null as d from t1) union"
            + "(select 't2' as t, t2.id as a, t2.v1 as b, null as c, t2.v3 as d from t2)) order by atable, idvalue");

        assertTrue(rs.next());
        assertEquals("t1", rs.getObject("atable"));
        assertEquals(1, rs.getInt("idvalue"));
        assertEquals(1, rs.getInt("value1"));
        assertEquals(1, rs.getInt("value2"));
        assertEquals(null, rs.getObject("value3"));
        assertTrue(rs.next());
        assertEquals("t1", rs.getObject("atable"));
        assertEquals(2, rs.getInt("idvalue"));
        assertEquals(2, rs.getInt("value1"));
        assertEquals(2, rs.getInt("value2"));
        assertEquals(null, rs.getObject("value3"));
        assertTrue(rs.next());
        assertEquals("t2", rs.getObject("atable"));
        assertEquals(1, rs.getInt("idvalue"));
        assertEquals(3, rs.getInt("value1"));
        assertEquals(null, rs.getObject("value2"));
        assertEquals(3, rs.getInt("value3"));    //this fails!
        assertFalse(rs.next());
    }
}

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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import junit.framework.Assert;

/**
 * Base tests for the period predicates queries.
 *
 * @author Pascal-Eric Servais (peservais at users dot sourceforge dot net)
 * @version 2.3.4
 * @since 2.3.4
 */
public class TestSqlPeriodPredicates extends TestBase {

    private Connection conn;

    public TestSqlPeriodPredicates(String name) throws Exception {

        super(name,  "jdbc:hsqldb:mem:test", true, false);
    }
    
    public void setUp() throws Exception {
        super.setUp();
        conn = newConnection();

		Statement stmt = conn.createStatement();
		stmt.executeUpdate("DROP TABLE PUBLIC.emp IF EXISTS");
		stmt.executeUpdate("CREATE TABLE PUBLIC.emp (emp_id INTEGER NOT NULL,name VARCHAR(30),salary DECIMAL(10,2),dept_id INTEGER,bus_start DATETIME NOT NULL,bus_end DATETIME NOT NULL);");
		
		stmt.executeUpdate("insert into PUBLIC.emp (emp_id, name, salary, dept_id, bus_start, bus_end)"
			+"values"
			+"(1, 'Tom', 300000.00, 1, TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03'),"
			+"(2, 'Tom', 305000.00, 1, TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-03-01 01:02:03'),"
			+"(3, 'Tom', 310000.00, 1, TIMESTAMP '2000-03-01 01:02:03', TIMESTAMP '2000-04-01 01:02:03')"
			+";");
		
		stmt.close();
    }

    public void tearDown() {
    	super.tearDown();
    }
    
    /**
     * Set the two parameters of the prepared statement, execute the query and validate the returned result set.
     */
    private void executeAndTestQuery(PreparedStatement stmt, String periodStart, String periodEnd, int... expectedIds) throws SQLException {
    	stmt.setString(1, periodStart);
    	stmt.setString(2, periodEnd);
    	
    	ResultSet rs = stmt.executeQuery();
    	assertAllIdsPresent(rs, expectedIds);
    	rs.close();
    }

    /**
     * Validate that all the expected ids are contained within the result set.
     * 
     * @param rs result set containing the result of the query
     * @param expectedIds list if the expected ids. If null, expects an empty result set.
     * @throws SQLException
     */
    private void assertAllIdsPresent(ResultSet rs, int... expectedIds) throws SQLException {
		Set<Integer> expected = new TreeSet<Integer>();
		Set<Integer> found = new TreeSet<Integer>();
		if(expectedIds != null) {
			for(int id : expectedIds) {
				expected.add(id);
			}
		}
		while(rs.next()) {
			found.add(rs.getInt(1));
		}
		Assert.assertEquals(expected.size(), found.size());
		Assert.assertTrue(found.containsAll(expected));
	}
    
    public void testFirstPeriodOverlapsSecondPeriod() throws SQLException {
    	
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) OVERLAPS PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-01 01:02:03'");

    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-12 01:02:03'", 1);

    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-12-31 01:02:03'", 1, 2, 3);

    	executeAndTestQuery(stmt, "TIMESTAMP '2000-04-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'");

    	stmt.close();
    }

    public void testFirstPeriodOverlapsSecondPeriodReversed() throws SQLException {
    	
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (?, ?) OVERLAPS PERIOD (BUS_START, BUS_END);";
		PreparedStatement stmt = conn.prepareStatement(query);

    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-12 01:02:03'", 1);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-01 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-12-31 01:02:03'", 1, 2, 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-04-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'");
    	
    	stmt.close();
    }

    public void testFirstPeriodOverlapsWithInterval() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (?, INTERVAL '40' DAY) OVERLAPS PERIOD (BUS_START, BUS_END);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	ResultSet rs;
    	
    	stmt.setString(1, "TIMESTAMP '2000-02-01 01:02:03'");
    	rs = stmt.executeQuery();
    	assertAllIdsPresent(rs, 2, 3);
    	rs.close();
    	
    	stmt.setString(1, "TIMESTAMP '1999-02-01 01:02:03'");
    	rs = stmt.executeQuery();
    	assertAllIdsPresent(rs);
    	rs.close();
    	
    	stmt.close();
    }
    
    public void testFirstPeriodEqualsSecondPeriod() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) EQUALS PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	ResultSet rs;
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-03-01 01:02:03'", 2);
    	stmt.close();
    	
    	query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (?, ?) EQUALS PERIOD (BUS_START, BUS_END);";
    	stmt = conn.prepareStatement(query);

    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-03-01 01:02:03'", 2);
    	stmt.close();
    	
    	query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) EQUALS PERIOD (TIMESTAMP '2000-03-01 01:02:03', INTERVAL '31' DAY);";
    	stmt = conn.prepareStatement(query);
    	rs = stmt.executeQuery();
    	assertAllIdsPresent(rs,3);
    	rs.close();
    	
    	stmt.close();
    }
    
    public void testFirstPeriodContainsSecondPeriod() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) CONTAINS PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-02-01 01:02:04'", 2);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-03-01 01:02:03'", "TIMESTAMP '1999-04-01 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-03-01 01:02:03'", "TIMESTAMP '2000-03-30 01:02:03'", 3);
    	
    	stmt.close();
    	
    	query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (?, ?) CONTAINS PERIOD (BUS_START, BUS_END);";
    	stmt = conn.prepareStatement(query);

    	executeAndTestQuery(stmt, "TIMESTAMP '1999-03-01 01:02:03'", "TIMESTAMP '2001-03-01 01:02:03'", 1, 2, 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-01-01 01:02:03'", "TIMESTAMP '2001-04-01 01:02:03'", 1, 2, 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-01-31 01:02:03'", "TIMESTAMP '2000-03-01 01:02:03'", 2);
    	
    	stmt.close();
    }
    
    public void testFirstPeriodContainsDate() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) CONTAINS TIMESTAMP '2000-02-01 01:02:03';";
		PreparedStatement stmt = conn.prepareStatement(query);
    	ResultSet rs;
    	
    	rs = stmt.executeQuery();
    	assertAllIdsPresent(rs, 2);
    	rs.close();
    	stmt.close();
    	
    	query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) CONTAINS TIMESTAMP '1999-02-01 01:02:03';";
    	stmt = conn.prepareStatement(query);
    	rs = stmt.executeQuery();
    	assertAllIdsPresent(rs);
    	rs.close();

    	stmt.close();
    }

    public void testFirstPeriodPrecedesSecondPeriod() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) PRECEDES PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-04-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'", 1, 2, 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-03-31 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'", 1, 2);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-03-01 01:02:03'", "TIMESTAMP '1999-03-30 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-12 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'", 1);
    	
    	stmt.close();
    }
    
    public void testFirstPeriodSuccedesSecondPeriod() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) SUCCEEDS PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-04-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-03-01 01:02:03'", "TIMESTAMP '1999-03-30 01:02:03'", 1, 2, 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-12 01:02:03'", 2, 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-01-01 01:02:03'", "TIMESTAMP '2000-03-01 01:02:03'", 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-03-01 01:02:03'", 3);
    	
    	stmt.close();
    }

    public void testFirstPeriodImmediatelyPrecedesSecondPeriod() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) IMMEDIATELY PRECEDES PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-04-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'", 3);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-03-31 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-03-01 01:02:03'", "TIMESTAMP '1999-03-30 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'", 1);
    	
    	stmt.close();
    }
    
    public void testFirstPeriodImmediatelySuccedesSecondPeriod() throws SQLException {
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) IMMEDIATELY SUCCEEDS PERIOD (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-04-01 01:02:03'", "TIMESTAMP '2000-05-01 01:02:03'");
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '1999-12-01 01:02:03'", "TIMESTAMP '2000-01-01 01:02:03'", 1);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-01-01 01:02:03'", "TIMESTAMP '2000-02-01 01:02:03'", 2);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-02-01 01:02:03'", "TIMESTAMP '2000-03-01 01:02:03'", 3);
    	
    	stmt.close();
    }
    
    /**
     * When omiting the {@code PERIOD} keyword, it is possible to use a period constructor 
     * with the same date as start and and date.
     */
    public void testPeriodOverlapsSinglePointInTime() throws SQLException {
    	
    	String query = "SELECT emp_id FROM PUBLIC.EMP WHERE (BUS_START, BUS_END) OVERLAPS (?, ?);";
		PreparedStatement stmt = conn.prepareStatement(query);
    	
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-01-11 01:02:03'", "TIMESTAMP '2000-01-11 01:02:03'", 1);
    	
    	stmt.close();

       	query = "SELECT emp_id FROM PUBLIC.EMP WHERE (?, ?) OVERLAPS (BUS_START, BUS_END);";
       	stmt = conn.prepareStatement(query);
    	executeAndTestQuery(stmt, "TIMESTAMP '2000-01-11 01:02:03'", "TIMESTAMP '2000-01-11 01:02:03'", 1);

       	stmt.close();
    }

    /**
     * When using the {@code PERIOD} keyword, the start date of the period must be before the end date.
     */
    public void testInvalidPeriodDateSpecification() {
    	PreparedStatement stmt = null;
    	List<String> predicates = new LinkedList<String>();
    	Collections.addAll(predicates, "OVERLAPS", "EQUALS", "CONTAINS", "PRECEDES", "SUCCEEDS", "IMMEDIATELY PRECEDES", "IMMEDIATELY SUCCEEDS");
			for (String predicate: predicates) {
		    	String query = String.format("SELECT emp_id FROM PUBLIC.EMP WHERE PERIOD (BUS_START, BUS_END) %s PERIOD (?, ?);", predicate);
				try {
					stmt = conn.prepareStatement(query);
					// testing with start after end
					executeAndTestQuery(stmt, "TIMESTAMP '2000-01-11 01:02:03'", "TIMESTAMP '2000-01-10 01:02:03'");
					Assert.fail(String.format("An exception should have been raised for predicate %s when start is after end!", predicate));
				} catch (SQLDataException e) {
					// This is Ok. The test pass.
					Assert.assertEquals("data exception: invalid period value", e.getMessage());
				} catch (SQLException e) {
					e.printStackTrace();
					Assert.fail(e.getMessage());
				}
				try {
				// testing with start equals end
				executeAndTestQuery(stmt, "TIMESTAMP '2000-01-11 01:02:03'", "TIMESTAMP '2000-01-11 01:02:03'");
				Assert.fail(String.format("An exception should have been raised for predicate %s when start equals end!", predicate));
				} catch (SQLDataException e) {
					// This is Ok. The test pass.
					Assert.assertEquals("data exception: invalid period value", e.getMessage());
				} catch (SQLException e) {
					e.printStackTrace();
					Assert.fail(e.getMessage());
				}
			}
    }

}

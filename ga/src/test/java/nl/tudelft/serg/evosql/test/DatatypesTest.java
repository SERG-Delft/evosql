package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;

public class DatatypesTest extends TestBase {
	
	@Test
	public void testDatetime() {
		Connection conn;
		try {
			conn = DriverManager.getConnection(jdbcUrl, user, pwd);
			Statement st = conn.createStatement();
			st.execute("DROP TABLE DATETIME_TABLE IF EXISTS");
			st.execute("CREATE TABLE DATETIME_TABLE ( ID INT NOT NULL, START_DT DATETIME NOT NULL, END_DT DATETIME )");
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}
		assertTrue(testExecutePath("SELECT ID FROM DATETIME_TABLE WHERE START_DT BETWEEN '2000-01-01 00:00:00' AND '2000-01-02 00:00:00'"));
		assertTrue(testExecutePath("SELECT ID FROM DATETIME_TABLE WHERE START_DT BETWEEN '2000-01-01 00:00:00' AND '2000-01-02 00:00:00' AND END_DT BETWEEN '2008-01-01 00:00:00' AND '2008-01-02 00:00:00'"));
		assertTrue(testExecutePath("SELECT ID FROM DATETIME_TABLE WHERE START_DT = '2000-01-01 00:00:00' AND END_DT = '2000-01-02 00:00:00'"));
	}
	
	@Test
	public void testDate() {
		Connection conn;
		try {
			conn = DriverManager.getConnection(jdbcUrl, user, pwd);
			Statement st = conn.createStatement();
			st.execute("DROP TABLE DATE_TABLE IF EXISTS");
			st.execute("CREATE TABLE DATE_TABLE ( ID INT NOT NULL, START_DT DATE NOT NULL, END_DT DATE )");
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}

		assertTrue(testExecutePath("SELECT ID FROM DATE_TABLE WHERE START_DT BETWEEN '2000-01-01' AND '2000-01-02'"));
		assertTrue(testExecutePath("SELECT ID FROM DATE_TABLE WHERE START_DT BETWEEN '2000-01-01' AND '2000-01-02' AND END_DT BETWEEN '2008-01-01' AND '2008-01-02'"));
		assertTrue(testExecutePath("SELECT ID FROM DATE_TABLE WHERE START_DT = '2000-01-01' AND END_DT = '2000-01-02'"));
	}

	@Test
	public void testTime() {
		Connection conn;
		try {
			conn = DriverManager.getConnection(jdbcUrl, user, pwd);
			Statement st = conn.createStatement();
			st.execute("DROP TABLE TIME_TABLE IF EXISTS");
			st.execute("CREATE TABLE TIME_TABLE ( ID INT NOT NULL, START_TIME TIME NOT NULL, END_TIME TIME )");
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}

		assertTrue(testExecutePath("SELECT ID FROM TIME_TABLE WHERE START_TIME BETWEEN '00:00:00' AND '00:01:00'"));
		assertTrue(testExecutePath("SELECT ID FROM TIME_TABLE WHERE START_TIME BETWEEN '13:00:00' AND '16:15:14' AND END_TIME BETWEEN '23:11:00' AND '23:11:59'"));
		assertTrue(testExecutePath("SELECT ID FROM TIME_TABLE WHERE START_TIME = '00:00:00' AND END_TIME = '01:02:03'"));
	}
}

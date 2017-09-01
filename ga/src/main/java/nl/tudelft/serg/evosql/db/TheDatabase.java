package nl.tudelft.serg.evosql.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import nl.tudelft.serg.evosql.EvoSQLException;

public class TheDatabase {

	private String jdbc;
	private String user;
	private String pwd;

	public TheDatabase(String jdbc, String user, String pwd) {
		this.jdbc = jdbc;
		this.user = user;
		this.pwd = pwd;
	}
	
	public boolean execute(String sql) {
		try {
			Connection conn = DriverManager.getConnection(jdbc, user, pwd);
			
			boolean result = conn.prepareStatement(sql).execute();
			conn.close();
			
			return result;
		} catch (SQLException e) {
			throw new EvoSQLException(e);
		}
	}

	public boolean returnsSomething(String sql) {
		try {
			Connection conn = DriverManager.getConnection(jdbc, user, pwd);
			
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			boolean containsSomething = false;
			if(rs.next()) containsSomething = true;
			
			conn.close();
			
			return containsSomething;
		} catch (SQLException e) {
			throw new EvoSQLException(e);
		}
	}
}

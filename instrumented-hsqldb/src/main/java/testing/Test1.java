package testing;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import genetic.Instrumenter;

public class Test1 {
	public static boolean testing = false;
	private static boolean showError = true;

	public static void main(String[] args) {
		// Drop mem folder if it is there
		
		String thing = "Thu Feb 09 15:02:45 BRST 2017";
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = sdf.parse(thing);
			System.out.println(sdf2.format(date));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		if (true) return;
		deleteDir(new File("./mem"));
		
		if (!showError) {
			System.setErr(new PrintStream(new OutputStream() {
			    public void write(int b) {
			    }
			}));
		}
		System.gc();
		try {
		     Class.forName("org.hsqldb.jdbc.JDBCDriver" );
		} catch (Exception e) {
		     System.err.println("ERROR: failed to load HSQLDB JDBC driver.");
		     e.printStackTrace();
		     return;
		}
		try {
			Connection c = DriverManager.getConnection("jdbc:hsqldb:mem/test", "SA", "");
			Statement st = c.createStatement();
			runQueryFile(st, "TestQuery.sql");
			SQLWarning w = st.getWarnings();
			while (w != null) {
				System.out.println(w.getMessage());;
				w = w.getNextWarning();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//Instrumenter.StartDatabase();
	}
	
	static class SqlBlock {
		String sql;
		boolean isQuery;
		
		public SqlBlock(String sql, boolean isQuery) {
			this.sql = sql;
			this.isQuery = isQuery;
		}
	}
	
	static void runQueryFile(Statement st, String filename) throws SQLException {
		List<SqlBlock> sqls = new ArrayList<SqlBlock>();
		// Load file and store all queries
		try {
			List<String> fileLines = Files.readAllLines(Paths.get("./queries/" + filename));
			String currentSql = "";
			boolean isQuery = false;
			fileLines.add(""); // Add an empty string to make sure the last statement is also added
			for (String line : fileLines) {
				if (line.isEmpty()) {
					if (!currentSql.isEmpty()) {
						sqls.add(new SqlBlock(currentSql, isQuery));
						currentSql = "";
					}
					continue;
				}
				if (line.trim().startsWith("--")) 
					continue;
				if (currentSql.isEmpty()) {
					if (line.contains("SELECT"))
						isQuery = true;
					else
						isQuery = false;
				}
				currentSql += line + "\n";
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// Execute the queries
		for (SqlBlock sb : sqls) {
			// Remove all newlines
			sb.sql = sb.sql.replace("\r", "").replace("\n", " ");
			System.out.println("Executing: " + sb.sql);
			
			if (!sb.isQuery) {
				st.execute(sb.sql);
			} else {
				genetic.Instrumenter.startInstrumenting();
				testing = true;
				ResultSet res;		
				res = st.executeQuery(sb.sql);
				int colNr = res.getMetaData().getColumnCount();
				String out;
				System.out.println("Query output: ");
				out = "Header: ";
				for (int i = 1; i <= colNr; i++) {
					out += res.getMetaData().getColumnName(i) + " | ";
				}
				out = out.substring(0, out.length() - 3);
				System.out.println(out);
				while (res.next()) {
					out = "Row " + res.getRow() + ": ";
					for (int i = 1 ; i <= colNr; i++) {
						out += res.getString(i) + " | ";
					}
					out = out.substring(0, out.length() - 3);
					System.out.println(out);
				}
				testing = false;
			}
		}
		
		// Print out the comparisons
		//genetic.Instrumenter.printData();
	}
	
	public static boolean deleteDir(File dir) 
	{ 
	  if (dir.isDirectory()) 
	  { 
	    String[] children = dir.list(); 
	    for (int i=0; i<children.length; i++)
	      deleteDir(new File(dir, children[i])); 
	  }  
	  // The directory is now empty or this is a file so delete it 
	  return dir.delete(); 
	} 

}

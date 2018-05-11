package nl.tudelft.serg.evosql.test;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.After;
import org.junit.Before;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.db.SeedExtractor;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.metaheuristics.GAApproach;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.UsedColumnExtractor;
import org.junit.Rule;
import org.junit.rules.Timeout;

public class TestBase {
	//@Rule
	//public Timeout globalTimeout = new Timeout(10000, TimeUnit.MILLISECONDS);


	private static Logger log = LogManager.getLogger(TestBase.class);

	static List<Fixture> population = new ArrayList<>();
	static int maxGenerations = Integer.MAX_VALUE;
	
	static final String TBL_PRODUCTS = "PRODUCTS";
	
	static String jdbcUrl = "jdbc:hsqldb:mem/EvoSQLtest";
	static String user = "SA";
	static String database = "PUBLIC";
	static String schema = "PUBLIC";
	static String pwd = "";
	
	static {
		// Load HSQLDB driver
		try {
		     Class.forName("org.hsqldb.jdbc.JDBCDriver" );
		} catch (Exception e) {
		     System.err.println("ERROR: failed to load HSQLDB JDBC driver.");
		     e.printStackTrace();
		}
	}

	/**
	 * Enables injection of initial population
	 * @param newPopulation new population
	 */
	static void setPopulation(List<Fixture> newPopulation) {
		population = newPopulation;
	}

	/**
	 * Deletes the Database files in mem, then creates a new database with the necessary schema.
	 */
	@Before
	public void setUp() {
		clearMem();
		createProductTable();
		createProductDetailTable();
		createExtraProductTable();
		
		createTableToPlayWithStrings();
		population = new ArrayList<>();
	}
	
	private void createTableToPlayWithStrings() {
			for(int i = 0; i <= 4; i++) {
				createTable("STRINGS"+ (i==0?"":i), "CREATE TABLE STRINGS" + (i==0?"":i) + " ( C1 VARCHAR(50), C2 VARCHAR(50), C3 VARCHAR(50), " + 
						"C4 VARCHAR(50), C5 VARCHAR(50), C6 VARCHAR(50), C7 VARCHAR(50), C8 VARCHAR(50), C9 VARCHAR(50), C10 VARCHAR(50)"
						+ ")");
			}
		
		
	}

	/**
	 * Close the databases by issuing a SQL "SHUTDOWN" command
	 */
	@After
	public void tearDown() {
		population = new ArrayList<>();
		try {
			genetic.Instrumenter.execute("SHUTDOWN");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		Connection conn;
		try {
			conn = DriverManager.getConnection(jdbcUrl, user, pwd);
			Statement st = conn.createStatement();
			st.execute("SHUTDOWN");
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}
	}
	
	/**
	 * To execute the tests, only supports single table tests, and uses the input SQL as the only path for the GA
	 * @param sqlToBeTested
	 * @return Boolean indicating if execution was successful (meaning no errors and fixture outputs at least one output row) 
	 */
	public static boolean testExecutePath (String sqlToBeTested) {
		return testExecutePath(sqlToBeTested, 20000L); // 20 seconds tops
	}
	
	public static boolean testExecutePath (String sqlToBeTested, long time) {
		try {
			log.info("Testing " + sqlToBeTested);
			genetic.Instrumenter.startDatabase();
			
			SchemaExtractor schemaExtractor = new SchemaExtractor(jdbcUrl, database, user, pwd);
			
			Fixture generatedFixture = null;

			// Get all table schema's for current path
			Map<String, TableSchema> tableSchemas = schemaExtractor.getTablesFromQuery(sqlToBeTested);

			// Get the used columns in the current path
			Set<ColumnSchema> usedColumns = new UsedColumnExtractor(sqlToBeTested, tableSchemas).extract();
			for (ColumnSchema col : usedColumns) {
				col.setUsedColumn();
				col.getTable().addUsedColumn();
			}
			
			// Get the seeds for the current path
			Seeds seeds = new SeedExtractor(sqlToBeTested).extract();
			
			// Create schema on the instrumented database
			for (TableSchema ts : tableSchemas.values()) {
				genetic.Instrumenter.execute(ts.getDropSQL());
				genetic.Instrumenter.execute(ts.getCreateSQL());
			}
			
			for (int i = 0; i < EvoSQLConfiguration.TEST_MAX_ITERATIONS; i++) {
				GAApproach ga = new GAApproach(population, tableSchemas, sqlToBeTested, seeds, maxGenerations, !population.isEmpty());
				generatedFixture = ga.execute(time / EvoSQLConfiguration.TEST_MAX_ITERATIONS); //We want to hold the max time limit

				log.info("For path: " + sqlToBeTested);
				log.info("Generated fixture: {}", generatedFixture);
				
				if (generatedFixture.getFitness().getDistance() == 0)
					break;
			}
			
			// 	No solution after EvoSQLConfiguration.TEST_MAX_ITERATIONS			
			if (generatedFixture == null || generatedFixture.getFitness().getDistance() != 0) {
				return false;
			}
			
			//genetic.Instrumenter.printData();
			
			// Make sure that the solution is correct, by inserting the data into the database and reading the output
			// Truncate tables in Instrumented DB
			for (TableSchema tableSchema : tableSchemas.values()) {
				genetic.Instrumenter.execute(tableSchema.getTruncateSQL());
			}
			
			// Insert population
			for (String sqlStatement : generatedFixture.getInsertStatements()) {
				genetic.Instrumenter.execute(sqlStatement);
			}
			
			Statement st = genetic.Instrumenter.getStatement();

			ResultSet res = st.executeQuery(sqlToBeTested);
			if (res.next()) // If next returns true there is at least one row.
				return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.toString());
			return false;
		}
		
		return false;
	}
	
	/**
	 * Creates the default product table on the test database
	 */
	public static void createProductTable() {
		createTable("PRODUCTS", "CREATE TABLE PRODUCTS ( ID INT NULL, PRODUCT VARCHAR(500) NULL, PRICE DOUBLE NOT NULL)");
	}
	
	/**
	 * Creates the default product table on the test database
	 */
	public static void createProductDetailTable() {
		createTable("PRODUCT_DETAIL", "CREATE TABLE PRODUCT_DETAIL ( ID INT NULL, NAME VARCHAR(500) NULL, TYPE INT NULL )");

	}
	
	/**
	 * Creates the default product table on the test database
	 */
	public static void createExtraProductTable() {
		createTable("EXTRA_PRODUCT", "CREATE TABLE EXTRA_PRODUCT ( ID INT NULL, EXTRA VARCHAR(50) NULL )");

	}
	
	public static void createTable(String name, String sql) {
		Connection conn;
		try {
			conn = DriverManager.getConnection(jdbcUrl, user, pwd);
			Statement st = conn.createStatement();
			st.execute("DROP TABLE " + name + " IF EXISTS");
			st.execute(sql);
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}
	}
	
	/**
	 * Deletes the database information left-over in the mem folder
	 */
	public static void clearMem() {
		deleteDir(new File("./mem"));
	}
	
	private static boolean deleteDir(File dir) 
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

package nl.tudelft.serg.evosql;

import nl.tudelft.serg.evosql.db.TheDatabase;

public class Runner {

	public static void main(String[] args) {		
		createFakeDatabase();
		
		//new SchemaExtractor("jdbc:hsqldb:file:testdb", "SA", "").getTablesFromQuery("SELECT * FROM (SELECT * FROM t1) t2 LEFT JOIN t3 ON t2.id = t3.id WHERE t1.something = (SELECT MAX(something) FROM t4)");
		//new EvoSQL("jdbc:hsqldb:file:testdb", "SA", "").execute("SELECT * FROM (SELECT * FROM (SELECT * FROM products WHERE Product = 'A' GROUP BY Product, Price) t WHERE Price > 5  GROUP BY Product, Price) t WHERE Price < 20");
		//new EvoSQL("jdbc:hsqldb:file:testdb", "SA", "").execute("SELECT * FROM invoice where amount > 2000 and tax > 500");
//		Result result = new EvoSQL("jdbc:hsqldb:file:testdb", "testdb", "public", "SA", "").execute("SELECT * FROM products WHERE Price > 10");
		
//		if (result != null)
//			System.out.print(result.toString());
	}

	private static void createFakeDatabase() {
		try {
		     Class.forName("org.hsqldb.jdbc.JDBCDriver" );
		} catch (Exception e) {
		     System.err.println("ERROR: failed to load HSQLDB JDBC driver.");
		     e.printStackTrace();
		     return;
		}
		
		TheDatabase theDatabase = new TheDatabase("jdbc:hsqldb:file:testdb", "SA", "");
		theDatabase.execute("DROP SCHEMA PUBLIC CASCADE");
		theDatabase.execute("CREATE TABLE PRODUCTS ( PRODUCT VARCHAR(500) NULL, PRICE INT NOT NULL)");
		//theDatabase.execute("CREATE TABLE INVOICE(ID INTEGER PRIMARY KEY IDENTITY,CUSTOMER VARCHAR(500),AMOUNT DOUBLE NOT NULL,TAX DOUBLE NOT NULL)");
	}

}

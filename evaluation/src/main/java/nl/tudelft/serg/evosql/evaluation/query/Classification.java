package nl.tudelft.serg.evosql.evaluation.query;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.PrintStream;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.github.sergdelft.sqlcorgi.SQLCorgi;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.db.SchemaExtractor;
import nl.tudelft.serg.evosql.evaluation.Evaluation;
import nl.tudelft.serg.evosql.evaluation.ScriptRunner;
import nl.tudelft.serg.evosql.evaluation.tools.Crypto;
import nl.tudelft.serg.evosql.sql.TableSchema;
import nl.tudelft.serg.evosql.sql.parser.SqlSecurer;
import nl.tudelft.serg.evosql.sql.parser.UsedColumnExtractor;

/**
 * Takes a set of queries, parses them
 *
 */
public class Classification {
	private static long INTERVAL_TIME = 1000;// milliseconds
	private static Logger log = LogManager.getLogger(Evaluation.class);

	private List<String> queries;
	private PrintStream output;
	private ObjectOutputStream objOutput;
	private String user;
	private String pwd;
	private String connectionString;

	private String schemaSql;

	private String database;
	private String schema;
	
	private SchemaExtractor extractor;
	private Crypto crypto;

	public Classification(String connectionString, String database, String schema, String user, String pwd,
			String schemaSql, List<String> queries, PrintStream output, ObjectOutputStream objOutput) {
		this.connectionString = connectionString;
		this.database = database;
		this.schema = schema;
		this.user = user;
		this.pwd = pwd;
		this.schemaSql = schemaSql;
		this.queries = queries;
		this.output = output;
		this.objOutput = objOutput;
		extractor = new SchemaExtractor(connectionString, database, user, pwd);
		crypto = new Crypto();
	}
	
	public void perform(boolean useSQLFpc) throws IOException, SQLException {
		perform(0, useSQLFpc);
	}
	
	public void perform(int skip, boolean useSQLFpc) throws IOException, SQLException {
		loadSchema();
		// Print CSV header
		output.println("queryNo|tables|conditions|subqueries|joins|paths|functions|total columns|used columns|query");
		
		int queryNo = 0;
		long start, end;
		QueryMetrics metrics;
		for (String query : queries) {
			start = System.currentTimeMillis();
			queryNo++;
			if (skip > 0) {
				skip--;
				continue;
			}
			if (query.trim().startsWith("--")) continue;
			if (query.trim().startsWith("STOP")) break;
			
			crypto.renewKey();
			
			metrics = classifyQuery(queryNo, query, useSQLFpc);
			output.printf("%d|%d|%d|%d|%d|%d|%d|%d|%d|%s\n", queryNo
				, metrics.tables, metrics.conditions, metrics.subqueries, metrics.joins, metrics.paths, metrics.functions
				, metrics.totalColumns, metrics.usedColumns
				, query);
			
			// Write the path list with query number to the object stream
			if (useSQLFpc) {
				QueryPathList qpl = new QueryPathList(queryNo, metrics.pathList);
				objOutput.writeObject(qpl);
	
				end = System.currentTimeMillis();
				
				try {
					Thread.sleep(INTERVAL_TIME - (end - start));
				} catch (InterruptedException | IllegalArgumentException e ) { }
			}
		}
	}
	
	private QueryMetrics classifyQuery(int queryNo, String query, boolean useSQLFpc) {
		log.info("Q: {}, {}", queryNo, query);
		QueryMetrics metrics = new QueryMetrics(query);

		// Secure it for JSqlParser
		query = new SqlSecurer(query).getSecureSql();
		
		// Get the paths from SQLFpc
		if (useSQLFpc) {
			// A path is a SQL query that only passes a certain condition set.
			List<String> allPaths = new ArrayList<>(SQLCorgi.generateRules(query, null));

			metrics.paths = allPaths.size();
			metrics.pathList = allPaths;
		} else {
			metrics.paths = -1;
			metrics.pathList = null;
		}
		
		// Get the rest of the metrics from a visitor
		Select stmt = null;
		try {
			stmt = (Select) CCJSqlParserUtil.parse(query);
		} catch (JSQLParserException e) {
			throw new RuntimeException(e);
		}

		stmt.getSelectBody().accept(new ClassifierVisitor(metrics));
		
		// Measure the columns used and total columns available
		Map<String, TableSchema> schemas = extractor.getTablesFromQuery(query);
		metrics.totalColumns = 0;
		schemas.values().stream().forEach(ts -> metrics.totalColumns += ts.getColumns().size());
		
		metrics.usedColumns = new UsedColumnExtractor(query, schemas).extract().size();

		return metrics;
	}

	private void loadSchema() throws SQLException, IOException {
		Connection conn = DriverManager.getConnection(connectionString, user, pwd);

		// Delete all tables
		conn.createStatement().execute("DROP DATABASE IF EXISTS " + this.database);
		conn.createStatement().execute("CREATE DATABASE " + this.database);

		conn.setCatalog(this.database);
		
		// Create schema
		ScriptRunner runner = new ScriptRunner(conn, false, true);
		runner.runScript(new StringReader(schemaSql));
		conn.close();
	}
}

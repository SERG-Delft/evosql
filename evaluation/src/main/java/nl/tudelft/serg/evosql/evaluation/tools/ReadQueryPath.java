package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Paths;

import org.hibernate.engine.jdbc.internal.BasicFormatterImpl;

import nl.tudelft.serg.evosql.evaluation.query.QueryPathList;
import nl.tudelft.serg.evosql.evaluation.query.Runner;

public class ReadQueryPath {

	public static void main(String[] args) throws IOException {
		String scenarioName = "erpnext-process6";
		int queryNo = 2;
		int pathNo = 6;
		
		// You can ignore from here!
		String path = null;
		try {
			path = Paths.get(Runner.class.getResource("/").toURI()).toString() + "/../../scenarios/";
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		
		String projectPath = path + scenarioName + "/";
		
		// open query path reader
		QueryPathReader qpr = new QueryPathReader(projectPath);
		
		qpr.init();
		
		QueryPathList qpl = qpr.read(queryNo);
		
		qpr.close();
		
		System.out.println(getBeautifulSql(qpl.pathList.get(pathNo - 1)));
		
	}
	
	static BasicFormatterImpl formatter = new BasicFormatterImpl();
	static String getBeautifulSql(String uglySql) {
		return formatter.format(uglySql);
	}
}

package nl.tudelft.serg.evosql.evaluation.tools;

import java.io.EOFException;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.net.URISyntaxException;
import java.nio.file.Paths;

import nl.tudelft.serg.evosql.evaluation.query.QueryPathList;
import nl.tudelft.serg.evosql.evaluation.query.Runner;

public class QueryPathReader {
	private ObjectInputStream oin;
	private FileInputStream fin;
	private String projectPath;
	private int lastQueryNo;
	
	public QueryPathReader(String projectPath) {
		this.projectPath = projectPath;
	}
	
	public void init() throws IOException {
		fin = new FileInputStream(projectPath + "query_paths.ser");
		oin = new ObjectInputStream(fin);
		lastQueryNo = 0;
	}
	
	public void reset() throws IOException {
		this.close();
		this.init();
	}
	
	public QueryPathList readNext() {
		try {
			QueryPathList result = (QueryPathList) oin.readObject();
			lastQueryNo = result.queryNo;
			return result;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (EOFException e) {
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public QueryPathList read(int queryNo) {
		try {
			if (queryNo <= lastQueryNo) {
				reset();
			}
			QueryPathList qpl = null;
			while (lastQueryNo < queryNo) {
				qpl = readNext();
				if (qpl == null)
					return null;
			}
			if (lastQueryNo != queryNo)
				return null;
			return qpl;
		} catch (IOException e) {
			return null;
		}
	}
	
	public void close() throws IOException {
		oin.close();
		fin.close();
	}
	
	// Simple main that prints out each queries paths
	public static void main(String[] args) throws IOException {
		// Set the project to evaluate. That's the only config you need.
		String projectName = "espocrm";
		
		// You can ignore from here!
		String path = null;
		try {
			path = Paths.get(Runner.class.getResource("/").toURI()).toString() + "/../../scenarios/";
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		
		String projectPath = path + projectName + "/";
		
		QueryPathReader qpr = new QueryPathReader(projectPath);
		qpr.init();
		
		QueryPathList qpl;
		
		while ((qpl = qpr.readNext()) != null) {
			System.out.println("Query " + qpl.queryNo + ", paths: " + qpl.pathList.size());
			for (String str : qpl.pathList) {
				System.out.println("\t" + str);
			}
			System.out.println();
		}
		
		
		qpr.close();
	}
}

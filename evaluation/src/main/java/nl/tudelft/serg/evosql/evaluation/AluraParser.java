package nl.tudelft.serg.evosql.evaluation;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



public class AluraParser {

	public static void main(String[] args) throws IOException {
		FileInputStream inputStream = null;
		Scanner sc = null;
		try {
		    inputStream = new FileInputStream("C:/Users/jeroe/Downloads/aluraquerytrace.txt");
		    sc = new Scanner(inputStream, "UTF-8");
		    
		    Set<String> queries = new HashSet<>();
		    
		    Pattern pattern = Pattern.compile("\\[(\\d*)\\] as \\[(.*)\\] - \\[(.*)\\]");
		    Pattern pattern2 = Pattern.compile("Binding \\[(.*)\\] to parameter: \\[(.*)\\]");
		    		
		    String currentSql = null;
		    Map<Integer,String> values = new TreeMap<>();
		    
		    while (sc.hasNextLine()) {
		        String line = sc.nextLine();
		        
		        boolean queryStarting = line.contains("DEBUG org.hibernate.engine.jdbc.spi.SqlStatementLogger.logStatement(SqlStatementLogger.java:109)");
		        if((currentSql!=null && queryStarting)) {
		        	
		        	for(Map.Entry<Integer, String> kv : values.entrySet()) {
		        		currentSql = currentSql.replaceFirst("\\?", kv.getValue());
		        	}
		        	
		        	queries.add(currentSql);
		        	currentSql = null;
		        	values = new TreeMap<>();
		        }
		        
		        if(currentSql == null && queryStarting && line.substring(115).toLowerCase().startsWith("select")) {
		        	currentSql = line.substring(115);
		        	
		        	// Replace is true by = 1 and is false by  = 0
		        	currentSql = currentSql
		        			.replaceAll("is true", "= 1")
		        			.replaceAll("is false", "= 0");
		        	
		        	// Remove ;
		        	if (currentSql.endsWith(";"))
		        		currentSql = currentSql.substring(0, currentSql.length() - 1);
		        }
		        
		        else if(currentSql!=null && line.contains("TRACE org.hibernate.type.descriptor.sql.BasicBinder.bind")) {
		        	Matcher matcher = pattern.matcher(line);
		        	if(matcher.find()) {
			        	int extractedPosition = Integer.parseInt(matcher.group(1));
			        	String type = matcher.group(2).toUpperCase();
		        		String param = matcher.group(3).replaceAll("\n", "\\n");
		        		param = convertDataString(param, type);

		        		values.put(extractedPosition, param);
		        	}
		        }

		        else if(currentSql!=null && line.contains("TRACE org.hibernate.type.EnumType$EnumValueMapperSupport.setValue")) {
		        	Matcher matcher = pattern2.matcher(line);
		        	if(matcher.find()) {
		        		int extractedPosition = Integer.parseInt(matcher.group(2));
		        		
	        			String param = matcher.group(1).replaceAll("\n", "\\n");
	        			if(!param.equals("null")) param = "'" + param + "'";
	        			values.put(extractedPosition, param);
		        	}
		        }
		        
		    }
		    
		    if(currentSql!=null) {
		    	queries.add(currentSql);
		    }
		    
		    // note that Scanner suppresses exceptions
		    if (sc.ioException() != null) {
		        throw sc.ioException();
		    }
		    
		    PrintStream ps = new PrintStream("C:/Users/jeroe/Downloads/aluraconverted.txt");
		    System.out.println("total: " + queries.size());
		    queries.stream().forEach(x -> ps.println(x));
		    queries.stream().forEach(x -> System.out.println(x));
		    ps.close();
		} finally {
		    if (inputStream != null) {
		        inputStream.close();
		    }
		    if (sc != null) {
		        sc.close();
		    }
		}
	}
	
	static String convertDataString(String data, String type) {
		type = type.toUpperCase();
		
		if (data == "null" ||
				type.equals("BIGINT") ||
				type.equals("INTEGER"))
			return data;
		
		if (type.equals("VARCHAR") ||
			type.equals("DATE") ||
			type.equals("TIMESTAMP") ||
			type.equals("VARBINARY") // Varbinary is actually an enum, which I think we implement as varchar
		)
			return "'" + data + "'";
		
		if (type.equals("BOOLEAN")) {
			if (data.toUpperCase().equals("FALSE"))
				return "0";
			else if (data.toUpperCase().equals("TRUE"))
				return "1";
		}
				
		throw new RuntimeException("Can't convert data '" + data +"' with type '" + type + "'");
	}
}

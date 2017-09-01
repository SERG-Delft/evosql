package nl.tudelft.serg.evosql.evaluation.query;

import java.io.Serializable;
import java.util.List;

public class QueryPathList implements Serializable {
	private static final long serialVersionUID = -857540404536033194L;
	public int queryNo;
	public List<String> pathList;
	
	public QueryPathList(int queryNo, List<String> pathList) {
		this.queryNo = queryNo;
		this.pathList = pathList;
	}
}

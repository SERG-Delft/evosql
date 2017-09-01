package nl.tudelft.serg.evosql.mock;

import java.util.ArrayList;
import java.util.List;

import nl.tudelft.serg.evosql.fixture.type.DBInteger;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class TableSchemaMocks {
	public static TableSchema T1() {
		List<ColumnSchema> csList = new ArrayList<ColumnSchema>();
		TableSchema ts = new TableSchema("T1", csList);
		
		csList.add(new ColumnSchema(ts, "A", new DBInteger(), false, false));
		csList.add(new ColumnSchema(ts, "B", new DBInteger(), false, false));
		csList.add(new ColumnSchema(ts, "C", new DBInteger(), false, false));
		csList.add(new ColumnSchema(ts, "D", new DBInteger(), false, false));
		
		return ts;
	}
	
	public static TableSchema T2() {
		List<ColumnSchema> csList = new ArrayList<ColumnSchema>();
		TableSchema ts = new TableSchema("T2", csList);
		
		csList.add(new ColumnSchema(ts, "A", new DBInteger(), false, false));
		csList.add(new ColumnSchema(ts, "B", new DBInteger(), false, false));
		csList.add(new ColumnSchema(ts, "C", new DBInteger(), false, false));
		
		return ts;
	}
}

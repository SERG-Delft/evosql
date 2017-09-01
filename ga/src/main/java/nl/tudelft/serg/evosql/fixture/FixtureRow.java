package nl.tudelft.serg.evosql.fixture;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

import nl.tudelft.serg.evosql.fixture.type.DBType;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class FixtureRow implements Cloneable{

	private TableSchema tableSchema;
	private String table;
	private Map<String, String> values;
	
	public FixtureRow(String table, TableSchema tableSchema) {
		this.table = table;
		this.values = new LinkedHashMap<String, String>();
		this.tableSchema = tableSchema;
	}
	
	public int columnCount() {
		return values.size();
	}
	
	public void set(String k, String v) {
		values.put(k.toUpperCase(), v);
	}

	public String getTable() {
		return table;
	}
	
	public TableSchema getTableSchema() {
		return tableSchema;
	}
	
	public ColumnSchema getColumnSchema(String columnName) {
		return tableSchema.getColumn(columnName);
	}
	
	public DBType getColumnType(String columnName) {
		return tableSchema.getColumn(columnName).getType();
	}

	public Map<String, String> getValues() {
		return Collections.unmodifiableMap(values);
	}

	public String getValueFor(String column) {
		return values.get(column.toUpperCase());
	}

	@Override
	public String toString() {
		return "FixtureTableRow [table=" + table + ", values=" + values + "]";
	}
	
	public String getValuesSQL() {
		 StringBuilder builder = new StringBuilder("(");
		 
		 int size = values.size();
		 int i = 0;
		 for (Map.Entry<String, String> entry : values.entrySet()) {
			 String value = entry.getValue();
			 if (value == null)
				 builder.append("NULL");
			 else {
				 builder.append('\'');
				 builder.append(value.replace("'", "''"));
				 builder.append('\'');
			 }

			 if (++i < size) {
				 builder.append(',');
			 }
		 }
		 
		 builder.append(')');
		 return builder.toString();
	}
	
    protected FixtureRow copy() {
		FixtureRow clone = new FixtureRow(new String(this.table), this.tableSchema);
		for (String key : this.values.keySet()){
			String val = this.values.get(key);
			clone.set(key, val == null ? null : ""+val); // Create new string by adding to ""
		}
		
		return clone;
    }

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		FixtureRow that = (FixtureRow) o;

		if (tableSchema != null ? !tableSchema.equals(that.tableSchema) : that.tableSchema != null) return false;
		if (table != null ? !table.equals(that.table) : that.table != null) return false;
		return values != null ? values.equals(that.values) : that.values == null;
	}

	@Override
	public int hashCode() {
		int result = tableSchema != null ? tableSchema.hashCode() : 0;
		result = 31 * result + (table != null ? table.hashCode() : 0);
		result = 31 * result + (values != null ? values.hashCode() : 0);
		return result;
	}
}

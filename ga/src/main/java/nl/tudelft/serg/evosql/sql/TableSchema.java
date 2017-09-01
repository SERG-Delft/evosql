package nl.tudelft.serg.evosql.sql;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

import nl.tudelft.serg.evosql.EvoSQLException;

public class TableSchema implements Serializable {

	private final String name;
	private final List<ColumnSchema> columns;
	private int usedColumnCount;
	
	public TableSchema(String name, List<ColumnSchema> columns) {
		this.name = name;
		this.columns = columns;
		usedColumnCount = 0;
	}

	public String getName() {
		return name;
	}

	public List<ColumnSchema> getColumns() {
		return columns;
	}
	
	/** Used Columns stuff **/
	public boolean hasUsedColumns() {
		return usedColumnCount > 0;
	}

	public void addUsedColumn() {
		usedColumnCount++;
	}
	
	public int getUsedColumnCount() {
		return usedColumnCount;
	}

	public void resetUsed() {
		usedColumnCount = 0;
		for (ColumnSchema cs : columns) {
			cs.resetUsed();
		}
	}

	@Override
	public String toString() {
		return "TableSchema [name=" + name + ", columns=" + columns + "]";
	}

	public ColumnSchema getColumn(String columnName) {
		Optional<ColumnSchema> column = columns.stream().filter(c -> c.getName().toUpperCase().equals(columnName.toUpperCase())).findFirst();
		if(!column.isPresent()) throw new EvoSQLException("Column " + columnName + " doesn't exist in the schema... Time to debug! :/");
		return column.get();
	}
	
	public String getDropSQL() {
		return "DROP TABLE \"" + this.name.toUpperCase() + "\" IF EXISTS";
	}
	
	public String getCreateSQL() {
		String sql = "CREATE TABLE \"" + this.name.toUpperCase() + "\" ( \n"; 
		
		for (ColumnSchema cs : columns) {
			sql += "\t\"" + cs.getName().toUpperCase() + "\" " + cs.getType().getTypeString();
			if (!cs.isNullable())
				sql += " NOT NULL";
			sql += ",\n";
		}
		
		sql = sql.substring(0, sql.length() - 2);
		sql += "\n ) ";
		
		return sql;
	}
	
	public String getTruncateSQL() {
		return "TRUNCATE TABLE \"" + this.name.toUpperCase() + "\"";
	}
	
	public String getInsertSQL() {
		return "INSERT INTO \"" + this.name.toUpperCase() + "\"";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((columns == null) ? 0 : columns.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TableSchema other = (TableSchema) obj;
		if (columns == null) {
			if (other.columns != null)
				return false;
		} else if (!columns.equals(other.columns))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	
}

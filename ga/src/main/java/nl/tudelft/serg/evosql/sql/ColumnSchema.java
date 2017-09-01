package nl.tudelft.serg.evosql.sql;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import nl.tudelft.serg.evosql.fixture.type.DBType;

public class ColumnSchema implements Serializable {
	private Set<ColumnSchema> seedSourceColumns;
	private final TableSchema table;
	private final String name;
	private final boolean nullable;
	private final boolean autoIncrement;
	private final DBType type;
	private boolean isUsed;
	
	public ColumnSchema(TableSchema table, String name, DBType type, boolean nullable, boolean autoIncrement) {
		this.table = table;
		this.name = name;
		this.type = type;
		this.nullable = nullable;
		this.autoIncrement = autoIncrement;
		this.isUsed = false;
	}

	public boolean isAutoIncrement() {
		return autoIncrement;
	}
	
	public String getName() {
		return name;
	}

	public boolean isNullable() {
		return nullable;
	}

	public DBType getType() {
		return type;
	}
	
	public TableSchema getTable() {
		return table;
	}
	
	public void setUsedColumn() {
		isUsed = true;
	}

	public boolean isUsedColumn() {
		return isUsed;
	}

	public void resetUsed() {
		isUsed = false;
		seedSourceColumns = null;
	}
	
	public void addSeedSourceColumn(ColumnSchema other) {
		if (seedSourceColumns == null)
			seedSourceColumns = new HashSet<ColumnSchema>();
		
		seedSourceColumns.add(other);
	}
	
	public Set<ColumnSchema> getSeedSourceColumns() {
		return seedSourceColumns;
	}

	@Override
	public String toString() {
		return "ColumnSchema [name=" + name + ", nullable=" + nullable + ", autoIncrement=" + autoIncrement + ", type="
				+ type + "]";
	}

	public boolean matches(String otherName) {
		return name.toLowerCase().equals(otherName.toLowerCase());
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (autoIncrement ? 1231 : 1237);
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + (nullable ? 1231 : 1237);
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		ColumnSchema other = (ColumnSchema) obj;
		if (autoIncrement != other.autoIncrement)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (nullable != other.nullable)
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.getClass().equals(other.type.getClass()))
			return false;
		return true;
	}
	
}

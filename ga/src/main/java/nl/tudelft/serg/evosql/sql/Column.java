package nl.tudelft.serg.evosql.sql;

public class Column {

	private Table table;
	private String name;
	private String alias;
	private ColumnSchema columnSchema;
	
	public Column(Table table, String name, String alias, ColumnSchema columnSchema) {
		this.table = table;
		this.name = name;
		this.alias = alias;
		this.columnSchema = columnSchema;
	}

	public Table getTable() {
		return table;
	}

	public String getName() {
		return name;
	}

	public String getAlias() {
		return alias;
	}
	
	public ColumnSchema getColumnSchema() {
		return columnSchema;
	}
	
	@Override
	public String toString() {
		return "Column [name=" + name + ", alias=" + alias + ", columnSchema=" + columnSchema + "]";
	}

	public boolean matches(String otherName) {
		return name.toLowerCase().equals(otherName.toLowerCase());
	}

}

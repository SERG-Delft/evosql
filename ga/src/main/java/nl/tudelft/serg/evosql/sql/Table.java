package nl.tudelft.serg.evosql.sql;

import java.util.ArrayList;
import java.util.List;

public class Table {

	private String name;
	private String alias;
	private TableSchema tableSchema;
	private List<Column> columns;
	
	public Table(String name, String alias, TableSchema tableSchema) {
		this.name = name;
		this.alias = alias;
		this.tableSchema = tableSchema;
		
		this.columns = new ArrayList<>();
		for(ColumnSchema columnInDb : tableSchema.getColumns()) {
			columns.add(new Column(this, columnInDb.getName(), null, columnInDb));
		}
	}

	public String getName() {
		return name;
	}

	public String getAlias() {
		return alias;
	}

	public TableSchema getTableSchema() {
		return tableSchema;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public boolean matches(String tableNameOrAlias) {
		if(tableNameOrAlias == null) return false;
		
		return (alias!=null && alias.toLowerCase().equals(tableNameOrAlias.toLowerCase())) ||
				name.toLowerCase().equals(tableNameOrAlias.toLowerCase());
	}

	@Override
	public String toString() {
		return "Table [name=" + name + ", alias=" + alias + ", tableSchema=" + tableSchema + ", columns=" + columns
				+ "]";
	}
	
}

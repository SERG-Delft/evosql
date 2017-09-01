package nl.tudelft.serg.evosql.sql;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import nl.tudelft.serg.evosql.EvoSQLException;

public class Tables {

	private List<Table> tables;

	public Tables(List<Table> tables) {
		this.tables = tables;
	}
	
	public Column findColumn(String columnName, String tableNameOrAlias) {
		if(tableNameOrAlias != null)
			return findSpecific(columnName, tableNameOrAlias);
		
		List<Column> matches = new ArrayList<>();
		for(Table table : tables) {
			List<Column> columns = table.getColumns();
			for(Column column : columns) {
				if(column.matches(columnName)) {
					matches.add(column);
				}
			}
		}
		
		if(matches.size() > 1)
			throw new EvoSQLException("two columns with the same name: " + columnName);
		if(matches.isEmpty())
			throw new EvoSQLException("column not found: " + columnName);
		
		return matches.get(0);
	}

	private Column findSpecific(String columnName, String tableNameOrAlias) {
		Optional<Table> table = tables.stream().filter(x -> x.matches(tableNameOrAlias)).findAny();
		if(!table.isPresent()) throw new EvoSQLException("Table or alias doesn't exist: " + tableNameOrAlias);
		
		return findInTable(table, columnName);
	}

	private Column findInTable(Optional<Table> table, String columnName) {
		for(Column column : table.get().getColumns()) {
			if(column.matches(columnName)) {
				return column;
			}
		}
		throw new EvoSQLException("column not found: " + columnName);
	}

	public Table findTable(String name, String alias) {
		Optional<Table> table = tables.stream().filter(x -> x.matches(name) || x.matches(alias)).findAny();
		if(!table.isPresent()) throw new EvoSQLException("Table not found (name=" + name + " or alias=" + alias + ")");
		
		return table.get();
	}

}

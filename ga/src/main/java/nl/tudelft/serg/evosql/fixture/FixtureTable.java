package nl.tudelft.serg.evosql.fixture;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class FixtureTable {

	private TableSchema tableSchema;
	
	private List<FixtureRow> rows;
	
	public FixtureTable(TableSchema tableSchema, List<FixtureRow> rows) {
		this.tableSchema = tableSchema;
		this.rows = rows;
	}
	
	public List<FixtureRow> getRows() {
		return Collections.unmodifiableList(rows);
	}
	
	public void addRow(FixtureRow row) {
		this.rows.add(row);
	}
	
	public int getRowCount() {
		return rows.size();
	}
	
	public List<String> getColumnValues(ColumnSchema cs) {
		List<String> result = new ArrayList<String>();
		
		for (FixtureRow fr : rows) {
			result.add(fr.getValueFor(cs.getName()));
		}
		
		return result;
	}
	
	public String getName() {
		return this.tableSchema.getName();
	}
	
	public TableSchema getSchema() {
		return this.tableSchema;
	}
	
	public void duplicateRow(int index) {
		FixtureRow row = rows.get(index);
		this.addRow(row.copy());
	}

	public void remove(int index) {
		rows.remove(index);
	}

	@Override
	public String toString() {
		return "FixtureTable [rows=" + rows + "]";
	}
	
	public String getInsertSQL() {
		String sql = tableSchema.getInsertSQL() + " VALUES ";
		
		int size = this.rows.size();		
		for (int i = 0; i < size; i++) {
			sql += rows.get(i).getValuesSQL();
			
			if (i < size - 1) {
				sql += ", ";
			}
		}
		
		return sql;
	}
	
	public String getInsertSQL(int excludeIndex) {
		String sql = tableSchema.getInsertSQL() + " VALUES ";
		
		int size = this.rows.size();		
		for (int i = 0; i < size; i++) {
			if (i == excludeIndex) continue;
			
			sql += rows.get(i).getValuesSQL();
			
			// Only put comma if not last
			if (!((i == size - 1) || (i == size - 2 && excludeIndex == size - 1))) {
				sql += ", ";
			}
		}
		
		return sql;
	}
	
    public FixtureTable copy() {
		List<FixtureRow> cloneList = new ArrayList<FixtureRow>();
		for (FixtureRow row : this.rows){
			cloneList.add(row.copy());
		}
		FixtureTable clone = new FixtureTable(this.tableSchema, cloneList);
        return clone;
    }

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		FixtureTable that = (FixtureTable) o;

		if (tableSchema != null ? !tableSchema.equals(that.tableSchema) : that.tableSchema != null) return false;
		return rows != null ? rows.equals(that.rows) : that.rows == null;
	}

	@Override
	public int hashCode() {
		int result = tableSchema != null ? tableSchema.hashCode() : 0;
		result = 31 * result + (rows != null ? rows.hashCode() : 0);
		return result;
	}
}

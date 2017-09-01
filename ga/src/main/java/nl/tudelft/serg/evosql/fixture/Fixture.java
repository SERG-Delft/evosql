package nl.tudelft.serg.evosql.fixture;

import java.util.*;

import nl.tudelft.serg.evosql.metaheuristics.operators.FixtureFitness;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class Fixture implements Cloneable{

	/** To keep track of its fitness value **/
	private FixtureFitness fitness = null;
	
	private List<FixtureTable> tables;

	public Fixture(List<FixtureTable> tables) {
		this.tables = tables;
	}
	
	public List<FixtureTable> getTables() {
		return Collections.unmodifiableList(tables);
	}
	
	public FixtureTable getTable(TableSchema ts) {
		return tables.stream().filter(ft -> ft.getSchema() == ts).findFirst().get();
	}

	public void removeTable(int idx) {
		tables.remove(idx);
	}
	
	public void addTable(FixtureTable table) {
		tables.add(table);
	}

	@Override
	public String toString() {
		return "Fixture [tables=" + tables + "]";
	}
	
	public List<String> getInsertStatements() {
		List<String> statements = new ArrayList<String>();
		
		for (FixtureTable ft : tables) {
			statements.add(ft.getInsertSQL());
		}
		
		return statements;
	}
	
	public List<String> getInsertStatements(String excludeTableName, int excludeIndex) {

		List<String> statements = new ArrayList<String>();
		
		for (FixtureTable ft : tables) {
			if (ft.getName().equals(excludeTableName)) {
				statements.add(ft.getInsertSQL(excludeIndex));
			} else {
				statements.add(ft.getInsertSQL());
			}
		}
		
		return statements;
	}
	

	public FixtureFitness getFitness(){
		return fitness;
	}
	
	public void setFitness (FixtureFitness fitness){
		this.fitness = fitness;
	}
	
	public void unsetFitness() {
		this.fitness = null;
	}
	
	public void remove(String tableName, int index) {
		for (FixtureTable ft : tables) {
			if (ft.getName().equals(tableName))
				ft.remove(index);
		}
	}
	
    public Fixture copy() {
    	List<FixtureTable> cloneList = new ArrayList<FixtureTable>();
		for (FixtureTable table : this.tables){
			cloneList.add(table.copy());
		}
        Fixture clone = new Fixture(cloneList);
        if (this.fitness != null)
        	clone.setFitness(this.fitness.copy());
        return clone;
    }

	public String prettyPrint() {
        StringBuilder prettyFixture = new StringBuilder();

        for (FixtureTable table : tables) {
            prettyFixture.append("-- Table: " + table.getName() + "\n");

            Iterator<FixtureRow> it = table.getRows().iterator();
            int rowCount = 1;
            while (it.hasNext()) {
                FixtureRow row = it.next();
                prettyFixture.append(" Row #" + rowCount + ": ");

                for (Map.Entry<String, String> kv : row.getValues().entrySet()) {
                    prettyFixture.append(kv.getKey() + "='" + kv.getValue() + "',");
                }

                prettyFixture.append("\n");
                rowCount++;
            }
            prettyFixture.append("\n");
        }

        return prettyFixture.toString().trim();
    }

	public int qtyOfTables() {
		return tables.size();
	}

	public FixtureTable getTable(int index) {
		return tables.get(index);
	}

    public FixtureTable getTable(String tableName) {
		return tables.stream().filter(x -> x.getName().equals(tableName)).findFirst().get();
    }

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		Fixture fixture = (Fixture) o;

		if (fitness != null ? !fitness.equals(fixture.fitness) : fixture.fitness != null) return false;
		return tables != null ? tables.equals(fixture.tables) : fixture.tables == null;
	}

	@Override
	public int hashCode() {
		int result = fitness != null ? fitness.hashCode() : 0;
		result = 31 * result + (tables != null ? tables.hashCode() : 0);
		return result;
	}
}

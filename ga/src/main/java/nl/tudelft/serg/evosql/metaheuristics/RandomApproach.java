package nl.tudelft.serg.evosql.metaheuristics;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import nl.tudelft.serg.evosql.EvoSQLConfiguration;
import nl.tudelft.serg.evosql.db.Seeds;
import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureRowFactory;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.sql.TableSchema;

public class RandomApproach extends Approach {
	
	/** Row Factory **/
	private FixtureRowFactory rowFactory = new FixtureRowFactory();
	private Seeds seeds;

	public RandomApproach(Map<String, TableSchema> pTableSchemas, String pPathToBeTested, Seeds seeds) {
		super(pTableSchemas, pPathToBeTested);
		this.seeds = seeds;
	}
	
	@Override
	public Fixture execute(long pathTime) throws SQLException {
		long startTime = System.currentTimeMillis();
		individualCount = 0;
		Fixture fixture;
	
		do {
			individualCount++;
			
			fixture = generateRandomFixture();
			
			if (hasOutput(fixture))
				break;
		} while (System.currentTimeMillis() - startTime < pathTime);
		
		return minimize(fixture);
	}
	
	public Fixture generateRandomFixture() {
		List<FixtureTable> tables = new ArrayList<FixtureTable>();
		for (TableSchema tableSchema : tableSchemas.values()) {
			List<FixtureRow> rows = new ArrayList<FixtureRow>();
			int numberOfRows = EvoSQLConfiguration.MIN_ROW_QTY;
			if (EvoSQLConfiguration.MAX_ROW_QTY > EvoSQLConfiguration.MIN_ROW_QTY)
				numberOfRows += random.nextInt(EvoSQLConfiguration.MAX_ROW_QTY - EvoSQLConfiguration.MIN_ROW_QTY);
			for(int j=0; j < numberOfRows; j++) {
				FixtureRow row = rowFactory.create(tableSchema, tables, seeds);
				rows.add(row);
				log.debug("Row created: {}", row);
			}
			tables.add(new FixtureTable(tableSchema, rows));
		}

		return new Fixture(tables);
	}
}

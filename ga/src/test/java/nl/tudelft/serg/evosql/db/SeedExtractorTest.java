package nl.tudelft.serg.evosql.db;

import org.junit.Assert;
import org.junit.Test;


public class SeedExtractorTest {

	@Test
	public void extractInt() {
		Seeds seeds = new SeedExtractor("select * from table where age = 15").extract();
		Assert.assertTrue(seeds.getLongs().contains("15"));
	}

	@Test
	public void extractComparisons() {
		Seeds seeds = new SeedExtractor("select * from table where age = 15 and age < 10 and age > 25 and age <= 30 and age >= 40 and age <> 50").extract();
		Assert.assertTrue(seeds.getLongs().contains("10"));
		Assert.assertTrue(seeds.getLongs().contains("15"));
		Assert.assertTrue(seeds.getLongs().contains("25"));
		Assert.assertTrue(seeds.getLongs().contains("30"));
		Assert.assertTrue(seeds.getLongs().contains("40"));
		Assert.assertTrue(seeds.getLongs().contains("50"));
	}

	@Test
	public void extractDouble() {
		Seeds seeds = new SeedExtractor("select * from table where age > 15.0").extract();
		Assert.assertTrue(seeds.getDoubles().contains("15.0"));
	}

	@Test
	public void extractStrings() {
		Seeds seeds = new SeedExtractor("select * from table where name = 'mauricio'").extract();
		Assert.assertTrue(seeds.getStrings().contains("mauricio"));
	}

	@Test
	public void extractStringsAndInts() {
		Seeds seeds = new SeedExtractor("select * from table where name = 'mauricio' and age = 20").extract();
		Assert.assertTrue(seeds.getStrings().contains("mauricio"));
		Assert.assertTrue(seeds.getLongs().contains("20"));
	}

	@Test
	public void extractSubQueries() {
		Seeds seeds = new SeedExtractor("select * from table where name = (select name from t2 where name = 'mauricio') and age = 10").extract();
		Assert.assertTrue(seeds.getStrings().contains("mauricio"));
		Assert.assertTrue(seeds.getLongs().contains("10"));
	}

	@Test
	public void extractLike() {
		Seeds seeds = new SeedExtractor("select * from table where name like '%mauricio%aniche'").extract();
		Assert.assertTrue(seeds.getStrings().contains("%mauricio%aniche"));
	}

	@Test
	public void extractIn() {
		Seeds seeds = new SeedExtractor("select * from table where age in (10, 15)").extract();
		Assert.assertTrue(seeds.getLongs().contains("10"));
		Assert.assertTrue(seeds.getLongs().contains("15"));
	}

	@Test
	public void extractArithmetic() {
		Seeds seeds = new SeedExtractor("select * from table where age = age + 10 + 15 - 5 / 2").extract();
		Assert.assertTrue(seeds.getLongs().contains("10"));
		Assert.assertTrue(seeds.getLongs().contains("15"));
		Assert.assertTrue(seeds.getLongs().contains("5"));
		Assert.assertTrue(seeds.getLongs().contains("2"));
	}

	@Test
	public void extractNothing() {
		Seeds seeds = new SeedExtractor("select * from table where age = age2").extract();
		Assert.assertTrue(seeds.getLongs().isEmpty());
		Assert.assertTrue(seeds.getStrings().isEmpty());
		Assert.assertTrue(seeds.getDoubles().isEmpty());

		seeds = new SeedExtractor("select * from table").extract();
		Assert.assertTrue(seeds.getLongs().isEmpty());
		Assert.assertTrue(seeds.getStrings().isEmpty());
		Assert.assertTrue(seeds.getDoubles().isEmpty());
	}

	@Test
	public void extractBetween() {
		Seeds seeds = new SeedExtractor("select * from table where age between 15 and 25").extract();
		Assert.assertTrue(seeds.getLongs().contains("15"));
		Assert.assertTrue(seeds.getLongs().contains("25"));
	}

	@Test
	public void extractFromSubquery() {
		Seeds seeds = new SeedExtractor("SELECT (SELECT MAX(Type) FROM Product_Detail WHERE Name = 'A') Subinfo, Product FROM Products").extract();
		Assert.assertTrue(seeds.getStrings().contains("A"));
	}
}

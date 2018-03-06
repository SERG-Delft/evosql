package nl.tudelft.serg.evosql.test;

import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@Ignore
@RunWith(Suite.class)
@Suite.SuiteClasses({
	SelectTest.class,
	DistinctTest.class,
	WhereTest.class,
	InTest.class,
	GroupByTest.class,
	HavingTest.class,
	SubqueryFromTest.class,
	SubquerySelectWhereTest.class,
	InnerJoinTest.class,
	LeftJoinTest.class,
	RightJoinTest.class,
	NullTest.class,
	CountTest.class,
	BetweenTest.class,
	LikeTest.class,
	ExistsTest.class,
	DatatypesTest.class,
	AggregatesTest.class,
	StringsTest.class
})
public class AllTestsSuite {}

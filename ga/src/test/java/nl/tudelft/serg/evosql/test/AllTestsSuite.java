package nl.tudelft.serg.evosql.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({
	TestSelect.class,
	TestDistinct.class,
	TestWhere.class,
	TestIn.class,
	TestGroupBy.class,
	TestHaving.class,
	TestSubqueryFrom.class,
	TestSubquerySelectWhere.class,
	TestInnerJoin.class,
	TestLeftJoin.class,
	TestRightJoin.class,
	TestNull.class,
	TestCount.class,
	TestBetween.class,
	TestLike.class,
	TestExists.class,
	TestDatatypes.class,
	TestAggregates.class,
	TestStrings.class
})
public class AllTestsSuite {}

package nl.tudelft.serg.evosql.querydepth;

import net.sf.jsqlparser.statement.select.Select;
import nl.tudelft.serg.evosql.test.*;
import org.junit.Assert;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

/**
 * Tests whether the QueryDepthExtractor can find the right depth for
 * certain queries. The expected number is derived from running the query
 * with EvoSQL and checking the fixture fitnesses.
 */
public class QueryDepthExtractorTest {

    /**
     * @see HavingTest#test2()
     */
    static final String TEST_QUERY_HAVING =
            "SELECT Product, AVG(Price) FROM products WHERE LENGTH(Product) = 5 GROUP BY Product HAVING AVG(Price) > 0 AND AVG(Price) < 10";

    /**
     * @see SubquerySelectWhereTest#test9()
     */
    static final String TEST_QUERY_SUBQUERY_1 =
            "SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM Product_Detail t2 WHERE LENGTH(t.Product) = (SELECT MIN(t3.ID) FROM Products t3 WHERE t3.ID >= 0 AND t3.Product = t2.Name))";

    /**
     * @see SubquerySelectWhereTest#test10()
     */
    static final String TEST_QUERY_SUBQUERY_2 =
            "SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM Product_Detail t2 WHERE LENGTH(t.Product) = (SELECT MIN(t3.ID) FROM Products t3 WHERE t3.ID >= 0 AND t3.Product = t2.Name))";

    /**
     * @see InnerJoinTest#test7()
     */
    static final String TEST_QUERY_JOIN =
            "SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID INNER JOIN PRODUCT_DETAIL t3 ON t1.ID = t3.ID - 10";

    /**
     * @author Daniël van Gelder
     */
    static final String TEST_QUERY_ERROR =
            "SELEC t FR;";

    /**
     * @author Daniël van Gelder
     */
    static final String TEST_QUERY_COMPOSITE =
            "SELECT Product, AVG(Price) FROM products INNER JOIN Table ON products.id=Table.id WHERE Price IN (SELECT Price FROM Product WHERE Price < 100) GROUP BY Product HAVING COUNT(Product) = 3";

    /**
     * @see InTest#test1()
     */
    static final String TEST_QUERY_IN_SET =
            "SELECT Product, Price FROM Products WHERE Product IN ('HI', 'BYE')";

    /**
     * @see InTest#test2()
     */
    static final String TEST_QUERY_IN_SUBQUERY =
            "SELECT Product, Price FROM Products WHERE Product IN (SELECT Name FROM Product_Detail)";

    /**
     * @author Daniël van Gelder
     */
    static final String TEST_QUERY_NESTED_SUBQUERY_1 =
            "SELECT Product, Id FROM Products WHERE Id IN (SELECT Id FROM Product_Detail WHERE Name IN (SELECT Name FROM Price))";

    /**
     * @see ExistsTest#test2()
     */
    static final String TEST_QUERY_EXISTS =
            "SELECT Product, Price FROM Products pr WHERE EXISTS (SELECT ID FROM Product_detail WHERE Type = pr.ID AND EXISTS(SELECT * FROM Price))";

    /**
     * @see SubqueryFromTest#test7()
     */
    static final String TEST_GROUP_BY_HAVING =
            "SELECT Product FROM (SELECT Product, Price FROM products GROUP BY Product, Price) t GROUP BY Product HAVING SUM(Price) > 4";

    /**
     * @see SubqueryFromTest#test8()
     */
    static final String TEST_NESTED_HAVING =
            "SELECT Product FROM (SELECT Product, Price FROM products GROUP BY Product, Price HAVING SUM(Price) < 10) t GROUP BY Product HAVING SUM(Price) > 4";

    /**
     * @see RightJoinTest#testRightJoinWithNulls2BasedOnEspocrmQ21P15()
     */
    static final String TEST_QUERY_LONG =
            "SELECT PORTAL.ID AS ID, PORTAL.NAME AS NAME, PORTAL.DELETED AS DELETED, PORTAL.CUSTOM_ID AS CUSTOMID, PORTAL.IS_ACTIVE AS " +
                    "ISACTIVE, PORTAL.TAB_LIST AS TABLIST, PORTAL.QUICK_CREATE_LIST AS QUICKCREATELIST, PORTAL.THEME AS THEME, PORTAL.LANGUAGE" +
                    "AS LANGUAGE, PORTAL.TIME_ZONE AS TIMEZONE, PORTAL.DATE_FORMAT AS DATEFORMAT, PORTAL.TIME_FORMAT AS TIMEFORMAT, " +
                    "PORTAL.WEEK_START AS WEEKSTART, PORTAL.DEFAULT_CURRENCY AS DEFAULTCURRENCY, PORTAL.DASHBOARD_LAYOUT AS DASHBOARDLAYOUT, " +
                    "PORTAL.DASHLETS_OPTIONS AS DASHLETSOPTIONS, PORTAL.CUSTOM_URL AS CUSTOMURL, PORTAL.MODIFIED_AT AS MODIFIEDAT, " +
                    "PORTAL.CREATED_AT AS CREATEDAT, PORTAL.MODIFIED_BY_ID AS MODIFIEDBYID, TRIM(CONCAT(MODIFIEDBY.FIRST_NAME, ' ', " +
                    "MODIFIEDBY.LAST_NAME)) AS MODIFIEDBYNAME, PORTAL.CREATED_BY_ID AS CREATEDBYID, TRIM(CONCAT(CREATEDBY.FIRST_NAME, ' ', " +
                    "CREATEDBY.LAST_NAME)) AS CREATEDBYNAME, LOGO.NAME AS LOGONAME, PORTAL.LOGO_ID AS LOGOID, COMPANYLOGO.NAME AS " +
                    "COMPANYLOGONAME, PORTAL.COMPANY_LOGO_ID AS COMPANYLOGOID "
                    + "FROM PORTAL INNER JOIN "
                    + "USER AS MODIFIEDBY ON PORTAL.MODIFIED_BY_ID = MODIFIEDBY.ID "
                    + "INNER JOIN USER AS CREATEDBY ON PORTAL.CREATED_BY_ID = CREATEDBY.ID "
                    + "INNER JOIN ATTACHMENT AS LOGO ON PORTAL.LOGO_ID = LOGO.ID "
                    + "LEFT JOIN ATTACHMENT AS COMPANYLOGO ON PORTAL.COMPANY_LOGO_ID = COMPANYLOGO.ID "
                    + "WHERE ( "
                    + "( COMPANYLOGO.ID IS NULL ) AND "
                    + "( PORTAL.COMPANY_LOGO_ID IS NULL ) "
                    + ") AND "
                    + "( PORTAL.ID = 'testPortalId' AND PORTAL.DELETED = '0' )";

    /**
     * @see SubquerySelectWhereTest#test3()
     */
    static final String TEST_TWO_SUBQUERIES =
            "SELECT * FROM (SELECT Product, Price FROM products t WHERE LENGTH(t.Product) = 1 GROUP BY Product, Price) t " +
                    "WHERE t.Price < (SELECT MAX(Type) FROM product_detail t2 WHERE t.Product = t2.Name)";


    /**
     * @see RightJoinTest#test4()
     */
    static final String TEST_RIGHT_JOIN =
            "SELECT * FROM Products t1 RIGHT JOIN PRODUCT_DETAIL t3 ON t1.ID = t3.ID - 1 RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.Type = 10";

    @Test
    public void parserSetupTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_HAVING);
        Select statement = extractor.getStatement();
        Assert.assertNotNull(statement);
    }

    @Test
    public void queryDepthHavingTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_HAVING);
        Assert.assertEquals(2, extractor.getQueryDepth());
    }

    @Test
    public void queryDepthSubquery1Test() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_SUBQUERY_1);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void queryDepthSubquery2Test() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_SUBQUERY_2);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void queryDepthJoinTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_JOIN);
        Assert.assertEquals(1, extractor.getQueryDepth());
    }

    @Test
    public void queryDepthInSetTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_IN_SET);
        Assert.assertEquals(2, extractor.getQueryDepth());
    }

    @Test
    public void queryDepthInSubQueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_IN_SUBQUERY);
        Assert.assertEquals(2, extractor.getQueryDepth());
    }

    @Test
    public void invalidQueryTest() {
        Assertions.assertThrows(RuntimeException.class, () -> {
            QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_ERROR);
        });
    }

    @Test
    public void compositeQueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_COMPOSITE);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void nestedInQueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_NESTED_SUBQUERY_1);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void existsWithNestedSubqueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_EXISTS);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void longQueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_LONG);
        Assert.assertEquals(1, extractor.getQueryDepth());
    }

    @Test
    public void groupByHavingTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_GROUP_BY_HAVING);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void nestedHavingTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_NESTED_HAVING);
        Assert.assertEquals(4, extractor.getQueryDepth());
    }

    //Verifies behaviour of reusing depth attribute using mocks
    @Test
    public void reuseDepthTest() {
        Select mock = Mockito.mock(Select.class);
        QueryDepthExtractor extractor = new QueryDepthExtractor(mock);
        extractor.getQueryDepth();
        extractor.getQueryDepth();
        Mockito.verify(mock, Mockito.atMost(1)).accept(Mockito.any());
    }

    @Test
    public void setTestTwoSubqueries() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_TWO_SUBQUERIES);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void rightJoinTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_RIGHT_JOIN);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }


}

package nl.tudelft.serg.evosql.querydepth;

import net.sf.jsqlparser.statement.select.Select;
import org.junit.Assert;
import org.junit.Test;

public class QueryDepthExtractorTest {

    static final String TEST_QUERY_HAVING =
            "SELECT Product, AVG(Price) FROM products WHERE LENGTH(Product) = 5 GROUP BY Product HAVING AVG(Price) > 0 AND AVG(Price) < 10";

    static final String TEST_QUERY_SUBQUERY =
            "SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM Product_Detail t2 WHERE LENGTH(t.Product) = (SELECT MIN(t3.ID) FROM Products t3 WHERE t3.ID >= 0 AND t3.Product = t2.Name))";

    static final String TEST_QUERY_JOIN =
            "SELECT Product FROM Products t1 INNER JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID INNER JOIN PRODUCT_DETAIL t3 ON t1.ID = t3.ID - 10";

    static final String TEST_QUERY_ERROR =
            "SELEC t FR;";

    static final String TEST_QUERY_COMPOSITE =
            "SELECT Product, AVG(Price) FROM products INNER JOIN Table ON products.id=Table.id WHERE Price IN (SELECT Price FROM Product WHERE Price < 100) GROUP BY Product HAVING COUNT(Product) = 3";

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
    public void queryDepthSubqueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_SUBQUERY);
        Assert.assertEquals(3, extractor.getQueryDepth());
    }

    @Test
    public void queryDepthJoinTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_JOIN);
        Assert.assertEquals(3,extractor.getQueryDepth());
    }

    @Test(expected=RuntimeException.class)
    public void invalidQueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_ERROR);
    }

    @Test
    public void compositeQueryTest() {
        QueryDepthExtractor extractor = new QueryDepthExtractor(TEST_QUERY_COMPOSITE);
        Assert.assertEquals(4, extractor.getQueryDepth());
    }


}

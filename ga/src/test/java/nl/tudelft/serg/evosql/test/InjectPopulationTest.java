package nl.tudelft.serg.evosql.test;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.fixture.type.DBDouble;
import nl.tudelft.serg.evosql.fixture.type.DBInteger;
import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.metaheuristics.GAApproach;
import nl.tudelft.serg.evosql.metaheuristics.operators.FixtureFitness;
import nl.tudelft.serg.evosql.querydepth.QueryDepthExtractorTest;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.TestCase.assertTrue;

public class InjectPopulationTest extends TestBase {
    private final TableSchema tableSchemaProducts = createTableProductsSchema();
    private final TableSchema tableSchemaProductDetail = createTableProductDetailSchema();


    private TableSchema createTableProductsSchema() {
        List<ColumnSchema> columnSchemasProducts = new ArrayList<>();
        TableSchema tableSchemaProducts = new TableSchema("PRODUCTS", columnSchemasProducts);
        ColumnSchema columnSchemaIdProducts = new ColumnSchema(tableSchemaProducts, "ID", new DBInteger(), true, false);
        ColumnSchema columnSchemaProductProducts = new ColumnSchema(tableSchemaProducts, "PRODUCT", new DBString(500), true, false);
        ColumnSchema columnSchemaPriceProducts = new ColumnSchema(tableSchemaProducts, "PRICE", new DBDouble(), false, false);
        columnSchemasProducts.add(columnSchemaIdProducts);
        columnSchemasProducts.add(columnSchemaProductProducts);
        columnSchemasProducts.add(columnSchemaPriceProducts);
        return tableSchemaProducts;
    }

    private TableSchema createTableProductDetailSchema() {
        List<ColumnSchema> columnSchemasProductDetail = new ArrayList<>();
        TableSchema tableSchemaProductDetail = new TableSchema("PRODUCT_DETAIL", columnSchemasProductDetail);
        ColumnSchema columnSchemaIdProductDetail = new ColumnSchema(tableSchemaProductDetail, "ID", new DBInteger(), true, false);
        ColumnSchema columnSchemaNameProductDetail = new ColumnSchema(tableSchemaProductDetail, "NAME", new DBString(500), true, false);
        ColumnSchema columnSchemaTypeProductDetail = new ColumnSchema(tableSchemaProductDetail, "TYPE", new DBInteger(), true, false);
        columnSchemasProductDetail.add(columnSchemaIdProductDetail);
        columnSchemasProductDetail.add(columnSchemaNameProductDetail);
        columnSchemasProductDetail.add(columnSchemaTypeProductDetail);
        return tableSchemaProductDetail;
    }

    /**
     * @see SubquerySelectWhereTest#test3()
     * <p>
     * FIXTURE to be generated:
     * Products
     * ID PRODUCT PRICE
     * 1  i       1
     * <p>
     * Product detail
     * ID NAME TYPE
     * 1  i	   2
     */
    @Test
    public void injectCorrectPopulationTest3() {
        List<Fixture> injectedPopulation = new ArrayList<>();
        List<FixtureTable> fixtureTables = new ArrayList<>();

        // Create Table for table PRODUCT
        List<FixtureRow> fixtureRowsProducts = new ArrayList<>();
        FixtureRow fixtureRowProducts = new FixtureRow("PRODUCTS", tableSchemaProducts);
        fixtureRowsProducts.add(fixtureRowProducts);
        FixtureTable fixtureTableProducts = new FixtureTable(tableSchemaProducts, fixtureRowsProducts);
        fixtureRowProducts.set("ID", "1");
        fixtureRowProducts.set("PRODUCT", "i");
        fixtureRowProducts.set("PRICE", "1");
        fixtureTables.add(fixtureTableProducts);

        // Create Table for table PRODUCT_DETAIL
        List<FixtureRow> fixtureRowsProductDetail = new ArrayList<>();
        FixtureRow fixtureRowProductDetail = new FixtureRow("PRODUCT_DETAIL", tableSchemaProductDetail);
        fixtureRowsProductDetail.add(fixtureRowProductDetail);
        FixtureTable fixtureTableProductDetail = new FixtureTable(tableSchemaProductDetail, fixtureRowsProductDetail);
        fixtureRowProductDetail.set("ID", "1");
        fixtureRowProductDetail.set("NAME", "i");
        fixtureRowProductDetail.set("TYPE", "2");
        fixtureTables.add(fixtureTableProductDetail);

        // Set Fixture
        Fixture fixture = new Fixture(fixtureTables);
        FixtureFitness ff = Mockito.mock(FixtureFitness.class);
        Mockito.when(ff.getFitnessValue()).thenReturn(0.d);
        injectedPopulation.add(fixture);
        fixture.setFitness(ff);
        setPopulation(injectedPopulation,true);
        assertTrue(testExecutePath(QueryDepthExtractorTest.TEST_TWO_SUBQUERIES));
    }


    /**
     * @see SubquerySelectWhereTest#test7()
     * <p>
     * FIXTURE to be generated:
     * Products
     * ID PRODUCT PRICE
     * 1  to       10
     * <p>
     * Product detail
     * ID NAME TYPE
     * 1  to	   200
     */
    @Test
    public void injectCorrectPopulationTest7() {
        List<Fixture> injectedPopulation = new ArrayList<>();
        List<FixtureTable> fixtureTables = new ArrayList<>();

        // Create Table for table PRODUCT
        List<FixtureRow> fixtureRowsProducts = new ArrayList<>();
        FixtureRow fixtureRowProducts = new FixtureRow("PRODUCTS", tableSchemaProducts);
        fixtureRowsProducts.add(fixtureRowProducts);
        FixtureTable fixtureTableProducts = new FixtureTable(tableSchemaProducts, fixtureRowsProducts);
        fixtureRowProducts.set("ID", "1");
        fixtureRowProducts.set("PRODUCT", "to");
        fixtureRowProducts.set("PRICE", "10");
        fixtureTables.add(fixtureTableProducts);


        // Create Table for table PRODUCT_DETAIL
        List<FixtureRow> fixtureRowsProductDetail = new ArrayList<>();
        FixtureRow fixtureRowProductDetail = new FixtureRow("PRODUCT_DETAIL", tableSchemaProductDetail);
        fixtureRowsProductDetail.add(fixtureRowProductDetail);
        FixtureTable fixtureTableProductDetail = new FixtureTable(tableSchemaProductDetail, fixtureRowsProductDetail);
        fixtureRowProductDetail.set("ID", "1");
        fixtureRowProductDetail.set("NAME", "to");
        fixtureRowProductDetail.set("TYPE", "200");
        fixtureTables.add(fixtureTableProductDetail);

        // Create Table List
        fixtureTables.add(fixtureTableProductDetail);

        // Set Fixture
        Fixture fixture = new Fixture(fixtureTables);
        FixtureFitness ff = Mockito.mock(FixtureFitness.class);
        Mockito.when(ff.getFitnessValue()).thenReturn(0.d);
        injectedPopulation.add(fixture);
        fixture.setFitness(ff);
        setPopulation(injectedPopulation,true);
        assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM (SELECT Name, Type FROM Product_Detail WHERE LENGTH(Name) = 2) t2 WHERE t.Product = t2.Name)"));
    }


    /**
     * @see SubquerySelectWhereTest#test8()
     * Products
     * ID PRODUCT PRICE
     * 2  i      10
     *
     * Product detail
     * ID NAME TYPE
     * 1  i    200
     */
    @Test
    public void injectCorrectPopulationTest8() {
        List<Fixture> injectedPopulation = new ArrayList<>();
        List<FixtureTable> fixtureTables = new ArrayList<>();

        // Create Table for table PRODUCT
        List<FixtureRow> fixtureRowsProducts = new ArrayList<>();
        FixtureRow fixtureRowProducts = new FixtureRow("PRODUCTS", tableSchemaProducts);
        fixtureRowsProducts.add(fixtureRowProducts);
        FixtureTable fixtureTableProducts = new FixtureTable(tableSchemaProducts, fixtureRowsProducts);
        fixtureRowProducts.set("ID", "2");
        fixtureRowProducts.set("PRODUCT", "i");
        fixtureRowProducts.set("PRICE", "10");
        fixtureTables.add(fixtureTableProducts);


        // Create Table for table PRODUCT_DETAIL
        List<FixtureRow> fixtureRowsProductDetail = new ArrayList<>();
        FixtureRow fixtureRowProductDetail = new FixtureRow("PRODUCT_DETAIL", tableSchemaProductDetail);
        fixtureRowsProductDetail.add(fixtureRowProductDetail);
        FixtureTable fixtureTableProductDetail = new FixtureTable(tableSchemaProductDetail, fixtureRowsProductDetail);
        fixtureRowProductDetail.set("ID", "1");
        fixtureRowProductDetail.set("NAME", "i");
        fixtureRowProductDetail.set("TYPE", "200");
        fixtureTables.add(fixtureTableProductDetail);

        // Create Table List
        fixtureTables.add(fixtureTableProductDetail);

        // Set Fixture
        Fixture fixture = new Fixture(fixtureTables);
        FixtureFitness ff = Mockito.mock(FixtureFitness.class);
        Mockito.when(ff.getFitnessValue()).thenReturn(0.d);
        injectedPopulation.add(fixture);
        fixture.setFitness(ff);
        setPopulation(injectedPopulation,true);
        assertTrue(testExecutePath("SELECT * FROM Products t WHERE t.Price < (SELECT MAX(Type) FROM (SELECT Name, Type FROM Product_Detail t3 WHERE LENGTH(Name) < t.ID) t2 WHERE t.Product = t2.Name)"));
    }


    /**
     * @see RightJoinTest#testRightJoinWithNulls2BasedOnEspocrmQ21P15()
     */
}

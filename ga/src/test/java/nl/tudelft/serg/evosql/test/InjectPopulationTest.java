package nl.tudelft.serg.evosql.test;

import nl.tudelft.serg.evosql.fixture.Fixture;
import nl.tudelft.serg.evosql.fixture.FixtureRow;
import nl.tudelft.serg.evosql.fixture.FixtureTable;
import nl.tudelft.serg.evosql.fixture.type.DBDouble;
import nl.tudelft.serg.evosql.fixture.type.DBInteger;
import nl.tudelft.serg.evosql.fixture.type.DBString;
import nl.tudelft.serg.evosql.querydepth.QueryDepthExtractorTest;
import nl.tudelft.serg.evosql.sql.ColumnSchema;
import nl.tudelft.serg.evosql.sql.TableSchema;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.TestCase.assertTrue;

public class InjectPopulationTest extends TestBase {
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


        // Generate TableSchema for table PRODUCTS
        List<ColumnSchema> columnSchemasProducts = new ArrayList<>();
        TableSchema tableSchemaProducts = new TableSchema("PRODUCTS", columnSchemasProducts);
        ColumnSchema columnSchemaIdProducts = new ColumnSchema(tableSchemaProducts, "ID", new DBInteger(), true, false);
        ColumnSchema columnSchemaProductProducts = new ColumnSchema(tableSchemaProducts, "PRODUCT", new DBString(500), true, false);
        ColumnSchema columnSchemaPriceProducts = new ColumnSchema(tableSchemaProducts, "PRICE", new DBDouble(), false, false);
        columnSchemasProducts.add(columnSchemaIdProducts);
        columnSchemasProducts.add(columnSchemaProductProducts);
        columnSchemasProducts.add(columnSchemaPriceProducts);

        // Generate TableSchema for table PRODUCT_DETAIL
        List<ColumnSchema> columnSchemasProductDetail = new ArrayList<>();
        TableSchema tableSchemaProductDetail = new TableSchema("PRODUCT_DETAIL", columnSchemasProductDetail);
        ColumnSchema columnSchemaIdProductDetail = new ColumnSchema(tableSchemaProductDetail, "ID", new DBInteger(), true, false);
        ColumnSchema columnSchemaNameProductDetail = new ColumnSchema(tableSchemaProductDetail, "NAME", new DBString(500), true, false);
        ColumnSchema columnSchemaTypeProductDetail = new ColumnSchema(tableSchemaProductDetail, "TYPE", new DBInteger(), true, false);
        columnSchemasProductDetail.add(columnSchemaIdProductDetail);
        columnSchemasProductDetail.add(columnSchemaNameProductDetail);
        columnSchemasProductDetail.add(columnSchemaTypeProductDetail);

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

        // Create Table List
        fixtureTables.add(fixtureTableProducts);
        fixtureTables.add(fixtureTableProductDetail);

        // Set Fixture
        Fixture fixture = new Fixture(fixtureTables);
        injectedPopulation.add(fixture);
        setPopulation(injectedPopulation);
        assertTrue(testExecutePath(QueryDepthExtractorTest.TEST_TWO_SUBQUERIES));
    }


    /**
     * @see SubquerySelectWhereTest#test7()
     */

    /**
     * @see SubquerySelectWhereTest#test8()
     */


    /**
     * @see RightJoinTest#testRightJoinWithNulls2BasedOnEspocrmQ21P15()
     */
}

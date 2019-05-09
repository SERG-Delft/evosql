package nl.tudelft.serg.evosql.experiment;


import net.sf.jsqlparser.JSQLParserException;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

/**
 * Tests end-to-end functionality of query mutation.
 */
public class QueryMutatorTest {
// TODO: Make assertions more specific

   @Disabled // We know that ErpNext fails since the schema XML is too large...
   @Test
   public void mutateQueryErpNext1Test() throws JSQLParserException {
       String query = "select * from `tabPOS Profile` where user = 'Administrator' and company = '_Test Company'";
       QueryMutator queryMutator = new QueryMutator(query);
       List<String> result = queryMutator.createMutants().getMutants();
       assertFalse(result.isEmpty());
   }

   @Test
   public void mutateQueryEspoCrm1Test() throws JSQLParserException {
       String query = "SELECT COUNT(role.id) AS AggregateValue FROM `role` WHERE role.id = '589dd9e072d8768c3' AND role.deleted = '0'";
       QueryMutator queryMutator = new QueryMutator(query);
       List<String> result = queryMutator.createMutants().getMutants();
       assertFalse(result.isEmpty());
   }

   @Test
   public void mutateQuerySuiteCrm1Test() throws JSQLParserException {
       String query = " SELECT  currencies.*  FROM currencies  where currencies.deleted=0 ORDER BY currencies.name";
       QueryMutator queryMutator = new QueryMutator(query);
       List<String> result = queryMutator.createMutants().getMutants();
       assertFalse(result.isEmpty());
   }

   @Test
   public void mutateQueryTest4() throws JSQLParserException {
       String sql = "SELECT * FROM MY_TABLE1, MY_TABLE2, (SELECT * FROM MY_TABLE3) LEFT OUTER JOIN MY_TABLE4 " +
               " WHERE ID = (SELECT MAX(ID) FROM MY_TABLE5) AND ID2 IN (SELECT * FROM MY_TABLE6)";
       QueryMutator queryMutator = new QueryMutator(sql);
       List<String> result = queryMutator.createMutants().getMutants();
       for (String s : result) {
           System.out.println(s);
       }
       assertFalse(result.isEmpty());
   }

    @Test
    void simpleANDEqualsTest() throws JSQLParserException {
        String sql = "SELECT * FROM myTable WHERE age = 5 AND year > 2019";
        QueryMutator queryMutator = new QueryMutator(sql);
        MutationResult result = queryMutator.createMutants();
        result.print();
        assertFalse(result.getMutants().isEmpty());
    }

    @Test
    void simpleOREqualsTest() throws JSQLParserException {
        String sql = "SELECT * FROM myTable WHERE age = 5 OR year > 2019";
        QueryMutator queryMutator = new QueryMutator(sql);
        MutationResult result = queryMutator.createMutants();
        result.print();
        assertFalse(result.getMutants().isEmpty());
    }


    @Test
    void simpleORArithmeticTest() throws JSQLParserException {
        String sql = "SELECT * FROM myTable WHERE age + year = 5";
        QueryMutator queryMutator = new QueryMutator(sql);
        MutationResult result = queryMutator.createMutants();
        result.print();
        assertFalse(result.getMutants().isEmpty());
    }

    @Test
    void simpleDoubleTest() throws JSQLParserException {
        String sql = "SELECT * FROM myTable WHERE age = 5.0";
        QueryMutator queryMutator = new QueryMutator(sql);
        MutationResult result = queryMutator.createMutants();
        result.print();
        assertFalse(result.getMutants().isEmpty());
    }

    @Test
    void simpleLongTest() throws JSQLParserException {
        String sql = "SELECT * FROM myTable WHERE age = 5";
        QueryMutator queryMutator = new QueryMutator(sql);
        MutationResult result = queryMutator.createMutants();
        result.print();
        assertFalse(result.getMutants().isEmpty());
    }

}

package nl.tudelft.serg.evosql.experiment;


import org.junit.Ignore;
import org.junit.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

/**
 * Tests end-to-end functionality of query mutation.
 */
public class QueryMutatorTest {
// TODO: Make assertions more specific

    @Ignore // We know that ErpNext fails since the schema XML is too large...
    @Test
    public void mutateQueryErpNext1Test() {
        String query = "select * from `tabPOS Profile` where user = 'Administrator' and company = '_Test Company'";
        QueryMutator queryMutator = new QueryMutator(query, "erpnext");
        List<String> result = queryMutator.createMutants();
        assertFalse(result.isEmpty());
    }

    @Test
    public void mutateQueryEspoCrm1Test() {
        String query = "SELECT COUNT(role.id) AS AggregateValue FROM `role` WHERE role.id = '589dd9e072d8768c3' AND role.deleted = '0'";
        QueryMutator queryMutator = new QueryMutator(query, "espocrm");
        List<String> result = queryMutator.createMutants();
        assertFalse(result.isEmpty());
    }

    @Test
    public void mutateQuerySuiteCrm1Test() {
        String query = " SELECT  currencies.*  FROM currencies  where currencies.deleted=0 ORDER BY currencies.name";
        QueryMutator queryMutator = new QueryMutator(query, "suitecrm");
        List<String> result = queryMutator.createMutants();
        assertFalse(result.isEmpty());
    }


}

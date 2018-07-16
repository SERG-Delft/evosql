package nl.tudelft.serg.evosql.experiment;

import org.junit.Test;

import static org.junit.Assert.assertFalse;

/**
 * Tests that check whether a connection to the web service can be made.
 */
public class WebMutatorConnectorTest {

    @Test
    public void webRequestErpNextTest() {
        String sqlQuery = "select name, is_group from `tabWarehouse` where `tabWarehouse`.company = '_Test Company' order by `tabWarehouse`.`modified` desc";
        WebMutatorConnector webMutatorConnector = new WebMutatorConnector(sqlQuery, "erpnext");
        String result = webMutatorConnector.requestMutants();
        System.out.println(result);
        assertFalse(result.isEmpty());
    }

    @Test
    public void webRequestEspoCrmTest() {
        String sqlQuery = "SELECT COUNT(role.id) AS AggregateValue FROM `role` WHERE role.id = '589dd9e072d8768c3' AND role.deleted = '0'";
        WebMutatorConnector webMutatorConnector = new WebMutatorConnector(sqlQuery, "espocrm");
        String result = webMutatorConnector.requestMutants();
        System.out.println(result);
        assertFalse(result.isEmpty());
    }

    @Test
    public void webRequestSuiteCrmTest() {
        String sqlQuery = "SELECT meetings.* from meetings_users,meetings  WHERE  meetings_users.meeting_id=meetings.id AND meetings_users.user_id='1' AND meetings.deleted=0 AND meetings_users.deleted=0";
        WebMutatorConnector webMutatorConnector = new WebMutatorConnector(sqlQuery, "suitecrm");
        String result = webMutatorConnector.requestMutants();
        System.out.println(result);
        assertFalse(result.isEmpty());
    }

}

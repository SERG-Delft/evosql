package nl.tudelft.serg.evosql.test;

import nl.tudelft.serg.evosql.EvoSQL;
import nl.tudelft.serg.evosql.Result;
import nl.tudelft.serg.evosql.metaheuristics.GAApproach;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;

import static org.junit.Assert.assertTrue;

public class TestLongQuery extends TestBase {


    private static Logger log = LogManager.getLogger(TestBase.class);


    static String jdbcUrl = "jdbc:hsqldb:mem/EvoSQLtest";
    static String user = "SA";
    static String database = "PUBLIC";
    static String schema = "PUBLIC";
    static String pwd = "";

    static {
        // Load HSQLDB driver
        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver" );
        } catch (Exception e) {
            System.err.println("ERROR: failed to load HSQLDB JDBC driver.");
            e.printStackTrace();
        }
    }

    @Test
    public void test1() {
        EvoSQL ga = new EvoSQL(jdbcUrl,database,schema,user,pwd,true);
        assertTrue(ga.execute("select count(securitygroups.id) as results from securitygroups inner join securitygroups_users on securitygroups.id = securitygroups_users.securitygroup_id and securitygroups_users.deleted = 0   and securitygroups_users.user_id = '' inner join securitygroups_records on securitygroups.id = securitygroups_records.securitygroup_id and securitygroups_records.deleted = 0   and securitygroups_records.record_id = '6aa0d809-8f2d-fbef-bd77-589c858f860b'   and securitygroups_records.module = 'Documents' where securitygroups.deleted = 0 \n") instanceof Result);
    }
}

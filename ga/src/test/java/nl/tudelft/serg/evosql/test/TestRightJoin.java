package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class TestRightJoin extends TestBase {
	
	/**
	 * Right join with WHERE on the first table to be a value, which is not possible in our GA
	 * However this could accidentally be solved, so the test is switched off.
	 */
	/*
	@Test
	public void test1() {
		assertFalse(testExecutePath("SELECT * FROM Products t1 RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t1.Price > 10"));
	}
	*/
	
	/**
	 * Right join with WHERE on the first table to be null
	 */
	@Test
	public void test2() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t1.Price IS NULL"));
	}
	
	/**
	 * Right join with WHERE on the joined table
	 */
	@Test
	public void test3() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.Type = 10"));
	}
	
	/**
	 * Right join with WHERE on the joined table
	 */
	@Test
	public void test4() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 RIGHT JOIN PRODUCT_DETAIL t3 ON t1.ID = t3.ID - 1 RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.Type = 10"));
	}
	
	/**
	 * Right join after LEFT JOIN
	 */
	@Test
	public void test5() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 LEFT JOIN PRODUCT_DETAIL t3 ON t1.ID = t3.ID RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID WHERE t2.Type = 10"));
	}
	
	/**
	 * INNER JOIN after RIGHT JOIN
	 */
	@Test
	public void test6() {
		assertTrue(testExecutePath("SELECT * FROM Products t1 RIGHT JOIN PRODUCT_DETAIL t2 ON t1.ID = t2.ID INNER JOIN extra_product t3 ON t2.Type = t3.ID WHERE t1.ID IS NULL AND t2.ID IS NULL"));
	}
	
	@Test
	public void testRightJoinWithNullsBasedOnEspocrmQ10P6() {
		String sql = "SELECT * FROM STRINGS RIGHT JOIN STRINGS2 ON STRINGS.C1 = STRINGS2.C1 AND STRINGS2.C2 = 'testPortalId' AND STRINGS2.C3 = '1' WHERE ( STRINGS.C1 IS NULL ) AND ( STRINGS2.C1 IS NULL ) AND ( STRINGS2.C2 IS NULL ) AND ( STRINGS2.C3 IS NULL ) ";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testRightJoinWithNulls2BasedOnEspocrmQ21P15() {
		
		createTable("PORTAL", "CREATE TABLE PORTAL ("+
		        "  id varchar(24),"+
		        "  name varchar(100) ,"+
		        "  deleted int,"+
		        "  custom_id varchar(36) ,"+
		        "  is_active int,"+
		        "  tab_list varchar(255),"+
		        "  quick_create_list varchar(255),"+
		        "  theme varchar(255) ,"+
		        "  language varchar(255) ,"+
		        "  time_zone varchar(255) ,"+
		        "  date_format varchar(255) ,"+
		        "  time_format varchar(255) ,"+
		        "  week_start int,"+
		        "  default_currency varchar(255) ,"+
		        "  dashboard_layout varchar(255),"+
		        "  dashlets_options varchar(255),"+
		        "  custom_url varchar(255),"+
		        "  modified_at datetime ,"+
		        "  created_at datetime ,"+
		        "  modified_by_id varchar(24) ,"+
		        "  created_by_id varchar(24) ,"+
		        "  logo_id varchar(24) ,"+
		        "  company_logo_id varchar(24) "+
		        ")");
		
		createTable("USER", "CREATE TABLE USER ("+
				"  id varchar(24) ,"+
				"  deleted int ,"+
				"  is_admin int  ,"+
				"  user_name varchar(50) ,"+
				"  password varchar(150) ,"+
				"  salutation_name varchar(255) ,"+
				"  first_name varchar(100) DEFAULT '',"+
				"  last_name varchar(100) DEFAULT '',"+
				"  is_active int  ,"+
				"  is_portal_user int  ,"+
				"  is_super_admin int  ,"+
				"  title varchar(100) ,"+
				"  gender varchar(255) DEFAULT '',"+
				"  created_at datetime ,"+
				"  default_team_id varchar(24) ,"+
				"  contact_id varchar(24) ,"+
				"  avatar_id varchar(24) ,"+
				")");
		
		createTable("ATTACHMENT", "CREATE TABLE ATTACHMENT ("+
				"  id varchar(24) ,"+
				"  name varchar(255) ,"+
				"  deleted int ,"+
				"  type varchar(100) ,"+
				"  size int ,"+
				"  source_id varchar(36) ,"+
				"  created_at datetime ,"+
				"  role varchar(36) ,"+
				"  storage varchar(24) ,"+
				"  global int  ,"+
				"  parent_id varchar(24) ,"+
				"  parent_type varchar(100) ,"+
				"  related_id varchar(24) ,"+
				"  related_type varchar(100) ,"+
				"  created_by_id varchar(24) ,"+
				")");
		
		String sql = "SELECT PORTAL.ID AS ID, PORTAL.NAME AS NAME, PORTAL.DELETED AS DELETED, PORTAL.CUSTOM_ID AS CUSTOMID, PORTAL.IS_ACTIVE AS ISACTIVE, PORTAL.TAB_LIST AS TABLIST, PORTAL.QUICK_CREATE_LIST AS QUICKCREATELIST, PORTAL.THEME AS THEME, PORTAL.LANGUAGE AS LANGUAGE, PORTAL.TIME_ZONE AS TIMEZONE, PORTAL.DATE_FORMAT AS DATEFORMAT, PORTAL.TIME_FORMAT AS TIMEFORMAT, PORTAL.WEEK_START AS WEEKSTART, PORTAL.DEFAULT_CURRENCY AS DEFAULTCURRENCY, PORTAL.DASHBOARD_LAYOUT AS DASHBOARDLAYOUT, PORTAL.DASHLETS_OPTIONS AS DASHLETSOPTIONS, PORTAL.CUSTOM_URL AS CUSTOMURL, PORTAL.MODIFIED_AT AS MODIFIEDAT, PORTAL.CREATED_AT AS CREATEDAT, PORTAL.MODIFIED_BY_ID AS MODIFIEDBYID, TRIM(CONCAT(MODIFIEDBY.FIRST_NAME, ' ', MODIFIEDBY.LAST_NAME)) AS MODIFIEDBYNAME, PORTAL.CREATED_BY_ID AS CREATEDBYID, TRIM(CONCAT(CREATEDBY.FIRST_NAME, ' ', CREATEDBY.LAST_NAME)) AS CREATEDBYNAME, LOGO.NAME AS LOGONAME, PORTAL.LOGO_ID AS LOGOID, COMPANYLOGO.NAME AS COMPANYLOGONAME, PORTAL.COMPANY_LOGO_ID AS COMPANYLOGOID "
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
		
		assertTrue(testExecutePath(sql));
	}

}

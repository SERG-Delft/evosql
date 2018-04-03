package nl.tudelft.serg.evosql.test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StringsTest extends TestBase {
	
	@Test
	public void testManyStringEqualities() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"C1 = 'Mauricio' and C2 = 'Annibale' and C3 = 'Mozhan' and C4 = 'Jeroen@jeroen.com' and C5 = 'Arie' " +
				"and C6 = '1_2' and C7 = '_Stroopwafel'";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringGreater() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"( C1 > 'Mauricio' ) ";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringGreaterEqual() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"( C1 >= 'Mozhan' ) ";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringSmaller() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"( C1 < 'Arie' ) ";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringSmallerEqual() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"( C1 <= 'Annibale' ) ";
		
		assertTrue(testExecutePath(sql));
	}

	@Test
	public void testEqualitiesAndLike() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"C1 = 'Mauricio' and C2 = 'Annibale' and C3 = 'Mozhan' and C4 = 'Jeroen' and C5 = 'Arie' " +
				"and C6 = '1_2' and C7 = 'Stroopwafel' and C8 like '%John%Doe%'";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringFunctions() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"C1 = 'Mauricio' and C2 = 'Annibale' and C3 = 'Mozhan' and C4 = 'Jeroen' and C5 = 'Arie' and LENGTH(C6) = 7";
		
		assertTrue(testExecutePath(sql));
	}

	@Test
	public void testStringFunctionsReverse() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"REVERSE(C1) = 'Mauricio' and C2 = 'Annibale' and C3 = 'Mozhan'";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void refrigeratorReverse() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"REVERSE(C1) = 'refrigerator'";
		
		assertTrue(testExecutePath(sql));
	}


	@Test
	public void testStringFunctionsRight() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"c1 like 'mau%' and right(C1, 3) = 'cio' and C2 = 'Annibale' and C3 = 'Mozhan'";
		
		assertTrue(testExecutePath(sql));
	}
	
	
	@Test
	public void testStringEqualitiesAndNull() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"C1 = 'Mauricio' and C2 = 'Annibale' and C3 = 'Mozhan' and C4 = 'Jeroen' and C5 = 'Arie' and C6 is null";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testDifferent() {
		String sql = "SELECT * FROM STRINGS WHERE " +
				"C1 = 'Mauricio' and C2 != 'Annibale' and C3 = 'Mozhan' and C4 = 'Jeroen' and C5 != 'Arie' and C6 is null";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testBigStrings() {
		
		String sql = "SELECT * FROM STRINGS WHERE " +
				"C1 = '71b756b6dadb58257371b6c636517c7c665214921154776a01ae1424167c9a6d' and "
				+ "C2 = '71b756b6dadb58257371b6cdasdasd517c7c665214921154776a01ae1424167c9a6d' and "
				+ "C3 = '71b756b6dadb58257371b6c636517c7c665214921154776a01fdsfdfsdfd4167c9a6d' and "
				+ "C4 = '71b756b6dadb5fdkjfhdskfhkds8257371b6c636517c7c665214921154776a01ae1424167c9a6d4397eofhdjfhdsiruyewirugewrew' "
				+ "and C5 = 'Arie'";
		
		assertTrue(testExecutePath(sql));
	}

	@Test
	public void testStringsInSubQueries() {
		String sql = "SELECT C1 FROM STRINGS where c1 in (select c1 from STRINGS2 where c1 = 'Mauricio')";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringsInSubQueriesPlusHaving() {
		String sql = "SELECT C1, COUNT(*) total FROM (SELECT C1 FROM STRINGS WHERE C1 = 'Mauricio') newtable GROUP BY C1 HAVING COUNT(*) > 3";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringsInSubQueriesWithLikesPlusHaving() {
		String sql = "SELECT C1, COUNT(*) total FROM (SELECT C1 FROM STRINGS WHERE C1 like 'Mauricio%') newtable GROUP BY C1 HAVING COUNT(*) > 2";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void testStringsAndJoins() {
		String sql = "SELECT C1 FROM STRINGS s1 join strings2 s2 on s1.c1 = s2.c2 where c3 = 'Jeroen'";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void moreConditionsBasedOnErpnextQ1016P19(){
		String sql = "SELECT * FROM STRINGS WHERE ( C1 IS NULL ) AND ( C2 IN ( 'Created', 'Updated', 'Submitted', 'Cancelled', 'Deleted' ) ) AND ( ( C3 = 'Task' AND C4 = 'TASK00009' ) ) AND NOT ((C5 = 'Task' AND C6 = 'TASK00009'))";
		
		assertTrue(testExecutePath(sql));
	}
	
	@Test
	public void realQueryBasedOnErpnextQ1016P19() {
		createTable("tabCommunication", "CREATE TABLE  tabCommunication  ("+
				"   name  varchar(140)   ,"+
				"   creation  datetime DEFAULT NULL,"+
				"   modified  datetime DEFAULT NULL,"+
				"   modified_by  varchar(140)  DEFAULT NULL,"+
				"   owner  varchar(140)  DEFAULT NULL,"+
				"   docstatus  int   DEFAULT '0',"+
				"   parent  varchar(140)  DEFAULT NULL,"+
				"   parentfield  varchar(140)  DEFAULT NULL,"+
				"   parenttype  varchar(140)  DEFAULT NULL,"+
				"   idx  int   DEFAULT '0',"+
				"   comment_type  varchar(140)  DEFAULT NULL,"+
				"   cc  varchar(500)  ,"+
				"   read_receipt  int   DEFAULT '0',"+
				"   link_doctype  varchar(140)  DEFAULT NULL,"+
				"   timeline_doctype  varchar(140)  DEFAULT NULL,"+
				"   sender_full_name  varchar(140)  DEFAULT NULL,"+
				"   seen  int   DEFAULT '0',"+
				"   email_account  varchar(140)  DEFAULT NULL,"+
				"   reference_owner  varchar(140)  DEFAULT NULL,"+
				"   subject  varchar(500)  ,"+
				"   reference_doctype  varchar(140)  DEFAULT NULL,"+
				"   text_content  varchar(500)  ,"+
				"   comments  varchar(500)  ,"+
				"   unread_notification_sent  int   DEFAULT '0',"+
				"   content  varchar(500)  ,"+
				"   communication_medium  varchar(140)  DEFAULT NULL,"+
				"   link_name  varchar(140)  DEFAULT NULL,"+
				"   message_id  varchar(995)  DEFAULT NULL,"+
				"   status  varchar(140)  DEFAULT NULL,"+
				"   liked_by  varchar(500)  ,"+
				"   recipients  varchar(500)  ,"+
				"   timeline_label  varchar(140)  DEFAULT NULL,"+
				"   communication_type  varchar(140)  DEFAULT 'Communication',"+
				"   assign  varchar(500)  ,"+
				"   reference_name  varchar(140)  DEFAULT NULL,"+
				"   user  varchar(140)  DEFAULT NULL,"+
				"   delivery_status  varchar(140)  DEFAULT NULL,"+
				"   in_reply_to  varchar(140)  DEFAULT NULL,"+
				"   user_tags  varchar(500)  ,"+
				"   sender  varchar(255)  DEFAULT NULL,"+
				"   sent_or_received  varchar(140)  DEFAULT NULL,"+
				"   timeline_name  varchar(140)  DEFAULT NULL,"+
				"   phone_no  varchar(140)  DEFAULT NULL,"+
				"   communication_date  datetime DEFAULT NULL,"+
				"   signature  varchar(140)  DEFAULT NULL"+
				")");
		
		String sql = "SELECT name, communication_type, communication_medium, comment_type, content, sender, sender_full_name, creation, subject, delivery_status, liked_by, timeline_doctype, timeline_name, reference_doctype, reference_name, link_doctype, link_name, 'Communication' AS DOCTYPE FROM tabCommunication WHERE ( communication_type IS NULL ) AND ( comment_type IN ( 'Created', 'Updated', 'Submitted', 'Cancelled', 'Deleted' ) ) AND ( ( timeline_doctype = 'Task' AND timeline_name = 'TASK00009' ) ) AND NOT ((reference_doctype = 'Task' AND reference_name = 'TASK00009'))";
		
		assertTrue(testExecutePath(sql));
		
	}
	
}

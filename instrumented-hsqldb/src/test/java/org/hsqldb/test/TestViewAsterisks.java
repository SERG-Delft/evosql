/* Copyright (c) 2001-2014, The HSQL Development Group
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the HSQL Development Group nor the names of its
 * contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL HSQL DEVELOPMENT GROUP, HSQLDB.ORG,
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


package org.hsqldb.test;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import org.hsqldb.error.ErrorCode;

import junit.framework.AssertionFailedError;

/**
 *  is a test which verifies the functionality of replacing asterisks in VIEW statements with column
 *  lists.
 *
 *  During investigating http://www.openoffice.org/issues/show_bug.cgi?id=78296 (an issue raised
 *  in OpenOffice.org, which integrates HSQLDB), it rose that views did not behave to the standard
 *  in that they don't always reflect the table column list at the time of creation of the view.
 *
 *  This was changed so that when you CREATE a VIEW, then any asterisks in the constituting
 *  statement are replaced with their column lists.
 *
 *  This test verifies this functionality in a number of different flavours.
 *
 * @author frank.schoenheit@sun.com
 */
public class TestViewAsterisks extends TestBase {

    java.sql.Statement  m_statement;
    java.sql.Connection m_connection;

    /** Creates a new instance of TestViewAsterisks */
    public TestViewAsterisks(String testName) {
        super(testName, null, false, false);
    }

    /**
     * creates the database tables needed for the test
     */
    private void setupDatabase() {

        try {
            m_connection = newConnection();
            m_statement  = m_connection.createStatement();

            executeStatement("DROP TABLE ABC IF EXISTS CASCADE");
            executeStatement("DROP TABLE TABLE_A IF EXISTS CASCADE");
            executeStatement("DROP TABLE TABLE_B IF EXISTS CASCADE");
            executeStatement("DROP VIEW V1 IF EXISTS CASCADE"); // V1 is created by a previous test case
            executeStatement(
                "CREATE TABLE ABC (ID INTEGER NOT NULL PRIMARY KEY, A VARCHAR(50), B VARCHAR(50), C VARCHAR(50))");
            executeStatement("INSERT INTO ABC VALUES (1, 'a', 'b', 'c')");
            executeStatement("INSERT INTO ABC VALUES (2, 'd', 'e', 'f')");
            executeStatement(
                "CREATE TABLE TABLE_A (ID_A INTEGER NOT NULL PRIMARY KEY, NAME_A VARCHAR(50))");
            executeStatement("INSERT INTO TABLE_A VALUES (1, 'first A')");
            executeStatement("INSERT INTO TABLE_A VALUES (2, 'second A')");
            executeStatement(
                "CREATE TABLE TABLE_B (ID_B INTEGER NOT NULL PRIMARY KEY, NAME_B VARCHAR(50))");
            executeStatement("INSERT INTO TABLE_B VALUES (1, 'first B')");
            executeStatement("INSERT INTO TABLE_B VALUES (2, 'second B')");
        } catch (SQLException ex) {
            fail(ex.toString());
        }
    }

    public void setUp() throws Exception {
        super.setUp();
        setupDatabase();
    }

    protected void tearDown() {
        executeStatement("SHUTDOWN");
        super.tearDown();
    }

    /**
     * executes a given m_statement
     *
     *  <p>Basically, this method calls <code>m_statement.execute(sql)</code>,
     *  but wraps any <code>SQLException</code>s into a JUnit error.
     */
    private void executeStatement(String sql) {
        executeStatement(sql, 0);
    }

    private void executeStatement(String sql, int expectedVendorCode) {

        try {
            m_statement.execute(sql);
            assertTrue(
                "executing\n  " + sql
                + "\nwas expected to fail, but it didn't", expectedVendorCode
                    == 0);
        } catch (SQLException ex) {
            if (expectedVendorCode == 0) {
                fail(ex.toString());
            }

            assertEquals(
                "executing\n  " + sql
                + "\ndid not result in the expected error", expectedVendorCode, -ex
                    .getErrorCode());
        }
    }

    /**
     *  creates a view with the given name, the given constituting statement, and an optional column list
     *
     *  @param viewName
     *      specifies the name of the view to create
     *  @param columnList
     *      list of names of the columns of the view, will be specified in the CREATE VIEW statement. Might be <code>null</code>.
     *  @param viewStatement
     *      the statement of the view
     */
    private void createView(String viewName, String[] columnList,
                            String viewStatement) throws SQLException {

        StringBuffer colList = new StringBuffer();

        if (columnList != null) {
            colList.append(" (");

            for (int i = 0; i < columnList.length; ++i) {
                colList.append('"').append(columnList[i]).append('"');

                if (i < columnList.length - 1) {
                    colList.append(',');
                }
            }

            colList.append(")");
        }

        executeStatement("CREATE VIEW " + viewName + colList.toString()
                         + " AS " + viewStatement);

        if (columnList != null) {
            ensureTableColumns(viewName, columnList);
        }
    }

    /**
     *  retrieves the statement which defines a given view
     */
    private String getViewStatement(String viewName) throws SQLException {

        ResultSet res = m_statement.executeQuery(
            "SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = '"
            + viewName + "'");

        res.next();

        String statement = res.getString(1);

        return statement;
    }

    /**
     *  ensures two tables (or views, that is) have the same content
     */
    private void ensureEqualContent(String tableNameLHS,
                                    String tableNameRHS) throws SQLException {

        ResultSet lhs = m_statement.executeQuery("SELECT * FROM \""
            + tableNameLHS + "\"");
        ResultSet rhs = m_statement.executeQuery("SELECT * FROM \""
            + tableNameRHS + "\"");
        ResultSetMetaData meta = lhs.getMetaData();

        while (lhs.next() && rhs.next()) {
            for (int col = 1; col <= meta.getColumnCount(); ++col) {
                assertEquals("table content does not match: cp. "
                             + tableNameLHS + "-" + tableNameRHS + ", row "
                             + lhs.getRow() + ", col "
                             + col, lhs.getObject(col), rhs.getObject(col));
            }
        }

        // lhs should be after last, rhs still on last
        assertTrue("row count does not match: " + tableNameLHS + "-"
                   + tableNameRHS, lhs.isAfterLast() && rhs.isLast());
    }

    /**
     *  ensures the content of a given table matches a given object array's content
     */
    private void ensureTableContent(String tableName,
                                    Object[][] tableData) throws SQLException {

        ResultSet lhs = m_statement.executeQuery("SELECT * FROM \""
            + tableName + "\"");
        ResultSetMetaData meta     = lhs.getMetaData();
        int               colCount = meta.getColumnCount();

        while (lhs.next()) {
            int row = lhs.getRow();

            assertEquals(colCount, tableData[row - 1].length);

            for (int col = 1; col <= colCount; ++col) {
                assertEquals(
                    "unexpected table content in " + tableName + " (row "
                    + row + ", col " + col + ")", tableData[row - 1][col - 1],
                                                  lhs.getObject(col));
            }
        }
    }

    /**
     *  creates a view with a given name and statement, ensures that it's statement is translated as expected, and ensures
     *  that the content of the view is as expected
     *
     *  @param viewName
     *      the name of the to-be-created view
     *  @param columnNames
     *      the names of the columns of the view, as to be specified in the CREATE VIEW statement. Might be null,
     *      in this case the view will be created without an explicit column list
     *  @param viewStatement
     *      the statement of the to-be-created view
     *  @param expectedTranslatedStatement
     *      the expected statement of the view, after it has been implicitly translated by HSQL. If the actual
     *      statement after creation does not match this expected statement, this is a failure condition which
     *      results in a AssertionFailedError being thrown.
     *  @param expectedContent
     *      the expected content of the view. If this is <code>null</code>, it is ignored. Else, if it is a
     *      string, it is interpreted as name of the table which must have the same content as a view. If
     *      it's no string either, it must be a two-dimensional Object array specifying the expected content.
     */
    private void checkViewTranslationAndContent(String viewName,
            String[] columnList, String viewStatement,
            String expectedTranslatedStatement,
            Object expectedContent) throws SQLException {

        createView(viewName, columnList, viewStatement);

        String actualTranslatedStatement = getViewStatement(viewName);

        if (!actualTranslatedStatement.equals(expectedTranslatedStatement)) {
            StringBuffer message = new StringBuffer();

            message.append(viewName).append(
                "'s statement not translated as expected\n");
            message.append("original statement:\n  ").append(
                viewStatement).append('\n');
            message.append("expected translated statement:\n  ").append(
                expectedTranslatedStatement).append('\n');
            message.append("actual translated statement:\n  ").append(
                actualTranslatedStatement).append('\n');

            throw new AssertionFailedError(message.toString());
        }

        if (expectedContent instanceof Object[][]) {
            ensureTableContent(viewName, (Object[][]) expectedContent);
        }
    }

    /**
     *  ensures that a given table has columns with a given name
     */
    private void ensureTableColumns(String tableName,
                                    String[] columnNames) throws SQLException {

        ResultSet res = m_connection.getMetaData().getColumns(null, null,
            tableName, "%");

        while (res.next()) {
            assertEquals(
                "unexpected column name in table \"" + tableName
                + "\" at position "
                + (res.getRow() - 1), res.getString(
                    "COLUMN_NAME"), columnNames[res.getRow() - 1]);
        }

        res.previous();
        assertEquals("not enough columns in table \"" + tableName + "\"",
                     columnNames.length, res.getRow());
    }

    /**
     *  checks views selecting an asterisk from a table, in different flavours
     */
    private void checkSimpleViews() throws SQLException {

        // ................................................................
        // SELECT *
        checkViewTranslationAndContent(
            "S1", null, "SELECT * FROM ABC",
            "SELECT PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC",
            "ABC");

        // adding a column to "ABC" should succeed, and still leave the view with the columns
        // before the addition
        executeStatement("ALTER TABLE ABC ADD COLUMN D VARCHAR(50)");
        ensureTableColumns("ABC", new String[] {
            "ID", "A", "B", "C", "D"
        });
        ensureTableColumns("S1", new String[] {
            "ID", "A", "B", "C"
        });

        // dropping the column which is not part of the view should be possible
        executeStatement("ALTER TABLE ABC DROP COLUMN D");

        // dropping another column which *is* part of the view shouldn't
        executeStatement("ALTER TABLE ABC DROP COLUMN C", ErrorCode.X_42536);

        // finally, dropping the column with CASCADE should work, and also drop the view
        //executeStatement("ALTER TABLE ABC DROP COLUMN C CASCADE");
        // DROP COLUMN c CASCADE not implemented, yet
        // ................................................................
        // same as S1, but this time add a LIMIT clause to the statement
        checkViewTranslationAndContent(
            "S2", null, "SELECT LIMIT 0 2 * FROM ABC ORDER BY ID",
            "SELECT LIMIT 0 2 PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC ORDER BY ID",
            "ABC");

        // ................................................................
        // same as S1, but this time add a TOP clause to the statement
        checkViewTranslationAndContent(
            "S3", null, "SELECT TOP 2 * FROM ABC ORDER BY ID",
            "SELECT TOP 2 PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC ORDER BY ID",
            "ABC");

        // ................................................................
        // same as S1, but this time add a DISTINCT clause to the statement
        checkViewTranslationAndContent(
            "S4", null, "SELECT DISTINCT * FROM ABC",
            "SELECT DISTINCT PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC",
            "ABC");

        // ................................................................
        // same as S1, but this time qualifying the asterisk
        checkViewTranslationAndContent(
            "S5", null, "SELECT ABC.* FROM ABC",
            "SELECT  PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C  FROM PUBLIC.ABC",
            "ABC");

        // ................................................................
        // same as S5, but this time also giving the table an alias
        checkViewTranslationAndContent(
            "S6", null, "SELECT \"A\".* FROM ABC AS A",
            "SELECT A.ID,A.A,A.B,A.C FROM PUBLIC.ABC AS A",
            "ABC");

        // ................................................................
        // same as S1, but bracket the SELECT definition
        checkViewTranslationAndContent(
            "S7", null, "( SELECT * FROM ABC )",
            "(SELECT PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC)",
            "ABC");
    }

    /**
     *  checks views selecting an asterisk plus existing columns
     */
    private void checkAsterisksCombined() throws SQLException {

        // ................................................................
        checkViewTranslationAndContent(
            "C1", null, "SELECT * AS \"a2\" FROM ABC",
            "SELECT PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C AS \"a2\" FROM PUBLIC.ABC",
            new Object[][] {
            new Object[] {
                new Integer(1), "a", "b", "c"
            }, new Object[] {
                new Integer(2), "d", "e", "f"
            }
        });

        // ................................................................
        checkViewTranslationAndContent(
            "C2", null, "SELECT B AS \"b2\", ABC.* FROM ABC",
            "SELECT B AS \"b2\", PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C  FROM PUBLIC.ABC",
            new Object[][] {
            new Object[] {
                "b", new Integer(1), "a", "b", "c"
            }, new Object[] {
                "e", new Integer(2), "d", "e", "f"
            }
        });
    }

    /**
     *  checks views selecting asterisks from multiple tables
     */
    private void checkMultipleTables() throws SQLException {

        // ................................................................
        checkViewTranslationAndContent(
            "M1", null, "SELECT * FROM TABLE_A, TABLE_B",
            "SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A,PUBLIC.TABLE_B.ID_B,PUBLIC.TABLE_B.NAME_B FROM PUBLIC.TABLE_A,PUBLIC.TABLE_B",
            new Object[][] {
            new Object[] {
                new Integer(1), "first A", new Integer(1), "first B"
            }, new Object[] {
                new Integer(1), "first A", new Integer(2), "second B"
            }, new Object[] {
                new Integer(2), "second A", new Integer(1), "first B"
            }, new Object[] {
                new Integer(2), "second A", new Integer(2), "second B"
            }
        });

        // ................................................................
        checkViewTranslationAndContent(
            "M2", null, "SELECT TABLE_B.*, TABLE_A.* FROM TABLE_A, TABLE_B",
            "SELECT  PUBLIC.TABLE_B.ID_B,PUBLIC.TABLE_B.NAME_B , PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A  FROM PUBLIC.TABLE_A,PUBLIC.TABLE_B",
            new Object[][] {
            new Object[] {
                new Integer(1), "first B", new Integer(1), "first A"
            }, new Object[] {
                new Integer(2), "second B", new Integer(1), "first A"
            }, new Object[] {
                new Integer(1), "first B", new Integer(2), "second A"
            }, new Object[] {
                new Integer(2), "second B", new Integer(2), "second A"
            }
        });

        // ................................................................
        checkViewTranslationAndContent(
            "M3", null, "SELECT \"TABLE_A\".* FROM TABLE_A, TABLE_B",
            "SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A FROM PUBLIC.TABLE_A,PUBLIC.TABLE_B",
            new Object[][] {
            new Object[] {
                new Integer(1), "first A"
            }, new Object[] {
                new Integer(1), "first A"
            }, new Object[] {
                new Integer(2), "second A"
            }, new Object[] {
                new Integer(2), "second A"
            }
        });
    }

    /**
     *  checks views selecting from sub selects
     */
    private void checkSubSelects() throws SQLException {

        // ................................................................
        checkViewTranslationAndContent(
            "Q1", null, "SELECT * FROM ( SELECT * FROM ABC )",
            "SELECT ID,A,B,C FROM(SELECT PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC)",
            null);

        // ................................................................
        checkViewTranslationAndContent(
            "Q2", null,
            "SELECT * FROM ( SELECT * FROM TABLE_A ), ( SELECT * FROM TABLE_B )",
            "SELECT ID_A,NAME_A,ID_B,NAME_B FROM(SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A FROM PUBLIC.TABLE_A),(SELECT PUBLIC.TABLE_B.ID_B,PUBLIC.TABLE_B.NAME_B FROM PUBLIC.TABLE_B)",
            null);

        // ................................................................
        checkViewTranslationAndContent(
            "Q3", null, "SELECT A.* FROM ( SELECT * FROM TABLE_A ) AS A",
            "SELECT  A.ID_A,A.NAME_A  FROM(SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A FROM PUBLIC.TABLE_A)AS A",
            null);

        // ................................................................
        checkViewTranslationAndContent(
            "Q4", null,
            "SELECT A.*, B.* FROM ( SELECT * FROM TABLE_A ) AS A, ( SELECT * FROM TABLE_B ) AS B",
            "SELECT  A.ID_A,A.NAME_A , B.ID_B,B.NAME_B  FROM(SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A FROM PUBLIC.TABLE_A)AS A,(SELECT PUBLIC.TABLE_B.ID_B,PUBLIC.TABLE_B.NAME_B FROM PUBLIC.TABLE_B)AS B",
            null);
    }

    /**
     *  checks views which are defined using a column list
     */
    private void checkColumnLists() throws SQLException {

        // just to ensure the column count handling is as expected, else below tests might be useless
        executeStatement("CREATE VIEW IMPOSSIBLE (\"A\") AS SELECT * FROM ABC",
                         ErrorCode.X_42593);

        // ................................................................
        // not that it should make any difference to S1, but who knows
        checkViewTranslationAndContent("L1", new String[] {
            "C1", "C2", "C3", "C4"
        }, "SELECT * FROM ABC", "SELECT PUBLIC.ABC.ID,PUBLIC.ABC.A,PUBLIC.ABC.B,PUBLIC.ABC.C FROM PUBLIC.ABC",
           "ABC");
    }

    /**
     *  checks views based on other views
     */
    private void checkViewsOnViews() throws SQLException {

        // ................................................................
        // not that it should make any difference whether we SELECT FROM a table or view, but who knows
        checkViewTranslationAndContent(
            "V1", null, "SELECT * FROM S1",
            "SELECT PUBLIC.S1.ID,PUBLIC.S1.A,PUBLIC.S1.B,PUBLIC.S1.C FROM PUBLIC.S1", "L1");
    }

    /**
     *  checks views based on a UNION statement
     */
    private void checkUnionViews() throws SQLException {

        checkViewTranslationAndContent(
            "U1", null, "SELECT * FROM TABLE_A UNION SELECT * FROM TABLE_B",
            "SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A FROM PUBLIC.TABLE_A UNION SELECT PUBLIC.TABLE_B.ID_B,PUBLIC.TABLE_B.NAME_B FROM PUBLIC.TABLE_B",
            new Object[][] {
            new Object[] {
                new Integer(1), "first A"
            }, new Object[] {
                new Integer(1), "first B"
            }, new Object[] {
                new Integer(2), "second A"
            }, new Object[] {
                new Integer(2), "second B"
            }
        });
        checkViewTranslationAndContent(
            "U2", null,
            "SELECT * FROM ( SELECT * FROM TABLE_A UNION SELECT * FROM TABLE_B )",
            "SELECT ID_A,NAME_A FROM(SELECT PUBLIC.TABLE_A.ID_A,PUBLIC.TABLE_A.NAME_A FROM PUBLIC.TABLE_A UNION SELECT PUBLIC.TABLE_B.ID_B,PUBLIC.TABLE_B.NAME_B FROM PUBLIC.TABLE_B)",
            new Object[][] {
            new Object[] {
                new Integer(1), "first A"
            }, new Object[] {
                new Integer(1), "first B"
            }, new Object[] {
                new Integer(2), "second A"
            }, new Object[] {
                new Integer(2), "second B"
            }
        });
    }

    /**
     *  main test method of this class
     */
    public void test() {

        try {
            checkSimpleViews();
            checkAsterisksCombined();
            checkMultipleTables();
            checkSubSelects();
            checkColumnLists();
            checkViewsOnViews();
            checkUnionViews();
        } catch (SQLException ex) {
            fail(ex.toString());
        }
    }

    /**
     *  entry point to run the test directly
     */
    public static void main(String[] argv) {
        runWithResult(TestViewAsterisks.class, "test");
    }
}

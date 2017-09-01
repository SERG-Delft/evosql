/* Copyright (c) 2001-2015, The HSQL Development Group
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

import java.io.IOException;
import java.io.PrintStream;
import java.sql.SQLException;

import org.hsqldb.lib.FileUtil;

/** test various text table features
 *
 * @author frank.schoenheit@sun.com
 */
public class TestTextTable extends TestBase {

    java.sql.Statement  m_statement;
    java.sql.Connection m_connection;

    private class TextTableDescriptor {

        private String     m_name;
        private String     m_columnSpec;
        private String     m_separator;
        private String     m_separatorSpec;
        private Object[][] m_data;

        public TextTableDescriptor(String name, String columnSpec,
                                   String separator, String separatorSpec,
                                   Object[][] data) {

            m_name          = name;
            m_columnSpec    = columnSpec;
            m_separator     = separator;
            m_separatorSpec = separatorSpec;
            m_data          = data;
        }

        public final String getName() {
            return m_name;
        }

        public final String getColumnSpec() {
            return m_columnSpec;
        }

        public final String getSeparator() {
            return m_separator;
        }

        public final String getSeparatorSpec() {
            return m_separatorSpec;
        }

        public final Object[][] getData() {
            return m_data;
        }

        public final Object[][] appendRowData(Object[] rowData) {

            Object[][] newData = new Object[m_data.length + 1][rowData.length];

            for (int row = 0; row < m_data.length; ++row) {
                newData[row] = m_data[row];
            }

            newData[m_data.length] = rowData;
            m_data                 = newData;

            return m_data;
        }

        /**
         * creates a text file as described by this instance
         */
        private void createTextFile() {

            PrintStream textFile = null;

            try {
                String completeFileName = m_name + ".csv";

                FileUtil.getFileUtil().delete(completeFileName);

                textFile = new PrintStream(
                    FileUtil.getFileUtil().openOutputStreamElement(
                        completeFileName));

                new java.io.File(completeFileName).deleteOnExit();
            } catch (IOException ex) {
                fail(ex.toString());
            }

            for (int row = 0; row < m_data.length; ++row) {
                StringBuffer buf      = new StringBuffer();
                int          colCount = m_data[row].length;

                for (int col = 0; col < colCount; ++col) {
                    buf.append(m_data[row][col].toString());

                    if (col + 1 != colCount) {
                        buf.append(m_separator);
                    }
                }

                textFile.println(buf.toString());
            }

            textFile.close();
        }

        private String getDataSourceSpec() {
            return m_name + ".csv;encoding=UTF-8;fs=" + m_separatorSpec;
        }

        private void createTable(java.sql.Connection connection)
        throws SQLException {

            String createTable = "DROP TABLE \"" + m_name + "\" IF EXISTS;";

            createTable += "CREATE TEXT TABLE \"" + m_name + "\" ( "
                           + m_columnSpec + " );";

            connection.createStatement().execute(createTable);

            boolean test = isReadOnly(m_name);
            String setTableSource = "SET TABLE \"" + m_name + "\" SOURCE \""
                                    + getDataSourceSpec() + "\"";

            connection.createStatement().execute(setTableSource);
        }
    }
    ;

    TextTableDescriptor m_products = new TextTableDescriptor("products",
        "ID INTEGER PRIMARY KEY, \"name\" VARCHAR(20)", "\t", "\\t",
        new Object[][] {
        new Object[] {
            new Integer(1), "Apples"
        }, new Object[] {
            new Integer(2), "Oranges"
        }
    });
    TextTableDescriptor m_customers = new TextTableDescriptor("customers",
        "ID INTEGER PRIMARY KEY," + "\"name\" VARCHAR(50),"
        + "\"address\" VARCHAR(50)," + "\"city\" VARCHAR(50),"
        + "\"postal\" VARCHAR(50)", ";", "\\semi", new Object[][] {
        new Object[] {
            new Integer(1), "Food, Inc.", "Down Under", "Melbourne", "509"
        }, new Object[] {
            new Integer(2), "Simply Delicious", "Down Under", "Melbourne",
            "518"
        }, new Object[] {
            new Integer(3), "Pure Health", "10 Fish St.", "San Francisco",
            "94107"
        }
    });

    /** Creates a new instance of TestTextTable */
    public TestTextTable(String testName) {
        super(testName, "jdbc:hsqldb:file:test", false, false);
    }

    /**
     * sets up all text files for the test database
     */
    private void setupTextFiles() {
        m_products.createTextFile();
        m_customers.createTextFile();
    }

    /**
     * creates the database tables needed for the test
     */
    private void setupDatabase() {

        try {
            m_connection = newConnection();
            m_statement  = m_connection.createStatement();

            m_products.createTable(m_connection);
            m_customers.createTable(m_connection);
        } catch (SQLException ex) {
            fail(ex.toString());
        }
    }

    public void setUp() throws Exception {

        super.setUp();
        setupTextFiles();
        setupDatabase();
    }

    protected void tearDown() {
        executeStatement("SHUTDOWN");
        super.tearDown();
    }

    /**
     * returns the data source definition for a given text table
     */
    private String getDataSourceSpec(String tableName) {

        String spec = null;

        try {
            java.sql.ResultSet results = m_statement.executeQuery(
                "SELECT DATA_SOURCE_DEFINTION FROM INFORMATION_SCHEMA.SYSTEM_TEXTTABLES "
                + "WHERE TABLE_NAME='" + tableName + "'");

            results.next();

            spec = results.getString(1);
        } catch (SQLException ex) {
            fail("getDataSourceSpec(" + tableName + ") failed: "
                 + ex.toString());
        }

        return spec;
    }

    /**
     * determines whether a given table is currently read-only
     */
    private boolean isReadOnly(String tableName) {

        boolean isReadOnly = true;

        try {
            java.sql.ResultSet systemTables = m_statement.executeQuery(
                "SELECT READ_ONLY FROM INFORMATION_SCHEMA.SYSTEM_TABLES "
                + "WHERE TABLE_NAME='" + m_products.getName() + "'");

            systemTables.next();

            isReadOnly = systemTables.getBoolean(1);
        } catch (SQLException ex) {
            fail("isReadOnly(" + tableName + ") failed: " + ex.toString());
        }

        return isReadOnly;
    }

    /**
     * checks different field separators
     */
    private void checkSeparators() {

        String[][] separators = new String[][] {

            // special separators
            new String[] {
                ";", "\\semi"
            }, new String[] {
                "\"", "\\quote"
            }, new String[] {
                " ", "\\space"
            }, new String[] {
                "'", "\\apos"
            },

            //new String[] { "\n", "\\n" },
            // doesn't work as expected - seems I don't understand how this is intended to work?
            new String[] {
                "\t", "\\t"
            }, new String[] {
                "\\", "\\"
            },

            // some arbitrary separators which need not to be escaped
            new String[] {
                ".", "."
            }, new String[] {
                "-", "-"
            }, new String[] {
                "#", "#"
            }, new String[] {
                ",", ","
            }

            // unicode character
            //new String[] { "\u1234", "\\u1234" }
            // doesn't work. How do I specify in a FileOutputStream which encoding to use when writing
            // strings?
        };

        for (int i = 0; i < separators.length; ++i) {
            String separator     = separators[i][0];
            String separatorSpec = separators[i][1];

            // create the file
            String tableName = "customers_" + i;
            TextTableDescriptor tempCustomersDesc =
                new TextTableDescriptor(tableName,
                                        m_customers.getColumnSpec(),
                                        separator, separatorSpec,
                                        m_customers.getData());

            tempCustomersDesc.createTextFile();

            try {
                tempCustomersDesc.createTable(m_connection);
            } catch (Throwable t) {
                fail("checkSeparators: separator '" + separatorSpec
                     + "' doesn't work: " + t.toString());
            }

            executeStatement("SET TABLE \"" + tableName + "\" SOURCE OFF");
            executeStatement("DROP TABLE \"" + tableName + "\"");
        }
    }

    /**
     * verifies the content of a given table is as expected
     *  @param tableName
     *      the name of the table whose content is to check
     *  @param expectedValues
     *      the values expected in the table
     */
    private void verifyTableContent(String tableName,
                                    Object[][] expectedValues) {

        String selectStmt = "SELECT * FROM \"" + tableName + "\" ORDER BY ID";

        try {
            java.sql.ResultSet results = m_statement.executeQuery(selectStmt);
            int                row     = 0;

            while (results.next()) {
                row = results.getRow();

                Object[] expectedRowContent = expectedValues[row - 1];

                for (int col = 0; col < expectedRowContent.length; ++col) {
                    Object expectedValue = expectedRowContent[col];
                    Object foundValue    = results.getObject(col + 1);

                    assertEquals("table " + tableName + ", row " + row
                                 + ", column " + col + ":", expectedValue,
                                     foundValue);
                }
            }

            // finally ensure that there are not more rows in the table than expected
            assertEquals("table " + tableName + "'s row count: ",
                         expectedValues.length, row);
        } catch (junit.framework.AssertionFailedError e) {
            throw e;
        } catch (Throwable t) {
            fail("verifyTableContent(" + tableName + ") failed with "
                 + t.toString());
        }
    }

    /**
     * executes a given m_statement
     *
     *  <p>Basically, this method calls <code>m_statement.execute(sql)</code>,
     *  but wraps any <code>SQLException</code>s into a JUnit error.
     */
    private void executeStatement(String sql) {

        try {
            m_statement.execute(sql);
        } catch (SQLException ex) {
            fail(ex.toString());
        }
    }

    /**
     * verifies the initial content of the "products" text table, plus a simple insertion
     */
    private void verifyInitialContent() {
        verifyTableContent(m_products.getName(), m_products.getData());
        verifyTableContent(m_customers.getName(), m_customers.getData());
    }

    /**
     * does some very basic insertion tests
     */
    private void checkInsertions() {

        // check whether inserting a value succeeds
        executeStatement("INSERT INTO \"" + m_products.getName()
                         + "\" VALUES ( 3, 'Pears' )");
        verifyTableContent(m_products.getName(),
                           m_products.appendRowData(new Object[] {
            new Integer(3), "Pears"
        }));

        // check whether the PK constraint works
        try {
            m_statement.execute("INSERT INTO \"" + m_products.getName()
                                + "\" VALUES ( 1, 'Green Apples' )");
            fail("PKs do not work as expected.");
        } catch (SQLException e) {}
    }

    /**
     * verifies whether implicit and explicit dis/connections from/to the text table source work
     *  as expected
     */
    private void checkSourceConnection() {

        String sqlSetTable = "SET TABLE \"" + m_products.getName() + "\"";

        // preconditions for the following tests
        assertEquals(
            "internal error: retrieving the data source does not work properly at all.",
            m_products.getDataSourceSpec(),
            getDataSourceSpec(m_products.getName()));
        assertFalse("internal error: table should not be read-only, initially",
                    isReadOnly(m_products.getName()));

        // disconnect, see if the table behaves well afterwards
        executeStatement(sqlSetTable + " SOURCE OFF");
        assertEquals(
            "Disconnecting a text table should not reset the table source.",
            m_products.getDataSourceSpec(),
            getDataSourceSpec(m_products.getName()));
        assertTrue(
            "Disconnecting from the table source should put the table into read-only mode.",
            isReadOnly(m_products.getName()));

        try {
            java.sql.ResultSet tableContent =
                m_statement.executeQuery("SELECT * FROM \""
                                         + m_products.getName() + "\"");

            assertFalse("A disconnected table should be empty.",
                        tableContent.next());
        } catch (SQLException ex) {
            fail("Selecting from a disconnected table should return an empty result set.");
        }

        // reconnect, see if the table works as expected then
        executeStatement(sqlSetTable + " SOURCE ON");
        verifyTableContent(m_products.getName(), m_products.getData());

        // check whether dis-/reconnecting a readonly table preserves the readonly-ness
        executeStatement(sqlSetTable + " READONLY TRUE");
        assertTrue("Setting the table to read-only failed.",
                   isReadOnly(m_products.getName()));
        executeStatement(sqlSetTable + " SOURCE OFF");
        assertTrue("Still, a disconnected table should be read-only.",
                   isReadOnly(m_products.getName()));
        executeStatement(sqlSetTable + " SOURCE ON");
        assertTrue(
            "A reconnected readonly table should preserve its readonly-ness.",
            isReadOnly(m_products.getName()));
        executeStatement(sqlSetTable + " READONLY FALSE");
        assertFalse("Unable to reset the readonly-ness.",
                    isReadOnly(m_products.getName()));

        // check whether setting an invalid data source sets the table to readonly, by
        // preserving the data source
        try {

            // create a malformed file
            String fileName = "malformed.csv";
            PrintStream textFile = new PrintStream(
                FileUtil.getFileUtil().openOutputStreamElement(fileName));

            textFile.println("not a number;some text");
            textFile.close();
            new java.io.File(fileName).deleteOnExit();

            // try setting it as source
            String newDataSourceSpec = fileName + ";encoding=UTF-8;fs=\\semi";

            try {
                m_statement.execute(sqlSetTable + " SOURCE \""
                                    + newDataSourceSpec + "\"");
                fail("a malformed data source was accepted silently.");
            } catch (java.sql.SQLException es) {    /* that's expected here */
            }

            // new - a malformed data source assignment by user should not survive
            // and should revert to the existing one
            assertTrue(
                "A table with an invalid data source should fall back to original read-only.",
                !isReadOnly(m_products.getName()));
            assertEquals(
                "A data source which cannot be set should nonetheless be remembered.",
                m_products.getDataSourceSpec(),
                getDataSourceSpec(m_products.getName()));

            // the data source spec should even survive a shutdown
            executeStatement("SHUTDOWN");

            m_connection = newConnection();
            m_statement  = m_connection.createStatement();

            assertEquals("A data source should survive a database shutdown.",
                         m_products.getDataSourceSpec(),
                         getDataSourceSpec(m_products.getName()));
            assertTrue(
                "After shutdown and DB-reconnect, the table should keepe read-only attribute.",
                !isReadOnly(m_products.getName()));

            // reconnect after fixing the file
            FileUtil.getFileUtil().delete(fileName);

            textFile = new PrintStream(
                FileUtil.getFileUtil().openOutputStreamElement(fileName));

            textFile.println("1;some text");
            textFile.close();
            m_statement.execute(sqlSetTable + " SOURCE \"" + newDataSourceSpec
                                + "\"");
            assertFalse(
                "The file was fixed, reconnect was successful, so the table shouldn't be read-only.",
                isReadOnly(m_products.getName()));

            // finally re-create the proper version of the table for any further tests
            m_statement.execute(sqlSetTable + " SOURCE \""
                                + m_products.getDataSourceSpec() + "\"");
            verifyTableContent(m_products.getName(), m_products.getData());
        } catch (junit.framework.AssertionFailedError e) {
            throw e;
        } catch (Throwable t) {
            fail("checkSourceConnection: unable to check invalid data sources, error: "
                 + t.toString());
        }
    }

    /**
     * basic tests for text files
     */
    public void testTextFiles() {

        verifyInitialContent();
        checkInsertions();
        checkSeparators();
        checkSourceConnection();
    }

    public static void main(String[] argv) {
        runWithResult(TestTextTable.class, "testTextFiles");
    }
}

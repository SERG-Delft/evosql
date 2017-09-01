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

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import org.hsqldb.lib.ArraySort;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.FileUtil;
import org.hsqldb.lib.HsqlArrayList;
import org.hsqldb.lib.LineGroupReader;
import org.hsqldb.lib.StopWatch;
import org.hsqldb.lib.StringComparator;
import org.hsqldb.lib.StringUtil;

/**
 * Utility class providing methodes for submitting test statements or
 * scripts to the database, comparing the results returned with
 * the expected results. The test script format is compatible with existing
 * scripts.
 *
 * Script writers be aware that you can't use stderr to distinguish error
 * messages.  This class writes error messages to stdout.
 *
 * @author Ewan Slater (ewanslater@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 */
public class TestUtil {

    /*
     * The executing scripts do have state.  This class should be
     * redesigned with OOD.
     */
    static private final SimpleDateFormat sdfYMDHMS =
        new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    static private boolean      abortOnErr        = false;
    static final private String TIMESTAMP_VAR_STR = "${timestamp}";
    static final String LS = System.getProperty("line.separator", "\n");
    static final boolean        oneSessionOnly    = false;

    public static void main(String[] argv) {

        StopWatch sw = new StopWatch(true);

        TestUtil.testScripts("testrun/hsqldb", sw);
        System.out.println(sw.currentElapsedTimeToMessage("Total time :"));
    }

    public static void deleteDatabase(String path) {
        FileUtil.deleteOrRenameDatabaseFiles(path);
    }

    public static boolean delete(String file) {
        return new File(file).delete();
    }

    public static void checkDatabaseFilesDeleted(String path) {

        File[] list = FileUtil.getDatabaseFileList(path);

        if (list.length != 0) {
            System.out.println("database files not deleted");
        }
    }

    /**
     * Expand occurrences of "${timestamp}" in input to time stamps.
     */
    static protected void expandStamps(StringBuffer sb) {

        int i = sb.indexOf(TIMESTAMP_VAR_STR);

        if (i < 1) {
            return;
        }

        String timestamp;

        synchronized (sdfYMDHMS) {
            timestamp = sdfYMDHMS.format(new java.util.Date());
        }

        while (i > -1) {
            sb.replace(i, i + TIMESTAMP_VAR_STR.length(), timestamp);

            i = sb.indexOf(TIMESTAMP_VAR_STR);
        }
    }

    static void testScripts(String directory, StopWatch sw) {

        TestUtil.deleteDatabase("test1");

        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver");

            String     url = "jdbc:hsqldb:test1;sql.enforce_strict_size=true";
            String     user        = "sa";
            String     password    = "";
            Connection cConnection = null;
            String[]   filelist;
            String     absolute = new File(directory).getAbsolutePath();

            filelist = new File(absolute).list();

            ArraySort.sort((Object[]) filelist, 0, filelist.length,
                           new StringComparator());

            for (int i = 0; i < filelist.length; i++) {
                String fname = filelist[i];

                if (fname.startsWith("TestSelf") && fname.endsWith(".txt")) {
                    long elapsed = sw.elapsedTime();

                    if (!oneSessionOnly || cConnection == null) {
                        cConnection = DriverManager.getConnection(url, user,
                                password);
                    }

                    print("Opened DB in "
                          + (double) (sw.elapsedTime() - elapsed) / 1000
                          + " s");
                    testScript(cConnection, absolute + File.separator + fname);

                    if (!oneSessionOnly) {
                        cConnection.close();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            print("TestUtil init error: " + e.toString());
        }
    }

    static void testScript(Connection aConnection, String aPath) {

        /*
         * This is a legacy wrapper method which purposefully inherits the sins
         * of the original.
         * No indication is given to the invoker of even RuntimeExceptions.
         */
        File file = new File(aPath);

        try {
            TestUtil.testScript(aConnection, file.getAbsolutePath(),
                                new FileReader(file));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("test script file error: " + e.toString());
        }
    }

    /**
     * Runs a preformatted script.<p>
     *
     * Where a result set is required, each line in the script will
     * be interpreted as a seperate expected row in the ResultSet
     * returned by the query.  Within each row, fields should be delimited
     * using either comma (the default), or a user defined delimiter
     * which should be specified in the System property TestUtilFieldDelimiter
     * @param aConnection Connection object for the database
     * @param sourceName Identifies the script which failed
     * @param inReader Source of commands to be tested
     */
    public static void testScript(Connection aConnection, String sourceName,
                                  Reader inReader)
                                  throws SQLException, IOException {

        Statement        statement = aConnection.createStatement();
        LineNumberReader reader    = new LineNumberReader(inReader);
        LineGroupReader  sqlReader = new LineGroupReader(reader);
        int              startLine = 0;

        System.out.println("Opened test script file: " + sourceName);

        /**
         * we read the lines from the start of one section of the script "/*"
         *  until the start of the next section, collecting the lines in the
         *  list.
         *  When a new section starts, we pass the list of lines
         *  to the test method to be processed.
         */
        try {
            while (true) {
                HsqlArrayList section = sqlReader.getSection();

                startLine = sqlReader.getStartLineNumber();

                if (section.size() == 0) {
                    break;
                }

                testSection(statement, section, sourceName, startLine);
            }

            statement.close();

            // The following catch blocks are just to report the source location
            // of the failure.
        } catch (SQLException se) {
            System.out.println("Error encountered at command beginning at "
                               + sourceName + ':' + startLine);

            throw se;
        } catch (RuntimeException re) {
            System.out.println("Error encountered at command beginning at "
                               + sourceName + ':' + startLine);

            throw re;
        }

        System.out.println("Processed " + reader.getLineNumber()
                           + " lines from " + sourceName);
    }

    /** Legacy wrapper */
    static void test(Statement stat, String s, int line) {
        TestUtil.test(stat, s, null, line);
    }

    /**
     * Performs a preformatted statement or group of statements and throws
     *  if the result does not match the expected one.
     * @param line start line in the script file for this test
     * @param stat Statement object used to access the database
     * @param sourceName Identifies the script which failed
     * @param s Contains the type, expected result and SQL for the test
     */
    static void test(Statement stat, String s, String sourceName, int line) {

        //maintain the interface for this method
        HsqlArrayList section = new HsqlArrayList(new String[8], 0);

        section.add(s);
        testSection(stat, section, sourceName, line);
    }

    /**
     * Method to save typing ;-)
     * This method does not distinguish between normal and error output.
     *
     * @param s String to be printed
     */
    static void print(String s) {
        System.out.println(s);
    }

    /**
     * Takes a discrete section of the test script, contained in the
     * section vector, splits this into the expected result(s) and
     * submits the statement to the database, comparing the results
     * returned with the expected results.
     * If the actual result differs from that expected, or an
     * exception is thrown, then the appropriate message is printed.
     * @param stat Statement object used to access the database
     * @param section Vector of script lines containing a discrete
     * section of script (i.e. test type, expected results,
     * SQL for the statement).
     * @param line line of the script file where this section started
     */
    private static void testSection(Statement stat, HsqlArrayList section,
                                    String scriptName, int line) {

        //create an appropriate instance of ParsedSection
        ParsedSection pSection = parsedSectionFactory(section);

        if (pSection == null) {    //it was not possible to sucessfully parse the section
            System.out.println(
                "The section starting at " + scriptName + ':' + line
                + " could not be parsed, and so was not processed." + LS);

            return;
        }

        if (pSection instanceof IgnoreParsedSection) {
            System.out.println("At " + scriptName + ':' + line + ": "
                               + pSection.getResultString());

            return;
        }

        if (pSection instanceof DisplaySection
                || pSection instanceof WaitSection
                || pSection instanceof ProceedSection) {
            String s = pSection.getResultString();

            if (s != null) {

                // May or may not want to report line number for these sections?
                System.out.println(pSection.getResultString());
            }
        }

        if (pSection instanceof DisplaySection) {
            return;    // Do not run test method for DisplaySections.
        }

        if (!pSection.test(stat)) {
            System.out.println("Section starting at " + scriptName + ':'
                               + line + " returned an unexpected result: "
                               + pSection.getTestResultString());

            if (TestUtil.abortOnErr) {
                throw new TestRuntimeException(scriptName + ": " + line
                                               + "pSection");
            }
        }
    }

    /**
     * Factory method to create appropriate parsed section class for the section
     * @param aSection Vector containing the section of script
     * @return a ParesedSection object
     */
    private static ParsedSection parsedSectionFactory(
            HsqlArrayList sectionLines) {

        //type of the section
        char type = ' ';

        //read the first line of the Vector...
        String topLine = (String) sectionLines.get(0);

        //...and check it for the type...
        if (topLine.startsWith("/*")) {
            type = topLine.charAt(2);

            //if the type code is UPPERCASE and system property IgnoreCodeCase
            //has been set to true, make the type code lowercase
            if ((Character.isUpperCase(type))
                    && (Boolean.getBoolean("IgnoreCodeCase"))) {
                type = Character.toLowerCase(type);
            }

            //if the type code is invalid return null
            if (!ParsedSection.isValidCode(type)) {
                return null;
            }
        }

        //then pass this to the constructor for the ParsedSection class that
        //corresponds to the value of type
        switch (type) {

            case 'u' : {
                ParsedSection section = new UpdateParsedSection(sectionLines);

                if (TestUtil.oneSessionOnly) {
                    if (section.getSql().toUpperCase().contains("SHUTDOWN")) {
                        section = new IgnoreParsedSection(sectionLines, type);
                    }
                }

                return section;
            }
            case 's' :
                return new SilentParsedSection(sectionLines);

            case 'w' :
                return new WaitSection(sectionLines);

            case 'p' :
                return new ProceedSection(sectionLines);

            case 'r' :
                return new ResultSetParsedSection(sectionLines);

            case 'o' :
                return new ResultSetOutputParsedSection(sectionLines);

            case 'c' :
                return new CountParsedSection(sectionLines);

            case 'd' :
                return new DisplaySection(sectionLines);

            case 'e' :
                return new ExceptionParsedSection(sectionLines);

            case ' ' : {
                ParsedSection section = new BlankParsedSection(sectionLines);

                if (TestUtil.oneSessionOnly) {
                    if (section.getSql().toUpperCase().contains("SHUTDOWN")) {
                        section = new IgnoreParsedSection(sectionLines, type);
                    }
                }

                return section;
            }
            default :

                //if we arrive here, then we should have a valid code,
                //since we validated it earlier, so return an
                //IgnoreParsedSection object
                return new IgnoreParsedSection(sectionLines, type);
        }
    }

    /**
     * This method should certainly be an instance method.
     *
     * Can't do that until make this entire class OO.
     */
    public static void setAbortOnErr(boolean aoe) {
        abortOnErr = aoe;
    }

    static class TestRuntimeException extends RuntimeException {

        public TestRuntimeException(String s) {
            super(s);
        }

        public TestRuntimeException(Throwable t) {
            super(t);
        }

        public TestRuntimeException(String s, Throwable t) {
            super(s, t);
        }
    }
}

/**
 * Abstract inner class representing a parsed section of script.
 * The specific ParsedSections for each type of test should inherit from this.
 */
abstract class ParsedSection {

    static final String LS = System.getProperty("line.separator", "\n");

    /**
     * Type of this test.
     * @see #isValidCode(char) for allowed values
     */
    protected char type = ' ';

    /** error message for this section */
    String message = null;

    /** contents of the section as an array of Strings, one for each line in the section. */
    protected String[] lines = null;

    /** number of the last row containing results in sectionLines */
    protected int resEndRow = 0;

    /** SQL query to be submitted to the database. */
    protected String sqlString = null;

    /**
     * Constructor when the section's input lines do not need to be parsed
     * into SQL.
     */
    protected ParsedSection() {}

    /**
     * Common constructor functions for this family.
     * @param linesArray Array of the script lines containing the section of script.
     * database
     */
    protected ParsedSection(HsqlArrayList linesArray) {

        //read the lines array backwards to get out the SQL String
        //using a StringBuffer for efficency until we've got the whole String
        StringBuffer sqlBuff  = new StringBuffer();
        int          endIndex = 0;
        int          k;
        String       s = (String) linesArray.get(0);

        if (s.startsWith("/*")) {

            //if, after stripping out the declaration from topLine, the length of topLine
            //is greater than 0, then keep the rest of the line, as the first row.
            //Otherwise it will be discarded, and the offset (between the array and the vector)
            //set to 1.
            if (s.length() == 3) {
                lines = (String[]) linesArray.toArray(1, linesArray.size());
            } else {
                lines    = (String[]) linesArray.toArray();
                lines[0] = lines[0].substring(3);
            }

            k = lines.length - 1;

            do {

                //check to see if the row contains the end of the result set
                if ((endIndex = lines[k].indexOf("*/")) != -1) {

                    //then this is the end of the result set
                    sqlBuff.insert(0, lines[k].substring(endIndex + 2));

                    lines[k] = lines[k].substring(0, endIndex);

                    if (lines[k].length() == 0) {
                        resEndRow = k - 1;
                    } else {
                        resEndRow = k;
                    }

                    break;
                } else {
                    sqlBuff.insert(0, lines[k]);
                }

                k--;
            } while (k >= 0);
        } else {
            lines = (String[]) linesArray.toArray();

            for (k = 0; k < lines.length; k++) {
                sqlBuff.append(lines[k]);
                sqlBuff.append(LS);
            }
        }

        //set sqlString value
        sqlString = sqlBuff.toString();
    }

    /**
     * String representation of this ParsedSection
     * @return String representation of this ParsedSection
     */
    protected String getTestResultString() {

        StringBuffer b = new StringBuffer();

        b.append(LS + "******" + LS);
        b.append("Type: ");
        b.append(getType()).append(LS);
        b.append("SQL: ").append(getSql()).append(LS);
        b.append("expected results:").append(LS);
        b.append(getResultString()).append(LS);

        //check to see if the message field has been populated
        if (getMessage() != null) {
            b.append(LS + "message:").append(LS);
            b.append(getMessage()).append(LS);
        }

        b.append("actual results:").append(LS);
        b.append(getActualResultString());
        b.append(LS + "******" + LS);

        return b.toString();
    }

    /**
     * returns a String representation of the expected result for the test
     * @return The expected result(s) for the test
     */
    protected abstract String getResultString();

    /**
     * returns a String representation of the actual result for the test
     * @return The expected result(s) for the test
     */
    protected String getActualResultString() {
        return "";
    }

    /**
     *  returns the error message for the section
     *
     * @return message
     */
    protected String getMessage() {
        return message;
    }

    /**
     * returns the type of this section
     * @return type of this section
     */
    protected char getType() {
        return type;
    }

    /**
     * returns the SQL statement for this section
     * @return SQL statement for this section
     */
    protected String getSql() {
        return sqlString;
    }

    /**
     * performs the test contained in the section against the database.
     * @param aStatement Statement object
     * @return true if the result(s) are as expected, otherwise false
     */
    protected boolean test(Statement aStatement) {

        try {
            String sql = getSql();

            aStatement.execute(sql);
        } catch (Exception x) {
            message = x.toString();

            return false;
        }

        return true;
    }

    /**
     * Checks that the type code letter is valid
     * @param aCode Lower-cased type code to validate.
     * @return true if the type code is valid, otherwise false.
     */
    protected static boolean isValidCode(char aCode) {

        /* Allowed values for test codes are:
         * (note that UPPERCASE codes, while valid are only processed if the
         * system property IgnoreCodeCase has been set to true)
         *
         * 'u' - update
         * 'c' - count
         * 'e' - exception
         * 'r' - results
         * 'w' - wait
         * 'p' - proceed
         * 's' - silent
         * 'd' - display   (No reason to use upper-case).
         * ' ' - not a test
         */
        switch (aCode) {

            case ' ' :
            case 'r' :
            case 'o' :
            case 'e' :
            case 'c' :
            case 'u' :
            case 's' :
            case 'd' :
            case 'w' :
            case 'p' :
                return true;
        }

        return false;
    }
}

/** Represents a ParsedSection for a ResultSet test */
class ResultSetParsedSection extends ParsedSection {

    private String   delim = System.getProperty("TestUtilFieldDelimiter", ",");
    private String[] expectedRows = null;
    private String[] actualRows   = null;

    /**
     * constructs a new instance of ResultSetParsedSection, interpreting
     * the supplied results as one or more lines of delimited field values
     */
    protected ResultSetParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        type = 'r';

        //now we'll populate the expectedResults array
        expectedRows = new String[(resEndRow + 1)];

        for (int i = 0; i <= resEndRow; i++) {
            int skip = StringUtil.skipSpaces(lines[i], 0);

            expectedRows[i] = lines[i].substring(skip);
        }
    }

    protected String getResultString() {

        StringBuffer printVal     = new StringBuffer();
        String[]     expectedRows = getExpectedRows();

        for (int i = 0; i < expectedRows.length; i++) {
            printVal.append(expectedRows[i]).append(LS);
        }

        return printVal.toString();
    }

    protected String getActualResultString() {

        StringBuffer printVal   = new StringBuffer();
        String[]     actualRows = getActualRows();

        if (actualRows == null) {
            return "no result";
        }

        for (int i = 0; i < actualRows.length; i++) {
            printVal.append(actualRows[i]).append(LS);
        }

        return printVal.toString();
    }

    protected boolean test(Statement aStatement) {

        try {
            try {

                //execute the SQL
                aStatement.execute(getSql());
            } catch (SQLException s) {
                throw new Exception("Expected a ResultSet, but got the error: "
                                    + s.getMessage());
            }

            //check that update count != -1
            if (aStatement.getUpdateCount() != -1) {
                throw new Exception(
                    "Expected a ResultSet, but got an update count of "
                    + aStatement.getUpdateCount());
            }

            //iterate over the ResultSet
            HsqlArrayList list     = new HsqlArrayList(new String[1][], 0);
            ResultSet     results  = aStatement.getResultSet();
            int           colCount = results.getMetaData().getColumnCount();

            while (results.next()) {
                String[] row = new String[colCount];

                for (int i = 0; i < colCount; i++) {
                    row[i] = results.getString(i + 1);
                }

                list.add(row);
            }

            results.close();

            actualRows = new String[list.size()];

            for (int i = 0; i < list.size(); i++) {
                String[]     row = (String[]) list.get(i);
                StringBuffer sb  = new StringBuffer();

                for (int j = 0; j < row.length; j++) {
                    if (j > 0) {
                        sb.append(',');
                    }

                    sb.append(row[j]);
                }

                actualRows[i] = sb.toString();
            }

            String[] expectedRows = getExpectedRows();
            int      count        = 0;

            for (; count < list.size(); count++) {
                if (count < expectedRows.length) {
                    String[] expectedFields =
                        StringUtil.split(expectedRows[count], delim);

                    // handle ARRAY[val,val, val] commas
                    for (int i = 0; i < expectedFields.length; i++) {
                        if (expectedFields[i] == null) {
                            expectedFields = (String[]) ArrayUtil.resizeArray(
                                expectedFields, i);

                            break;
                        }

                        if (expectedFields[i].startsWith("ARRAY[")) {
                            if (expectedFields[i].endsWith("]")) {
                                continue;
                            }

                            for (int j = i + 1; j < expectedFields.length;
                                    j++) {
                                String part = expectedFields[j];

                                expectedFields[i] += delim + part;

                                if (part.endsWith("]")) {
                                    ArrayUtil.adjustArray(
                                        ArrayUtil.CLASS_CODE_OBJECT,
                                        expectedFields, expectedFields.length,
                                        i + 1, i - j);

                                    break;
                                }
                            }
                        }
                    }

                    //check that we have the number of columns expected...
                    if (colCount == expectedFields.length) {

                        //...and if so, check that the column values are as expected...
                        int j = 0;

                        for (int i = 0; i < expectedFields.length; i++) {
                            j = i + 1;

                            String actual = ((String[]) list.get(count))[i];

                            //...including null values...
                            if (actual == null) {    //..then we have a null

                                //...check to see if we were expecting it...
                                if (!expectedFields[i].equalsIgnoreCase(
                                        "NULL")) {
                                    message = "Expected row " + (count + 1)
                                              + " of the ResultSet to contain:"
                                              + LS + expectedRows[count] + LS
                                              + "but field " + j
                                              + " contained NULL";

                                    break;
                                }
                            } else if (!actual.equals(expectedFields[i])) {

                                //then the results are different
                                message = "Expected row " + (count + 1)
                                          + " of the ResultSet to contain:"
                                          + LS + expectedRows[count] + LS
                                          + "but field " + j + " contained "
                                          + actual;

                                break;
                            }
                        }
                    } else {

                        //we have the wrong number of columns
                        message = "Expected the ResultSet to contain "
                                  + expectedFields.length
                                  + " fields, but it contained " + colCount
                                  + " fields.";
                    }
                }

                if (message != null) {
                    break;
                }
            }

            //check that we got as many rows as expected
            if (count != expectedRows.length) {
                if (message == null) {

                    //we don't have the expected number of rows
                    message = "Expected the ResultSet to contain "
                              + expectedRows.length
                              + " rows, but it contained " + count + " rows.";
                }
            }
        } catch (Exception x) {
            message = x.toString();

            return false;
        }

        return message == null;
    }

    private String[] getExpectedRows() {
        return expectedRows;
    }

    private String[] getActualRows() {
        return actualRows;
    }
}

/** Represents a ParsedSection for a ResultSet dump */
class ResultSetOutputParsedSection extends ParsedSection {

    private String   delim = System.getProperty("TestUtilFieldDelimiter", ",");
    private String[] expectedRows = null;

    /**
     * constructs a new instance of ResultSetParsedSection, interpreting
     * the supplied results as one or more lines of delimited field values
     */
    protected ResultSetOutputParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        type = 'o';
    }

    protected String getResultString() {
        return "";
    }

    protected boolean test(Statement aStatement) {

        try {
            try {

                //execute the SQL
                aStatement.execute(getSql());
            } catch (SQLException s) {
                throw new Exception("Expected a ResultSet, but got the error: "
                                    + s.getMessage());
            }

            //check that update count != -1
            if (aStatement.getUpdateCount() != -1) {
                throw new Exception(
                    "Expected a ResultSet, but got an update count of "
                    + aStatement.getUpdateCount());
            }

            //iterate over the ResultSet
            ResultSet    results  = aStatement.getResultSet();
            StringBuffer printVal = new StringBuffer();

            while (results.next()) {
                for (int j = 0; j < results.getMetaData().getColumnCount();
                        j++) {
                    if (j != 0) {
                        printVal.append(',');
                    }

                    printVal.append(results.getString(j + 1));
                }

                printVal.append(LS);
            }

            throw new Exception(printVal.toString());
        } catch (Exception x) {
            message = x.toString();

            return false;
        }
    }

    private String[] getExpectedRows() {
        return expectedRows;
    }
}

/** Represents a ParsedSection for an update test */
class UpdateParsedSection extends ParsedSection {

    //expected update count
    int countWeWant;

    protected UpdateParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        type        = 'u';
        countWeWant = Integer.parseInt(lines[0]);
    }

    protected String getResultString() {
        return Integer.toString(getCountWeWant());
    }

    private int getCountWeWant() {
        return countWeWant;
    }

    protected boolean test(Statement aStatement) {

        try {
            try {

                //execute the SQL
                aStatement.execute(getSql());
            } catch (SQLException s) {
                throw new Exception("Expected an update count of "
                                    + getCountWeWant()
                                    + ", but got the error: "
                                    + s.getMessage());
            }

            if (aStatement.getUpdateCount() != getCountWeWant()) {
                throw new Exception("Expected an update count of "
                                    + getCountWeWant()
                                    + ", but got an update count of "
                                    + aStatement.getUpdateCount() + ".");
            }
        } catch (Exception x) {
            message = x.toString();

            return false;
        }

        return true;
    }
}

class WaitSection extends ParsedSection {

    /* Would love to have a setting to say whether multi-thread mode,
     * but the static design of TestUtil prevents that.
     * a W command will cause a non-threaded execution to wait forever.
     */
    static private String W_SYNTAX_MSG =
        "Syntax of Wait commands:" + LS
        + "    /*w 123*/     To Wait 123 milliseconds" + LS
        + "    /*w false x*/ Wait until /*p*/ command in another script has executed"
        + LS
        + "    /*w true x*/  Same, but the /*p*/ must not have executed yet";

/** Represents a ParsedSection for wait execution */
    long    sleepTime       = -1;
    Waiter  waiter          = null;
    boolean enforceSequence = false;

    protected WaitSection(HsqlArrayList linesArray) {

        /* Can't user the super constructor, since it does funny things when
         * constructing the SQL Buffer, which we don't need. */
        lines = (String[]) linesArray.toArray();

        int    closeCmd = lines[0].indexOf("*/");
        String cmd      = lines[0].substring(0, closeCmd);

        lines[0] = lines[0].substring(closeCmd + 2).trim();

        String trimmed = cmd.trim();

        if (trimmed.indexOf('e') < 0 && trimmed.indexOf('E') < 0) {

            // Does not contain "true" or "false"
            sleepTime = Long.parseLong(trimmed);
        } else {
            try {

                // Would like to use String.split(), but don't know if Java 4
                // is allowed here.
                // Until we can use Java 4, prohibit tabs as white space.
                int index = trimmed.indexOf(' ');

                if (index < 0) {
                    throw new IllegalArgumentException();
                }

                enforceSequence = Boolean.valueOf(trimmed.substring(0,
                        index)).booleanValue();
                waiter = Waiter.getWaiter(trimmed.substring(index).trim());
            } catch (IllegalArgumentException ie) {
                throw new IllegalArgumentException(W_SYNTAX_MSG);
            }
        }

        type = 'w';
    }

    protected String getResultString() {

        StringBuffer sb = new StringBuffer();

        if (lines.length == 1 && lines[0].trim().length() < 1) {
            return null;
        }

        for (int i = 0; i < lines.length; i++) {
            if (i > 0) {
                sb.append(LS);
            }

            sb.append("+ " + lines[i]);
        }

        TestUtil.expandStamps(sb);

        return sb.toString().trim();
    }

    protected boolean test(Statement aStatement) {

        if (waiter == null) {
            try {

                //System.err.println("Sleeping for " + sleepTime + " ms.");
                Thread.sleep(sleepTime);
            } catch (InterruptedException ie) {
                throw new RuntimeException("Test sleep interrupted", ie);
            }
        } else {
            waiter.waitFor(enforceSequence);
        }

        return true;
    }
}

class ProceedSection extends ParsedSection {

    /* See comment above for WaitSection */
    static private String P_SYNTAX_MSG =
        "Syntax of Proceed commands:" + LS
        + "    /*p false x*/ /*p*/ command in another script may Proceed" + LS
        + "    /*p true x*/  Same, but the /*w*/ must be waiting when we execute /*p*/"
    ;

/** Represents a ParsedSection for wait execution */
    Waiter  waiter          = null;
    boolean enforceSequence = false;

    protected ProceedSection(HsqlArrayList linesArray) {

        /* Can't use the super constructor, since it does funny things when
         * constructing the SQL Buffer, which we don't need. */
        lines = (String[]) linesArray.toArray();

        int    closeCmd = lines[0].indexOf("*/");
        String cmd      = lines[0].substring(0, closeCmd);

        lines[0] = lines[0].substring(closeCmd + 2).trim();

        String trimmed = cmd.trim();

        try {

            // Would like to use String.split(), but don't know if Java 4
            // is allowed here.
            // Until we can use Java 4, prohibit tabs as white space.
            int index = trimmed.indexOf(' ');

            if (index < 0) {
                throw new IllegalArgumentException();
            }

            enforceSequence = Boolean.valueOf(trimmed.substring(0,
                    index)).booleanValue();
            waiter = Waiter.getWaiter(trimmed.substring(index).trim());
        } catch (IllegalArgumentException ie) {
            throw new IllegalArgumentException(P_SYNTAX_MSG);
        }

        type = 'p';
    }

    protected String getResultString() {

        StringBuffer sb = new StringBuffer();

        if (lines.length == 1 && lines[0].trim().length() < 1) {
            return "";
        }

        for (int i = 0; i < lines.length; i++) {
            if (i > 0) {
                sb.append(LS);
            }

            sb.append("+ " + lines[i]);
        }

        TestUtil.expandStamps(sb);

        return sb.toString().trim();
    }

    protected boolean test(Statement aStatement) {

        waiter.resume(enforceSequence);

        return true;
    }
}

/** Represents a ParsedSection for silent execution */
class SilentParsedSection extends ParsedSection {

    protected SilentParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        type = 's';
    }

    protected String getResultString() {
        return "";
    }

    protected boolean test(Statement aStatement) {

        try {
            aStatement.execute(getSql());
        } catch (Exception x) {}

        return true;
    }
}

/** Represents a ParsedSection for a count test */
class CountParsedSection extends ParsedSection {

    //expected row count
    private int countWeWant;

    protected CountParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        type        = 'c';
        countWeWant = Integer.parseInt(lines[0]);
    }

    protected String getResultString() {
        return Integer.toString(getCountWeWant());
    }

    private int getCountWeWant() {
        return countWeWant;
    }

    protected boolean test(Statement aStatement) {

        try {

            //execute the SQL
            try {
                aStatement.execute(getSql());
            } catch (SQLException s) {
                throw new Exception("Expected a ResultSet containing "
                                    + getCountWeWant()
                                    + " rows, but got the error: "
                                    + s.getMessage());
            }

            //check that update count != -1
            if (aStatement.getUpdateCount() != -1) {
                throw new Exception(
                    "Expected a ResultSet, but got an update count of "
                    + aStatement.getUpdateCount());
            }

            //iterate over the ResultSet
            ResultSet results = aStatement.getResultSet();
            int       count   = 0;

            while (results.next()) {
                count++;
            }

            //check that we got as many rows as expected
            if (count != getCountWeWant()) {

                //we don't have the expected number of rows
                throw new Exception("Expected the ResultSet to contain "
                                    + getCountWeWant()
                                    + " rows, but it contained " + count
                                    + " rows.");
            }
        } catch (Exception x) {
            message = x.toString();

            return false;
        }

        return true;
    }
}

/** Represents a ParsedSection for an Exception test */
class ExceptionParsedSection extends ParsedSection {

    private String    expectedState = null;
    private Throwable caught        = null;

    protected ExceptionParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        expectedState = lines[0].trim();

        if (expectedState.length() < 1) {
            expectedState = null;
        }

        type = 'e';
    }

    protected String getResultString() {
        return (caught == null) ? "Nothing thrown"
                                : caught.toString();
    }

    protected boolean test(Statement aStatement) {

        try {
            aStatement.execute(getSql());
        } catch (SQLException sqlX) {
            caught = sqlX;

            if (expectedState == null
                    || expectedState.equalsIgnoreCase(sqlX.getSQLState())) {
                return true;
            }

            message = "SQLState '" + sqlX.getSQLState() + "' : "
                      + sqlX.toString() + " instead of '" + expectedState
                      + "'";
        } catch (Exception x) {
            caught  = x;
            message = x.toString();
        }

        return false;
    }
}

/** Represents a ParsedSection for a section with blank type */
class BlankParsedSection extends ParsedSection {

    protected BlankParsedSection(HsqlArrayList linesArray) {

        super(linesArray);

        type = ' ';
    }

    protected String getResultString() {
        return "";
    }
}

/** Represents a ParsedSection that is to be ignored */
class IgnoreParsedSection extends ParsedSection {

    protected IgnoreParsedSection(HsqlArrayList sectionLines, char aType) {

        /* Extremely ambiguous to use input parameter of same exact
         * variable name as the superclass member "lines".
         * Therefore, renaming to inLines. */

        // Inefficient to parse this into SQL when we aren't going to use
        // it as SQL.  Should probably just be removed to use the
        // super() constructor.
        super(sectionLines);

        type = aType;
    }

    protected String getResultString() {
        return "This section, of type '" + getType() + "' was ignored";
    }
}

/** Represents a Section to be Displayed, not executed */
class DisplaySection extends ParsedSection {

    protected DisplaySection(HsqlArrayList sectionLines) {

        /* Can't user the super constructor, since it does funny things when
         * constructing the SQL Buffer, which we don't need. */
        lines = (String[]) sectionLines.toArray();

        int firstSlash = lines[0].indexOf('/');

        lines[0] = lines[0].substring(firstSlash + 1).trim();
    }

    protected String getResultString() {

        StringBuffer sb = new StringBuffer();

        if (lines.length == 1 && lines[0].trim().length() < 1) {
            return null;
        }

        for (int i = 0; i < lines.length; i++) {
            if (i > 0) {
                sb.append(LS);
            }

            sb.append("+ " + lines[i]);
        }

        TestUtil.expandStamps(sb);

        return sb.toString().trim();
    }
}

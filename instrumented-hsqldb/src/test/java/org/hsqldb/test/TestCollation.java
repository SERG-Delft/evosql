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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;

import org.hsqldb.lib.HashSet;
import org.hsqldb.lib.Iterator;
import org.hsqldb.lib.Set;
import org.hsqldb.types.Collation;

/**
 * Test HSQLDBs collation capabilities
 * @author frank.schoenheit@sun.com
 */
public class TestCollation extends TestBase {

    Statement  statement;
    Connection connection;
    Iterator   collIterator;
    Iterator   localeIterator;

    /** Creates a new instance of TestCollation */
    public TestCollation(String name) {

        super(name, "jdbc:hsqldb:file:test", false, false);

        super.isNetwork = false;
    }

    protected void setUp() throws Exception {

        super.setUp();

        connection     = super.newConnection();
        statement      = connection.createStatement();
        collIterator   = Collation.getCollationsIterator();
        localeIterator = Collation.getLocalesIterator();
    }

    protected void tearDown() {

        try {
            statement = connection.createStatement();

            statement.execute("SHUTDOWN");
        } catch (Exception e) {}

        super.tearDown();
    }

    /**
     * checks whether expected locales are present and selectable
     */
    public void testVerifyAvailability() {

        // let's check whether unknown collation identifiers are rejected
        try {
            statement.execute(
                getSetCollationStmt(
                    "ThisIsDefinitlyNoValidCollationIdentifier"));
            fail("database did not reject invalid collation name");
        } catch (SQLException e) {}

        // let's check whether the DB accepts all known collations
        int count = 0;

        while (collIterator.hasNext()) {
            String collationName = (String) collIterator.next();

            try {
                statement.execute(getSetCollationStmt(collationName));
            } catch (SQLException e) {
                fail("could not set collation '" + collationName
                     + "'\n  exception message: " + e.getMessage());
            }

            ++count;
        }

        System.out.println("checked " + count
                           + " collations for availability.");

        // even if the above worked, we cannot be sure that all locales are really supported.
        // The fact that SET DATABASE COLLATION succeeeded only means that a Collator could
        // be instantiated with a Locale matching the given collation name. But what if
        // Locale.Instance(...) lied, and returned a fallback Locale instance?
        //
        // Hmm, looking at the documentation of Locale.getAvailableLocales, I'm not sure
        // whether it is really feasible. The doc states "returns a list of all installed Locales".
        // The "installed" puzzles me - maybe this is really different per installation, and not only
        // per JDK version?
        Locale[] availableLocales = Locale.getAvailableLocales();
        Set      existenceCheck   = new HashSet();

        for (int i = 0; i < availableLocales.length; ++i) {
            String availaleName = availableLocales[i].getLanguage();

            if (availableLocales[i].getCountry().length() > 0) {
                availaleName += "-" + availableLocales[i].getCountry();
            }

            existenceCheck.add(availaleName);
        }

        String notInstalled = "";
        int    expected     = 0,
               failed       = 0;

        while (localeIterator.hasNext()) {
            String localeName = (String) localeIterator.next();

            ++expected;

            if (!existenceCheck.contains(localeName)) {
                if (notInstalled.length() > 0) {
                    notInstalled += "; ";
                }

                notInstalled += localeName;

                ++failed;
            }
        }

        if (notInstalled.length() > 0) {
            fail("the following locales are not installed:\n  " + notInstalled
                 + "\n  (" + failed + " out of " + expected + ")");
        }
    }

    /**
     * checks whether sorting via a given collation works as expected
     */
    public void testVerifyCollation() {

        String failedCollations = "";
        String failMessage      = "";

        while (collIterator.hasNext()) {
            String collationName = (String) collIterator.next();
            String message       = checkSorting(collationName);

            if (message.length() > 0) {
                if (failedCollations.length() > 0) {
                    failedCollations += ", ";
                }

                failedCollations += collationName;
                failMessage      += message;
            }
        }

        if (failedCollations.length() > 0) {
            fail("test failed for following collations:\n" + failedCollations
                 + "\n" + failMessage);
        }
    }

    /**
     * returns an SQL statement to set the database collation
     */
    protected final String getSetCollationStmt(String collationName) {

        final String setCollationStmtPre  = "SET DATABASE COLLATION \"";
        final String setCollationStmtPost = "\"";

        return setCollationStmtPre + collationName + setCollationStmtPost;
    }

    /**
     * checks sorting a table with according to a given collation
     */
    protected String checkSorting(String collationName) {

        String stmt1 = "DROP TABLE WORDLIST IF EXISTS;";
        String stmt2 =
            "CREATE TEXT TABLE WORDLIST ( ID INTEGER, WORD VARCHAR(50) );";
        String stmt3 = "SET TABLE WORDLIST SOURCE \"" + collationName
                       + ".csv;encoding=UTF-8\"";
        String selectStmt    = "SELECT ID, WORD FROM WORDLIST ORDER BY WORD";
        String returnMessage = "";

        try {

            // set database collation
            statement.execute(getSetCollationStmt(collationName));
            statement.execute(stmt1);
            statement.execute(stmt2);
            statement.execute(stmt3);

            ResultSet results = statement.executeQuery(selectStmt);

            while (results.next()) {
                int expectedPosition = results.getInt(1);
                int foundPosition    = results.getRow();

                if (expectedPosition != foundPosition) {
                    String word = results.getString(2);

                    return "testing collation '" + collationName
                           + "' failed\n" + "  word              : " + word
                           + "\n" + "  expected position : "
                           + expectedPosition + "\n"
                           + "  found position    : " + foundPosition + "\n";
                }
            }
        } catch (SQLException e) {
            return "testing collation '" + collationName
                   + "' failed\n  exception message: " + e.getMessage() + "\n";
        }

        return "";
    }

    public static void main(String[] argv) {
        runWithResult(TestCollation.class, "testVerifyAvailability");
        runWithResult(TestCollation.class, "testVerifyCollation");
    }
}

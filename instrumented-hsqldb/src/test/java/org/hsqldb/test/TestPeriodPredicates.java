/* Copyright (c) 2001-2016, The HSQL Development Group
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

import org.hsqldb.Scanner;
import org.hsqldb.Session;
import org.hsqldb.jdbc.JDBCConnection;
import org.hsqldb.types.DateTimeType;
import org.hsqldb.types.IntervalType;
import org.hsqldb.types.Type;
import org.hsqldb.types.Types;

import junit.framework.Assert;

/**
 * Tests the period predicates implementation of the {@link DateTimeType} class.
 * <p>
 * TODO: Add tests with intervals, other date types/time and time zone.
 *
 * @author Pascal-Eric Servais (peservais@users dot sourceforge.net)
 * @version 2.3.4
 * @since 2.3.4
 */
public class TestPeriodPredicates extends TestBase {

    private Scanner    scanner;
    private Connection conn;
    private Session    session;

    public TestPeriodPredicates(String name) {

        super(name,  "jdbc:hsqldb:mem:test", false, false);

        scanner = new Scanner();
    }

    protected void setUp() throws Exception {

        super.setUp();

        conn    = super.newConnection();
        session = (Session) ((JDBCConnection) conn).getSession();
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-12 01:02:03')
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodOverlapsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-12 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.overlaps(session, a, ta, b, tb));
        Assert.assertTrue(DateTimeType.overlaps(session, b, tb, a, ta));
    }

    /**
     * (TIMESTAMP '2000-01-12 01:02:03', TIMESTAMP '1999-12-01 01:02:03')
     * OVERLAPS
     * (TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-01-01 01:02:03')
     * is true
     */
    public void testFirstPeriodOverlapsSecondPeriod_reversed() {

        Object[] a = {
            scanner.newTimestamp("2000-01-12 01:02:03"),
            scanner.newTimestamp("1999-12-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.overlapsRelaxed(session, a, ta, b, tb));
        Assert.assertTrue(DateTimeType.overlapsRelaxed(session, b, tb, a, ta));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is false
     */
    public void testFirstPeriodDoesNotOverlapsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.overlaps(session, a, ta, b, tb));
        Assert.assertFalse(DateTimeType.overlaps(session, b, tb, a, ta));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-01 01:02:03')
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is false
     */
    public void testFirstPeriodDoesNotOverlapsSecondPeriod2() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.overlaps(session, a, ta, b, tb));
        Assert.assertFalse(DateTimeType.overlaps(session, b, tb, a, ta));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-01 01:02:04')
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodOverlapsSecondPeriodByOneSecond() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:04")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.overlaps(session, a, ta, b, tb));
        Assert.assertTrue(DateTimeType.overlaps(session, b, tb, a, ta));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '40' DAY)
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodOverlapsSecondPeriodWithInterval() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "40",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.overlaps(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * OVERLAPS
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '40' DAY)
     * is true
     */
    public void testFirstPeriodOverlapsSecondPeriodWithIntervalReversed() {

        Object[] a2 = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Object[] b2 = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "40",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };

        Assert.assertTrue(DateTimeType.overlaps(session, b2, tb, a2, ta));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '31' DAY)
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is false
     */
    public void testFirstPeriodDoesNotOverlapsSecondPeriodWithInterval() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.overlaps(session, a, ta, b, tb));
    }

    /**
     * (INTERVAL '31' DAY, TIMESTAMP '1999-12-01 01:02:03')
     * OVERLAPS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is false
     */
    public void testPeriodStartingWithInterval() {

        Object[] a = {
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)),
            scanner.newTimestamp("1999-12-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        try {
            DateTimeType.overlaps(null, a, ta, b, tb);
            Assert.fail("It is illegal to start a period with an interval");
        } catch (Exception e) {}
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '31' DAY)
     * PRECEDES
     * (TIMESTAMP '2000-01-01 01:02:03', INTERVAL '31' DAY)
     * is true
     */
    public void testFirstPeriodPrecedesSecondPeriodWithInterval() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };

        Assert.assertTrue(DateTimeType.precedes(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-01 01:02:03')
     * PRECEDES
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodPrecedesSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.precedes(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * PRECEDES
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-12 01:02:03')
     * is false
     */
    public void testFirstPeriodDoesNotPrecedesSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-12 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.precedes(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-01 01:02:04')
     * PRECEDES
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is false
     */
    public void testFirstPeriodDoesNotPrecedesSecondPeriod2() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:04")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.precedes(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-01-01 01:02:03', INTERVAL '7' DAY)
     * PRECEDES
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '7' DAY)
     * is false
     */
    public void testFirstPeriodIsAfterSecondPeriodWithInterval() {

        Object[] a = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newInterval(
                "7",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "7",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };

        Assert.assertFalse(DateTimeType.precedes(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-03-01 01:02:03')
     * SUCCEEDS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodSucceedsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newTimestamp("2000-03-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.succeeds(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * SUCCEEDS
     * (TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-03-01 01:02:03')
     * is false
     */
    public void testFirstPeriodDoesNotSucceedsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newTimestamp("2000-03-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.succeeds(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-03-01 01:02:03')
     * SUCCEEDS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:04')
     * is false
     */
    public void testFirstPeriodDoesNotSucceedsSecondPeriod2() {

        Object[] a = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newTimestamp("2000-03-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:04")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.succeeds(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-02-01 01:02:03', INTERVAL '31' DAY)
     * SUCCEEDS
     * (TIMESTAMP '2000-01-01 01:02:03', , INTERVAL '31' DAY)
     * is true
     */
    public void testFirstPeriodSucceedsSecondPeriodWithInterval() {

        Object[] a = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };

        Assert.assertTrue(DateTimeType.succeeds(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '2000-02-01 01:02:03', INTERVAL '31' DAY)
     * SUCCEEDS
     * (TIMESTAMP '2000-01-01 01:02:03', , INTERVAL '32' DAY)
     * is true
     */
    public void testFirstPeriodDoesNotSucceedsSecondPeriodWithInterval() {

        Object[] a = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newInterval(
                "31",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newInterval(
                "32",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };

        Assert.assertFalse(DateTimeType.succeeds(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-12 01:02:03')
     * EQUALS
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-12 01:02:03')
     * is true
     */
    public void testFirstPeriodEqualsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-12 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-12 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.equals(session, a, ta, b, tb));
        Assert.assertTrue(DateTimeType.equals(session, b, tb, a, ta));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '10' DAY)
     * EQUALS
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-11 01:02:03')
     * is true
     */
    public void testFirstPeriodEqualsSecondPeriodWithOneInterval() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "10",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-11 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.equals(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '10' DAY)
     * EQUALS
     * (TIMESTAMP '1999-12-01 01:02:03', INTERVAL '10' DAY)
     * is true
     */
    public void testFirstPeriodEqualsSecondPeriodWithTwoIntervals() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "10",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newInterval(
                "10",
                IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0))
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            IntervalType.newIntervalType(Types.SQL_INTERVAL_DAY, 2, 0)
        };

        Assert.assertTrue(DateTimeType.equals(session, a, ta, b, tb));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-02 01:02:03')
     * CONTAINS
     * TIMESTAMP '1999-12-01 01:02:03'
     * is false
     */
    public void testFirstPeriodCannotContainsSecondPeriodIfTheyAreEquals() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:01"),
            scanner.newTimestamp("1999-12-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            null
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.contains(session, a, ta, b, tb,
                true));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * CONTAINS
     * TIMESTAMP '1999-12-01 01:02:03'
     * is true
     */
    public void testFirstPeriodContainsItsStartDate() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            null
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.contains(session, a, ta, b, tb, true));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * CONTAINS
     * TIMESTAMP '1999-12-31 01:02:03'
     * is false
     */
    public void testFirstPeriodDoesNotContainsItsEndDate() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-31 01:02:03"),
            null
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.contains(session, a, ta, b, tb,
                true));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * CONTAINS
     * (TIMESTAMP '1999-12-30 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * is true
     */
    public void testFirstPeriodContainsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-30 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.contains(session, a, ta, b, tb, false));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * CONTAINS
     * (TIMESTAMP '1999-12-31 01:02:02', TIMESTAMP '1999-12-31 01:02:03')
     * is true
     */
    public void testFirstPeriodContainsItselfMinus1Second() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-31 01:02:02"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.contains(session, a, ta, b, tb, false));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * CONTAINS
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * is true
     */
    public void testFirstPeriodContainsSecondPeriodEvenIfEquals() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.contains(session, a, ta, b, tb, false));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '1999-12-31 01:02:03')
     * CONTAINS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-12-31 01:02:03')
     * is false
     */
    public void testFirstPeriodCannotContainsSecondPeriodWhenPrecedes() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("1999-12-31 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-12-31 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.contains(session, a, ta, b, tb,
                false));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-01 01:02:03')
     * PRECEDES
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodImmediatelyPrecedesSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.immediatelyPrecedes(session, a, ta, b,
                tb));
    }

    /**
     * (TIMESTAMP '1999-12-01 01:02:03', TIMESTAMP '2000-01-01 01:02:02')
     * PRECEDES
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodDoesNotImmediatelyPrecedesSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("1999-12-01 01:02:03"),
            scanner.newTimestamp("2000-01-01 01:02:02")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertFalse(DateTimeType.immediatelyPrecedes(session, a, ta, b,
                tb));
    }

    /**
     * (TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-03-01 01:02:03')
     * SUCCEEDS
     * (TIMESTAMP '2000-01-01 01:02:03', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodImmediatelySucceedsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newTimestamp("2000-03-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:03"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.immediatelySucceeds(session, a, ta, b,
                tb));
    }

    /**
     * (TIMESTAMP '2000-02-01 01:02:03', TIMESTAMP '2000-03-01 01:02:03')
     * SUCCEEDS
     * (TIMESTAMP '2000-01-01 01:02:04', TIMESTAMP '2000-02-01 01:02:03')
     * is true
     */
    public void testFirstPeriodDoesNotImmediatelySucceedsSecondPeriod() {

        Object[] a = {
            scanner.newTimestamp("2000-02-01 01:02:03"),
            scanner.newTimestamp("2000-03-01 01:02:03")
        };
        Object[] b = {
            scanner.newTimestamp("2000-01-01 01:02:04"),
            scanner.newTimestamp("2000-02-01 01:02:03")
        };
        Type[] ta = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };
        Type[] tb = {
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0),
            new DateTimeType(Types.SQL_TIMESTAMP, Types.SQL_TIMESTAMP, 0)
        };

        Assert.assertTrue(DateTimeType.immediatelySucceeds(session, a, ta, b,
                tb));
    }
}

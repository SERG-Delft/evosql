/*
 * $Id: dsv-omits.sql$
 *
 * Tests omitting columns via header line and *DSV_SKIP_COLS
 */

CREATE TABLE t (i INT, a INT, b INT, c INT);

\m dsv-omits.dsv
SELECT COUNT(*) FROM t
WHERE i IS NOT null AND a IS NOT null AND b IS NOT null AND c IS NOT null;

*if (*? != 2) \q Import using header line - column-skips failed

/** Repeat test with some non-default DSV settings */
* *DSV_SKIP_COLS =   c|   a 

DELETE FROM t;
\m dsv-omits.dsv

SELECT COUNT(*) FROM t
WHERE i IS NOT null AND b IS NOT null AND a IS null AND c IS null;

*if (*? != 2)
    \q Import using header line - AND *DSV_SKIP_COLS column-skips failed
*end if

/* Now test that behavior reverts when PL variable is cleared */
* *DSV_SKIP_COLS =
* listvalues

DELETE FROM t;
\m dsv-omits.dsv
SELECT COUNT(*) FROM t
WHERE i IS NOT null AND a IS NOT null AND b IS NOT null AND c IS NOT null;
\p Post everything

*if (*? != 2)
    SELECT * FROM t;
    \q *DSV_SKIP_COLS behavior failed to revert when variable was cleared
*end if

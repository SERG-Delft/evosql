/*
 * $Id: dsv-abortcommits.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests proper commit behavior upon DSV abortion
 */

CREATE TABLE t (i INT, r REAL, d DATE, t TIMESTAMP, v VARCHAR(80), b BOOLEAN);

\c true

\a true
\m dsv-rejects.dsv
SELECT COUNT(*) FROM t;
*if (*? != 1) \q Should have imported 1 good DSV records, but imported *{?} (1)
ROLLBACK;
SELECT COUNT(*) FROM t;
*if (*? != 1)
    \q Should have retained 1 DSV record after ROLLBACK w/autocommit, but retained *{?}
*end if

-- Now with auto-commit off
\a false
DELETE FROM t;
COMMIT;
\m dsv-rejects.dsv
SELECT COUNT(*) FROM t;
*if (*? != 1) \q Should have imported 1 good DSV records, but imported *{?} (2)
ROLLBACK;
SELECT COUNT(*) FROM t;
*if (*? != 0)
    \q Should have retained 0 DSV record after ROLLBACK, but retained *{?}
*end if

DELETE FROM t;
COMMIT;
* *DSV_RECORDS_PER_COMMIT = 10
\m dsv-rejects.dsv
SELECT COUNT(*) FROM t;
*if (*? != 1) \q Should have imported 1 good DSV records, but imported *{?} (3)
ROLLBACK;
SELECT COUNT(*) FROM t;
*if (*? != 1)
    \q Should have retained 1 DSV record after ROLLBACK w/RPC, but retained *{?}
*end if

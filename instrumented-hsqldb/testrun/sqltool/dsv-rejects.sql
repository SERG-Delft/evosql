/*
 * $Id: dsv-rejects.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests proper rejection of bad DSV input records
 */

CREATE TABLE t (i INT, r REAL, d DATE, t TIMESTAMP, v VARCHAR(80), b BOOLEAN);

* *DSV_REJECT_REPORT = ${java.io.tmpdir}/sqltoolutst-${user.name}.html
\m dsv-rejects.dsv

SELECT COUNT(*) FROM t;

*if (*? != 2) \q Should have imported 2 good DSV records, but imported *{?}

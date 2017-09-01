/*
 * $Id: dsv-multiline.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Does a DSV export using a multi-line custom query instead of just
 * specifying the table name.
 * Imports it back to validate the output.
 */

* *DSV_TARGET_FILE = ${java.io.tmpdir}/test-roundtrip-${user.name}.dsv
* *DSV_TARGET_TABLE = t
CREATE TABLE t (i INT, a INT, d DATE);

INSERT INTO t(i, a, d) VALUES (1, 149, null);
INSERT INTO t(i, a, d) VALUES (2, null, '2007-06-24');

\.
SELECT
  * FROM
     t
.

/* Export */
\x : WHERE i = 1

SELECT count(*) FROM t WHERE i = 1 AND a = 149 AND d IS null;
*if (*? != 1) \q Pre-check of inserted data failed (1)
SELECT count(*) FROM t WHERE i = 2 AND a IS NULL AND d = '2007-06-24';
*if (*? != 1) \q Pre-check of inserted data failed (2)


/* Import */
\m *{*DSV_TARGET_FILE}

SELECT count(*) FROM t WHERE i = 1 AND a = 149 AND d IS null;
*if (*? != 2) \q Post-check of imported data failed (1)
SELECT count(*) FROM t WHERE i = 2 AND a IS NULL AND d = '2007-06-24';
*if (*? != 1) \q Post-check of imported data failed (2)

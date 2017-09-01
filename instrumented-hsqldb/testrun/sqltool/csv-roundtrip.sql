/*
 * $Id: csv-roundtrip.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests a DSV "round trip".
 * Create a table, export the data, import it back, cf. imported  and original.
 */

* *DSV_TARGET_FILE = ${java.io.tmpdir}/test-roundtrip-${user.name}.csv
* *DSV_TARGET_TABLE = t
* *DSV_COL_DELIM = \t
* *DSV_COL_SPLITTER = \t
-- * *ALL_QUOTED = true
CREATE TABLE t (i INT, v VARCHAR(25), d DATE);

INSERT INTO t(i, v, d) VALUES (1, 'one two three', null);
INSERT INTO t(i, v, d) VALUES (2, null, '2007-06-24');
INSERT INTO t(i, v, d) VALUES (3, 'one,two,,three', '2007-06-24');
INSERT INTO t(i, v, d) VALUES (4, '"one"two""three', '2007-06-24');
INSERT INTO t(i, v, d) VALUES (5, '"one,two"three,', '2007-06-24');

/* Export */
\xq t

SELECT count(*) FROM t WHERE i = 1 AND v = 'one two three' AND d IS null;
*if (*? != 1) \q Pre-check of inserted data failed (1)
SELECT count(*) FROM t WHERE i = 2 AND v IS NULL AND d = '2007-06-24';
*if (*? != 1) \q Pre-check of inserted data failed (2)
SELECT count(*) FROM t WHERE i = 3 AND v = 'one,two,,three' AND d = '2007-06-24';
*if (*? != 1) \q Pre-check of inserted data failed (3)
SELECT count(*) FROM t WHERE i = 4 AND v = '"one"two""three' AND d = '2007-06-24';
*if (*? != 1) \q Pre-check of inserted data failed (4)
SELECT count(*) FROM t WHERE i = 5 AND v = '"one,two"three,' AND d = '2007-06-24';
*if (*? != 1) \q Pre-check of inserted data failed (5)


/* Import */
\mq *{*DSV_TARGET_FILE}

SELECT count(*) FROM t WHERE i = 1 AND v = 'one two three' AND d IS null;
*if (*? != 2) \q Post-check of inserted data failed (1)
SELECT count(*) FROM t WHERE i = 2 AND v IS NULL AND d = '2007-06-24';
*if (*? != 2) \q Post-check of inserted data failed (2)
SELECT count(*) FROM t WHERE i = 3 AND v = 'one,two,,three' AND d = '2007-06-24';
*if (*? != 2) \q Post-check of inserted data failed (3)
SELECT count(*) FROM t WHERE i = 4 AND v = '"one"two""three' AND d = '2007-06-24';
*if (*? != 2) \q Post-check of inserted data failed (4)
SELECT count(*) FROM t WHERE i = 5 AND v = '"one,two"three,' AND d = '2007-06-24';
*if (*? != 2) \q Post-check of inserted data failed (5)

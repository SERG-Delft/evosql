/*
 * $Id: dsv-sqlarray.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests a DSV "round trip".
 * Create a table, export the data, import it back, cf. imported  and original.
 */

* *DSV_TARGET_FILE = ${java.io.tmpdir}/test-sqlarray-${user.name}.dsv
* *DSV_TARGET_TABLE = t

CREATE TABLE t (i BIGINT PRIMARY KEY, ar INTEGER ARRAY);

INSERT INTO t VALUES (1, array [11, null, 13]);
INSERT INTO t VALUES (2, null);
INSERT INTO t VALUES (3, array [21, 22]);
COMMIT;

/* Export */
\x t

SELECT count(*) FROM t WHERE ar IS NULL AND i = 2;
*if (*? != 1) \q Pre-check of inserted Array array data failed (1)
SELECT count(*) FROM t WHERE i in (1, 3) AND ar IS NOT null;
*if (*? != 2) \q Pre-check of inserted Array data failed (2)

DELETE FROM t;

SELECT count(*) FROM t;
*if (*? != 0) \q Failed to clear table data

/* Import */
\m *{*DSV_TARGET_FILE}
SELECT count(*) FROM t WHERE ar IS NULL AND i = 2;
*if (*? != 1) \q Post-check of inserted Array array data failed (1)
SELECT count(*) FROM t WHERE i in (1, 3) AND ar IS NOT null;
*if (*? != 2) \q Post-check of inserted Array data failed (2)

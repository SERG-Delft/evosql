/*
 * $Id: lastval.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests auto-variable ?
 */

CREATE TABLE t (i INT);

* if (*? != 0) \q ? variable not capturing CREATE TABLE return value

INSERT INTO t values (21);
* if (*? != 1) \q ? variable not capturing INSERT return value

INSERT INTO t values (10);
* if (*? != 1) \q ? variable not capturing INSERT return value

INSERT INTO t values (43);
* if (*? != 1) \q ? variable not capturing INSERT return value

SELECT * FROM t ORDER BY i DESC;
* if (*? != 10) \q ? variable not capturing last fetched value

\p echo some stuff
\p to verify that ? variable value is preserved
* list

* if (*? != 10) \q ? value not retained after special commands
* if (*{?} != 10) \q ? value not dereferenced with {} usage

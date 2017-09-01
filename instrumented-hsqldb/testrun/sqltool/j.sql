/*
 * $Id: j.sql 4816 2011-11-24 23:15:42Z unsaved $
 *
 * Tests \j command
 */

CREATE TABLE t1(i int);
INSERT INTO t1 VALUES(11);
COMMIT;

\j SA jdbc:hsqldb:mem:dataSource2
SET PASSWORD 'sapwd';
CREATE TABLE t2(i int);
INSERT INTO t2 VALUES(22);
COMMIT;

\j SA jdbc:hsqldb:mem:utst
SELECT * FROM t1;
* if (*? != 11) \q \j failed

\j SA sapwd jdbc:hsqldb:mem:dataSource2
SELECT * FROM t2;
* if (*? != 22) \q \j failed

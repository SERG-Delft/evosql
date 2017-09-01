/*
 * $Id: dsv-prepare.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests PL 'prepare' command
 */

CREATE TABLE t (i INT, a INT, b INT, c INT);

* N = 4567
* prepare N

INSERT INTO t(i, a, b, c) VALUES (1, ?, 8, 9);

SELECT count(*) FROM t WHERE i = 1 AND a = 4567 AND b= 8 AND c = 9;

*if (*? != 1) \q PL prepare command failed

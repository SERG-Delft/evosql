/*
 * $Id: rawmode.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests raw mode
 */

CREATE TABLE t (i INTEGER);
INSERT INTO t values (42);

/** Adding a few blank lines in what is sent to server on purpose. */
\.


SELECT i FROM t


.;

*if (*? != 42) \q Raw command failed

-- To change results so we can be confident of getting 1 later on.
INSERT INTO t values (43);
SELECT * FROM t;

\.
SELECT count(*) FROM t
.
:a WHERE i = 42
;
*if (*? != 1) \q Raw command failed

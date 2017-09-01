/*
 * $Id: macro.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests interactive macro commands /...
 *
 * See macro.inter script also.
 */


\c false

/=q SELECT count(*) FROM t

CREATE TABLE t(i int);
INSERT INTO t VALUES(1);
INSERT INTO t VALUES(2);
INSERT INTO t VALUES(3);
INSERT INTO t VALUES(4);
INSERT INTO t VALUES(5);
COMMIT;

/q WHERE i > 3;

* if (*? != 2) \q Query returned *{?} rows, should have returned 2.

/* Now test with lots of intervening white space */
  /  =   q   SELECT count(*) FROM t WHERE i > *{LIMIT}   

   /   =   setlim  *  LIMIT =   

* LIMIT = 4
/q;
* if (*? != 1) \q Query returned *{?} rows, should have returned 1.

/setlim 3;
/q;
* if (*? != 2) \q Query returned *{?} rows, should have returned 2.

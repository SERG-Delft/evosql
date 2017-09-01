/*
 * $Id: buffer-vars.sql 5406 2014-10-13 20:53:18Z unsaved $
 */

CREATE TABLE t (i INT, a INT, d DATE);

INSERT INTO t(i, a, d) VALUES (1, 149, null);

-- 1-liner sanity check:
* qpart1 = i FROM
SELECT *{qpart1} t;
* if (*? != 1) \q 1-line query with internal PL variable failed

-- Multi-line PL var:
\.
a
    FROM
.
* qpart2 :
SELECT *{qpart2} t;
* if (*? != 149) \q 1-line query with multi-line internal PL variable failed

* res1 ~
SELECT
  *{qpart2}
     t;
* if (*res1 != 149)
      \q multi-line query with multi-line internal PL variable failed
* end if

-- Multi-line Macro:
\.
  SELECT
a
.
/= m1 : FROM
* res2 ~
/m1 t;
* if (*res2 != 149)
      \q Legacy multi-line query with multi-line internal PL variable failed
* end if

-- Newer syntax of same:
\.
  SELECT
a
.
-- Note the critical 2 spaces before FROM to delimite it from preceding token:
/: m1  FROM
* res3 ~
/m1 t;
* if (*res3 != 149)
      \q multi-line query with multi-line internal PL variable failed. Ws by appendage.
* end if

-- With separating white space in in middle appendage
\.
a
    FROM
.
* qpart3 : 
SELECT *{qpart3}t;
* if (*? != 149) \q White space inserted with middle appendage

-- With separating white space in the base
\.
a
    FROM 
.
* qpart3 :
SELECT *{qpart3}t;
* if (*? != 149) \q White space inserted with middle appendage

/*
 * $Id: function.sql 4847 2011-12-27 15:23:12Z unsaved $
 *
 * Tests SqlTool functions.
 */

-- Special command function
/= f() \p one *{:2} *{1} four
/f(alpha, beta)five;
/f(alpha) six;
--/f();
/f(alpha, beta)seven
:;
\p uno *{:2} *{:1} quatro
/: g() sinco
/g(alpha, beta);


CREATE TABLE t(i integer, vc varchar(20));
INSERT INTO t VALUES(1, 'one');
INSERT INTO t VALUES(2, 'two');
COMMIT;

-- SQL functions
\.
INSERT INTO t VALUES(3, 'three');
SELECT  -- Trailing whitespace on next line
    * *{1} 
.
/: h() t 
-- Trailing whitespace on previous line
* quieter ~
/h(FROM)WHERE i = 3;
* if (*? != three)
    \q SqlTool function for multi-line chunked SQL command with appendages failed
*end if

-- Same but without any appendages
\.
INSERT INTO t VALUES(4, 'four');
SELECT vc FROM *{1} WHERE i = 4
.
/: f1()
* quieter ~
/f1(t);
* if (*? != four)
    \q SqlTool function for multi-line chunked SQL command (no appendages) failed
*end if

-- Test function invocation with no params but appendage
\.
INSERT INTO t VALUES(5, 'four');
SELECT vc FROM t
.
/: f2()
* quieter ~
/f2() WHERE i = 4;
* if (*? != four)
    \q SqlTool function for multi-line chunked SQL command (no params) failed
*end if

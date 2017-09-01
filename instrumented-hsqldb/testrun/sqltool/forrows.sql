/*
 * $Id: forrows.sql 5445 2015-03-22 18:06:13Z unsaved $
 *
 * Tests forrows iterator
 */

create table t(i int, vc varchar(25));
insert into t values(1, 'one');
insert into t values(2, 'two');
insert into t values(null, 'three');
insert into t values(4, null);

* RES={
* EXPECTED={ Q1 1|one 1,(one) Q1 2|two 2,(two) Q1 [null]|three ,(three) Q1 4|[null] 4,() }
*forrows   INT   VCHAR  
SELECT * FROM t;
    * RES=*{RES} Q1 *{*ROW}
    * RES=*{RES} *{:INT},(*{:VCHAR})
*end forrows
* RES=*{RES} }
* if (*RES != *EXPECTED) \q [*{RES}] != [*{EXPECTED}]

* RES={
* EXPECTED={ Q2 1|one Q2 2|two Q2 [null]|three Q2 4|[null] }
*forrows   
SELECT * FROM t;
    * RES=*{RES} Q2 *{*ROW}
*end forrows
* RES=*{RES} }
* if (*RES != *EXPECTED) \q [*{RES}] != [*{EXPECTED}]

-- Test that case of 0 rows handled gracefully
DELETE FROM t;
*forrows   INT   VCHAR  
SELECT * FROM t;
    \q Executing forrow body when table is empty
*end forrows
*forrows   
SELECT * FROM t;
    \q Executing forrow body when table is empty
*end forrows

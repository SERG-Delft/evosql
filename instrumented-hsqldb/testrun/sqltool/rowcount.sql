/*
 * $Id: rowcount.sql 5446 2015-03-22 18:06:56Z unsaved $
 *
 * Tests automatic variable #
 */

create table t(i int, vc varchar(25));
insert into t values(1, 'one');
insert into t values(2, 'two');
insert into t values(null, 'three');
insert into t values(4, null);
* var = x

*if (*# != 0) \q Initial value of # != 0: *{#}

*forrows   INT   VCHAR  
SELECT * FROM t WHERE i IS NOT null;
    *if (*# != 3) \q # inside forrows != 3: *{#}
*end forrows
*if (*# != 3) \q # after forrows != 3: *{#}

SELECT * FROM t WHERE i = 2;
*if (*# != 1) \q # after single-row SELECT: *{#}
-- Test with nesting
*if (1 == 1)
    *if (*# != 1) \q # nexted after single-row SELECT: *{#}
    SELECT * FROM t WHERE i > 1;
    *if (*# != 2) \q # after SELECT != 2: *{#}
*end if
*if (*# != 2) \q # after nested SELECT != 2: *{#}

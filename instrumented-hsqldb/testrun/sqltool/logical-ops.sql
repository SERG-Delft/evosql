/*
 * $Id: logical-ops.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Test logical operations.
 */

* three = 3
* four = 4

*if (3 != 3) \q 3 != 3

*if (3 == 4) \q 3 == 4

*if (3 > 4) \q 3 > 4

*if (!4 > 3) \q !4 > 3

*if (3 >= 4) \q 3 >= 4

*if (4 =< 3) \q 4 =< 3

*if (*unset1 != *unset2) \q *unset1 != *unset2

*if (3 == three) \q 3 == three

*if (3 == four) \q 3 == four

* blankVar1 =
* blankVar2 =
*if (*blankVar1 != *blankVar2) \q *blankVar1 != *blankVar2

*if (*blankVar1 == *unset1) \q *blankVar1 == *unset1

*if (*{blankVar1} != *{blankVar2}) \q *{blankVar1} != *{blankVar2}

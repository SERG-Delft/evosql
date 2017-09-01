/**
 * Logical expressions where elements contain spaces.
 */

* str1 = one  two
* expected = one  two
* wrong1 = one two
* wrong2 = one
* wrong3 = two

*if (*str1 == *wrong1) \q 'one  two' == 'one two'
*if (*str1 == *wrong2) \q 'one  two' == 'one'
*if (*str1 == *wrong3) \q 'one  two' == 'two'
*if (*str1 != *expected) \q (*{str1}) vs. (*{expected})

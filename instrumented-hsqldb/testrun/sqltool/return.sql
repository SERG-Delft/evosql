/*
 * $Id: return.sql 4717 2011-11-07 00:28:07Z unsaved $
 *
 * Tests the new "return" statement, which is equivalent to a "break" statement
 * with no parameter.
 */

* VAR=one
\i return.isql
* VAR=*{VAR} three

* EXPECTED = one two three
* if (*VAR != *EXPECTED) \q return statement failed: (*{VAR}) vs. (*{EXPECTED})

* return

\q return.sql ran past the return statement

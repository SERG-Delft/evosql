/*
 * $Id: errhandling.sql 610 2008-12-22 15:54:18Z unsaved $
 *
 * Tests error handling inside of blocks and in subscripts.
 */

\c true
bad;
\p Made it past first ignored error.

/* At root level, can even ignore fatal syntax errors */
* foreach bad
* ifff

* V = changethis
* if (1)
    bad;
    * ifff
    * end nosuch
    * V = ok
* end if 

* if (*V != ok)
    \q Seems to have aborted inside if block in Continue-on-error mode
* end if

* W = changethis
* if (1)
    bad;
    *if (2)
        * ifff
        * end nosuch
        * W = ok
    *end if
    worse;
* end if 

* if (*W != ok)
    \q Seems to have aborted inside nested if block in Continue-on-error mode
* end if

\i errhandling.isql

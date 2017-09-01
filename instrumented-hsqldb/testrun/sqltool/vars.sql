/*
 * $Id: vars.sql 5406 2014-10-13 20:53:18Z unsaved $
 */

* mt1 =
* mt2 =
-- Following line has trailing white space, but that should have no effect.
* mt3 =   
* - un1
* - un2

* if (*unsetA != **NULL) \q Never used variable is not **NULL
* if (*un1 != **NULL) \q Explicitly unset variable is not **NULL
* if (*unsetA != *unsetB) \q Two never-set vars differ
* if (*un1 != *un2) \q Two explicitly unset variables differ
* if (*un1 != *unsetA) \q Explicitly unset vs. neverset vars differ

* if (*mt1 != *mt2) \q Two legacy-unset vars differ

* if (*mt1 != *mt3) \q Two legacy-unset vars differ, one set to blanks

* if (*mt1 == *unset) \q Legacy-unset var != never-set var

* if (alpha != alpha) \q Sanity constant comparison failed

* a = alpha
* anotherA = alpha
* if (*a != *anotherA) \q To equivalant variable values differ

-- Following two have 2 trailing spaces:
* wsTrailed1 = alpha  
* wsTrailed2 = alpha  
* if (*wsTrailed1 == a)
    \q Trailing white-space not honored in logical evaluation
* end if
* if (*wsTrailed1 != *wsTrailed2)
    \q Trailing white-space not valued equally for logical evaluation
* end if

* wsEmbed1 = alpha  beta
* wsEmbed2 = alpha  beta
* if (*wsEmbed1 != *wsEmbed2)
    \q Embedded white-space not valued equally for logical evaluation
* end if

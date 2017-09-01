/*
 * $Id: logic.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Logic tests
 */

*if (1) * T1 = true
*if (! *T1) \q Test of (1) failed
*if (0) \q Test of (0) failed

*if (! 1) \q Test of (! 1) failed
*if (! 0) * T2 = true
*if (! *T2) \q Test of (! 0) failed

*if (!1) \q Test of (!1) failed
*if (!0) * T3 = true
*if (!*T3) \q Test of (!0) failed

* SETVAR=3
*if (*SETVAR) * T4 = true
*if (! *T4) \q Test of (*SETVAR) failed
*if (*UNSETVAR) \q Test of (*UNSETVAR) failed

*if (! *SETVAR) \q Test of (! *SETVAR) failed
*if (! *UNSETVAR) * T5 = true
*if (! *T5) \q Test of (! *UNSETVAR) failed

*if (!*SETVAR) \q Test of (!*SETVAR) failed
*if (!*UNSETVAR) * T6 = true
*if (!*T6) \q Test of (!*UNSETVAR) failed

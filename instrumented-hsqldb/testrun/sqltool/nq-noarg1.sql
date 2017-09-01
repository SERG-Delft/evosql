/*
 * $Id: nq-noarg1.sql 610 2008-12-22 15:54:18Z unsaved $
 *
 * Test of \q with arg from nested script.
 */

\i nq-noarg1.isql
\q Should not have returned from nested script!

/*
 * $Id: atuser.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Test loading other files with @
 */

\i @/tblx.sql

\m @/tblx.dsv

SELECT COUNT(*) FROM tblx;
*if (*? != 2) \q Failed to load table deta from @ directory

/*
 * $Id: sqljrt.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests SQL/JRT
 */

create function dehex(VARCHAR(80), INTEGER)
    returns INTEGER
    no sql
    language java
    external name 'CLASSPATH:java.lang.Integer.valueOf'
.;

CALL dehex('12', 16);
*if (*? != 18) \q SQL/JRT function failed

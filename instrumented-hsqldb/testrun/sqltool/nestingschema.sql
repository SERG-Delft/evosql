/*
 * $Id: nestingschema.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests a schema creation statement that nests some objects.
 */

/**
 * Besides testing nesting of commands without ; delimiters, this also
 * regression tests that the CREATE SCHEMA... command itself does not require
 * the closing ; to be sent to the DB engine.
 */
CREATE SCHEMA FELIX AUTHORIZATION DBA
    CREATE TABLE FELIXT1 (AV1 VARCHAR(10), BV VARCHAR(10))
    CREATE TABLE FELIXT2 (AV2 VARCHAR(10), BI INTEGER)
    CREATE SEQUENCE FELIXS1
    CREATE VIEW FELIXV1 AS SELECT * FROM FELIXT1 JOIN FELIXT2 ON AV1 = AV2
    CREATE VIEW FELIXV2 AS SELECT AV1 AS C1, NEXT VALUE FOR FELIXS1 AS C2 FROM FELIXT1;

SELECT count(*) FROM felix.felixv2;
*if (*? != 0) \q Nesting CREATE SCHEMA failed

/*
 * $Id: comments.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests comments.  This comment itself is a multi-line comment
 */

/* Just to have a work table */
CREATE TABLE t(i int);

  /* A multi-line
  comment  with
  leading + trailing white space. */  

/*Repeat with text right up to edges.
 *
 * Tests comments.  This comment itself is a multi-line comment*/

  /*Repeat with text right up to edges.
  comment  with
  leading + trailing white space. */

/* Following line contains spaces */
           

/* Simple hyphen-hyphen comments */
-- blah
  -- blah

/* Empty and white space comments: */
/**/
/*****/
/*** Extra stars ***/
  /*** Extra stars ***/   
   /**************/
---- Extra slashes
  ---- Extra slashes  
    ----------------------
/*  */
  /**/  
  /*  */
/* The second of each of the following pairs have trailing white space.
--
--  
  --
  --  

/* Comments trailing SQL */
INSERT INTO t VALUES (9);

/* Simple SQL-embedded traditional comments */
SELECT * FROM  /* A simple traditional comment */ t;
* if (*? != 9) \q Hyphen-hyphen trailing SQL failed
SELECT * FROM  /* A simple traditional
comment */ t;
* if (*? != 9) \q Hyphen-hyphen trailing SQL failed
SELECT * FROM  -- A simple single-line comment
t;
* if (*? != 9) \q Hyphen-hyphen trailing SQL failed
SELECT * FROM  -- Two simple single-line
-- comments
t;
* if (*? != 9) \q Hyphen-hyphen trailing SQL failed
SELECT * FROM  -- Two simple single-line
  -- comments.  With leading white space
  t;
* if (*? != 9) \q Hyphen-hyphen trailing SQL failed

/* Nesting different comments inside one another */
/* -- The traditional comment should still close. */
SELECT * FROM  /* Something -- single-line SQL-trailing comment */ t;
* if (*? != 9) \q Hyphen-hyphen trailing SQL failed

/* Sanity check */
* V1 = one
* if (*V1 != one) \q Failed sanity check for simple variable test

/* Test single-line within PL command */
* V2 = alpha--some crap
* if (*V2 != alpha) \q Failed single-line within PL command

/* Test traditional within PL command */
* V3 = gamma/*some crap*/
* if (*V3 != gamma) \q Failed traditional within PL command

/* Test multiple traditionals within PL command */
* V4 = de/*some crap*/l/*more*/ta
* if (*V4 != delta) \q Failed multiple traditional within PL command

/* Test single-line within PL command */
* V5 = alpha--some crap /* with nested traditional */ there
* if (*V5 != alpha) \q Failed single-line within PL w/ nesting+trailing failed

/* Test single-line within PL command */
* V6 = alpha--some crap /* with nested traditional */
* if (*V6 != alpha) \q Failed single-line within PL w/ nesting failed

/* Test single-line within PL command */
* V7 = alpha--some crap /* with nested traditional
* if (*V6 != alpha) \q Failed single-line within PL w/ unclosed nesting failed

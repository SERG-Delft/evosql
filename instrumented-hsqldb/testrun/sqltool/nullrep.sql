/*
 * $Id: nullrep.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests enforcement of null-representation token 
 */

CREATE TABLE t (i INT, vc VARCHAR(80));

INSERT INTO t VALUES(1, 'one');
/** For INPUT, the NULLREP is only used for DSV imports, since unquoted
 *  null works perfectly for other forms of input.
 *  Therefore, following should enter "[null]" literally.
 */
INSERT INTO t VALUES(2, '[null]');
INSERT INTO t VALUES(3, null);

* COUNT _
SELECT count(*) FROM t WHERE i = 2 AND vc IS NULL;
* if (*COUNT != 0)
    \q Seems that non-DSV insertion of '[null]' inserted a real NULL
* end if

* COUNT _
SELECT count(*) FROM t WHERE i = 3 AND vc IS null;
* if (*COUNT != 1)
    \q Seems that non-DSV insertion of plain null did not insert a SQL NULL
* end if
DROP TABLE t;


/* Now test nullrep tokens with DSV imports */
CREATE TABLE t (
    id VARCHAR(80) PRIMARY KEY,
    i INTEGER,
    r REAL,
    d DATE,
    t TIMESTAMP,
    v VARCHAR(80),
    b BOOLEAN
);

\m nullrep.dsv
SELECT count(*) FROM t WHERE id = 'wspaces' AND i IS null;
*if (*? != 1) \q Insertion of INTEGER space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND r IS null;
*if (*? != 1) \q Insertion of REAL space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND d IS null;
*if (*? != 1) \q Insertion of DATE space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND t IS null;
*if (*? != 1) \q Insertion of TIMESTAMP space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND v = '  [null]  ';
*if (*? != 1) \q Insertion of VARCHAR w/ space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND b IS null;
*if (*? != 1) \q Insertion of BOOLEAN space-embedded null-rep-token failed

DELETE FROM t;

/** Repeat test with some non-default DSV settings */
* *NULL_REP_TOKEN = %%
* *DSV_COL_SPLITTER = :
* *DSV_ROW_SPLITTER = \}(?:\r\n|\r|\n)

\m nullrep-alt.dsv
SELECT count(*) FROM t WHERE id = 'wspaces' AND i IS null;
*if (*? != 1) \q Insertion of INTEGER space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND r IS null;
*if (*? != 1) \q Insertion of REAL space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND d IS null;
*if (*? != 1) \q Insertion of DATE space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND t IS null;
*if (*? != 1) \q Insertion of TIMESTAMP space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND v = '  %%  ';
*if (*? != 1) \q Insertion of VARCHAR w/ space-embedded null-rep-token failed

SELECT count(*) FROM t WHERE id = 'wspaces' AND b IS null;
*if (*? != 1) \q Insertion of BOOLEAN space-embedded null-rep-token failed

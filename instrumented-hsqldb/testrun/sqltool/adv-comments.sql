/* The tests in this file don't succeed with SqlTool as it is now due to:
 *   Improper handling of traditional-comments inside single-line comment.
 *   Improper handling of single-line comments inside traditional comment.
 *   Inability to recognize SQL commands on lines which don't end with ;\s*$.
 */

/* Repeat with text right up to edges/* /*on one*/ /*line*/
    /*Same thing/* /*with leading*/ /*+ trailing white space*/   


CREATE TABLE t(i int);
INSERT INTO t VALUES(1);
INSERT INTO t VALUES(2);

SELECT * FROM t;  -- single-line SQL-trailing comment
* if (*? != 2) \q Hyphen-hyphen trailing SQL failed
SELECT * FROM t;  /* traditional SQL-trailing comment */
* if (*? != 2) \q Traditional trailing SQL failed

SELECT * FROM t;  /* Something -- single-line SQL-trailing comment */
* if (*? != 2) \q Hyphen-hyphen trailing SQL failed

/*
 * $Id: dsv-rpcommit.sql 5406 2014-10-13 20:53:18Z unsaved $
 *
 * Tests *DSV_RECORDS_PER_COMMIT setting
 */

/* Unfortunately, can't test how many commits are performed and where.
 * That would * require adding significant complexity to SqlFile itself, or
 * complex interception of commits.
 * I have, however, manually tested the commits by echoing the commits in
 * the source code, and removing observing what remains uncommitted after
 * removing the straggler-catching commit after the insertion loop in
 * SqlFile.importDsv().
 * All that we are testing here is that all records which should be committed
 * do get committed.
 */

CREATE TABLE t (i INT);

\c true
* *DSV_RECORDS_PER_COMMIT=5
\m dsv-rpcommit.dsv

ROLLBACK;

SELECT COUNT(*) FROM t;
*if (*? != 13) \q *DSV_RECORDS_PER_COMMIT committed only *{?} records instead 13

DELETE FROM t;
* *DSV_REJECT_REPORT = ${java.io.tmpdir}/test-rpcommit-${user.name}.dsv
\m dsv-rpcommit.dsv

SELECT COUNT(*) FROM t;
*if (*? != 21) \q *DSV_RECORDS_PER_COMMIT committed only *{?} records instead 21

CREATE TABLE t ( a INT )

INSERT INTO t VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)

SELECT a
FROM t
WHERE a > 5 AND a < 8

DROP TABLE t
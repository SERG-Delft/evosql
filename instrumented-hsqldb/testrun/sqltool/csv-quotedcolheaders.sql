-- Simplification of test case submitted by tokajac

CREATE TABLE IF NOT EXISTS tmp_tbl(imports_pk NUMERIC NOT NULL IDENTITY,field1 VARCHAR(255),field2 VARCHAR(255),field3 VARCHAR(255),field4 VARCHAR(255));
* *DSV_TARGET_TABLE = tmp_tbl
* *DSV_COL_SPLITTER=,
\mq csv-quotedcolheaders.csv
commit;

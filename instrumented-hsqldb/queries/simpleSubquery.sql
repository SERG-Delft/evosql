CREATE TABLE products ( "Product" VARCHAR(50), "Type" int, "Price" FLOAT )

INSERT INTO products VALUES ('A',1,5), ('A',2,3), ('A',3,3), ('B',1,10), ('B',2,8), ('C', 1, 7)

SELECT t1."Product", (SELECT MAX("Price") FROM products AS t2 WHERE t1."Product" = t2."Product") AS "Price"
FROM products AS t1

DROP TABLE products
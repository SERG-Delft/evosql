CREATE TABLE products ( "Product" VARCHAR(50), "Type" int, "Price" FLOAT )

INSERT INTO products VALUES ('Clock deluxe',1,5), ('Clock basic',2,3), ('Other thing',3,3), ('Clock',1,10), ('B',2,8), ('C', 1, 7)

SELECT t1."Product", t1."Type", t1."Price"
FROM products AS t1
WHERE t1."Product" LIKE 'Clock%'

DROP TABLE products
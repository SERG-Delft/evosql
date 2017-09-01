CREATE TABLE products ( "Product" VARCHAR(50), "Type" int, "Price" FLOAT )

INSERT INTO products VALUES ('A',1,5), ('A',2,3), ('A',3,3), ('B',1,10), ('B',2,8), ('C', 1, 7)

SELECT t1."Product", t1."Price" 
FROM (
	SELECT "Product", MAX("Price") "Price" 
	FROM products 
	WHERE "Price" > 5
	GROUP BY "Product"
) AS t1 
WHERE t1."Price" < 9

DROP TABLE products
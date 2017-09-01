CREATE TABLE products ( "Product" VARCHAR(50), "Type" int, "Price" FLOAT )

INSERT INTO products VALUES ('A',1,5), ('A',2,3), ('A',3,3), ('B',1,10), ('B',2,8), ('C', 1, 7)

SELECT "Product", AVG("Price")
FROM products
WHERE "Price" >= 5
GROUP BY "Product"
HAVING AVG("Price") > 5

DROP TABLE products
CREATE TABLE products ( "Product" VARCHAR(50) NULL, "Type" int, "Price" FLOAT  )

INSERT INTO products VALUES ('A',1,5), ('A',2,3), ('A',3,3), ('B',1,10), ('B',2,8), ('C', 1, 7)--, (NULL, 1, 10)

SELECT *
FROM products
WHERE ("Product" = 'A' AND "Price" > 4) -- OR NOT ("Product" = 'B' AND "Price" < 10)-- OR ("Product" = 'C')

DROP TABLE products
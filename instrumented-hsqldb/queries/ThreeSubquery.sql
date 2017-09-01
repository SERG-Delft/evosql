CREATE TABLE products (Product VARCHAR(50), Price DOUBLE )

INSERT INTO products VALUES ('A',6), ('A', 7)

SELECT * FROM (SELECT * FROM (SELECT * FROM products WHERE Product = 'A' GROUP BY Product, Price) t WHERE Price > 5  GROUP BY Product, Price) t WHERE Price < 20

DROP TABLE products
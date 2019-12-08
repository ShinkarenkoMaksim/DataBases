USE shop_temp;

INSERT INTO orders (user_id) VALUES (6), (2), (1);

SELECT DISTINCT users.name FROM users RIGHT JOIN orders ON users.id = orders.user_id;

SELECT p.name, c.name FROM products AS p JOIN catalogs AS c ON p.catalog_id = c.id;
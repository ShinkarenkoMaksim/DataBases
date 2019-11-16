CREATE DATABASE example;
USE example;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя'
)

mysqldump example > example.sql
mysql -e 'CREATE DATABASE sample'
mysql sample < example.sql

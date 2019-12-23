-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и 
-- products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор 
-- первичного ключа и содержимое поля name.

USE shop

CREATE TABLE logs (
	id INT PRIMARY KEY AUTO_INCREMENT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	table_name VARCHAR(255) NOT NULL,
	prim_key TINYINT NOT NULL,
	name VARCHAR(255)
	) ENGINE=ARCHIVE;

CREATE TRIGGER products_insert AFTER INSERT ON products FOR EACH ROW
	INSERT INTO logs (table_name, prim_key, name) VALUES ('products', NEW.id, NEW.name);

CREATE TRIGGER users_insert AFTER INSERT ON users FOR EACH ROW
	INSERT INTO logs (table_name, prim_key, name) VALUES ('users', NEW.id, NEW.name);

CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs FOR EACH ROW
	INSERT INTO logs (table_name, prim_key, name) VALUES ('catalogs', NEW.id, NEW.name);

DESC users;

-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- Решил сделать это процедурой

DELIMITER //

CREATE PROCEDURE loop_users_billion()
BEGIN
	DECLARE x INT;
	SET x = 0;
	myloop: LOOP
		IF x > 999999 THEN
			LEAVE myloop;
		END IF;
	SET x = x + 1;
	INSERT INTO users (name) VALUES ('Имя');
	END LOOP;
END//

DELIMITER ;

CALL loop_users_billion()
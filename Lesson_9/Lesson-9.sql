-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users SELECT id, name FROM shop.users WHERE shop.users.id = 1;
DELETE FROM shop.users WHERE id = 1;

COMMIT;


-- Создайте представление, которое выводит название name товарной позиции из таблицы products и 
-- соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW prod_cat AS
SELECT p.name prod, c.name cat 
	FROM products AS p 
	JOIN catalogs AS c 
		ON p.catalog_id = c.id;

SELECT * FROM prod_cat;



-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
-- "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
BEGIN
	CASE 
		WHEN CURRENT_TIME BETWEEN '6:00:00' AND '11:59:59' 
			THEN RETURN 'Доброе утро';
		WHEN CURRENT_TIME BETWEEN '12:00:00' AND '17:59:59' 
			THEN RETURN 'Добрый день';
		WHEN CURRENT_TIME BETWEEN '18:00:00' AND '23:59:59' 
			THEN RETURN 'Добрый вечер';
		ELSE RETURN 'Доброй ночи';
	END CASE;
END//

DELIMITER;

SELECT hello();



-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо 
-- присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить 
-- полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS products_insert;

CREATE TRIGGER products_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL AND NEW.description IS NULL)
		THEN SIGNAL SQLSTATE '45500' SET message_text = 'Необходимо заполнить минимум одно из полей name или description';
	END IF;
END//
-- Не очень понятно, почему ограничена возможность использования ROLLBACK в триггерах, решил выйти из ситуации ошибкой

INSERT INTO products (name, description) VALUES (NULL, NULL);




-- Операторы, фильтрация, сортировка и ограничение
-- 1) Заполняем столбцы created_at и updated_at текущим временем
UPDATE users SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;


-- 2) Изменяем тип данных столбцов created_at и updated_at в требуемый формат с сохранением данных. Сервер mysql пытается максимально корректно преобразовать данные, в нашем случае успешно
ALTER TABLE users MODIFY updated_at DATETIME;
ALTER TABLE users MODIFY created_at DATETIME;

CREATE TABLE storehouses_products (`index` SERIAL, value INT NOT NULL);
INSERT INTO storehouses_products (value) VALUES (0);

-- 3) Делаем сортировку по заданию - сперва булевыми значениями (FALSE будет первым) помещяем нули в конец, затем сортируем по столбцу value
SELECT * FROM storehouses_products ORDER BY value = 0, value;


-- Агрегация данных
-- 1) Подсчитываем средний возраст пользователей в таблице users
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, CURDATE())) FROM users;

-- 2) Подсчитываем, сколько дней рождений выпадает на каждый день недели
SELECT COUNT(*),
CASE
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 1 THEN "Sunday"
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 2 THEN "Monday"
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 3 THEN "Tuesday"
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 4 THEN "Wednesday"
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 5 THEN "Thursday"
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 6 THEN "Friday"
	WHEN DAYOFWEEK(CONCAT("2019-", SUBSTRING(birthday_at, 6, 5))) = 7 THEN "Saturday"
END AS `dayofweek`
FROM users GROUP BY `dayofweek`;
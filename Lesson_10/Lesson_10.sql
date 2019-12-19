-- 1. Проанализировать какие запросы могут выполняться наиболее часто в 
-- процессе работы приложения и добавить необходимые индексы.

CREATE INDEX communities_name_idx ON communities(name);

CREATE INDEX media_filename_idx ON media(filename);

CREATE INDEX messages_header_idx ON messages(header);

CREATE INDEX posts_header_idx ON posts(header);

CREATE INDEX profiles_hometown ON profiles(hometown);

CREATE INDEX users_first_name_idx ON users(first_name);

CREATE INDEX users_last_name_idx ON users(last_name);

CREATE INDEX users_email_idx ON users(email);

CREATE INDEX users_phone_idx ON users(phone);


-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый пожилой пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

SELECT DISTINCT communities.name AS group_name,
	COUNT(communities_users.user_id) OVER () / (SELECT COUNT(*) FROM communities) as `avg`,
	MIN(profiles.birthday) OVER w AS young,
	MAX(profiles.birthday) OVER w AS `old`,
	COUNT(communities_users.user_id) OVER w AS `count`,
	(SELECT COUNT(*) FROM users) AS total_users,
	COUNT(communities_users.user_id) OVER w / (SELECT COUNT(*) FROM users) * 100 AS "%%"
		FROM (communities 
			LEFT JOIN communities_users 
				ON communities.id = communities_users.community_id
			LEFT JOIN profiles
				ON communities_users.user_id = profiles.user_id
			LEFT JOIN users
				ON profiles.user_id = users.id)
		WINDOW w AS (PARTITION BY communities.id);

	-- Тут я немного запутался - нужно ли было выводить дату рождения самого полодого пользователя, или его имя (что у меня не получилось).
	-- Да и с некоторыми запросами обработка происходила не так, как ожидалось...
















-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные 
-- корректировки и/или улучшения (JOIN пока не применять).

-- Проанализировал, повторил. Корректировки пришлось вносить в свою БД, а не в запросы))


-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался 
-- с нашим пользователем.
-- Под формулировкой "больше всех общался" принимаем отправленные сообщения выбранному пользователю (выбрал id=39)

SELECT CONCAT(first_name, ' ', last_name) FROM users 
WHERE id = (SELECT from_user_id FROM messages WHERE to_user_id = 39 GROUP BY from_user_id ORDER BY COUNT(*) DESC LIMIT 1);
-- (TODO) Если будет одинаковое количество сообщений от разных пользователей, то выведется только один пользователь



-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT COUNT(*) AS total_likes FROM likes WHERE target_id IN (SELECT * FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS t);


-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
CASE (SELECT sex FROM likes, profiles WHERE likes.user_id = profiles.user_id GROUP BY sex ORDER BY COUNT(sex) DESC LIMIT 1)
	WHEN "f" THEN "Больше лайков поставили женщины"
	WHEN "m" THEN "Больше лайков поставили мужчины"
END;


-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании 
-- социальной сети.
-- За выражение активности принимаем отправленные сообщения, опубликованные посты и медиа, проставленные лайки

SELECT id, (msg_cnt + lks_cnt + mds_cnt + psts_cnt) AS activity FROM users, 
(SELECT COUNT(from_user_id) AS msg_cnt, from_user_id FROM messages GROUP BY from_user_id) AS msgs, 
(SELECT COUNT(user_id) AS lks_cnt, user_id FROM likes GROUP BY user_id) AS lks,
(SELECT COUNT(user_id) AS mds_cnt, user_id FROM media GROUP BY user_id) AS mds,
(SELECT COUNT(user_id) AS psts_cnt, user_id FROM posts GROUP BY user_id) AS psts
WHERE users.id = msgs.from_user_id AND users.id = lks.user_id AND users.id = mds.user_id AND users.id = psts.user_id ORDER BY activity LIMIT 10;


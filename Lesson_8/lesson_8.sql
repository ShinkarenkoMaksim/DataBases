-- Добавляем внешние ключи

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;
      
-- Немного приводим бд к целостности
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
UPDATE profiles SET photo_id = FLOOR(RAND()*150) WHERE 1;
UPDATE profiles SET photo_id = NULL WHERE photo_id NOT IN (SELECT id FROM media);


ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id)
    ON DELETE SET NULL;
    

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
   	ON DELETE SET NULL;
    

ALTER TABLE friendship
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT friendship_status_id_fk
  	FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
  	ON DELETE SET NULL;

   
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT likes_target_type_id_fk
  	FOREIGN KEY (target_type_id) REFERENCES target_types(id)
 	ON DELETE SET NULL;
  

ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT media_media_type_id_fk
  	FOREIGN KEY (media_type_id) REFERENCES media_types(id)
 	ON DELETE SET NULL;
  
  
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT messages_to_user_id_fk
  	FOREIGN KEY (to_user_id) REFERENCES users(id)
  	ON DELETE SET NULL,
  ADD CONSTRAINT messages_attached_media_id_fk 
    FOREIGN KEY (attached_media_id) REFERENCES media(id)
    ON DELETE SET NULL;


ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT posts_attached_media_id_fk 
    FOREIGN KEY (attached_media_id) REFERENCES media(id)
    ON DELETE SET NULL;
   
   
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT posts_attached_media_id_fk 
    FOREIGN KEY (attached_media_id) REFERENCES media(id)
    ON DELETE SET NULL;
   
   
ALTER TABLE user_privacy
  ADD CONSTRAINT user_privacy_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT user_privacy_section_id_fk 
    FOREIGN KEY (section_id) REFERENCES `section`(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT user_privacy_privacy_id_fk 
    FOREIGN KEY (privacy_id) REFERENCES privacy(id)
    ON DELETE SET NULL;
   
   
ALTER TABLE privacy_except_user
  ADD CONSTRAINT privacy_except_user_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT privacy_except_user_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT privacy_except_user_privacy_id_fk 
    FOREIGN KEY (privacy_id) REFERENCES privacy(id)
    ON DELETE SET NULL;
    
    
   
-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался 
-- с нашим пользователем.
-- Под формулировкой "больше всех общался" принимаем отправленные сообщения выбранному пользователю (выбрал id=39)


SELECT CONCAT(first_name, ' ', last_name)
	FROM users 
		JOIN friendship ON users.id = friendship.user_id OR users.id = friendship.friend_id
		JOIN messages ON messages.from_user_id = friendship.user_id OR messages.from_user_id = friendship.friend_id
	WHERE (friendship.user_id = 39 OR friendship.friend_id = 39) AND users.id != 39
	GROUP BY users.id
	ORDER BY COUNT(*) DESC LIMIT 1;
	
-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.


SELECT SUM(`count`) AS total_likes FROM (
	SELECT COUNT(likes.target_id) AS `count`
		FROM profiles
		LEFT JOIN likes
			ON profiles.user_id = likes.target_id AND target_type_id = 2
		GROUP BY profiles.user_id
		ORDER BY profiles.birthday DESC LIMIT 10) as A;

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
CASE (SELECT sex FROM likes JOIN profiles ON likes.user_id = profiles.user_id GROUP BY sex ORDER BY COUNT(sex) DESC LIMIT 1)
	WHEN "f" THEN "Больше лайков поставили женщины"
	WHEN "m" THEN "Больше лайков поставили мужчины"
END;




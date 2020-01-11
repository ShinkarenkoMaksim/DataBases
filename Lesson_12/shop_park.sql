-- База данных должна обеспечивать интернет-магазин электронной техники. Фильтрацию и поиск по запросам пользователей будет выполнять FTS, 
-- реляционная база используется для систематизированного хранения информации о товарах, пользователях, заказах, корзине. Также должны 
-- храниться избранные и сравниваемые товары пользователей. Предполагается постоянное обслуживание БД и сайта программистом. 
-- При добавлении заказа должны сохраняться цена на момент заказа товара. Должна иметься возможность использования других контактных данных,
-- отличных от данных в профиле. Характеристики товаров должны храниться струткурированно для упрощения управления ими, для фильтрации и 
-- поиска товара по ним используется FTS.



CREATE DATABASE park_shop;
USE park_shop;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	email VARCHAR(50) NOT NULL UNIQUE,
	phone INT(20) UNIQUE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	firstname VARCHAR(50),
	secondname VARCHAR(50),
	lastname VARCHAR(50),
	address TEXT,
	city VARCHAR(50)
);

CREATE TABLE brands (
	id SERIAL PRIMARY KEY,
	title VARCHAR(45) UNIQUE NOT NULL
);



CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(20) NOT NULL,
    discount INT(5)
);

UPDATE catalogs SET discount = 0 WHERE 1;


CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	brand_id BIGINT UNSIGNED,
	photos JSON,
	leftover INT(10),
	price INT(10),
	discount INT(5),
	catalog_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE attributes_list (
	id SERIAL PRIMARY KEY,
	title VARCHAR(50),
	attr_type VARCHAR(50)
);

 
CREATE TABLE product_attributes (
	product_id BIGINT UNSIGNED NOT NULL ,
	attribute_id BIGINT UNSIGNED NOT NULL ,
	value VARCHAR(45) NOT NULL,
	PRIMARY KEY (product_id, attribute_id)
);

CREATE TABLE shops (
	id SERIAL PRIMARY KEY,
	codename VARCHAR(50) NOT NULL,
	address TEXT NOT NULL,
	phone VARCHAR(20) NOT NULL,
	schedule VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	fullname VARCHAR(100),
	email VARCHAR(50),
	phone VARCHAR(20),
	shop_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE order_products (
	order_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	quantity INT(5),
	price INT(10),
	PRIMARY KEY (order_id, product_id)
);

CREATE TABLE basket (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	quantity INT(5),
	price INT(10),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE favorites (
	user_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, product_id)
);

CREATE TABLE compares (
	user_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, product_id)
);

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE ON UPDATE CASCADE;
     
     
ALTER TABLE products
  ADD CONSTRAINT products_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
      ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT products_brand_id_fk 
    FOREIGN KEY (brand_id) REFERENCES brands(id)
      ON DELETE RESTRICT ON UPDATE CASCADE;
     


ALTER TABLE product_attributes
  ADD CONSTRAINT product_attributes_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT product_attributes_attribute_id_fk 
    FOREIGN KEY (attribute_id) REFERENCES attributes_list(id)
      ON DELETE CASCADE ON UPDATE CASCADE;
     
     
     
ALTER TABLE orders
  ADD CONSTRAINT orders_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT orders_shop_id_fk 
    FOREIGN KEY (shop_id) REFERENCES shops(id)
      ON UPDATE CASCADE;
     
     
     
ALTER TABLE order_products
  ADD CONSTRAINT order_products_order_id_fk 
    FOREIGN KEY (order_id) REFERENCES orders(id)
      ON UPDATE CASCADE,
  ADD CONSTRAINT order_products_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON UPDATE CASCADE;
     
     
     
ALTER TABLE basket
  ADD CONSTRAINT basket_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT basket_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE ON UPDATE CASCADE;
     
     
ALTER TABLE favorites
  ADD CONSTRAINT favorites_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT favorites_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE ON UPDATE CASCADE;
     
ALTER TABLE compares
  ADD CONSTRAINT compares_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT compares_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE ON UPDATE CASCADE;
     
     
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('101', 'christiansen.reid@example.org', 2147483647, '2015-08-29 03:55:55');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('102', 'homenick.justyn@example.com', 134, '1980-05-10 23:55:59');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('103', 'sawayn.madie@example.org', 723867, '2006-03-26 09:21:24');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('104', 'klindgren@example.net', 0, '2006-12-30 17:02:07');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('106', 'neva.ondricka@example.com', 1, '2005-12-09 15:08:40');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('108', 'zdickinson@example.org', 842, '2001-04-17 22:05:29');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('109', 'crist.jayce@example.net', 296099, '1989-11-19 20:01:22');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('110', 'guadalupe.greenholt@example.org', 6, '2003-01-22 00:47:08');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('111', 'uhaley@example.com', 237, '1986-07-25 02:24:23');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('115', 'bednar.kari@example.net', 579441, '2006-06-13 10:04:55');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('117', 'devin.langworth@example.org', 977, '1997-07-13 07:11:56');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('118', 'torphy.therese@example.net', 722, '1996-09-22 22:41:55');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('119', 'abbott.dane@example.com', 2045171266, '2019-08-09 23:24:51');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('120', 'ansley49@example.net', 29, '1978-04-08 11:37:26');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('121', 'larissa.schaden@example.net', 684059, '1994-12-22 16:58:04');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('123', 'andre.blanda@example.org', 512044, '1998-09-29 15:47:49');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('124', 'sister84@example.com', 938930, '1980-08-03 18:16:20');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('125', 'alisa99@example.com', 421013, '2014-04-25 11:06:45');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('130', 'johnson.jaunita@example.com', 632338, '2012-07-06 06:18:28');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('132', 'kiana94@example.net', 569732, '1982-04-01 08:17:02');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('133', 'kailee20@example.org', 233948, '1979-04-15 04:13:07');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('135', 'mylene.ledner@example.org', 709501, '2009-11-14 21:54:08');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('139', 'kennedi.lehner@example.org', 38, '2006-12-05 00:47:31');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('140', 'julia.zemlak@example.org', 190, '1981-07-12 22:11:29');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('141', 'madisyn10@example.org', 178, '1993-10-28 19:11:26');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('142', 'kaycee10@example.com', 586, '1972-05-20 11:17:31');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('144', 'jaydon70@example.com', 7058, '1973-08-12 00:46:39');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('149', 'jorge73@example.net', 128957, '2017-03-14 05:15:33');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('150', 'letha43@example.org', 635, '2005-05-04 11:37:28');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('155', 'antonina.parker@example.org', 41, '2018-10-02 17:18:41');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('158', 'claude.monahan@example.net', 426075, '1970-11-07 12:06:19');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('159', 'lempi87@example.net', 161601, '1988-03-26 04:42:50');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('160', 'gusikowski.charlene@example.com', 528577, '2002-03-19 02:02:36');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('161', 'tpacocha@example.org', 598, '2001-11-01 19:45:48');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('162', 'lamar53@example.org', 224, '1977-04-07 09:29:36');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('164', 'schimmel.webster@example.net', 964, '2008-12-31 08:25:17');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('168', 'salma61@example.net', 1674206815, '1990-09-08 16:53:07');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('171', 'nhuel@example.com', 605405, '1980-04-14 09:18:01');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('173', 'ecrist@example.org', 695, '1971-01-29 09:16:13');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('180', 'cormier.zula@example.org', 934686, '2014-01-31 13:40:27');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('181', 'iframi@example.org', 889, '2011-01-15 11:29:06');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('185', 'gibson.haylee@example.net', 8, '2004-08-04 20:27:08');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('186', 'schaefer.ellis@example.org', 347, '1970-10-28 00:01:28');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('191', 'gorczany.dessie@example.com', 40, '1974-08-01 08:44:57');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES ('192', 'emmy.sauer@example.org', 570477, '1976-09-22 22:34:24');
     
     
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('101', 'Cecilia', 'eius', 'Reilly', '18705 Kaela Highway\nHermistonburgh, AL 50957-3117', 'South Rockyton');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('102', 'Nona', 'fugiat', 'Beier', '59142 Eve Highway Suite 946\nPort Emoryfort, IA 81371-5598', 'Hettingerstad');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('103', 'Markus', 'recusandae', 'Purdy', '008 Lou Corners\nKalebport, DE 06122-5417', 'North Jakobtown');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('104', 'Tyrell', 'suscipit', 'Hickle', '49536 Graciela Cape Suite 176\nAnnabelstad, CA 12607-6488', 'North Magnusview');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('106', 'Dexter', 'fugiat', 'Green', '7907 Carleton Glen Suite 971\nKylermouth, WV 49953', 'Stiedemannfurt');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('108', 'Erik', 'repellat', 'Lockman', '7204 Zita Well Suite 374\nMoenbury, NC 90689', 'Cassinmouth');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('109', 'Junius', 'ipsam', 'Kris', '304 Fadel Pass\nWest Dortha, WI 56207', 'New Marielle');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('110', 'Abigail', 'asperiores', 'Hand', '90196 Mante Estate\nNew Holden, NJ 20404', 'South Rigobertoport');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('111', 'Kyler', 'magni', 'Simonis', '2033 Jayce Fords Apt. 582\nGarryburgh, UT 83179', 'West Margarette');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('115', 'Clovis', 'temporibus', 'Swaniawski', '8800 Milan Dale Suite 169\nHaneland, MA 42694-1704', 'New Ardenshire');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('117', 'Buddy', 'vero', 'Kautzer', '80980 Lambert Pines Suite 448\nLake Mollie, KY 71171', 'West Maggiefort');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('118', 'Raven', 'et', 'Wilderman', '9520 Effie Meadows Suite 271\nNew Hunter, NM 58390-2934', 'Weissnatton');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('119', 'Jennie', 'rerum', 'Lowe', '59200 Dennis Island Suite 296\nPort Eliseoburgh, UT 06184-9392', 'Marianashire');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('120', 'Ebba', 'ut', 'Kutch', '75482 Parisian Lodge Suite 253\nFreedaport, DC 17357', 'New Ephraimside');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('121', 'Brody', 'dignissimos', 'Wuckert', '597 Boyer Junction Suite 216\nLake Theresia, WI 84175-9676', 'New Ahmedfort');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('123', 'Wanda', 'officiis', 'Anderson', '77092 Spinka Mills Apt. 255\nGrimesburgh, MT 29147-3275', 'Jazmynechester');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('124', 'Ocie', 'eos', 'Braun', '986 Bechtelar Mission\nPort Eleonore, WY 54552-6639', 'New Noebury');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('125', 'Freida', 'aut', 'Nicolas', '565 Feeney Locks\nTyriqueville, MA 44006-4655', 'North Jamieburgh');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('130', 'Jewel', 'eum', 'Nitzsche', '006 Beer Orchard Suite 889\nSouth Mabelville, DC 48659', 'South Lura');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('132', 'Alberta', 'quasi', 'Fadel', '17092 Thompson Wells Apt. 614\nWest Vita, VA 03542', 'Streichfurt');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('133', 'Dariana', 'non', 'Gislason', '560 Bauch Club Suite 715\nWest Kendall, NC 02355', 'Eileenfort');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('135', 'Alycia', 'animi', 'Mayert', '44978 O\'Connell Glen\nJadenfort, NH 39290-2133', 'Marionbury');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('139', 'Lyric', 'ut', 'Reilly', '554 Rachelle Trafficway\nGloverbury, SC 83035-3445', 'Danland');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('140', 'Susie', 'ea', 'Feest', '67113 Terrence Springs\nSouth Rollinbury, IN 09757', 'Paucekberg');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('141', 'Alison', 'cumque', 'Wiegand', '7105 Welch Drive\nPort Dorothy, MD 59405-0570', 'West Elliotfurt');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('142', 'Kattie', 'excepturi', 'Rowe', '1121 Katherine Keys\nPedroport, IA 83254', 'Lake Albertha');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('144', 'Javonte', 'sed', 'Moore', '753 Arnold Ridges\nPort Novellafort, ND 32860', 'Sawaynshire');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('149', 'Frederique', 'voluptas', 'Abbott', '351 Darren Walk Apt. 097\nNorth Brentbury, NY 34034', 'North Marciaton');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('150', 'Marta', 'labore', 'Swift', '176 Mitchel Wells Apt. 591\nEast Loismouth, LA 18248', 'Leraport');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('155', 'Jettie', 'quibusdam', 'D\'Amore', '2629 Hugh Mountains Suite 720\nPort Favianview, KY 31226', 'Raynorburgh');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('158', 'Lane', 'perferendis', 'Funk', '2644 Jana Divide Suite 334\nLake Madgefurt, NY 38335', 'Port Seth');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('159', 'Lorine', 'repellendus', 'Rice', '8492 Kuvalis Groves Apt. 296\nLednerchester, NM 79920', 'Rowanmouth');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('160', 'Elda', 'aut', 'Waelchi', '869 Deborah Estate\nWest Celestine, ME 33170-6414', 'Abigailland');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('161', 'Jaeden', 'quia', 'Walsh', '663 Rogahn Club Apt. 734\nOniemouth, WI 88514', 'New Dawsonfurt');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('162', 'Loyal', 'et', 'Kuhn', '37562 Hirthe Gateway\nEast Maefurt, SD 94083', 'Prohaskachester');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('164', 'Mortimer', 'quod', 'Rodriguez', '6710 Grimes Creek\nWest Dennisberg, MD 79519', 'North Josiane');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('168', 'Keagan', 'qui', 'Renner', '602 Gerald Branch Apt. 053\nNew Jazmynmouth, MI 72903', 'Russelfurt');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('171', 'Selena', 'nostrum', 'Goodwin', '02199 Goldner Dam\nRunolfssonview, HI 56056-0517', 'Keaganville');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('173', 'Maegan', 'quas', 'Miller', '8793 Kassulke Falls\nEast Bertha, OK 22147-4386', 'Evangelinestad');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('180', 'Antonina', 'non', 'Lueilwitz', '2098 Belle Road\nParkermouth, FL 50768', 'Huelview');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('181', 'Felicity', 'ducimus', 'Kunde', '4835 Anderson Underpass Suite 106\nEast Rosamond, PA 65590-6206', 'North Felipetown');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('185', 'Araceli', 'non', 'Gulgowski', '87129 Goyette Burgs\nDonnellton, DE 19624-2116', 'East Clintfort');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('186', 'Brody', 'sed', 'Steuber', '1992 Erdman Rapids\nPollichview, MO 78450', 'Port Wilburnton');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('191', 'Clemmie', 'qui', 'Walter', '3060 Mckayla Forks\nNew Lydia, AK 88865', 'East Shaniyabury');
INSERT INTO `profiles` (`user_id`, `firstname`, `secondname`, `lastname`, `address`, `city`) VALUES ('192', 'Nicolette', 'quasi', 'Aufderhar', '3971 Garfield Loop\nNorth Lisastad, NH 58753', 'South Daynafort');

     
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('1', 'bkat', '0836 Maximo Pine\nRippinstad, MI 98092-8525', '880-395-0279x529', '', '1997-12-29 00:02:03', '1979-06-23 05:54:38');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('2', 'ovay', '2811 Randy Rapids Apt. 912\nLangworthburgh, AK 65395', '1-013-587-2550', '', '2010-12-22 05:49:59', '1974-10-20 22:44:05');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('3', 'kism', '5127 Barrows Estate Apt. 729\nNikolausburgh, NM 39485-0830', '517-194-0546', '', '2006-05-07 11:12:10', '2012-07-14 11:13:39');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('4', 'volm', '173 Jacynthe Harbor Apt. 439\nLexiechester, CT 68372-6703', '899.638.6468x959', '', '1985-12-27 08:45:24', '1973-01-15 06:14:55');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('5', 'nqwv', '644 Dora Manors Apt. 208\nClairville, MO 80587-2914', '+59(4)0515097901', '', '2001-01-18 08:18:30', '2007-09-02 21:09:58');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('6', 'ktwg', '08313 Ashly View\nBalistreribury, KS 48170-8043', '(957)427-0902', '', '1995-04-12 07:25:30', '1977-10-30 05:51:07');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('7', 'tmwt', '447 Noemi Ports Suite 223\nNorth Rowena, AL 05295-8947', '1-174-012-8540x84114', '', '2002-06-21 10:32:57', '2000-12-29 13:19:24');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('8', 'hqlf', '73474 Rippin Cliffs\nSouth Jeffrymouth, NV 70749-7565', '09620375022', '', '2012-05-09 06:44:22', '2009-02-23 16:43:45');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('9', 'audb', '00782 Corkery Landing\nSchroedermouth, LA 30505', '326.241.8499', '', '2009-06-20 16:10:57', '1980-06-12 12:22:19');
INSERT INTO `shops` (`id`, `codename`, `address`, `phone`, `schedule`, `created_at`, `updated_at`) VALUES ('10', 'muwc', '934 Braxton Spurs\nLake Guy, NV 33819-9912', '898-041-6303', '', '2013-03-07 09:10:25', '1987-02-25 18:18:25');

     

INSERT INTO brands (title) VALUES ('Apple');
INSERT INTO brands (title) VALUES ('Samsung');
INSERT INTO brands (title) VALUES ('Xiaomi');
INSERT INTO brands (title) VALUES ('Huawei');
INSERT INTO brands (title) VALUES ('Meizu');
INSERT INTO brands (title) VALUES ('Sony');
INSERT INTO brands (title) VALUES ('ASUS');
INSERT INTO brands (title) VALUES ('BQ');
INSERT INTO brands (title) VALUES ('Prestigio');
INSERT INTO brands (title) VALUES ('Honor');
INSERT INTO brands (title) VALUES ('Realme');
INSERT INTO brands (title) VALUES ('Micromax');
INSERT INTO brands (title) VALUES ('Amazfit');
INSERT INTO brands (title) VALUES ('Canyon');
INSERT INTO brands (title) VALUES ('Nokia');
INSERT INTO brands (title) VALUES ('Alcatel');
INSERT INTO brands (title) VALUES ('Vertex');
INSERT INTO brands (title) VALUES ('Digma');



INSERT INTO catalogs (title) VALUES ('Смартфоны');
INSERT INTO catalogs (title) VALUES ('Смартчасы');
INSERT INTO catalogs (title) VALUES ('Телефоны');
INSERT INTO catalogs (title) VALUES ('Аксессуары');
INSERT INTO catalogs (title) VALUES ('Планшеты');
INSERT INTO catalogs (title) VALUES ('Ноутбуки');
INSERT INTO catalogs (title) VALUES ('Моноблоки');
INSERT INTO catalogs (title) VALUES ('Телевизоры');



INSERT INTO attributes_list (title, attr_type) VALUES ('Операционная система', 'Общие характеристики');
INSERT INTO attributes_list (title, attr_type) VALUES ('Версия ОС', 'Общие характеристики');
INSERT INTO attributes_list (title, attr_type) VALUES ('Диагональ', 'Экран');
INSERT INTO attributes_list (title, attr_type) VALUES ('Разрешение экрана', 'Экран');
INSERT INTO attributes_list (title, attr_type) VALUES ('Тип матрицы', 'Экран');
INSERT INTO attributes_list (title, attr_type) VALUES ('Диагональ', 'Экран');
INSERT INTO attributes_list (title, attr_type) VALUES ('Устойчивое к царапинам стекло', 'Экран');
INSERT INTO attributes_list (title, attr_type) VALUES ('Цвет', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Корпус', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Разъемы', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Высота ', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Ширина ', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Толщина ', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Вес ', 'Корпус');
INSERT INTO attributes_list (title, attr_type) VALUES ('Частота процессора', 'Процессор');
INSERT INTO attributes_list (title, attr_type) VALUES ('Количество ядер', 'Процессор');
INSERT INTO attributes_list (title, attr_type) VALUES ('Встроенная память', 'Память');
INSERT INTO attributes_list (title, attr_type) VALUES ('Оперативная память', 'Память');
INSERT INTO attributes_list (title, attr_type) VALUES ('Карта памяти', 'Память');
INSERT INTO attributes_list (title, attr_type) VALUES ('Поддержка карт памяти', 'Память');
INSERT INTO attributes_list (title, attr_type) VALUES ('Wi-Fi', 'Связь');
INSERT INTO attributes_list (title, attr_type) VALUES ('Bluetooth', 'Связь');
INSERT INTO attributes_list (title, attr_type) VALUES ('NFC', 'Связь');
INSERT INTO attributes_list (title, attr_type) VALUES ('Мобильная связь', 'Связь');
INSERT INTO attributes_list (title, attr_type) VALUES ('Камера основная Mpx', 'Камера');
INSERT INTO attributes_list (title, attr_type) VALUES ('Камера фронтальная Mpx', 'Камера');
INSERT INTO attributes_list (title, attr_type) VALUES ('Функции камеры', 'Камера');
INSERT INTO attributes_list (title, attr_type) VALUES ('Емкость аккумулятора mAh', 'Аккумулятор');
INSERT INTO attributes_list (title, attr_type) VALUES ('Время в режиме пользования', 'Аккумулятор');
INSERT INTO attributes_list (title, attr_type) VALUES ('Время в режиме ожидания', 'Аккумулятор');
INSERT INTO attributes_list (title, attr_type) VALUES ('Процессор', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Видеокарта', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Количество SIM-карт', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Функции', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Сканер отпечатка пальца', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Цвета браслета/ремешка', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Поддержка mp3', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Мощность звука Вт', 'Прочие');
INSERT INTO attributes_list (title, attr_type) VALUES ('Для пожилых людей', 'SEO');



INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 7 32Gb Black', '1', '5', '29990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 7 32Gb Rose Gold', '1', '5', '29990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 7 32Gb Gold', '1', '5', '29990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 7 128Gb Rose Gold', '1', '5', '34490', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 8 64Gb Space Grey', '1', '5', '36990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 8 64Gb Gold', '1', '5', '36990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Apple iPhone 7 256Gb Silver', '1', '5', '39990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPhone 8 Plus 64Gb Space Gray', '1', '5', '44190', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy A30S 64GB (2019) [SM-A307] White', '2', '5', '15990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy A30S 64GB (2019) [SM-A307] Violet', '2', '5', '15990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Note 9 N960 512GB Brown', '2', '5', '91590', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy N975 Note 10+ Black', '2', '5', '89990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Redmi Note 7 4/64GB Black', '3', '5', '13990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Redmi Note 8 4/64Gb Black', '3', '5', '15490', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('RedMi Note 7 4/128Gb Blue', '3', '5', '16990', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Redmi Note 8 Pro 6/128Gb Gray', '3', '5', '19490', '0', '1');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Watch Nike+ S3 38mm Space Gray/ Black', '1', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Watch Nike+ S3 42mm [MQL42] Space Gray/Black', '1', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Watch Sport S4 44mm [MU6C2] Silver/White', '1', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Watch Active R500 Rose Gold', '2', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Watch Active R500 Black', '2', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Watch Active R500 Gray', '2', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Mijia Quartz Watch Gray', '3', '5', '29990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Mijia Quartz Watch Black', '3', '5', '4990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Mijia Quartz Watch White', '3', '5', '4990', '0', '2');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPad 32Gb Wi-Fi + Cellular Silver', '1', '5', '29690', '0', '5');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPad 10.2 Wi-Fi 128Gb (2019) [MW772] Space Gray', '1', '5', '34990', '0', '5');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iPad (2018) 32Gb Wi-Fi Silver', '1', '5', '24890', '0', '5');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Tab S3 9,7" T820 32Gb Silver', '2', '5', '32990', '0', '5');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Tab S5e 10.5 SM-T725 64Gb Black', '2', '0', '36490', '0', '5');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Galaxy Tab S6 10.5 128Gb (2019) [SM-T860] BlueBlue', '2', '0', '52990', '0', '5');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('MacBook Air 13" 128Gb (2017) [MQD32] Silver', '1', '5', '61990', '0', '6');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('MacBook Pro 13" 128Gb (2019) Touch Bar [MUHN2] Space Gray', '1', '5', '109990', '0', '6');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('MacBook Pro 13" 256GB (2019) Touch Bar [MUHP2] Space Gray', '1', '5', '125990', '0', '6');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iMac 21.5" Retina 4K (2019) [MRT32]', '1', '5', '99990', '0', '7');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iMac 21.5" Retina 4K (2019) [MRT42]', '1', '5', '121990', '0', '7');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('iMac 27" Retina 5K (2017) [MNE92]', '1', '5', '146990', '0', '7');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('UE50NU7002UXRU', '2', '5', '34990', '0', '8');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('UE43RU7400UXRU', '2', '5', '39190', '0', '8');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('UE55RU7140UXRU', '2', '5', '44990', '0', '8');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('UE55NU7140UXRU', '2', '5', '54990', '0', '8');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('UE55RU8000UXRU', '2', '5', '68990', '0', '8');
INSERT INTO products (title, brand_id, leftover, price, discount, catalog_id) VALUES ('Mi LED TV 32 4A', '3', '5', '12990', '0', '8');


INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '8', 'черный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '17', '32 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '34', 'стерео звук / GPS / ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('1', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '8', 'розовое золото');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '17', '32 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '34', 'стерео звук / GPS ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('2', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '8', 'золотой');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '17', '32 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '34', 'стерео звук / GPS ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('3', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '8', 'черный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '17', '32 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '34', 'стерео звук / G');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('4', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '8', 'розовое золото');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '17', '32 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '34', 'стерео звук / GPS / ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('5', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '8', 'золотой');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '17', '32 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '34', 'стерео звук / GPS / A-GP');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('6', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '8', 'розовое золото');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '17', '128 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '24', 'LTE / 3G / ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '34', 'стерео звук / GPS / A-GPS / г');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('7', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '2', 'iOS 11');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '8', 'серый');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '9', 'стекло / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '11', '138.4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '12', '67.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '13', '7.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '14', '148');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '15', 'A11 Bionic с 64-битной архитектурой');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '16', '6');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '17', '64 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '18', '3 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '27', 'автофокус / HD видео / последовательные фото / вспышка');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '28', '1821');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '29', '12 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '34', 'GPS / A-GPS / г');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('8', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '2', 'iOS 11');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '8', 'золотой');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '9', 'стекло / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '11', '138.4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '12', '67.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '13', '7.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '14', '148');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '15', 'A11 Bionic с 64-битной архитектурой');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '16', '6');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '17', '64 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '18', '3 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '27', 'автофокус / HD видео / ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '28', '1821');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '29', '12 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '34', 'GPS / A-GPS / глонасся');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('9', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '2', 'iOS 10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '3', '4.5"- 4.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '4', '1334 x 750');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '6', '4.7"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '8', 'розовое золото');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '9', 'металл / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '11', '138.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '12', '67.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '13', '7.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '14', '138');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '15', '2.34');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '16', '4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '17', '256 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '18', '2 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '25', '12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '28', '1960');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '34', 'с / барометр к приближения');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('10', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '1', 'Apple iOS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '2', 'iOS 11');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '3', '5.5"- 5.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '4', '1920 x 1080');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '5', 'IPS');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '6', '5.5"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '8', 'серый');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '9', 'стекло / влагозащитный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '10', 'Lightning');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '11', '158,4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '12', '78,1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '13', '7,5');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '14', '202');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '15', 'A11 Bionic с 64-битной архитектурой');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '16', '6');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '17', '64 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '18', '3 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '20', 'Нет');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '21', 'Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '22', 'Bluetooth 4.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '25', '12 + 12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '26', '7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '27', 'Автофокус');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '28', '2675');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '29', '15 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '30', '10 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '31', 'Apple Bionic');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '33', '1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '34', 'GPS / Aения');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('11', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '1', 'Android');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '2', 'Android 9.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '3', '5.5"- 5.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '4', '1560 x 720');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '5', 'AMOLED');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '6', '6.4"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '7', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '8', 'белый');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '9', 'классический / пластик');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '10', '3.5 мм аудио / USB Type-C');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '11', '158,5');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '12', '74,7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '13', '7,8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '14', '169');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '15', '1800');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '16', '8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '17', '64 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '18', '4 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '19', 'до 512 Гб Micro SD');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '20', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '21', 'Wi-Fi 802.11n / Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '22', 'Bluetooth 5.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '23', 'отсутствует');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '25', '25+5+8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '26', '16');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '27', 'автофокус / HD видео / ночной режим / вспышка');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '28', '4000');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '29', '12 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '30', '5 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '33', '2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '34', 'FM-радио/ гироскоп / компас / микрофон');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('12', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '1', 'Android');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '2', 'Android 9.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '3', '5.5"- 5.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '4', '1560 x 720');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '5', 'AMOLED');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '6', '6.4"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '7', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '8', 'фиолетовый');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '9', 'классический / пластик');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '10', '3.5 мм аудио / USB Type-C');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '11', '158,5');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '12', '74,7');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '13', '7,8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '14', '169');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '15', '1800');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '16', '8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '17', '64 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '18', '4 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '19', 'до 512 Гб Micro SD');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '20', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '21', 'Wi-Fi 802.11n / Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '22', 'Bluetooth 5.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '23', 'отсутствует');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '25', '25+5+8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '26', '16');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '27', 'автофокус / HD видео / ночной режим / вспышка');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '28', '4000');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '29', '12 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '30', '5 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '33', '2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '34', 'FM-радисти / гироскоп / компас / микрофон');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('13', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '1', 'Android');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '2', 'Android 8.1');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '3', '6.0"- 6.4"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '4', '2960 x 1440');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '5', 'AMOLED');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '6', '6.4"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '7', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '8', 'коричневый');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '9', 'классический / металл / стекло');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '10', '3.5 мм аудио / Thunderbolt 3 (USB-C)');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '11', '161.9');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '12', '76.4');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '13', '8.8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '14', '201');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '15', '2700');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '16', '8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '17', '512 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '18', '8 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '19', 'до 512 Гб Micro SD');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '20', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '21', 'Wi-Fi 802.11ac / WiFi Direct');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '22', 'Bluetooth 5.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '25', 'двойная 12/12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '26', '8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '27', 'автофокус / вспышка');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '28', '4000');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '29', '8 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '30', '5 дней');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '31', 'Samsung Exynos');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '33', '2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '34', 'FM-радиоти / гироскоп / компас / микрофон');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('14', '35', 'Есть');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '1', 'Android');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '2', 'Android 9.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '3', '5.5"- 5.9"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '5', 'AMOLED / Super AMOLED');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '6', '6.8"');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '7', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '8', 'черный');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '9', 'классический');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '10', 'USB Type-C');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '11', '162.3');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '12', '77.2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '13', '7.9');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '14', '196');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '15', '2730');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '16', '8');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '17', '256 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '18', '12 Гб');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '19', 'до 512 Гб Micro SD');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '20', 'Да');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '21', 'Wi-Fi 802.11n / Wi-Fi 802.11ac');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '22', 'Bluetooth 5.0');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '23', 'есть NFC');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '24', 'LTE / 3G / 4G / GSM1800 / GSM1900 / GSM900');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '25', '16+12+12');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '26', '10');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '27', 'автофокус / вспышка');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '28', '4300');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '29', '6 часов');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '30', '2 дня');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '31', 'Samsung Exynos');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '33', '2');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '34', 'глонасс / фонарик ');
INSERT INTO product_attributes (product_id, attribute_id, value) VALUES ('15', '35', 'Есть');


INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('101', '1');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('101', '3');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('101', '5');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('102', '2');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('102', '4');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('102', '6');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('103', '3');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('103', '5');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('103', '7');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('104', '4');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('104', '6');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('104', '8');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('106', '5');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('106', '7');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('106', '9');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('108', '6');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('108', '8');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('108', '10');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('109', '7');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('109', '9');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('109', '11');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('110', '8');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('110', '10');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('110', '12');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('111', '9');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('111', '11');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('111', '13');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('115', '10');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('115', '12');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('115', '14');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('117', '11');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('117', '13');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('118', '12');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('118', '14');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('119', '13');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('119', '15');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('120', '14');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('120', '16');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('121', '15');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('121', '17');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('123', '16');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('123', '18');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('124', '17');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('124', '19');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('125', '18');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('125', '20');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('130', '19');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('130', '21');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('132', '20');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('132', '22');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('133', '21');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('133', '23');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('135', '22');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('135', '24');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('139', '23');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('139', '25');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('140', '24');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('140', '26');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('141', '25');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('141', '27');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('142', '26');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('142', '28');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('144', '27');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('144', '29');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('149', '28');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('149', '30');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('150', '29');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('150', '31');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('155', '30');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('155', '32');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('158', '31');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('158', '33');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('159', '32');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('159', '34');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('160', '33');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('160', '35');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('161', '34');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('161', '36');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('162', '35');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('162', '37');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('164', '36');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('164', '38');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('168', '37');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('168', '39');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('171', '38');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('171', '40');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('173', '39');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('173', '41');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('180', '40');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('180', '42');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('181', '41');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('181', '43');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('185', '1');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('185', '42');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('186', '2');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('186', '43');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('191', '1');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('191', '3');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('192', '2');
INSERT INTO `favorites` (`user_id`, `product_id`) VALUES ('192', '4');

INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('101', '1');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('101', '3');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('101', '5');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('102', '2');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('102', '4');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('102', '6');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('103', '3');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('103', '5');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('103', '7');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('104', '4');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('104', '6');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('104', '8');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('106', '5');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('106', '7');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('106', '9');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('108', '6');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('108', '8');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('108', '10');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('109', '7');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('109', '9');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('109', '11');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('110', '8');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('110', '10');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('110', '12');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('111', '9');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('111', '11');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('111', '13');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('115', '10');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('115', '12');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('115', '14');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('117', '11');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('117', '13');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('118', '12');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('118', '14');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('119', '13');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('119', '15');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('120', '14');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('120', '16');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('121', '15');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('121', '17');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('123', '16');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('123', '18');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('124', '17');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('124', '19');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('125', '18');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('125', '20');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('130', '19');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('130', '21');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('132', '20');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('132', '22');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('133', '21');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('133', '23');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('135', '22');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('135', '24');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('139', '23');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('139', '25');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('140', '24');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('140', '26');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('141', '25');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('141', '27');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('142', '26');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('142', '28');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('144', '27');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('144', '29');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('149', '28');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('149', '30');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('150', '29');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('150', '31');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('155', '30');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('155', '32');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('158', '31');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('158', '33');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('159', '32');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('159', '34');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('160', '33');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('160', '35');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('161', '34');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('161', '36');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('162', '35');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('162', '37');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('164', '36');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('164', '38');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('168', '37');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('168', '39');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('171', '38');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('171', '40');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('173', '39');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('173', '41');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('180', '40');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('180', '42');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('181', '41');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('181', '43');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('185', '1');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('185', '42');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('186', '2');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('186', '43');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('191', '1');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('191', '3');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('192', '2');
INSERT INTO `compares` (`user_id`, `product_id`) VALUES ('192', '4');



INSERT INTO `orders` VALUES ('1','101','Prof. Diana Roob','funk.godfrey@example.org','(690)326-8152x1409','1','1988-07-28 21:27:04','1988-06-01 05:06:50'),
('2','102','Lizzie Jacobs','rschaden@example.com','303-504-9108x7399','2','1988-09-20 12:28:42','2002-12-16 05:01:02'),
('3','103','Nova Swift','elwyn20@example.org','1-081-233-1023x5819','3','1985-02-02 12:29:30','2019-08-09 04:54:59'),
('4','104','Mrs. Cydney Marks','jerad.roob@example.net','(440)911-2320','4','2019-11-21 12:29:15','2018-11-06 07:30:27'),
('5','106','Colt Kiehn','erdman.haleigh@example.com','04903630210','5','1975-05-23 06:53:16','1977-04-27 14:31:06'),
('6','108','Prof. Kale Runte Jr.','osvaldo45@example.org','(498)701-4197','6','1974-02-17 17:47:50','2016-11-07 06:03:01'),
('7','109','Maureen Harber PhD','jvon@example.org','201.459.7919','7','1979-04-10 09:01:14','1985-06-05 23:01:37'),
('8','110','Vernie Brakus','harmstrong@example.com','216.798.4895','8','1994-07-30 01:51:13','2000-01-25 02:39:39'),
('9','111','Fred Koss','rolfson.omari@example.net','1-260-283-7477','9','2005-08-05 23:47:36','2009-07-23 13:26:43'),
('10','115','Bridget Schultz','elna.veum@example.org','956.885.6613x0763','10','2000-08-15 03:43:15','1989-11-17 04:50:27'),
('11','117','Orpha Ebert','roberts.lafayette@example.net','09250377250','1','1997-09-21 06:00:30','2018-09-13 17:06:18'),
('12','118','Leonora Feil','delores60@example.com','256.967.0861x596','2','2014-11-12 23:44:40','1982-01-24 10:12:28'),
('13','119','Mrs. Freida Durgan I','qkiehn@example.org','182-283-1709','3','2011-10-03 04:42:59','1980-04-17 15:08:58'),
('14','120','Carter Nader','prosacco.kasandra@example.com','495.053.7140x6811','4','2009-08-01 21:03:09','1984-10-06 12:28:49'),
('15','121','Greta Williamson','bayer.rashawn@example.com','00243126437','5','2011-01-21 09:54:15','1975-01-12 01:45:13'),
('16','123','Rogelio Barton','asa30@example.org','+85(8)2680597722','6','1991-07-29 00:18:41','1984-09-16 14:55:02'),
('17','124','Sasha Koepp IV','fcorwin@example.net','1-586-345-8399','7','1997-04-06 06:44:12','2004-06-13 21:58:01'),
('18','125','Miss Katlyn Dietrich Sr.','ewalsh@example.org','1-866-310-6211x42978','8','1972-04-07 09:25:08','2004-08-13 17:40:59'),
('19','130','Marcelle Schmitt','hickle.rahsaan@example.org','898-465-7055','9','1977-03-22 09:13:37','1993-07-08 23:24:17'),
('20','132','Marion Cummings','hermann.aleen@example.net','1-352-345-6623x4450','10','2006-12-11 05:33:48','2002-06-24 15:26:13'),
('21','133','Eryn Braun','miguel20@example.net','796-526-0079','1','1987-01-03 13:10:52','2005-05-04 08:02:52'),
('22','135','Prof. Paul White DDS','chauck@example.org','868-451-6244x7785','2','1999-06-28 18:50:37','1970-09-22 22:21:28'),
('23','139','Ryan Bogisich','cesar.ledner@example.net','224.272.5909','3','1992-07-03 18:08:08','1973-05-05 23:35:58'),
('24','140','Mr. Dudley Yost I','lebsack.ezekiel@example.org','1-210-970-4495x75345','4','1973-03-12 04:13:15','1988-03-20 22:03:19'),
('25','141','Sanford Wyman','herman.julio@example.com','740-484-7457x950','5','2002-09-18 17:22:27','2018-09-16 18:50:53'),
('26','142','Dr. Mazie Harvey PhD','lockman.maude@example.org','(301)094-1835','6','1974-04-29 14:56:49','1996-10-17 08:03:08'),
('27','144','Mr. Gene Padberg','lubowitz.harold@example.net','02187277981','7','1998-11-16 19:51:46','2004-09-24 01:04:06'),
('28','149','Jeremie Wiza','nikki23@example.org','(777)422-9796','8','1980-09-23 12:11:14','1990-06-29 06:02:59'),
('29','150','Jaiden Kirlin','ybashirian@example.net','332-168-5506x89227','9','2010-09-02 16:46:05','2019-02-07 21:19:49'),
('30','155','Joesph Roob','ublick@example.com','859-541-1284','10','1976-03-23 18:26:04','1975-09-18 18:37:02'),
('31','158','Paula Rodriguez','zieme.price@example.com','296.757.8010','1','2010-03-11 11:53:56','1982-11-16 02:43:57'),
('32','159','Mr. Elton Schoen II','madaline68@example.com','(865)969-4940x502','2','1988-06-25 11:21:49','2001-12-05 12:54:38'),
('33','160','Dr. Stuart Reinger DVM','edyth.dickens@example.org','(043)408-1684x127','3','1971-12-31 13:04:07','2007-09-10 12:34:45'),
('34','161','Zachariah Flatley','jbotsford@example.com','884-922-5118x8468','4','2013-03-26 02:41:06','1998-07-08 06:20:39'),
('35','162','Ray Hahn DDS','feest.dortha@example.net','1-399-147-9799x01982','5','1976-09-12 19:02:20','1970-04-03 07:44:15'),
('36','164','Jaida Oberbrunner','hilpert.dusty@example.net','+69(1)6421265673','6','1973-11-27 07:47:11','1974-03-15 02:17:41'),
('37','168','Angie Schuster','raltenwerth@example.net','1-710-138-8711','7','2005-03-02 15:01:54','2009-10-05 03:50:45'),
('38','171','Lyda Walter','kellie.fahey@example.com','292.091.6838x5830','8','1979-08-24 17:25:45','2008-06-04 01:12:02'),
('39','173','Guadalupe Quigley','aric59@example.net','1-253-285-3399x333','9','1988-11-11 15:38:38','2012-10-03 16:11:31'),
('40','180','Colten Casper','rosalee.kling@example.com','771.289.2627x607','10','1972-09-15 21:34:19','1977-08-12 17:41:36'),
('41','181','Calista Goyette I','labadie.micheal@example.com','(207)313-3171','1','1992-04-14 05:24:37','1996-02-17 07:17:44'),
('42','185','Prof. Tess Rau Jr.','presley53@example.org','1-964-459-3254x691','2','1986-08-11 11:11:18','1988-01-18 16:36:11'),
('43','186','Vesta Runolfsdottir','uquigley@example.net','(557)863-8765x9879','3','2013-09-27 18:24:51','2014-07-06 03:35:00'),
('44','191','Johnathon Reinger','destiney.adams@example.org','641-371-9005','4','1978-04-25 01:23:54','1981-11-03 12:56:52'),
('45','192','Mr. Alberto Rosenbaum Jr.','vlehner@example.net','(115)432-7548','5','1984-11-29 19:49:37','1993-04-02 06:19:26'),
('46','101','Carlie Donnelly','blubowitz@example.org','+78(6)1485515012','6','1979-08-25 20:10:48','1991-11-08 11:18:57'),
('47','102','Prof. Wilmer Kihn MD','anissa76@example.net','1-615-017-9487','7','2017-03-02 22:10:08','2018-01-26 01:25:37'),
('48','103','Bill Watsica','janick73@example.net','075-883-6194','8','2009-12-08 20:17:29','1974-01-12 08:25:13'),
('49','104','Dillon Ziemann','pearline12@example.net','+35(6)4229251188','9','2016-05-22 11:01:22','1980-03-12 03:39:33'),
('50','106','Zelma Grady','maryse.beer@example.net','03972641247','10','2015-02-25 18:56:12','2002-02-23 15:30:59'),
('51','108','Muhammad Lowe','co\'kon@example.net','676-099-4656x900','1','2002-12-08 02:43:24','2005-01-19 20:52:54'),
('52','109','Uriel Stokes','ignatius58@example.net','1-049-878-7205x2980','2','2008-10-26 12:25:14','1997-08-01 17:22:41'),
('53','110','Franz Larkin II','april53@example.net','260-150-9166','3','1995-02-10 14:56:54','2004-04-28 12:10:24'),
('54','111','Shanelle Haley III','keebler.maude@example.org','272-083-9983','4','2010-06-04 13:52:15','1994-09-13 02:57:13'),
('55','115','Candido Mosciski','armando.goodwin@example.com','629-414-9537','5','1988-11-18 10:38:15','2010-07-19 10:02:43'),
('56','117','Faustino Oberbrunner','burnice13@example.net','944-791-5586x5458','6','1986-05-19 19:52:34','1998-12-12 02:31:03'),
('57','118','Aurore Beer','schulist.brown@example.org','+28(0)1842384215','7','1982-12-27 09:18:40','1975-04-27 18:27:05'),
('58','119','Ezra McClure','bailey.drake@example.net','813-407-5688x99899','8','2006-12-27 20:05:17','1994-09-25 03:50:01'),
('59','120','Prof. Coralie Strosin','breana.nicolas@example.net','00948503838','9','2016-07-09 17:57:36','1973-05-25 04:27:59'),
('60','121','Nathan Johnson','emmy25@example.com','+46(7)8758816330','10','2015-02-12 05:59:44','1976-04-28 16:54:03'),
('61','123','Dorian Cummerata','shyann.spencer@example.net','1-677-479-2882','1','1992-08-02 14:53:35','2006-06-01 15:10:22'),
('62','124','Vincenza Gaylord','kacie13@example.org','1-287-863-2171x727','2','1978-09-10 08:51:46','2012-05-08 14:39:51'),
('63','125','Mrs. Mary Fadel','nhoeger@example.net','1-293-021-1202','3','2019-05-21 00:51:04','1979-05-11 15:02:36'),
('64','130','Magdalena Fay','llewellyn.reichert@example.com','04613572241','4','1991-05-24 15:40:00','2008-04-21 02:23:58'),
('65','132','Prof. Jacey Bode MD','monserrate.schuster@example.net','1-745-856-9147x208','5','1992-06-04 12:19:16','1978-06-12 03:32:45'),
('66','133','Rebecca Bode','mafalda66@example.net','(479)137-0026x673','6','2004-09-27 16:38:02','1991-07-29 00:26:15'),
('67','135','Dr. Sasha Armstrong','keaton87@example.org','517-319-0231x96118','7','1995-06-21 10:17:42','2019-04-08 09:52:07'),
('68','139','Anita Leannon PhD','xconnelly@example.org','744.814.4599','8','1996-02-24 05:17:13','1997-01-19 03:44:45'),
('69','140','Dr. Enrico Hudson III','damian.mante@example.net','1-697-897-0114x44828','9','2018-03-21 06:05:45','2007-12-30 15:54:01'),
('70','141','Gregoria Rodriguez','oheaney@example.com','790.143.4902x61031','10','1970-10-27 12:20:27','1985-12-22 23:16:06'),
('71','142','Adolphus Emard','amelia52@example.org','330.518.2351x3302','1','1996-10-04 11:22:32','2006-03-25 08:11:20'),
('72','144','Clinton Harvey','pacocha.nya@example.org','1-275-560-6256x5534','2','1981-04-12 06:48:03','1993-11-29 12:59:26'),
('73','149','Eliseo Wunsch','swolf@example.net','743-883-7112','3','2006-07-27 05:55:40','1998-02-18 23:19:09'),
('74','150','Kasandra Champlin','tromp.adonis@example.org','187.847.7880x25595','4','2010-02-26 22:54:00','1998-06-18 07:43:23'),
('75','155','Alexzander Davis','doyle.jamil@example.com','03012867204','5','2008-09-26 20:58:19','1980-05-11 17:41:47'),
('76','158','Reina Jacobson','olen.corkery@example.net','775.382.0850x291','6','2013-04-24 05:57:24','1985-06-12 12:42:18'),
('77','159','Magnus Wiegand','buster51@example.com','1-235-201-5786x78991','7','1994-03-22 11:06:28','2015-02-02 13:14:53'),
('78','160','Jaiden Waelchi','ortiz.jameson@example.com','(993)465-7703','8','1977-04-08 09:50:01','2016-11-16 07:11:05'),
('79','161','Mrs. Kendra Quitzon','hermann.annalise@example.net','(982)721-3985','9','1993-06-07 01:59:00','1977-09-11 13:45:42'),
('80','162','Keyshawn Hills','zbrown@example.net','1-874-042-2336x96899','10','2017-03-10 00:18:57','1994-09-19 16:59:27'),
('81','164','Hollie Casper II','elisabeth02@example.org','054-327-9183x74309','1','2005-07-02 11:53:08','2001-02-07 05:14:57'),
('82','168','Bulah Carroll','eliane.altenwerth@example.org','(404)902-3424','2','2015-01-23 11:04:41','2007-09-25 22:06:10'),
('83','171','Jody Bogan','mmosciski@example.org','045.397.2115x3325','3','1994-05-25 00:58:22','1993-12-13 11:51:42'),
('84','173','Dr. Claudie O\'Kon II','pearline.collins@example.com','(107)181-3655','4','1977-12-01 16:50:36','2008-05-11 02:20:27'),
('85','180','Miss Leda Kihn','armstrong.barney@example.com','01398289760','5','1992-08-03 19:53:06','1988-03-01 02:56:01'),
('86','181','Dr. Maverick Rice II','maynard.simonis@example.net','704.459.6188x8869','6','1972-08-06 17:37:51','2014-06-20 08:49:07'),
('87','185','Gwendolyn Turner','orion.pollich@example.net','06045880762','7','2018-08-14 05:33:45','1981-04-04 05:18:46'),
('88','186','Austyn Terry II','autumn31@example.net','06249022958','8','2001-10-31 08:19:49','1993-06-20 11:39:51'),
('89','191','Lonnie Sauer','ghegmann@example.org','332-495-4140x0584','9','1987-01-24 16:42:25','1991-10-27 21:06:09'),
('90','192','Santina Crist','ibeahan@example.org','906-267-2757','10','2017-02-19 15:48:42','2003-03-12 13:43:49'),
('91','101','Prof. Demond Bruen','briana.gorczany@example.org','1-248-503-2865','1','2013-10-20 09:56:34','1996-11-18 11:34:54'),
('92','102','Conner Kunze','schulist.alfreda@example.net','770.112.1276','2','1993-07-06 16:33:13','1998-10-22 13:37:10'),
('93','103','Ollie Hoppe DDS','rbergnaum@example.org','(020)636-2438','3','1980-07-30 17:40:20','1989-08-22 14:25:15'),
('94','104','Dr. Eli Klocko Jr.','dalton.jenkins@example.net','1-848-512-6271x384','4','2018-08-10 00:20:42','1984-03-16 06:01:38'),
('95','106','Mrs. Krystal Schultz I','darrick.borer@example.com','(286)523-2131x75751','5','2016-04-02 07:50:59','1980-05-05 16:08:25'),
('96','108','Kavon Denesik','everette.mckenzie@example.com','(462)353-5232x62789','6','1996-07-20 11:04:28','2016-07-07 07:32:02'),
('97','109','Mr. Patrick Wolff','zchristiansen@example.net','251.504.7135x18201','7','1996-04-08 10:19:08','1979-08-30 10:23:20'),
('98','110','Dr. Hailey Donnelly Sr.','kohler.charlotte@example.com','364-257-6246x8442','8','1990-06-24 08:50:17','2015-06-09 12:34:10'),
('99','111','Amiya Kutch','altenwerth.betty@example.net','438-226-3150x6286','9','1987-06-07 07:43:34','1981-02-21 09:31:07'),
('100','115','Maybelle Ondricka','russell.howe@example.org','01771898564','10','2015-04-18 22:03:54','1978-04-19 01:23:23'); 


INSERT INTO `order_products` VALUES ('1','1','2','28425'),
('1','15','5','20612'),
('2','2','2','30753'),
('2','16','3','45744'),
('3','3','3','16762'),
('3','17','5','88040'),
('4','4','3','22985'),
('4','18','5','86180'),
('5','5','3','47465'),
('5','19','1','47992'),
('6','6','5','43679'),
('6','20','4','70550'),
('7','7','2','60955'),
('7','21','5','33338'),
('8','8','3','70974'),
('8','22','3','93819'),
('9','9','2','60603'),
('9','23','1','37832'),
('10','10','5','18579'),
('10','24','4','57243'),
('11','11','2','55122'),
('11','25','4','59852'),
('12','12','3','15666'),
('12','26','3','82769'),
('13','13','2','23964'),
('13','27','4','92953'),
('14','14','3','52278'),
('14','28','3','38230'),
('15','15','3','49163'),
('15','29','1','88539'),
('16','16','2','52876'),
('16','30','1','75890'),
('17','17','4','96552'),
('17','31','5','36392'),
('18','18','4','49851'),
('18','32','4','73584'),
('19','19','3','47435'),
('19','33','4','25007'),
('20','20','4','65818'),
('20','34','1','63957'),
('21','21','2','57833'),
('21','35','4','49726'),
('22','22','5','15141'),
('22','36','4','71271'),
('23','23','3','27383'),
('23','37','3','97193'),
('24','24','2','26711'),
('24','38','2','66618'),
('25','25','3','66286'),
('25','39','4','42629'),
('26','26','3','75239'),
('26','40','3','29945'),
('27','27','1','26519'),
('27','41','1','38652'),
('28','28','1','20706'),
('28','42','2','91362'),
('29','29','1','19725'),
('29','43','3','30705'),
('30','1','3','83422'),
('30','30','4','77454'),
('31','2','5','28252'),
('31','31','2','27753'),
('32','3','2','54862'),
('32','32','5','21036'),
('33','4','2','19983'),
('33','33','1','27198'),
('34','5','5','84657'),
('34','34','3','42476'),
('35','6','1','76026'),
('35','35','3','80777'),
('36','7','5','31551'),
('36','36','4','18257'),
('37','8','4','15278'),
('37','37','2','66935'),
('38','9','2','60506'),
('38','38','1','38208'),
('39','10','2','96542'),
('39','39','5','87488'),
('40','11','4','31244'),
('40','40','2','51058'),
('41','12','2','33106'),
('41','41','1','53828'),
('42','13','4','58932'),
('42','42','5','63344'),
('43','14','2','92004'),
('43','43','2','43748'),
('44','1','5','93988'),
('44','15','3','81636'),
('45','2','4','67254'),
('45','16','1','29354'),
('46','3','4','94250'),
('46','17','5','28541'),
('47','4','3','83039'),
('47','18','2','57447'),
('48','5','1','70429'),
('48','19','5','59514'),
('49','6','5','25656'),
('49','20','2','67701'),
('50','7','4','84397'),
('50','21','4','80000'),
('51','8','1','90621'),
('51','22','3','22021'),
('52','9','5','45377'),
('52','23','5','33441'),
('53','10','4','33380'),
('53','24','4','31638'),
('54','11','1','55102'),
('54','25','4','42147'),
('55','12','5','43414'),
('55','26','4','89704'),
('56','13','4','67833'),
('56','27','5','76527'),
('57','14','4','85842'),
('57','28','4','60186'),
('58','15','5','70139'),
('58','29','4','15867'),
('59','16','4','51032'),
('59','30','2','74847'),
('60','17','3','86696'),
('60','31','2','20576'),
('61','18','2','34600'),
('61','32','4','44424'),
('62','19','4','33589'),
('62','33','5','17674'),
('63','20','1','86268'),
('63','34','1','22085'),
('64','21','3','82593'),
('64','35','5','63181'),
('65','22','1','79388'),
('65','36','2','93249'),
('66','23','4','53588'),
('66','37','5','71133'),
('67','24','4','32333'),
('67','38','4','94546'),
('68','25','2','74128'),
('68','39','2','53284'),
('69','26','5','81555'),
('69','40','5','86123'),
('70','27','1','22679'),
('70','41','2','48826'),
('71','28','1','33278'),
('71','42','1','97665'),
('72','29','1','27219'),
('72','43','5','60019'),
('73','1','1','52656'),
('73','30','3','53382'),
('74','2','4','69790'),
('74','31','1','85790'),
('75','3','3','74092'),
('75','32','1','80706'),
('76','4','3','73698'),
('76','33','2','87947'),
('77','5','1','62159'),
('77','34','5','70202'),
('78','6','5','37986'),
('78','35','3','80579'),
('79','7','2','73120'),
('79','36','4','19688'),
('80','8','1','29587'),
('80','37','3','46527'),
('81','9','2','92519'),
('81','38','3','37976'),
('82','10','4','21858'),
('82','39','3','33550'),
('83','11','1','84468'),
('83','40','4','82426'),
('84','12','4','48932'),
('84','41','3','34467'),
('85','13','3','32845'),
('85','42','4','97543'),
('86','14','5','19048'),
('86','43','5','76856'),
('87','1','5','69549'),
('87','15','4','34048'),
('88','2','4','93937'),
('88','16','1','93657'),
('89','3','3','50081'),
('89','17','4','51578'),
('90','4','3','45798'),
('90','18','5','23519'),
('91','5','3','15822'),
('91','19','4','23059'),
('92','6','4','87803'),
('92','20','2','33086'),
('93','7','5','36421'),
('93','21','5','35453'),
('94','8','3','35722'),
('94','22','4','33639'),
('95','9','2','80240'),
('95','23','4','25254'),
('96','10','3','30620'),
('96','24','5','43841'),
('97','11','5','90843'),
('97','25','1','43704'),
('98','12','2','60275'),
('98','26','4','25006'),
('99','13','5','63793'),
('99','27','5','96832'),
('100','14','5','74147'),
('100','28','5','81289'); 


INSERT INTO `basket` VALUES ('1','101','1','4','84315','1991-08-02 18:25:13'),
('2','102','2','4','53107','1991-12-10 11:53:45'),
('3','103','3','3','56716','1986-02-22 02:09:52'),
('4','104','4','5','78468','2003-02-16 00:47:38'),
('5','106','5','1','69653','1971-06-24 11:09:00'),
('6','108','6','1','44014','2014-06-17 22:17:25'),
('7','109','7','4','97185','2003-08-09 15:42:07'),
('8','110','8','5','65543','1975-01-30 17:31:29'),
('9','111','9','1','67880','1997-02-19 17:51:06'),
('10','115','10','1','33866','2000-11-18 09:01:34'),
('11','117','11','4','15384','2011-07-29 20:11:40'),
('12','118','12','1','76644','1985-09-01 11:57:57'),
('13','119','13','1','65538','1982-01-14 23:39:42'),
('14','120','14','5','93730','1994-05-16 16:32:52'),
('15','121','15','5','97057','1999-07-16 11:41:50'),
('16','123','16','4','60436','1974-02-16 06:23:44'),
('17','124','17','2','64534','1978-01-11 13:00:51'),
('18','125','18','2','18559','1977-06-30 05:55:59'),
('19','130','19','5','75621','2012-08-04 20:02:21'),
('20','132','20','1','50516','1990-08-19 14:31:45'),
('21','133','21','4','52880','1970-11-30 21:04:40'),
('22','135','22','5','73199','1984-03-22 13:31:19'),
('23','139','23','4','49038','1984-04-09 00:47:06'),
('24','140','24','1','49220','1975-04-01 02:08:54'),
('25','141','25','1','92780','1995-01-07 06:14:37'),
('26','142','26','4','42185','1983-07-18 14:49:34'),
('27','144','27','1','52585','1977-08-14 18:35:53'),
('28','149','28','5','79721','2018-06-24 15:41:17'),
('29','150','29','1','31340','1980-08-15 07:01:20'),
('30','155','30','1','97172','2016-01-14 05:10:12'),
('31','158','31','4','67366','1998-01-25 18:28:10'),
('32','159','32','4','55234','2008-05-25 07:46:17'),
('33','160','33','5','59241','2008-10-26 01:48:37'),
('34','161','34','5','68106','2001-05-13 01:47:09'),
('35','162','35','3','34379','1996-07-01 19:52:33'),
('36','164','36','5','71704','2016-09-09 05:45:11'),
('37','168','37','1','33895','1999-01-04 07:07:22'),
('38','171','38','2','60738','1975-07-03 16:44:03'),
('39','173','39','1','49821','1991-03-05 08:16:05'),
('40','180','40','5','36606','1996-09-05 21:57:21'),
('41','181','41','1','79245','1979-10-17 09:45:55'),
('42','185','42','1','85660','1991-03-04 02:32:30'),
('43','186','43','5','21533','2007-07-23 00:42:45'),
('44','191','1','3','55745','2013-12-25 02:47:29'),
('45','192','2','2','89016','1991-05-01 19:50:31'),
('46','101','3','4','57302','1985-12-17 09:10:31'),
('47','102','4','1','90547','1992-07-12 12:15:05'),
('48','103','5','2','34452','2003-08-07 10:30:33'),
('49','104','6','5','71056','1984-09-27 20:46:01'),
('50','106','7','1','45734','2004-10-20 05:17:54'),
('51','108','8','3','17406','1991-10-12 09:44:20'),
('52','109','9','4','34365','1973-04-24 17:58:36'),
('53','110','10','2','42349','1970-04-27 19:07:40'),
('54','111','11','2','93547','2014-06-08 02:32:06'),
('55','115','12','4','44292','1974-10-21 06:12:00'),
('56','117','13','1','93376','2007-04-06 09:44:19'),
('57','118','14','4','42149','1985-11-28 20:36:46'),
('58','119','15','3','54261','2002-08-27 04:35:09'),
('59','120','16','1','24238','1983-12-28 16:13:57'),
('60','121','17','5','76135','1991-10-07 05:58:55'),
('61','123','18','4','98103','1980-09-08 14:57:44'),
('62','124','19','5','38169','1980-03-16 02:28:06'),
('63','125','20','1','94297','1980-10-12 15:43:15'),
('64','130','21','2','26212','1989-06-27 12:35:00'),
('65','132','22','5','38771','2013-05-27 11:23:00'),
('66','133','23','3','52180','1975-06-01 05:33:34'),
('67','135','24','3','77989','2011-06-21 15:18:07'),
('68','139','25','1','22706','1985-12-22 22:42:17'),
('69','140','26','4','47238','1971-12-04 13:30:43'),
('70','141','27','1','41359','1994-01-04 16:12:59'),
('71','142','28','4','26221','2002-08-02 22:44:03'),
('72','144','29','2','88221','1979-06-17 15:57:29'),
('73','149','30','2','50939','2018-08-04 08:36:23'),
('74','150','31','4','79378','1985-10-05 04:06:55'),
('75','155','32','5','37413','1987-05-12 00:43:20'),
('76','158','33','1','61394','1972-11-11 19:47:47'),
('77','159','34','3','52520','2013-10-24 09:28:53'),
('78','160','35','5','68437','1984-01-29 21:19:45'),
('79','161','36','5','41228','2016-08-06 23:57:10'),
('80','162','37','2','89835','2016-05-16 23:15:54'),
('81','164','38','4','63116','1980-10-25 05:17:04'),
('82','168','39','4','57490','2008-08-31 21:03:36'),
('83','171','40','3','26167','1976-08-27 20:00:53'),
('84','173','41','1','36122','2003-09-01 04:01:34'),
('85','180','42','1','29399','1971-07-26 23:54:44'),
('86','181','43','1','81595','1980-11-05 09:07:40'),
('87','185','1','2','31290','1983-04-18 01:27:15'),
('88','186','2','1','35448','1982-06-02 04:27:55'),
('89','191','3','2','74041','2002-11-25 07:10:17'),
('90','192','4','3','75596','1993-11-26 02:13:42'),
('91','101','5','1','30962','1981-04-30 05:51:32'),
('92','102','6','5','72930','1979-01-25 15:28:10'),
('93','103','7','1','66686','2016-10-13 18:35:22'),
('94','104','8','2','95238','2012-09-28 18:37:57'),
('95','106','9','1','23617','1978-09-17 23:34:09'),
('96','108','10','5','48548','2005-12-13 07:03:29'),
('97','109','11','3','51644','1997-11-16 01:54:42'),
('98','110','12','5','73479','2006-07-03 07:39:15'),
('99','111','13','3','27541','2008-05-07 04:06:14'),
('100','115','14','5','96076','2017-05-13 13:31:44'),
('101','117','15','3','30679','1982-07-10 08:09:47'),
('102','118','16','5','24268','2006-12-05 12:43:31'),
('103','119','17','1','66952','1998-09-03 00:46:34'),
('104','120','18','1','32538','1986-03-28 13:04:50'),
('105','121','19','1','24895','1976-09-30 22:36:49'),
('106','123','20','2','86960','1985-03-24 03:32:12'),
('107','124','21','2','63277','1983-03-18 13:50:52'),
('108','125','22','5','47140','2005-09-13 17:14:44'),
('109','130','23','2','70667','1972-01-31 22:17:43'),
('110','132','24','2','39946','1983-01-29 21:27:20'),
('111','133','25','3','40311','2010-05-07 02:26:29'),
('112','135','26','3','90275','2016-11-30 06:46:04'),
('113','139','27','2','27011','1988-06-05 21:31:42'),
('114','140','28','3','95740','2013-11-18 22:28:58'),
('115','141','29','4','96651','1990-11-20 06:17:43'),
('116','142','30','3','97949','2000-07-07 23:44:59'),
('117','144','31','1','59695','2003-06-04 22:00:51'),
('118','149','32','2','85282','2011-01-22 11:22:51'),
('119','150','33','2','98844','2017-11-25 13:27:18'),
('120','155','34','3','72001','1977-11-13 20:10:00'),
('121','158','35','3','88076','2016-02-08 19:13:53'),
('122','159','36','5','33509','1973-06-28 00:20:18'),
('123','160','37','1','58416','1972-06-04 17:42:32'),
('124','161','38','2','83387','1989-08-31 21:32:24'),
('125','162','39','2','48840','2005-05-13 17:56:38'),
('126','164','40','2','19158','2002-09-25 04:35:37'),
('127','168','41','2','66874','1976-07-26 09:42:13'),
('128','171','42','5','91316','1989-11-08 00:48:51'),
('129','173','43','5','62995','2008-11-20 14:10:02'),
('130','180','1','4','57358','1989-12-15 10:17:19'),
('131','181','2','5','44112','1982-10-16 13:53:30'),
('132','185','3','4','74612','2012-10-21 08:28:36'),
('133','186','4','5','30516','2017-01-07 23:33:58'),
('134','191','5','5','76013','1993-07-27 10:54:22'),
('135','192','6','2','23125','1995-07-11 20:33:20'),
('136','101','7','4','93001','1970-02-19 19:34:05'),
('137','102','8','2','81644','2004-12-23 23:57:58'),
('138','103','9','1','33357','1972-02-22 22:44:41'),
('139','104','10','3','31435','1982-06-14 12:55:35'),
('140','106','11','1','64955','1980-11-13 14:30:13'),
('141','108','12','3','95253','2006-10-11 15:49:35'),
('142','109','13','4','30890','2010-11-22 15:40:55'),
('143','110','14','2','41527','1980-11-25 09:32:32'),
('144','111','15','3','35470','2017-09-16 22:34:26'),
('145','115','16','1','98800','2010-12-09 15:42:51'),
('146','117','17','1','71052','1970-02-24 16:44:42'),
('147','118','18','4','28536','2019-12-11 07:52:04'),
('148','119','19','5','33509','1985-09-14 05:10:06'),
('149','120','20','1','65849','1998-07-26 14:10:41'),
('150','121','21','2','89207','1980-12-13 10:58:46'),
('151','123','22','3','82099','2010-03-07 18:36:09'),
('152','124','23','1','36491','2015-06-17 22:15:17'),
('153','125','24','2','79145','2002-01-23 19:51:33'),
('154','130','25','1','64822','2017-12-19 15:52:56'),
('155','132','26','5','59978','1982-12-19 05:55:07'),
('156','133','27','4','52220','1987-09-03 17:46:46'),
('157','135','28','3','26072','2017-09-05 18:45:03'),
('158','139','29','5','95922','1982-09-09 12:42:06'),
('159','140','30','5','79820','2002-01-23 09:09:18'),
('160','141','31','1','37107','2006-03-05 02:03:13'),
('161','142','32','5','77001','2005-08-30 06:32:00'),
('162','144','33','3','69024','1996-02-07 20:57:31'),
('163','149','34','3','58391','1984-01-26 19:22:25'),
('164','150','35','5','74849','1988-10-28 22:33:11'),
('165','155','36','2','91222','1980-09-11 02:41:14'),
('166','158','37','5','77864','1978-11-29 16:03:35'),
('167','159','38','3','84724','2004-05-06 04:53:07'),
('168','160','39','5','47156','2004-03-21 14:20:51'),
('169','161','40','3','27669','1987-07-11 15:02:33'),
('170','162','41','4','34429','2005-08-01 23:11:31'),
('171','164','42','1','18362','1978-04-22 17:58:50'),
('172','168','43','5','91988','2015-09-17 10:31:38'),
('173','171','1','4','97635','1994-04-03 18:03:06'),
('174','173','2','5','80155','1983-07-22 04:42:45'),
('175','180','3','5','67553','1990-01-27 04:25:50'),
('176','181','4','4','31167','2015-07-17 05:14:09'),
('177','185','5','4','15060','1984-12-11 07:11:12'),
('178','186','6','4','53903','2004-07-18 09:56:27'),
('179','191','7','3','18619','1996-12-23 00:58:20'),
('180','192','8','3','48289','1985-10-07 19:52:22'),
('181','101','9','1','59659','2012-01-04 04:29:45'),
('182','102','10','4','71636','1997-07-20 15:06:32'),
('183','103','11','1','90336','1977-10-17 00:35:22'),
('184','104','12','3','66267','1991-06-21 12:26:29'),
('185','106','13','4','91492','2005-11-20 02:20:55'),
('186','108','14','1','21708','1982-01-29 01:31:10'),
('187','109','15','1','21957','1994-01-14 04:34:28'),
('188','110','16','1','44154','2005-04-11 11:28:08'),
('189','111','17','4','34528','1989-10-09 11:36:20'),
('190','115','18','4','57387','1971-10-04 22:17:51'),
('191','117','19','3','20725','1991-07-18 05:49:39'),
('192','118','20','2','76596','1985-12-18 19:55:58'),
('193','119','21','1','67303','1991-04-19 23:36:00'),
('194','120','22','1','59638','1997-07-24 11:30:58'),
('195','121','23','3','66579','2018-02-11 15:33:30'),
('196','123','24','1','62446','2016-10-25 13:12:52'),
('197','124','25','1','22801','2011-06-12 23:54:14'),
('198','125','26','2','58329','1992-04-02 23:36:28'),
('199','130','27','1','26918','2015-07-11 21:57:26'),
('200','132','28','5','72418','1991-01-13 05:16:12'),
('201','133','29','2','19311','2002-01-15 08:03:20'),
('202','135','30','4','90318','1979-06-24 01:49:51'),
('203','139','31','3','47858','1980-08-24 10:21:14'),
('204','140','32','2','53085','1982-12-02 16:30:15'),
('205','141','33','2','47396','1975-09-01 22:58:52'),
('206','142','34','4','24360','2000-12-26 19:16:44'),
('207','144','35','4','98034','1987-09-16 11:03:59'),
('208','149','36','3','71955','1971-04-08 15:09:11'),
('209','150','37','3','64037','1988-11-09 11:26:19'),
('210','155','38','2','69320','1979-11-08 12:33:08'),
('211','158','39','4','59399','1973-05-19 22:26:45'),
('212','159','40','2','29881','2000-08-06 07:19:20'),
('213','160','41','4','44628','1973-01-30 20:19:37'),
('214','161','42','3','92678','2011-12-11 13:06:57'),
('215','162','43','1','61588','1982-04-11 01:31:15'),
('216','164','1','1','23572','1971-06-16 18:21:06'),
('217','168','2','3','96340','1972-09-28 05:02:22'),
('218','171','3','5','16816','1988-01-04 02:00:29'),
('219','173','4','1','77058','1989-01-18 14:49:22'),
('220','180','5','2','89994','1989-12-07 17:47:00'),
('221','181','6','2','48735','1979-02-20 12:18:58'),
('222','185','7','1','53055','1980-01-29 13:56:57'),
('223','186','8','5','85912','2016-03-26 20:12:09'),
('224','191','9','5','49789','2007-10-12 13:35:47'),
('225','192','10','5','85737','2003-09-09 22:42:16'),
('226','101','11','4','45302','1972-06-23 09:10:47'),
('227','102','12','1','70878','2009-11-25 15:25:45'),
('228','103','13','5','84291','1996-05-23 12:13:03'),
('229','104','14','5','35887','1975-11-13 02:16:03'),
('230','106','15','1','57576','1971-12-14 20:00:52'),
('231','108','16','1','69796','1991-09-28 23:04:35'),
('232','109','17','5','81047','2014-11-30 10:31:02'),
('233','110','18','5','52960','1992-04-27 16:26:39'),
('234','111','19','4','60373','2014-01-02 01:13:29'),
('235','115','20','4','94345','1973-02-05 07:21:07'),
('236','117','21','2','37628','1995-02-08 06:25:24'),
('237','118','22','4','35147','1979-12-19 05:42:37'),
('238','119','23','2','45495','1972-08-12 20:56:10'),
('239','120','24','4','46650','2012-01-25 19:03:23'),
('240','121','25','5','78231','2011-03-17 10:34:57'),
('241','123','26','4','83298','2017-07-21 16:05:48'),
('242','124','27','3','62225','1988-08-02 14:50:48'),
('243','125','28','3','37658','2015-01-19 09:56:13'),
('244','130','29','2','93107','1984-01-17 02:05:17'),
('245','132','30','3','90420','2018-05-06 15:59:42'),
('246','133','31','1','17863','1998-08-16 05:44:02'),
('247','135','32','1','56781','2010-09-10 00:32:11'),
('248','139','33','1','47342','1974-06-20 10:14:34'),
('249','140','34','4','44108','1981-06-30 16:46:51'),
('250','141','35','4','22421','1982-03-19 13:49:42'),
('251','142','36','5','28405','1980-05-04 21:09:15'),
('252','144','37','5','95899','2014-06-15 11:27:19'),
('253','149','38','5','20676','1974-09-03 10:29:42'),
('254','150','39','5','66285','2005-08-25 22:40:45'),
('255','155','40','4','41576','2018-02-20 05:03:21'),
('256','158','41','1','55823','2003-04-19 18:09:57'),
('257','159','42','5','91434','1997-04-16 03:40:13'),
('258','160','43','5','71683','1974-11-01 08:19:17'),
('259','161','1','3','59088','1971-06-30 19:05:09'),
('260','162','2','4','68910','2005-05-03 18:10:51'),
('261','164','3','4','20180','1980-02-10 03:07:23'),
('262','168','4','2','16859','2017-02-04 15:43:59'),
('263','171','5','4','87108','1997-04-08 09:22:53'),
('264','173','6','5','29356','1977-02-18 04:21:19'),
('265','180','7','5','84432','1986-05-25 11:21:24'),
('266','181','8','5','89048','2013-09-16 19:09:17'),
('267','185','9','4','69507','2000-04-19 00:16:03'),
('268','186','10','1','76194','1978-06-03 17:21:23'),
('269','191','11','3','69783','1988-09-15 00:37:25'),
('270','192','12','2','47312','2017-12-06 01:52:42'),
('271','101','13','5','17338','1985-04-29 11:33:31'),
('272','102','14','3','38134','2007-04-03 03:01:48'),
('273','103','15','1','32121','1987-07-17 03:38:56'),
('274','104','16','2','61517','2009-03-27 11:17:38'),
('275','106','17','1','31215','2010-12-18 04:57:59'),
('276','108','18','2','37894','2004-10-03 05:24:35'),
('277','109','19','1','28127','1987-10-25 17:52:44'),
('278','110','20','5','34091','2007-03-24 17:41:35'),
('279','111','21','3','79895','1981-02-01 15:37:06'),
('280','115','22','3','80094','2009-04-04 00:50:12'),
('281','117','23','2','26319','2007-07-10 00:20:37'),
('282','118','24','5','73328','1985-03-07 01:14:48'),
('283','119','25','4','41072','2003-08-25 19:09:26'),
('284','120','26','3','25737','1975-11-01 04:42:59'),
('285','121','27','4','83802','2004-06-11 21:49:37'),
('286','123','28','3','34961','1977-09-16 11:37:55'),
('287','124','29','3','20282','1988-02-06 06:41:49'),
('288','125','30','2','42796','1988-10-12 15:09:32'),
('289','130','31','2','31016','1995-07-31 10:14:28'),
('290','132','32','5','68073','1984-09-07 11:57:25'),
('291','133','33','4','75682','1996-05-09 05:41:11'),
('292','135','34','3','95389','1976-05-23 14:31:43'),
('293','139','35','1','79334','2002-09-13 15:37:24'),
('294','140','36','3','60026','2011-12-22 18:49:09'),
('295','141','37','2','47022','2010-02-05 15:11:18'),
('296','142','38','4','95547','1993-11-10 02:37:47'),
('297','144','39','3','95376','1990-05-28 00:05:04'),
('298','149','40','2','51751','2009-09-05 07:33:57'),
('299','150','41','2','40092','1984-05-04 12:13:59'),
('300','155','42','4','15565','1971-03-10 03:10:15'); 

ALTER TABLE orders ADD status INT(5) DEFAULT 1 AFTER shop_id;
UPDATE orders SET status = FLOOR(RAND()*5) + 1 WHERE 1;

-- Выборка и подготовка данных для отображения на странице смартфонов Samsung
SELECT p.id id, CONCAT("Смартфон ", b.title, " ", p.title) AS title, p.price - p.discount * p.price / 100 - c.discount * p.price / 100 price  FROM brands b 
	JOIN catalogs c
	LEFT JOIN  products p ON p.brand_id = b.id WHERE b.id = 2 AND c.id = p.catalog_id AND p.catalog_id = 1 AND p.leftover > 0;



DELIMITER //
CREATE PROCEDURE add_to_basket (IN product BIGINT, IN quantity INT, IN `user` BIGINT)
BEGIN
	INSERT INTO basket (user_id, product_id, quantity, price) VALUES (`user`, product, quantity, 
		(SELECT p.price - p.discount * p.price / 100 - c.discount * p.price / 100 
			FROM products p, catalogs c WHERE p.id = product LIMIT 1)
	);
END//



CREATE TRIGGER update_basket_price AFTER UPDATE ON products
FOR EACH ROW
BEGIN
	UPDATE basket b SET b.price = (SELECT NEW.price - NEW.discount * NEW.price / 100 - c.discount * p.price / 100 
			FROM products p, catalogs c WHERE p.id = NEW.id LIMIT 1) WHERE b.product_id = NEW.id;
END//


CREATE TRIGGER update_basket_on_delete_prod AFTER DELETE ON products
FOR EACH ROW
BEGIN
	DELETE FROM basket WHERE product_id = OLD.id;
END//

DELIMITER ;


CREATE OR REPLACE VIEW usrs (name, email) AS 
SELECT CONCAT(p.firstname, " ", p.secondname, " ", p.lastname), u.email FROM profiles p, users u WHERE p.user_id = u.id;


CREATE OR REPLACE VIEW products_ordered_by_price AS
SELECT * FROM products ORDER BY price;




CREATE INDEX title_brands_idx ON brands(title);
CREATE INDEX value_product_attributes_idx ON product_attributes(value);
CREATE INDEX title_products_idx ON products(title);
CREATE INDEX city_profiles_idx ON profiles(city);
CREATE INDEX email_users_idx ON users(email);















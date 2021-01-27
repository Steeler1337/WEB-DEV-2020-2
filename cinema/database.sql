-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_1225
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CPU`
--

DROP TABLE IF EXISTS `CPU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CPU` (
  `id` int(11) NOT NULL,
  `Model` varchar(40) NOT NULL,
  `Socket` varchar(10) NOT NULL,
  `Frequency` int(11) NOT NULL,
  `Year` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CPU`
--

LOCK TABLES `CPU` WRITE;
/*!40000 ALTER TABLE `CPU` DISABLE KEYS */;
INSERT INTO `CPU` VALUES (1,'Intel core i5 10400f','LGA 1200',2900,2020),(2,'Intel xeon','1155',3700,2018),(3,'Pentium-IV','423',3800,2019),(4,'Intel core i5 6600',' FCLGA1151',3300,2016),(5,'POWER-4','LGA 1150',2000,2005);
/*!40000 ALTER TABLE `CPU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Computer`
--

DROP TABLE IF EXISTS `Computer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Computer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `CPU` varchar(40) NOT NULL,
  `RAM` varchar(40) NOT NULL,
  `HDD` varchar(40) NOT NULL,
  `Year` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Computer`
--

LOCK TABLES `Computer` WRITE;
/*!40000 ALTER TABLE `Computer` DISABLE KEYS */;
INSERT INTO `Computer` VALUES (1,'Крутая сборка 1','Intel Xeon','HyperX 3333','WDBlue 1',2018),(2,'Крутая сборка 2','Pentium-IV','HyperX 4444','WDGreen 1',2017),(3,'Сборка для CSGO','Intel core i5 6600','Amd Radeon R5','Toshiba P300',2017),(4,'Сборка для монтажа видео','AMD Ryzen 5 3600','Apacer [EL.16G2V.GNH]','Seagate BarraCuda [ST500DM009]',2018),(5,'Энергичная сборка 1','POWER-4','HyperX 3333','WDBlue 1',2019),(6,'Энергичная сборка 2','POWER-4','HyperX 5555','Seagate BarraCuda [ST500DM009]',2020),(7,'Сборка на базе Pentium-IV','Pentium-IV','patriot memory','western digital',2020);
/*!40000 ALTER TABLE `Computer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Computer_series`
--

DROP TABLE IF EXISTS `Computer_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Computer_series` (
  `id_computer` int(11) NOT NULL,
  `id_series` int(11) NOT NULL,
  PRIMARY KEY (`id_computer`,`id_series`),
  KEY `id_series` (`id_series`),
  CONSTRAINT `Computer_series_ibfk_1` FOREIGN KEY (`id_computer`) REFERENCES `Computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Computer_series_ibfk_2` FOREIGN KEY (`id_series`) REFERENCES `Series` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Computer_series`
--

LOCK TABLES `Computer_series` WRITE;
/*!40000 ALTER TABLE `Computer_series` DISABLE KEYS */;
INSERT INTO `Computer_series` VALUES (1,1),(2,2),(7,3);
/*!40000 ALTER TABLE `Computer_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Distributor_brand`
--

DROP TABLE IF EXISTS `Distributor_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Distributor_brand` (
  `id` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Location` varchar(40) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Distributor_brand`
--

LOCK TABLES `Distributor_brand` WRITE;
/*!40000 ALTER TABLE `Distributor_brand` DISABLE KEYS */;
INSERT INTO `Distributor_brand` VALUES (1,'DNS','г. Москва, ул. Большая Семёновская 10','89998887766'),(2,'Мвидео','г. Москва, ул. Проспект Мира 15','89991112233');
/*!40000 ALTER TABLE `Distributor_brand` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`std_1225`@`%`*/ /*!50003 TRIGGER check_phone BEFORE INSERT ON Distributor_brand
FOR EACH ROW
BEGIN
	IF (NEW.Phone NOT REGEXP '^8[0-9+]') THEN
    	SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'Wrong format number';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Installed_processor`
--

DROP TABLE IF EXISTS `Installed_processor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Installed_processor` (
  `id_computer` int(11) NOT NULL,
  `id_cpu` int(11) NOT NULL,
  PRIMARY KEY (`id_computer`,`id_cpu`),
  KEY `id_cpu` (`id_cpu`),
  CONSTRAINT `Installed_processor_ibfk_1` FOREIGN KEY (`id_computer`) REFERENCES `Computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Installed_processor_ibfk_2` FOREIGN KEY (`id_cpu`) REFERENCES `CPU` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Installed_processor`
--

LOCK TABLES `Installed_processor` WRITE;
/*!40000 ALTER TABLE `Installed_processor` DISABLE KEYS */;
INSERT INTO `Installed_processor` VALUES (1,2),(2,3);
/*!40000 ALTER TABLE `Installed_processor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Made_computer`
--

DROP TABLE IF EXISTS `Made_computer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Made_computer` (
  `id_computer` int(11) NOT NULL,
  `id_company` int(11) NOT NULL,
  PRIMARY KEY (`id_computer`,`id_company`),
  KEY `id_company` (`id_company`),
  CONSTRAINT `Made_computer_ibfk_1` FOREIGN KEY (`id_company`) REFERENCES `Maker_brand` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Made_computer_ibfk_2` FOREIGN KEY (`id_computer`) REFERENCES `Computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Made_computer`
--

LOCK TABLES `Made_computer` WRITE;
/*!40000 ALTER TABLE `Made_computer` DISABLE KEYS */;
INSERT INTO `Made_computer` VALUES (1,1),(1,2),(2,3),(6,4),(5,5);
/*!40000 ALTER TABLE `Made_computer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Maker_brand`
--

DROP TABLE IF EXISTS `Maker_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Maker_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Location` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Maker_brand`
--

LOCK TABLES `Maker_brand` WRITE;
/*!40000 ALTER TABLE `Maker_brand` DISABLE KEYS */;
INSERT INTO `Maker_brand` VALUES (1,'Механики','Богодухов'),(2,'АСУС','Москва'),(3,'Железякеры','Богодухов'),(4,'Пекари','Орёл'),(5,'Конструкторы','Тула');
/*!40000 ALTER TABLE `Maker_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Series`
--

DROP TABLE IF EXISTS `Series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Series` (
  `id` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Series`
--

LOCK TABLES `Series` WRITE;
/*!40000 ALTER TABLE `Series` DISABLE KEYS */;
INSERT INTO `Series` VALUES (1,100,50000),(2,150,60000),(3,200,70000);
/*!40000 ALTER TABLE `Series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Series_sale`
--

DROP TABLE IF EXISTS `Series_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Series_sale` (
  `id_company` int(11) NOT NULL,
  `id_series` int(11) NOT NULL,
  PRIMARY KEY (`id_company`,`id_series`),
  KEY `id_series` (`id_series`),
  CONSTRAINT `Series_sale_ibfk_1` FOREIGN KEY (`id_company`) REFERENCES `Distributor_brand` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Series_sale_ibfk_2` FOREIGN KEY (`id_series`) REFERENCES `Series` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Series_sale`
--

LOCK TABLES `Series_sale` WRITE;
/*!40000 ALTER TABLE `Series_sale` DISABLE KEYS */;
INSERT INTO `Series_sale` VALUES (1,1),(1,2),(2,3);
/*!40000 ALTER TABLE `Series_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('54778e45c018');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complitation_movies`
--

DROP TABLE IF EXISTS `complitation_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complitation_movies` (
  `comp_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  PRIMARY KEY (`comp_id`,`movie_id`),
  KEY `fk_complitation_movies_movie_id_movies` (`movie_id`),
  CONSTRAINT `fk_complitation_movies_comp_id_complitations` FOREIGN KEY (`comp_id`) REFERENCES `complitations` (`id`),
  CONSTRAINT `fk_complitation_movies_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complitation_movies`
--

LOCK TABLES `complitation_movies` WRITE;
/*!40000 ALTER TABLE `complitation_movies` DISABLE KEYS */;
INSERT INTO `complitation_movies` VALUES (3,14),(2,16),(5,20),(3,21),(2,25);
/*!40000 ALTER TABLE `complitation_movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complitations`
--

DROP TABLE IF EXISTS `complitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_complitations_user_id_users` (`user_id`),
  CONSTRAINT `fk_complitations_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complitations`
--

LOCK TABLES `complitations` WRITE;
/*!40000 ALTER TABLE `complitations` DISABLE KEYS */;
INSERT INTO `complitations` VALUES (2,'Подборка Федора',2),(3,'Подборка Гарика',4),(4,'Ура',2),(5,'Лучшие комедии',2),(10,'da',2);
/*!40000 ALTER TABLE `complitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (3,'Боевик'),(1,'Комедия'),(4,'Мелодрама'),(6,'Приключения'),(2,'Триллер'),(7,'Фантастика'),(5,'Хоррор');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genres` (
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`),
  KEY `fk_movie_genres_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_movie_genres_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  CONSTRAINT `fk_movie_genres_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES `movie_genres` WRITE;
/*!40000 ALTER TABLE `movie_genres` DISABLE KEYS */;
INSERT INTO `movie_genres` VALUES (14,1),(19,1),(20,1),(22,1),(25,1),(12,2),(14,2),(15,2),(17,2),(18,2),(14,3),(15,3),(16,3),(14,4),(19,4),(21,4),(25,4),(12,5),(21,5),(13,6),(16,6),(17,6),(13,7),(16,7),(17,7);
/*!40000 ALTER TABLE `movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `year` int(11) NOT NULL,
  `country` varchar(100) NOT NULL,
  `producer` varchar(100) NOT NULL,
  `screenwriter` varchar(100) NOT NULL,
  `actors` varchar(100) NOT NULL,
  `duration` int(11) NOT NULL,
  `poster_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_movies_poster_id_posters` (`poster_id`),
  CONSTRAINT `fk_movies_poster_id_posters` FOREIGN KEY (`poster_id`) REFERENCES `posters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (12,'Астрал','**Джош** и **Рене** переезжают с детьми в новый дом, но не успевают толком распаковать вещи, как начинаются *странные события*. Необъяснимо перемещаются *предметы*, в детской звучат странные звуки… Но настоящий кошмар начинается для родителей, когда их десятилетний сын **Далтон** впадает в кому. Все усилия врачей в больнице помочь мальчику безуспешны.\n\nНесколько месяцев спустя его возвращают домой, где за несчастным ребенком ухаживают мать и сиделка. Но загадочные явления в доме продолжаются. Отчаявшиеся родители готовы обратиться за помощью к кому угодно, и вскоре выясняется, что Далтон в бессознательном состоянии связан с паранормальным миром.',2011,'США','Джеймс Ван','Ли Уоннелл','Лин Шей, Патрик Уилсон, Роуз Бирн, Тай Симпкинс, Энгус Сэмпсон',102,'86a86f9b-b4c9-436d-be21-ecd744b17ee6'),(13,'Звёздные Войны Эпизод VII','Через тридцать лет после гибели **Дарта Вейдера** и **Императора** галактика по-прежнему в опасности. Государственное образование Первый Орден во главе с таинственным верховным лидером *Сноуком* и его правой рукой **Кайло Реном** идёт по стопам Империи, пытаясь захватить всю власть. В это нелёгкое время судьба сводит юную девушку **Рей** и бывшего штурмовика Первого Ордена **Финна** с героями войны с Империей - *Ханом Соло*, *Чубаккой* и *генералом Леей*. Вместе они должны дать бой Первому Ордену, однако настаёт тот момент, когда становится очевидно, что лишь **джедаи** могут остановить *Сноука* и **Кайло Рена**.',2015,'США ','Дж. Дж. Абрамс ','Лоуренс Кэздан, Дж. Дж. Абрамс, Майкл Арндт ','Дэйзи Ридли, Джон Бойега, Оскар Айзек, Адам Драйвер',136,'7317add2-e348-4ece-8299-5d7bb71222ad'),(14,'Возмездие','Мексиканец **Педро** бежал из города Канкун в Россию. На родине он промышлял мелким грабежом и продавал поддельное \"Лего\". Здесь же, в России, он меняет имя и находит единомышленников. **Команда новоиспеченных недо-бандитов** решается на самое рискованное дело их жизни : украсть реликвию главного криминального авторитета Москвы - **Виктора**.\n*Однако не каждая авантюра щедро поощряется...Особенно преступная...*',2019,'Россия','Гладышев Федор','Гладышев Федор, Фаградян Артем','Панин Максим, Некрасов Даниил, Фаградян Артём, Полещук Евгений',22,'d1dcc661-2a94-49a2-b467-fb0091fc2898'),(15,'Форсаж','**Главный герой** — полицейский под прикрытием Брайан О’Коннер (Пол Уокер). **Его цель** — быть принятым в автобанду легендарного уличного гонщика **Доминика Торетто** (Вин Дизель), которого подозревают в налётах на грузовики с бытовой техникой.',2001,'США','Роб Коэн','Гэри Скотт Томпсон, Эрик Бергквист,  Дэвид Эйр','Вин Дизель, Пол Уокер, Мишель Родригес',106,'922acb31-0b85-4686-ab14-60d78e2e41d2'),(16,'Человек-Паук','**Питер Паркер** – обыкновенный школьник. Однажды он отправился с классом на экскурсию, где его кусает странный **паук-мутант**. Через время парень почувствовал в себе *нечеловеческую силу* и *ловкость в движении*, а главное – *умение лазать по стенам* и *метать стальную паутину*. Свои способности он направляет на защиту слабых. Так **Питер** становится настоящим супергероем по имени **Человек-паук**, который помогает людям и борется с преступностью. Но там, где есть супергерой, рано или поздно всегда объявляется и суперзлодей...',2002,'США','Сэм Рэйми','Дэвид Кепп, Стэн Ли, Стив Дитко','Тоби Магуайр, Уиллем Дефо, Кирстен Данст, Джеймс Франко',121,'6dbd07f1-8c8e-4cfc-b3c5-4ff28087240c'),(17,'Аватар','**Джейк Салли** - бывший морской пехотинец, прикованный к инвалидному креслу. Несмотря на немощное тело, Джейк в душе по-прежнему остается **воином**. Он получает задание совершить путешествие в несколько световых лет к базе землян на планете **Пандора**, где корпорации добывают *редкий минерал*, имеющий огромное значение для выхода Земли из энергетического кризиса.',2009,'США','Джеймс Кэмерон',' Джеймс Кэмерон','Сэм Уортингтон, Зои Салдана, Сигурни Уивер, Стивен Лэнг, Мишель Родригес',162,'f044b73e-c1fa-476d-b65a-015bfd6fdb91'),(18,'Остров Проклятых','Два американских *судебных пристава* отправляются на один из островов в штате Массачусетс, чтобы расследовать **исчезновение пациентки клиники для умалишенных преступников**. При проведении расследования им придется столкнуться с *паутиной лжи*, обрушившимся ураганом и смертельным бунтом обитателей клиники.',2009,'США','Мартин Скорсезе','Лаэта Калогридис, Деннис Лихейн','Леонардо ДиКаприо, Марк Руффало, Бен Кингсли, Макс фон Сюдов',138,'1715a491-3f06-4672-b9c1-cb90943ae4a1'),(19,'Титаник','В первом и последнем плавании шикарного «**Титаника**» встречаются двое. Пассажир нижней палубы **Джек** *выиграл билет в карты*, а богатая наследница **Роза** отправляется в Америку, чтобы выйти замуж по расчёту. Чувства молодых людей только успевают **расцвести**, и даже не классовые различия создадут испытания влюблённым, а айсберг, вставший на пути считавшегося непотопляемым лайнера.\n',1997,'США, Мексика, Австралия, Канада      ','Джеймс Кэмерон      ','Джеймс Кэмерон      ','Леонардо ДиКаприо, Кейт Уинслет, Билли Зейн, Кэти Бейтс',194,'1ef9f2db-b416-44aa-bfff-f0ea32003b80'),(20,'Всегда говори \"ДА\"','*Депрессивный главный герой* всегда и всем говорил «**нет**» — например, друзьям, если они зовут куда-то. Но в один прекрасный день он заключает соглашение, по которому всегда должен отвечать «**Да**» на любое предложение...',2008,'США, Великобритания','Пейтон Рид','Николас Столлер, Джеррад Пол, Эндрю Моугел,  Дэнни Уоллес','Джим Керри, Зои Дешанель, Брэдли Купер, Джон Майкл Хиггинс, \r\nРиз Дэрби',104,'10b421c4-96ab-4c90-b41c-5ffe69050074'),(21,'Игра в прятки','**Пожилой вдовец** (Де Ниро) обнаруживает что его **маленькая дочка** (Фэннинг) завела себе вымышленного *друга*, имеющего склонность ко вполне невымышленным актам насилия. Ортодоксальный, снятый совершенно by the book психологический хоррор.',2005,'США  ','Джон Полсон  ','Эри Шлоссберг  ','Роберт Де Ниро, Дакота Фэннинг, Фамке Янссен, Эми Ирвинг, Элизабет Шу, Дилан Бейкер',97,'4dfe4d96-acda-48df-a47c-f894ed0dfef3'),(22,'Шрек','Жил да был в **сказочном государстве** большой зеленый великан по имени **Шрек**. Жил он в гордом одиночестве в лесу, на болоте, которое считал своим. Но однажды злобный коротышка — **лорд Фаркуад**, правитель волшебного королевства, безжалостно согнал на Шреково болото всех сказочных обитателей.\n\nИ беспечной жизни зеленого великана пришел *конец*. Но лорд Фаркуад пообещал вернуть **Шреку** болото, если великан добудет ему прекрасную принцессу Фиону, которая томится в неприступной башне, охраняемой огнедышащим драконом…',2001,'США   ','Эндрю Адамсон, Вики Дженсон','Тед Эллиот, Терри Россио, Джо Стиллман','Кэмерон Диаз, Майк Майерс, Эдди Мёрфи, Джон Литгоу',90,'7cde3c4e-990e-4a8a-b228-cde3d09ed8f4'),(25,'1+1','Пострадав в результате *несчастного случая*, **богатый аристократ Филипп** нанимает в помощники человека, который менее всего подходит для этой работы, – молодого жителя предместья Дрисса, **только что освободившегося из тюрьмы**. Несмотря на то, что Филипп прикован к инвалидному креслу, **Дриссу** удается привнести в размеренную жизнь аристократа дух приключений.',2011,'Франция','Оливье Накаш, Эрик Толедано','Оливье Накаш, Эрик Толедано','Франсуа Клюзе, Омар Си, Анн Ле Ни, Одри Флеро',112,'7879e9d0-ee0e-4260-b3ec-56614e2972ec');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posters`
--

DROP TABLE IF EXISTS `posters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posters` (
  `id` varchar(36) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `md5_hash` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_posters_md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posters`
--

LOCK TABLES `posters` WRITE;
/*!40000 ALTER TABLE `posters` DISABLE KEYS */;
INSERT INTO `posters` VALUES ('0eed7ff8-589a-44b8-8c58-96b1816e2ebe','batman.jpg','image/jpeg','426325fea96a171002f046d6a1f82136'),('10b421c4-96ab-4c90-b41c-5ffe69050074','yes.jpeg','image/jpeg','d8ebea48c1dff653defbdc75b0bdfc5e'),('1715a491-3f06-4672-b9c1-cb90943ae4a1','island.jpg','image/jpeg','5ab569144943798d5af044090ca722ac'),('1ef9f2db-b416-44aa-bfff-f0ea32003b80','titanic.jpg','image/jpeg','6d65d2e9dfc78ea4060b15f8afa429cb'),('4dfe4d96-acda-48df-a47c-f894ed0dfef3','hideandseek.jpg','image/jpeg','e4888b8b843771d2080a3d963ff078b6'),('6dbd07f1-8c8e-4cfc-b3c5-4ff28087240c','spiderman.jpg','image/jpeg','4d8b85bba93e0299cbef2ac2a87f7a5e'),('7317add2-e348-4ece-8299-5d7bb71222ad','starwars.jpg','image/jpeg','aff05a5dd40bcdc615bd8259f8a70b03'),('7879e9d0-ee0e-4260-b3ec-56614e2972ec','oneplusone.jpg','image/jpeg','eb2f6197ad0696a73a4765678b8ab98c'),('7cde3c4e-990e-4a8a-b228-cde3d09ed8f4','shrek.jpg','image/jpeg','72bcc03c6e3b717c9ac5e6d263d18c3f'),('86a86f9b-b4c9-436d-be21-ecd744b17ee6','astral.jpg','image/jpeg','421283f883270b6c146e253bcd9af7c4'),('922acb31-0b85-4686-ab14-60d78e2e41d2','forsaj.jpg','image/jpeg','ea62b438ca204bd2c7eb26b3dbe3549f'),('d1dcc661-2a94-49a2-b467-fb0091fc2898','vozmezdie.jpg','image/jpeg','16ef81eefd6c93afd58c2b113d388442'),('f044b73e-c1fa-476d-b65a-015bfd6fdb91','avatar.jpg','image/jpeg','5abedaa763ab392708fa5b9fb63abb22');
/*!40000 ALTER TABLE `posters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_movie_id_movies` (`movie_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (6,12,1,5,'Очень **Страшный фильм**','2021-01-26 02:55:09'),(7,12,2,5,'Очень здорово','2021-01-26 11:56:46'),(10,18,1,5,'1. Захватывающий фильм\r\n2. Великолепная игра\r\n\r\n','2021-01-27 02:10:14'),(11,13,4,5,'Это же **звёздные войны**!! как здесь поставить *10 баллов*? ))','2021-01-27 02:23:59'),(12,14,4,5,'Ребята хорошо делают, у них **всё получится**!','2021-01-27 02:25:57'),(13,12,4,5,'Жутко...... **Понравилось**','2021-01-27 02:32:46'),(14,25,4,5,'Фильм о простом счастье иметь друга!','2021-01-27 02:33:09');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению фильмов'),(2,'Модератор','может редактировать фильмы и производить модерацию рецензий'),(3,'Пользователь','может оставлять рецензии');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles2`
--

DROP TABLE IF EXISTS `roles2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles2`
--

LOCK TABLES `roles2` WRITE;
/*!40000 ALTER TABLE `roles2` DISABLE KEYS */;
INSERT INTO `roles2` VALUES (1,'Администратор',NULL),(2,'Пользователь',NULL);
/*!40000 ALTER TABLE `roles2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','pbkdf2:sha256:150000$d2jBVUBT$cdb5bb22356159c146195e5eaea190c81d6f3bb12629e24941a9b3964aeb8372','Иванов','Иван',NULL,1),(2,'steeler','pbkdf2:sha256:150000$KFtiHxy4$22c455f24303362c65c675e3dc324a0ac2407d33d5a29f4d30a0b9822c213811','Федор','Гладышев',NULL,3),(3,'vasya','pbkdf2:sha256:150000$BLypmkOT$c878cb86305cea9e06f5f2b9936bff7ca874738792edd457016f0642664221f1','Васильев','Василий',NULL,2),(4,'buldog','pbkdf2:sha256:150000$bAgeZF2Z$fb4f4becc7f6515ba6a295f57eb16002b207e33874b57ca0e485ca5a2826b685','Харламов','Гарик',NULL,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users2`
--

DROP TABLE IF EXISTS `users2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `password_hash` varchar(256) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users2_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles2` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users2`
--

LOCK TABLES `users2` WRITE;
/*!40000 ALTER TABLE `users2` DISABLE KEYS */;
INSERT INTO `users2` VALUES (1,'user','Иванов','Иван','Иванович','65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5','2021-01-02 13:33:44',1);
/*!40000 ALTER TABLE `users2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_logs`
--

DROP TABLE IF EXISTS `visit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `visit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users2` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_logs`
--

LOCK TABLES `visit_logs` WRITE;
/*!40000 ALTER TABLE `visit_logs` DISABLE KEYS */;
INSERT INTO `visit_logs` VALUES (1,'/',NULL,'2021-01-14 11:28:48'),(2,'/static/styles.css',NULL,'2021-01-14 11:28:48'),(3,'/static/main.js',NULL,'2021-01-14 11:28:48'),(4,'/favicon.ico',NULL,'2021-01-14 11:28:48'),(5,'/visits/logs',NULL,'2021-01-14 11:28:50'),(6,'/users',NULL,'2021-01-14 11:28:56'),(7,'/static/styles.css',NULL,'2021-01-14 11:28:56'),(8,'/static/main.js',NULL,'2021-01-14 11:28:56'),(9,'/auth/login',NULL,'2021-01-14 11:29:02'),(10,'/static/styles.css',NULL,'2021-01-14 11:29:02'),(11,'/static/main.js',NULL,'2021-01-14 11:29:02'),(12,'/auth/login',NULL,'2021-01-14 11:29:05'),(13,'/',1,'2021-01-14 11:29:05'),(14,'/',1,'2021-01-14 11:40:36'),(15,'/auth/login',1,'2021-01-14 11:40:37'),(16,'/',1,'2021-01-14 11:40:39'),(17,'/',1,'2021-01-14 11:40:41'),(18,'/',1,'2021-01-14 11:40:43'),(19,'/',1,'2021-01-14 11:40:47'),(20,'/',1,'2021-01-14 11:41:08'),(21,'/',1,'2021-01-14 11:41:10'),(22,'/',1,'2021-01-14 11:41:24'),(23,'/',1,'2021-01-14 11:41:25'),(24,'/',1,'2021-01-14 11:41:25'),(25,'/',1,'2021-01-14 12:15:37'),(26,'/',1,'2021-01-14 12:15:38'),(27,'/',1,'2021-01-14 12:15:39'),(28,'/',1,'2021-01-14 12:15:39'),(29,'/',1,'2021-01-14 12:15:40'),(30,'/favicon.ico',NULL,'2021-01-14 12:44:49'),(31,'/',NULL,'2021-01-14 14:26:42'),(32,'/static/main.js',NULL,'2021-01-14 14:26:42'),(33,'/favicon.ico',NULL,'2021-01-14 14:26:43'),(34,'/visits/logs',NULL,'2021-01-14 14:26:47'),(35,'/',NULL,'2021-01-14 14:26:52'),(36,'/static/main.js',NULL,'2021-01-14 14:26:52'),(37,'/users',NULL,'2021-01-14 14:26:53'),(38,'/static/main.js',NULL,'2021-01-14 14:26:53'),(39,'/',NULL,'2021-01-14 14:26:54'),(40,'/static/main.js',NULL,'2021-01-14 14:26:54'),(41,'/users',NULL,'2021-01-14 14:26:56'),(42,'/static/main.js',NULL,'2021-01-14 14:26:56'),(43,'/visits/logs',NULL,'2021-01-14 14:27:38'),(44,'/auth/login',NULL,'2021-01-14 14:27:48'),(45,'/static/main.js',NULL,'2021-01-14 14:27:48'),(46,'/visits/logs',NULL,'2021-01-14 14:27:54'),(47,'/favicon.ico',NULL,'2021-01-14 15:01:00'),(48,'/favicon.ico',NULL,'2021-01-17 12:23:48'),(49,'/',NULL,'2021-01-18 17:44:15'),(50,'/static/main.js',NULL,'2021-01-18 17:44:15'),(51,'/favicon.ico',NULL,'2021-01-18 17:44:16'),(52,'/',NULL,'2021-01-18 17:44:56'),(53,'/static/main.js',NULL,'2021-01-18 17:44:56'),(54,'/users',NULL,'2021-01-18 17:44:57'),(55,'/static/main.js',NULL,'2021-01-18 17:44:58'),(56,'/visits/logs',NULL,'2021-01-18 17:44:58');
/*!40000 ALTER TABLE `visit_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-27  2:37:02

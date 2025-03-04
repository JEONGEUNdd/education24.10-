/*
SQLyog Ultimate v8.55 
MySQL - 5.5.5-10.6.18-MariaDB-0ubuntu0.22.04.1 : Database - board_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`board_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `board_db`;

/*Table structure for table `chat_rooms` */

DROP TABLE IF EXISTS `chat_rooms`;

CREATE TABLE `chat_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user1_id` int(11) NOT NULL,
  `user2_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `post_id` int(11) NOT NULL DEFAULT 0,
  `category` enum('walks','petsitters','community_posts') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chat_rooms_user1` (`user1_id`),
  KEY `fk_chat_rooms_user2` (`user2_id`),
  CONSTRAINT `fk_chat_rooms_user1` FOREIGN KEY (`user1_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_chat_rooms_user2` FOREIGN KEY (`user2_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `chat_rooms` */

insert  into `chat_rooms`(`id`,`user1_id`,`user2_id`,`created_at`,`post_id`,`category`) values (31,1,2,'2025-02-08 22:38:00',32,'walks'),(32,2,5,'2025-02-08 22:44:39',15,'petsitters'),(33,2,5,'2025-02-08 22:44:39',15,'petsitters');

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `category` enum('walks','petsitters','community_posts') NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_comments_user` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `comments` */

insert  into `comments`(`id`,`post_id`,`category`,`user_id`,`content`,`created_at`) values (22,17,'community_posts',2,'하루에 3~5만 원 정도가 보통인 것 같아요.','2025-02-08 22:25:56'),(23,15,'community_posts',2,'저도 팁 필요해요ㅜㅜ','2025-02-08 22:26:39'),(24,31,'walks',2,'강아지 성격은 어떤가요?','2025-02-08 22:27:40'),(25,31,'walks',2,'산책 경로는 정해져 있나요?','2025-02-08 22:27:47'),(26,30,'walks',2,'안녕하세요 문의사항 있습니다!!','2025-02-08 22:35:25'),(27,18,'community_posts',2,'산책 도우미 업체 이용해본 적 있는데 괜찮았어요!','2025-02-08 22:42:08'),(28,33,'walks',2,'강아지 종은 어떻게 되나요?','2025-02-08 22:44:14'),(29,15,'petsitters',2,'몇시쯤인가요?','2025-02-08 22:44:38'),(30,20,'community_posts',1,'저도 해봤는데 추천합니다!','2025-02-09 11:59:24'),(31,16,'petsitters',1,'저 가능합니다!','2025-02-09 12:02:58'),(32,19,'petsitters',2,'저 가능합니다!','2025-02-09 12:07:31'),(33,20,'community_posts',2,'오 저도 궁급합니다!','2025-02-09 12:07:43');

/*Table structure for table `community_posts` */

DROP TABLE IF EXISTS `community_posts`;

CREATE TABLE `community_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_community_posts_user` (`user_id`),
  CONSTRAINT `fk_community_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `community_posts` */

insert  into `community_posts`(`id`,`title`,`content`,`user_id`,`created_at`,`image_path`) values (15,'대형견 키우는 분들 모여요!','<p>대형견 키우시는 분들, 산책이나 훈련할 때 팁 좀 공유해주세요! 반려견이 커서 그런지 힘 조절이 어려워요 ㅠㅠ</p>',1,'2025-02-08 22:07:58','realdog7.jpg'),(16,'우리 동네 강아지 산책 서비스 후기 공유해요!','<p>최근에 산책 대행 서비스를 이용했는데, 만족도가 높아요! 혹시 이용하신 분들 후기도 궁금합니다!</p><p><br></p>',5,'2025-02-08 22:12:48',NULL),(17,'강아지 돌봄 비용, 얼마나 드시나요?','<p>반려견을 맡기려고 하는데 비용이 천차만별이더라고요! 보통 어느 정도가 적정 가격일까요?</p>',5,'2025-02-08 22:13:02','face.png'),(18,'반려동물 호텔 VS 가정 돌봄, 뭐가 더 나을까요?','<p>가정 돌봄과 호텔 이용 중 고민 중인데, 각각 장단점이 어떻게 될까요? 경험자 분들의 조언 부탁드려요!</p>',2,'2025-02-08 22:41:32',NULL),(19,'고양이 돌봄 아르바이트 해보신 분 조언 부탁드립니다!','<p>방문 돌봄을 하려고 하는데 주의할 점이나 고객과의 계약 관련 조언 부탁드려요!</p>',2,'2025-02-08 22:41:46',NULL),(20,'반려동물 산책 아르바이트 해보신 분 계신가요?','<p>요즘 강아지 산책 아르바이트를 알아보고 있는데, 좋은 업체나 개인적으로 하시는 분들 추천해 주실 수 있나요?</p>',2,'2025-02-08 22:42:02','dog1.jpg');

/*Table structure for table `likes` */

DROP TABLE IF EXISTS `likes`;

CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `category` enum('walks','petsitters','community_posts') NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_id` (`post_id`,`category`,`user_id`),
  KEY `fk_likes_user` (`user_id`),
  CONSTRAINT `fk_likes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `likes` */

insert  into `likes`(`id`,`post_id`,`category`,`user_id`,`created_at`) values (13,1,'community_posts',1,'2025-01-31 13:32:14'),(23,1,'petsitters',1,'2025-01-31 13:33:00'),(28,3,'petsitters',1,'2025-01-31 14:29:31'),(33,2,'walks',1,'2025-01-31 15:03:30'),(34,2,'community_posts',1,'2025-01-31 15:14:56'),(35,1,'walks',1,'2025-01-31 16:54:26'),(36,8,'community_posts',2,'2025-02-01 13:22:57'),(42,7,'community_posts',1,'2025-02-01 15:46:44'),(46,4,'petsitters',1,'2025-02-03 09:57:10'),(61,12,'walks',1,'2025-02-03 17:40:48'),(84,17,'walks',6,'2025-02-05 17:15:50'),(88,6,'petsitters',6,'2025-02-05 17:16:08'),(108,5,'petsitters',7,'2025-02-05 17:34:35'),(157,6,'community_posts',7,'2025-02-05 19:00:08'),(159,10,'community_posts',7,'2025-02-05 19:07:15'),(169,11,'community_posts',7,'2025-02-05 19:07:44'),(170,8,'community_posts',7,'2025-02-05 19:07:44'),(180,3,'walks',1,'2025-02-05 21:34:32'),(185,8,'petsitters',7,'2025-02-08 12:28:38'),(186,7,'petsitters',7,'2025-02-08 12:28:40'),(190,13,'community_posts',1,'2025-02-08 17:57:51'),(193,14,'community_posts',1,'2025-02-08 22:00:36'),(194,29,'walks',1,'2025-02-08 22:10:46'),(195,17,'community_posts',5,'2025-02-08 22:13:13'),(196,16,'community_posts',5,'2025-02-08 22:13:13'),(197,15,'community_posts',5,'2025-02-08 22:14:19'),(203,15,'community_posts',2,'2025-02-08 22:26:54'),(204,31,'walks',2,'2025-02-08 22:28:57'),(205,32,'walks',2,'2025-02-08 22:28:58'),(207,17,'community_posts',2,'2025-02-08 22:41:11'),(208,20,'community_posts',2,'2025-02-08 22:43:35'),(209,19,'community_posts',2,'2025-02-08 22:43:38'),(210,33,'walks',1,'2025-02-08 22:46:47'),(212,20,'community_posts',4,'2025-02-08 22:47:45'),(213,19,'community_posts',4,'2025-02-08 22:47:50'),(214,37,'walks',7,'2025-02-09 11:49:22'),(215,17,'petsitters',7,'2025-02-09 11:51:41'),(216,15,'petsitters',7,'2025-02-09 11:51:42'),(217,14,'petsitters',7,'2025-02-09 11:51:45'),(218,20,'community_posts',7,'2025-02-09 11:51:49'),(219,16,'petsitters',1,'2025-02-09 12:02:49'),(220,18,'petsitters',2,'2025-02-09 12:05:51'),(221,19,'petsitters',2,'2025-02-09 12:07:23'),(222,20,'petsitters',2,'2025-02-09 12:10:45'),(223,21,'petsitters',1,'2025-02-09 12:12:55');

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_messages_chat` (`chat_id`),
  KEY `fk_messages_sender` (`sender_id`),
  CONSTRAINT `fk_messages_chat` FOREIGN KEY (`chat_id`) REFERENCES `chat_rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `messages` */

insert  into `messages`(`id`,`chat_id`,`sender_id`,`message`,`created_at`) values (35,31,1,'안녕하세요 혹시 학생도 가능할까요?','2025-02-08 22:38:17'),(36,31,1,'위치는 어디쯤일까요?','2025-02-08 22:38:35'),(37,31,2,'네 학생이셔도 가능하세요 ','2025-02-08 22:38:55'),(38,31,2,'위치는 서울시청 근처에요','2025-02-08 22:39:02'),(39,31,1,'시간은 언제쯤으로 생각하세요?','2025-02-09 11:59:44'),(40,31,1,'금요일 5시쯤 괜찮으세요?','2025-02-09 12:03:22'),(41,31,2,'네 가능합니다!','2025-02-09 12:06:00'),(43,31,2,'강아지 성격은 어떤가요?','2025-02-09 12:11:23'),(44,31,1,'온순하고 사람 잘따라요','2025-02-09 12:13:02');

/*Table structure for table `pets` */

DROP TABLE IF EXISTS `pets`;

CREATE TABLE `pets` (
  `pet_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pet_name` varchar(50) NOT NULL,
  `species` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `personality` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `fk_pets_user` (`user_id`),
  CONSTRAINT `fk_pets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pets` */

/*Table structure for table `petsitters` */

DROP TABLE IF EXISTS `petsitters`;

CREATE TABLE `petsitters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image_path` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `province` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `district` varchar(50) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_petsitters_user` (`user_id`),
  CONSTRAINT `fk_petsitters_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `petsitters` */

insert  into `petsitters`(`id`,`title`,`description`,`created_at`,`image_path`,`user_id`,`province`,`city`,`district`,`location`,`updated_at`) values (12,'이번주말 2박 3일 동안 강아지 돌봐주실 분 (비용 협의 가능)','<p>출장 일정이 생겨서 강아지를 돌봐주실 분을 찾습니다. </p><p>가정 돌봄 선호하고, 하루 2회 산책 필수입니다. (비용 협의 가능)</p><p>강아지 온순하고 차분해요</p>','2025-02-08 22:08:52',NULL,1,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:08:52'),(13,'고양이 방문 돌봄 구합니다! ','<p>3일 동안 집을 비우게 되어 하루 한 번 방문하여 사료와 화장실 정리만 해주시면 됩니다! </p><p>관심 있으시면 연락 주세요!</p><p>서울시청 근처입니다. </p><p>하루 5만원 사례비 드립니다</p>','2025-02-08 22:09:49','realdog5.jpg',1,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:09:49'),(14,'? 펫시터님 구해요! (강아지 3일 돌봄, 비용 협의)','<p>평소 돌봄 경험 있으신 분이면 좋겠습니다. 사료, 용품 제공해드리고 보수는 협의 가능합니다!</p><p>말티즈이며 온순하고 사람 잘따릅니다</p><p>서울공원 근처입니다 채팅 부탁드려요</p>','2025-02-08 22:15:27',NULL,5,'서울특별시','중구','소공동','서울특별시 중구 소공동','2025-02-08 22:15:27'),(15,'1박2일 동안 강아지 돌봐주실 분 구합니다ㅜㅜ','<p>출장 일정이 생겨서 강아지를 돌봐주실 분을 찾습니다. </p><p>가정 돌봄 선호하고, 하루 2회 산책 필수입니다. (비용 협의 가능)</p><p><br></p>','2025-02-08 22:16:56','realdog4.jpg',5,'서울특별시','중구','소공동','서울특별시 중구 소공동','2025-02-08 22:16:56'),(16,'강아지 낮 동안 돌봐주실 분 찾습니다 (하루 3만 원)','<p>평일 9시~18시 동안 강아지를 맡아주실 수 있는 분을 찾습니다. 강아지 돌봄 경험 있는 분이면 좋겠습니다!</p>','2025-02-08 22:42:43','realdog6.jpg',2,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:42:43'),(17,'강아지 하루만 맡아주실 분 찾아요','<p>소형견이고 사람 잘따라요 </p><p>이번주 주말이에요 사례비 5만원 드립니다. 강아지 키우시는 분이었으면 좋겠어요</p><p>부산역 인근입니다</p>','2025-02-09 11:51:31',NULL,7,'부산광역시','중구','중앙동','부산광역시 중구 중앙동','2025-02-09 11:51:31'),(18,'고양이 하루 돌봐주실 분 구합니다','<p>3일 동안 집을 비우게 되어 하루 한 번 방문하여 사료와 화장실 정리만 해주시면 됩니다!</p><p>관심 있으시면 연락 주세요!</p><p>서울시청 근처입니다.</p><p>하루 5만원 사례비 드립니다</p>','2025-02-09 12:02:43',NULL,1,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-09 12:02:43'),(19,'고양이 하루 돌봐주실 분!!','<p>3일 동안 집을 비우게 되어 하루 한 번 방문하여 사료와 화장실 정리만 해주시면 됩니다!</p><p>관심 있으시면 연락 주세요!</p><p>서울시청 근처입니다.</p><p>하루 5만원 사례비 드립니다</p>','2025-02-09 12:05:48',NULL,2,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-09 12:05:48'),(20,'강아지 이번주 금요일 돌봐주실 분','<p>3일 동안 집을 비우게 되어 하루 한 번 방문하여 사료와 화장실 정리만 해주시면 됩니다!</p><p>관심 있으시면 연락 주세요!</p><p>서울시청 근처입니다.</p><p>하루 5만원 사례비 드립니다</p>','2025-02-09 12:07:20',NULL,2,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-09 12:07:20'),(21,'이번주 금요일 강아지 돌봐주실 분','<p>사례비 드립니다 서울시청 근처에요</p>','2025-02-09 12:11:04',NULL,2,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-09 12:11:04'),(22,'강아지 하루 돌봐주실 분','<p>사례비 드립니다</p><p>리트리버에요 서울시청근처에서 하루 돌봐주실 분 찾습니다</p>','2025-02-09 12:12:53',NULL,1,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-09 12:12:53');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `province` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `district` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`user_id`,`username`,`nickname`,`email`,`password`,`province`,`city`,`district`) values (1,'홍길동','길동','gildong@example.com','1234','서울특별시','중구',''),(2,'김유리','유리','glass@example.com','3333','서울특별시','중구',''),(3,'이영희','영희','zero@example.com','1111','경기도','성남시 중원구',''),(4,'김영희','영이','kimzero@example.com','1111','경기도','성남시 중원구','성남동'),(5,'이순신','순신','sun@example.com','1111','서울특별시','중구','소공동'),(6,'이하늘','하늘','sky@example.com','1111','부산광역시','중구',''),(7,'이구름','구름','cloud@example.com','0202','부산광역시','중구','중앙동');

/*Table structure for table `walks` */

DROP TABLE IF EXISTS `walks`;

CREATE TABLE `walks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image_path` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `province` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `district` varchar(50) DEFAULT '전체',
  `location` varchar(255) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_walks_user` (`user_id`),
  CONSTRAINT `fk_walks_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `walks` */

insert  into `walks`(`id`,`title`,`description`,`created_at`,`image_path`,`user_id`,`province`,`city`,`district`,`location`,`updated_at`) values (29,'반려견 산책 아르바이트 구합니다!','<p>저녁마다 산책을 도와주실 분을 찾고 있어요! 강아지가 순해서 어려운 점은 없습니다. 관심 있으시면 연락 주세요!</p>','2025-02-08 22:10:13',NULL,1,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:10:13'),(30,'산책 친구 & 도우미 구해요! ','<p>1살 된 강아지가 산책을 어려워해서 함께 걸어주실 분을 찾습니다. 강아지와 친해질 수 있는 분이면 좋겠어요! (시간당 10,000원)</p><p><br></p>','2025-02-08 22:11:29','realdog6.jpg',1,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:11:29'),(31,'우리 강아지 대신 산책해주실 분!!','<p>주중에는 시간이 없어서 강아지를 산책시켜 주실 분을 구합니다.</p><p> 주 3회 이상 가능하신 분이면 좋겠습니다! (비용 협의 가능)</p><p><br></p>','2025-02-08 22:12:31',NULL,5,'서울특별시','중구','소공동','서울특별시 중구 소공동','2025-02-08 22:12:31'),(32,'이번주 금요일 강아지 산책 도와주실 분','<p>회사 일정이 바빠져서 강아지 산책을 도와주실 분을 찾습니다. 하루 1시간 정도 산책 가능하신 분 연락 주세요! </p><p>사람 잘 따르는 강아지입니다.서울공원에서 산책합니다</p>','2025-02-08 22:28:47','realdog.png',2,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:28:47'),(33,'강아지 산책 도와주실 분 구합니다! (비용 지원 가능)','<p>제가 회사 일정이 바빠져서 강아지 산책을 도와주실 분을 찾습니다. 하루 1시간 정도 산책 가능하신 분 연락 주세요</p>','2025-02-08 22:43:23',NULL,2,'서울특별시','중구','전체','서울특별시 중구 전체','2025-02-08 22:43:23'),(34,'말티즈 대신 산책해주실 분 계신가요? ','<p>주중에는 시간이 없어서 강아지를 산책시켜 주실 분을 구합니다.</p><p>주 3회 이상 가능하신 분이면 좋겠습니다!</p><p>성남공원근처입니다.</p>','2025-02-08 22:48:47','realdog7.jpg',4,'경기도','성남시 중원구','성남동','경기도 성남시 중원구 성남동','2025-02-08 22:48:47'),(35,'강아지 산책 도와주실 분 구합니다','<p>회사 일정이 바빠져서 강아지 산책을 도와주실 분을 찾습니다. 하루 1시간 정도 산책 가능하신 분 연락 주세요!</p>','2025-02-08 22:48:57',NULL,4,'경기도','성남시 중원구','성남동','경기도 성남시 중원구 성남동','2025-02-08 22:48:57'),(36,'2/10일 저녁에 비숑 산책해주실 분 구합니다!','<p>저녁에 시간이 안되서 잠깐 강아지 산책해주실 분 찾습니다.</p><p>부산공원 근처에서 1시간정도 산책 도와주시면 될 것같아요</p><p>사례비 조금 드립니다 채팅 주세요!!</p>','2025-02-09 11:47:53','realdog.png',7,'부산광역시','중구','중앙동','부산광역시 중구 중앙동','2025-02-09 11:47:53'),(37,'같이 강아지 산책하실 분~~','<p>강아지 사회성 기를겸 같이 산책하실 분 구하고 있어요 </p><p>매주 토요일 저녁에 하려고 합니다</p><p>부산공원 인근 가능하신분~</p>','2025-02-09 11:48:58',NULL,7,'부산광역시','중구','중앙동','부산광역시 중구 중앙동','2025-02-09 11:48:58');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

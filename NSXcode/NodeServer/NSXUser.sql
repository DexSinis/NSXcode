

--CREATE DATABASE `node` DEFAULT CHARACTER SET utf8 ;
--USE `node`;


-- ----------------------------
-- Table structure for `user`
-- ----------------------------
CREATE TABLE `t_nsxuser` (
  `userID` varchar(36) NOT NULL,
  `location` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  `followersCount` varchar(500) NOT NULL,
  `fansCount` varchar(500) NOT NULL,
  `score` varchar(500) NOT NULL,
  `favoriteCount` varchar(500) NOT NULL,
  `relationship` varchar(500) NOT NULL DEFAULT '0',
  `portraitURL` varchar(500) NOT NULL,
  `gender` varchar(500) NOT NULL,
  `developPlatform` varchar(500) NOT NULL,
  `expertise` varchar(500) NOT NULL,
  `joinTime` varchar(500) NOT NULL,
  `latestOnlineTime` varchar(500) NOT NULL,
  `pinyin` varchar(500) NOT NULL,
  `pinyinFirst` varchar(500) NOT NULL,
  `hometown` varchar(500) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
select * from t_nsxuser;


/*insert into user values('7606ffe4-ec02-4703-98c1-238d5cd99b40','admin','admin',3);

-- ----------------------------
-- Table structure for `resource`
-- ----------------------------
CREATE TABLE `resource` (
  `id` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `createTime` date NOT NULL,
  `url` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `article`
-- ----------------------------
CREATE TABLE `article` (
  `id` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `createTime` date NOT NULL,
  `content` varchar(9000),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; */





CREATE DATABASE `node` DEFAULT CHARACTER SET utf8 ;
USE `node`;


-- ----------------------------
-- Table structure for `user`
-- ----------------------------
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL,
  `u_level` int(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
select * from user;

insert into user values('7606ffe4-ec02-4703-98c1-238d5cd99b40','admin','admin',3);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



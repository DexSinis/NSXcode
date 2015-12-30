/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : localhost
 Source Database       : node

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : utf-8

 Date: 12/30/2015 20:35:57 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `createTime` date NOT NULL,
  `content` varchar(9000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `resource`
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `createTime` date NOT NULL,
  `url` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `resource`
-- ----------------------------
BEGIN;
INSERT INTO `resource` VALUES ('6bdf4e51-246d-4d52-8e84-71f3ca8b74f1', 'dede', 'admin', '2015-12-16', 'Icon-72@2x.png;');
COMMIT;

-- ----------------------------
--  Table structure for `t_account`
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account` (
  `accountName` varchar(200) NOT NULL,
  `password` varchar(500) NOT NULL,
  `userID` varchar(200) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_account`
-- ----------------------------
BEGIN;
INSERT INTO `t_account` VALUES ('13428281935', 'Qq343731621', '1'), ('13428281935', 'wwwww', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189');
COMMIT;

-- ----------------------------
--  Table structure for `t_news`
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `newsId` varchar(36) NOT NULL,
  `title` varchar(30) NOT NULL,
  `body` varchar(255) DEFAULT NULL,
  `images` varchar(500) DEFAULT NULL,
  `ismultipic` varchar(500) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `istopnews` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_news`
-- ----------------------------
BEGIN;
INSERT INTO `t_news` VALUES ('06f08ffa-0abc-4d08-9c3c-99ddada85e0c', 'Mac下的SVN图形客户端 SVNX', 'SVNX是mac下一个开源的图形化操作工具，使用起来比较方便 .支持图形化查看需该，删除，提交，以及解决冲突文件。', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 15:05:45', 'yes'), ('20e8a993-bb33-4472-b434-8a4485e37e02', '基于MVC的快速开发框架 BeeFramework', 'BeeFramework是一款iOS平台的MVC应用快速开发框架，使用Objective-C开发。 其早期原型曾经被应用在QQ空间 、QQ游戏大厅 等多款精品APP中。 BeeFramework 从根本上解决了iOS开发者长期困扰的各种问题，诸如：分层架构如何设计，层与层之间消息传递与处理，网...', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 15:04:45', 'yes'), ('38d55300-5f8b-4392-b59c-a8647f374f16', 'OSX游戏模拟器 Open Emu', 'OpenEmu 是一项开源计划，目的是将游戏模拟带入OS X，使用Cocoa、Core Animation和Quartz等现代OS X技术，使用Sparkle进行自动升级。 Open Emu使用模块化构架，支持游戏引擎插件，这意味着Open Emu可以支持不同的模拟引擎。Open Emu已经测试很长时间了，可...', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 15:03:45', 'yes'), ('54dd7480-b7be-4995-9518-670947c6f216', '钓鱼岛是中国的', '钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的,钓鱼岛是中国的钓鱼岛是中国的', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 15:02:45', 'yes'), ('69bebf80-f36c-42bd-8e09-2c7b2b6851d8', 'OSCHINA iPhone 客户端', '这是 OSCHINA 官方开发的 iPhone 客户端软件，采用原生 API 开发，非 HTML 模式。 采用 GPL 授权协议，鼓励你在这基础上进行修改和完善，并与大家分享你的版本。 下载官方版本：http://www.oschina.net/app...', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 15:06:54', 'yes'), ('7606ffe4-ec02-4703-98c1-238d5cd99b40', 'admin', 'asdsad', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 12:06:45', 'yes'), ('7606ffe4-ec02-4703-98c1-238d5cd99b41', 'jdkobe', 'asdasd', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 14:06:45', 'yes'), ('a7fbfbd6-683f-42ff-963f-5fb21c0c5ce5', '正则表达式库 RegexKitLite', 'RegexKitLite 是一个轻量级的 Objective-C 的正则表达式库，支持 Mac OS X 和 iOS，使用 ICU 库开发。 ; ...', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 15:09:45', 'no'), ('cc2a9c5b-635e-4a11-97a1-5a4e06240f45', '基于MVVM 的IOS开发框架 EasyIOS', 'Swift版本最新发布： https://github.com/EasyIOS/EasyIOS-Swift 全新基于MVVM(Model-View-ViewModel)编程模式架构，开启EasyIOS开发函数式编程新篇章。 EasyIOS 2.0类似AngularJs，最为核心的是：MVVM、ORM、模块化、自动化双向数据绑定、等等 关于有疑问...', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 20:06:45', 'no'), ('e5f24e42-6705-45be-a3a4-bcea88b576e0', '开源的移动分析应用 Countly', 'Countly 是一个实时的、开源的移动分析应用，通过收集来自手机的数据，并将这些数据通过可视化效果展示出来以分析移动应用的使用和最终用户的行为。一旦你打开该程序的面板，你会发现数据的监控是那么的简单。 Countly 提供了 Android 和 iOS 两种版本的开...', 'http://pic2.zhimg.com/06921ceb3b3929b5313fb26d42d40ba1.jpg,http://pic3.zhimg.com/5d333f49128d8f0dd0369c7e47ed294e.jpg,http://pic4.zhimg.com/c5257aeafb79891fb5d139c0d595b143.jpg', 'no', 'http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg', '2015-12-26 18:06:45', 'no');
COMMIT;

-- ----------------------------
--  Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `userID` varchar(36) NOT NULL,
  `location` varchar(30) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `followersCount` int(255) DEFAULT NULL,
  `fansCount` int(255) DEFAULT NULL,
  `score` int(255) DEFAULT NULL,
  `favoriteCount` int(255) DEFAULT NULL,
  `relationship` int(255) DEFAULT '0',
  `portraitURL` varchar(500) DEFAULT NULL,
  `gender` varchar(500) DEFAULT NULL,
  `developPlatform` varchar(500) DEFAULT NULL,
  `expertise` varchar(500) DEFAULT NULL,
  `joinTime` date DEFAULT NULL,
  `latestOnlineTime` date DEFAULT NULL,
  `pinyin` varchar(500) DEFAULT NULL,
  `pinyinFirst` varchar(500) DEFAULT NULL,
  `hometown` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_user`
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES ('1', '1', 'dexsinis', '123', '2332', '22223', '12', '12', 'http://tp2.sinaimg.cn/2005243885/180/40014873327/1', '123', '123', '123', '2015-12-12', '2015-12-12', '12', '12', '12'), ('4f0f3105-dd04-4105-a2b5-93fa5bc0b189', null, null, null, null, null, null, '0', null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL,
  `u_level` int(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('7606ffe4-ec02-4703-98c1-238d5cd99b40', 'admin', 'admin', '3'), ('a7fb9aef-ed4e-4fea-bd20-c58eed4e5939', 'asd', 'asdasd', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

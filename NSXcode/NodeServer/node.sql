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

 Date: 01/05/2016 19:59:57 PM
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
  `userId` varchar(200) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_account`
-- ----------------------------
BEGIN;
INSERT INTO `t_account` VALUES ('13428281935', 'Qq343731621', '1'), ('13428281935', 'wwwww', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189');
COMMIT;

-- ----------------------------
--  Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `commentId` varchar(200) NOT NULL,
  `username` varchar(500) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `timeString` varchar(500) DEFAULT NULL,
  `floor` int(255) DEFAULT NULL,
  `newsId` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `likeCount` varchar(255) DEFAULT NULL,
  `commentCount` varchar(255) DEFAULT NULL,
  `storey` int(255) DEFAULT NULL,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_comment`
-- ----------------------------
BEGIN;
INSERT INTO `t_comment` VALUES ('15c3fc80-5893-4649-93e6-d22907d25c16', '测试', '网易广东省深圳市手机网友 ', '测试测试测试测试测试测试测试测试测试…………然后崩溃了。', '2016-01-05 10:46:37 +0000', '3', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1391', '399', '5'), ('1a95a0d5-a96c-4c13-abdd-7d5e00950a9a', '(19.23.*.*)', '网易广东省广州市手机网友 ', '测试测试测试', '2016-01-05 10:46:37 +0000', '1', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '147', '216', '5'), ('2c487f7d-89a3-4d89-a3a8-288ee316e333', 'YUL大', '网易加拿大手机网友 ', '有病需趁早！ 累不累？有病需趁早！ 累不累有病需趁早！ 累不累', '2016-01-05 10:46:37 +0000', '6', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '151', '651', '6'), ('49dab5cf-9abe-4ed7-b0ac-fa71dc0e645d', '测试测试测试', '网易广东省深圳市手机网友 ', '测试测试测试测试…@######&*(IJKHG*&()PUIOPOIUYTLK', '2016-01-05 10:46:37 +0000', '2', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '392', '612', '6'), ('4dc80a9d-db80-4a61-b665-6136d2378294', '测试', '网易广东省深圳市手机网友 ', '确实！确实！确实！确实！', '2016-01-05 10:46:37 +0000', '2', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1791', '468', '5'), ('5000a492-5e4f-4d60-8645-5baec66cf83b', '测试', '网易江苏省手机网友 ', '花自己的钱 呢', '2016-01-05 10:46:37 +0000', '2', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '400', '393', '2'), ('5a26c074-1f17-4d37-bc25-404a106b09d3', '{{v{{', '网易四川省成都市网友 ', '科普一下：真是酱紫滴，测试测试测试测试…UIOPOIUYTLK就崩溃了823,。真是酱紫滴，测试测试测试测试…UIOPOIUYTLK就崩溃了823,。真是酱紫滴，测试测试测试测试…UIOPOIUYTLK就崩溃了823,。。', '2016-01-05 10:46:37 +0000', '5', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1615', '212', '6'), ('67e4a3c3-4155-4237-b8f1-546121463e44', '测试', '网易江苏省手机网友 ', '花自己的钱 呢', '2016-01-05 10:46:37 +0000', '2', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '48', '487', '1'), ('6bf44159-c013-43e2-872d-6d69672ea4a7', 'KSSLOPIS', '网易湖南省手机网友 ', '服了，了。服了，了。服了，了。服了，了。服了，了。', '2016-01-05 10:46:37 +0000', '9', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1691', '966', '6'), ('72130bd6-020d-4e6b-8603-612fcae4bf8d', '(11.23.*.*)', '网易广东省广州市手机网友 ', '测试测试测试测试…UIOPOIUYTLK。', '2016-01-05 10:46:37 +0000', '1', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '494', '582', '6'), ('82d875d1-0258-4f01-ba13-01f5f356dea7', '测试', '网易江苏省手机网友 ', '花自己的钱 呢', '2016-01-05 10:46:37 +0000', '2', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1563', '625', '3'), ('84739969-fbf8-464d-acc7-8282fa2285f6', '(16.24.*.*)', '网易广东省广州市手机网友 ', ' TYUIOIUYTUI 追那些。', '2016-01-05 10:46:37 +0000', '1', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '292', '475', '1'), ('854a33b4-7165-4d9a-9d5e-457aca114c77', '测试', '网易江苏省手机网友 ', '花自己的钱 呢', '2016-01-05 10:46:37 +0000', '2', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1449', '993', '4'), ('8cce5a14-69bf-42b4-8755-2389660958a7', 'sadfLLL大', '网易广西玉林市手机网友 ', '5楼，WQEwsfds吧', '2016-01-05 10:46:37 +0000', '7', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '312', '69', '6'), ('a456d694-5c1c-4e15-a998-5b1e3b1cf381', '测试测试', '网易广东省深圳市手机网友 ', '测试测试测试测试测试测试测试测试测试测试测试测试测试…………测试测试测试测试测试测试测试测试测试…………。', '2016-01-05 10:46:37 +0000', '5', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1523', '660', '5'), ('a63d4133-0589-49e2-9fa4-6ccb2c066846', '测!!!试', '网易广东省深圳市手机网友 ', '测试测试测试测试测试测试测试测试测试……试测试测试测试测试测试……然后试测试测试测试测试测试。', '2016-01-05 10:46:37 +0000', '4', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1406', '494', '5'), ('aaa04836-0795-4e93-8422-107c3a0b214a', 'ip360.55.*.*', '网易四川省手机网友 ', '5楼那个测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试服了，了。服了，了。服了，了。服了，了。服了，了。服了，了。服了，了。', '2016-01-05 10:46:37 +0000', '10', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '366', '107', '6'), ('c80033c6-b383-46c0-89c9-bae4bca782bc', '测试测试测cc试', '网易广东省深圳市手机网友 ', '测试测试测试测试…UIOPOIUYTLK就崩溃了823,。', '2016-01-05 10:46:37 +0000', '3', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '588', '276', '6'), ('ce6fd9e0-8b49-4578-9a55-bf36b3e7b7f3', '(16.24.*.*)', '网易广东省广州市手机网友 ', ' TYUIOIUYTUI 追那些。', '2016-01-05 10:46:37 +0000', '1', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '484', '736', '3'), ('cfda4624-73af-487c-bc20-265ce99f1d76', 'L!LLLL大', '网易江苏省手机网友 ', 'asfa样casdafa', '2016-01-05 10:46:37 +0000', '8', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1201', '792', '6'), ('dede2c6f-0863-42c1-ac9b-576b60132d34', '(16.24.*.*)', '网易广东省广州市手机网友 ', ' TYUIOIUYTUI 追那些。', '2016-01-05 10:46:37 +0000', '1', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '848', '659', '4'), ('e3e9f90a-df9d-42f3-9fcf-f2e14aa0eeb5', '&%IO101', '网易广东省佛山市南海区网友 ', '搬完服了，了。服了，了。服了，了。？', '2016-01-05 10:46:37 +0000', '10', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '208', '957', '6'), ('ec7ab753-cbc8-4da4-94d5-043a895f8c35', '(19.73.*.*)', '网易安徽省合肥市手机网友 ', '真是酱紫滴，测试测试测试测试…UIOPOIUYTLK就崩溃了823,。真是酱紫滴 。', '2016-01-05 10:46:37 +0000', '4', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '1537', '861', '6'), ('edeaa146-5f79-4c49-9484-fa5816648e71', '(16.24.*.*)', '网易广东省广州市手机网友 ', ' TYUIOIUYTUI 追那些。', '2016-01-05 10:46:37 +0000', '1', '20e8a993-bb33-4472-b434-8a4485e37e02', '4f0f3105-dd04-4105-a2b5-93fa5bc0b189', '219', '476', '2');
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
  `userId` varchar(36) NOT NULL,
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
  PRIMARY KEY (`userId`)
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


/**
 *
 * Author:Liuchang
 * Date:2015-11-18
 * Email:lc9401@gmail.com
 *
 */


var express = require('express');
var router = express.Router();
var crypto = require("crypto");
var user = require("../models/user");


router.get('/newsList', function(req, res, next) {
	var data = {"newsArray":[{"newsID": "1", "title": "基于MVC的快速开发框架 BeeFramework","body": "BeeFramework是一款iOS平台的MVC应用快速开发框架，使用Objective-C开发。 其早期原型曾经被应用在QQ空间 、QQ游戏大厅 等多款精品APP中。 BeeFramework 从根本上解决了iOS开发者长期困扰的各种问题，诸如：分层架构如何设计，层与层之间消息传递与处理，网..."},
             {"newsID": "2", "title": "OSCHINA iPhone 客户端","body": "这是 OSCHINA 官方开发的 iPhone 客户端软件，采用原生 API 开发，非 HTML 模式。 采用 GPL 授权协议，鼓励你在这基础上进行修改和完善，并与大家分享你的版本。 下载官方版本：http://www.oschina.net/app..."},
             {"newsID": "3", "title": "开源的移动分析应用 Countly","body": "Countly 是一个实时的、开源的移动分析应用，通过收集来自手机的数据，并将这些数据通过可视化效果展示出来以分析移动应用的使用和最终用户的行为。一旦你打开该程序的面板，你会发现数据的监控是那么的简单。 Countly 提供了 Android 和 iOS 两种版本的开..."},
             {"newsID": "4", "title": "Mac下的SVN图形客户端 SVNX","body": "SVNX是mac下一个开源的图形化操作工具，使用起来比较方便 .支持图形化查看需该，删除，提交，以及解决冲突文件。"},
             {"newsID": "5", "title": "OSX游戏模拟器 Open Emu","body": "OpenEmu 是一项开源计划，目的是将游戏模拟带入OS X，使用Cocoa、Core Animation和Quartz等现代OS X技术，使用Sparkle进行自动升级。 Open Emu使用模块化构架，支持游戏引擎插件，这意味着Open Emu可以支持不同的模拟引擎。Open Emu已经测试很长时间了，可..."},
             {"newsID": "6", "title": "基于MVVM 的IOS开发框架 EasyIOS","body": "Swift版本最新发布： https://github.com/EasyIOS/EasyIOS-Swift 全新基于MVVM(Model-View-ViewModel)编程模式架构，开启EasyIOS开发函数式编程新篇章。 EasyIOS 2.0类似AngularJs，最为核心的是：MVVM、ORM、模块化、自动化双向数据绑定、等等 关于有疑问..."},
             {"newsID": "7", "title": "正则表达式库 RegexKitLite","body": "RegexKitLite 是一个轻量级的 Objective-C 的正则表达式库，支持 Mac OS X 和 iOS，使用 ICU 库开发。 ; ..."},
             ],"totalNumber": "7"};
						 res.writeHead(200, {'Content-Type': 'application/json'});
             res.end(JSON.stringify(data));
});



/* GET home page. */
router.get('/', function(req, res, next) {
	res.render('login', { title: '样式写到吐血啊喂！'});
});


/*login*/
router.get('/login', function(req, res, next) {
	res.render('login', { title: '注意登陆用的post不写下面的就404啊喂！'});
});
router.post('/login', function(req, res, next){

	var name_ = req.body.account;
	var md5 = crypto.createHash("md5");
	/* 暂时不用密码加密 如若使用注释取消掉 把下面req.body.pwd换成pwd_就行 */
	//var pwd_ = md5.update(req.body.pwd).digest("base64");

	user.get(name_, function(err, user_, fields){
		if(!user_){
			console.log("用户不存在");
			res.send(false);
		}else{
			if(user_.password!=req.body.pwd){
				console.log("密码错误");
				res.send(false);
			}else{
				req.session.user = user_;
				res.send(true);
		}
		}
	});
});


router.get('/home', function(req, res, next) {
	res.render('index', { title: '后端码农啊界面纯手写啊喂布局好难啊不知道怎么才算好看啊喂！'});
});


module.exports = router;

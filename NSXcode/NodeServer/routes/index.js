
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
var news = require("../models/news");
var account = require("../models/account");
var comment = require("../models/comment");


router.post('/account', function(req, res, next) {
	var accountName = req.body.accountName;
	var password = req.body.password;
	account.get(accountName,password,function(err, account_, fields){
		//if(!user_){
		if(account_==null)
		{
			var jsonData = {"code":1,"message":"登录失败"};
			res.end(JSON.stringify(jsonData));
		}else
		{
			console.log(account_);
			res.writeHead(200, {'Content-Type': 'application/json'});
			var accountList_ = new Array();
			accountList_[0] = account_;
			var jsonData = {"accountArray":accountList_,"code":0,"message":"登录成功"};
			res.end(JSON.stringify(jsonData));
		}

	});
});



router.post('/accountInsert', function(req, res, next) {
	var account_ = new account({
		accountName: req.body.accountName,
		password: req.body.password
	});

	account_.add(function(err){
		if(err){
			throw err;
		}else{
			//res.send(true);
			res.writeHead(200, {'Content-Type': 'application/json'});
			var jsonData = {"code":0,"message":"注册成功"};
			res.end(JSON.stringify(jsonData));
		}
	});
});



router.post('/user', function(req, res, next) {
	var userId = req.body.userId;
	user.get(userId, function(err, user_, fields){
		//if(!user_){
		console.log(user_);
		var userList_ = new Array();
		userList_[0] = user_;
		var jsonData = {"userArray":userList_,"code":0,"message":"登录成功"};
		res.writeHead(200, {'Content-Type': 'application/json'});
		res.end(JSON.stringify(jsonData))
	});
});


router.post('/news', function(req, res, next) {
	//news.get(name_, function(err, news, fields){
	//	console.log(news);
	//	//if(!news){
	//	//	console.log("用户不存在");
	//	//	res.send(false);
	//	//}else{
	//	//	if(news.password!=req.body.pwd){
	//	//		console.log("密码错误");
	//	//		res.send(false);
	//	//	}else{
	//	//		req.session.user = user_;
	//	//		res.send(true);
	//	//	}
	//	//}
	//	res.writeHead(200, {'Content-Type': 'application/json'});
	//	res.end(JSON.stringify(news));
	//});
	var newsId = req.body.param.newsId;
	//var newsId ="7606ffe4-ec02-4703-98c1-238d5cd99b40";
	news.get(newsId, function(err, news_, fields){
		//if(!user_){
			console.log(news_);
		var newsList_ = new Array();
		newsList_[0] = news_;
		var jsonData = {"newsArray":newsList_,"code":0,"message":"登录成功"};
		res.writeHead(200, {'Content-Type': 'application/json'});
		res.end(JSON.stringify(jsonData));
		//	res.send(false);
		//}else{
		//	if(user_.password!=req.body.pwd){
		//		console.log("密码错误");
		//		res.send(false);
		//	}else{
		//		req.session.user = user_;
		//		res.send(true);
		//	}
		//}
	});
});





router.post('/commentViewModel', function(req, res, next) {

	var keyword =  "7"//req.body.param.keyword;
	//keyword ="7";
	var daysDataList;
	comment.getList(keyword, function(err, hotPostList_, fields){
		//if(!user_){
		comment.getTopList(keyword, function(err, commonList, fields){
			var data = {
				viewModel:{
					/*date : "20151226",
					daysDataList : newsList_,
					top_stories: topNewsList_ */
					hotPosts:hotPostList_,
					commonPosts:commonList

				}}
			res.writeHead(200, {'Content-Type': 'application/json'});
			res.end(JSON.stringify(data));
		})
	});

});

router.post('/commentInsert', function(req, res, next) {


	var comment_ = new comment({
	 commentId : req.body.commentId,
	 username : req.body.username,
	 address : req.body.address,
	 comment : req.body.comment,
	 timeString : req.body.timeString,
	 newsId : req.body.newsId,
	 userId : req.body.userId,
	 likeCount : req.body.likeCount,
	 commentCount : req.body.commentCount,
		storey : req.body.storey,

	});

	comment.getMaxFloor(comment_.newsId,comment_.storey,function(err, result, fields){
		var floor_ =new String(result[0].currentfloor);
		comment_.floor = Number(floor_)+1;
		comment_.add(function(err){
			if(err){
				throw err;
			}else{
				res.send(true);
			}
		});
	});


});


router.post('/newsViewModel', function(req, res, next) {

	var keyword =  "7"//req.body.param.keyword;
	//keyword ="7";
	var daysDataList;
	news.getList(keyword, function(err, newsList_, fields){
		//if(!user_){
		news.getTopList(keyword, function(err, topNewsList_, fields){
			var data = {
				viewModel:{
					date : "20151226",
					daysDataList : newsList_,
					top_stories: topNewsList_
				}}
			res.writeHead(200, {'Content-Type': 'application/json'});
			res.end(JSON.stringify(data));
		})
	});

});

router.post('/newsContentViewModel', function(req, res, next) {

       var  data = {
		   "body": "<div class=\"main-wrap content-wrap\">\n<div class=\"headline\">\n\n<div class=\"img-place-holder\"></div>\n\n\n\n</div>\n\n<div class=\"content-inner\">\n\n\n\n\n<div class=\"question\">\n<h2 class=\"question-title\">老炮儿里法拉利恩佐车漆的价钱？</h2>\n\n<div class=\"answer\">\n\n<div class=\"meta\">\n<img class=\"avatar\" src=\"http://pic3.zhimg.com/d583a2d0fe17155e29143e21b912fc66_is.jpg\">\n<span class=\"author\">戴少鹤，</span><span class=\"bio\">涂装逗逼狮/主机厂从业人员/WOWer/</span>\n</div>\n\n<div class=\"content\">\n<p><strong>（有剧透）</strong></p>\r\n<p>去看了老炮儿，确实很精彩，我看电影比较少，这大概是我今年看过的最精彩的剧情片了，一帮老戏骨演的也很有味，没有血溅街头，没有钢筋肌肉，却有着辛辣的荷尔蒙，就好像小卖部里随处可见的二两半的二锅头，瓶子小小的，包装简陋，不起眼的摆在那里，倘若你一口闷了下去，也会呛得你咳嗽连连，眼泛泪水。出于职业的敏感，当我看到那辆恩佐车门上的那一道子的时候，眼角不禁的抽抽了一下，感觉那一道子就好像划在了脸上一样，这种事情放在恩佐身上，已经不是一个简单的补漆的事情。</p>\r\n<p>首先要明白，<strong>恩佐并不仅仅是一辆很贵的跑车，它是一件为了纪念而诞生的艺术品，也是法拉利造车技术和理念的大成之作</strong>，购买条件严苛，全球总共限产 400 台，一台送给了上帝，对外出售的只有 399 台。这种艺术品，任何一点损伤都是难以接受的，在知乎上，我一直在讲一个理念，那就是&ldquo;车漆的完美成型于出炉的一瞬间，一经损坏，即是永久&rdquo;。而那一道贯穿整个车门划痕，直接把那辆恩佐从一个完美的艺术品杀破成了一个有瑕疵的艺术品，即使用神乎其技的手法将车漆修补到近乎完美，也无法掩盖它已经不再完美的事实。这种行为，根本不是钱不钱的问题，这简直就是在犯罪！</p>\r\n<p>唉，算了，平复一下心情，从技术方面来讲一下吧，我们先来讲一下那道十万的划痕，其实看到那里的时候，我女票也很惊讶的问我，真的要十万吗？</p>\r\n<p>我告诉她说，&ldquo;其实，<strong>十万块钱搞不定的！</strong>&rdquo;</p>\r\n<p>大家看电影里那道划痕，是泛着灰白色，这说明这道划痕是漆面划痕里最严重的一种，已经伤到了电泳层，晓波那孙子下手真是狠啊，对于这种情况，一般的车也就是正常的补漆，但恩佐这种艺术品，没那么简单。里面那个抽老炮六爷耳光的小哥说&ldquo;我这车漆都要从英国进口，一道划痕喷好至少要十万！&rdquo;，事实上，我很怀疑他是否真的有能力来补好，真正的恩佐被划了这么大的一道，那种改装厂是根本没有能力修补的，应该是把车运回意大利摩德纳进行修补，单是运费，保险费都要数万了，到摩德纳之后，补漆的材料费，工时费，厂家的利润，总共加起来何止十万。</p>\r\n<p>我们再来说一下那个值半个车价的车门，后面六爷的猪队友灯罩儿为了尽自己的一份力，偷偷地去用自己的方法私自补漆，结果把整个车门毁了，小飞说要全车喷漆，价钱差不多是全车的一半。</p>\r\n<p><strong>一个车门值半个车，一点都不夸张。</strong></p>\r\n<p>对普通的车来讲，顶多是把整个车门重喷，有些人比较讲究，就干脆换个车门，但对于恩佐，并没有那么简单，最次也要全车喷漆，而不是简单地喷个车门。在最开始我就说了，恩佐不仅仅是一辆普通的跑车，更是一个艺术品，应该是把它当作一个艺术品来看。一个艺术品，最基本的要素就是完美，即使残缺，无序，乖离，也是一种完美的残缺无序乖离。</p>\r\n<p>那么对于这种艺术品的修补最容易出现的问题是什么呢？</p>\r\n<p>跟普通的家用车补漆一样，最容易出现的问题就是<strong>色差。</strong>对于色差问题，普通车在 4S 店补漆的时候，一般肉眼分别不出来就可以了。但对于恩佐这种艺术品来讲，却是完全不能接受的。这就是为什么只是一扇车门花了，但小飞却说要全车喷漆，可以看得出来，他确实是一个懂车的人，因为如果把整个车门打磨补漆，那么整个车门喷完后必然会与整个车身产生色差，大家在外面补漆也是一样的，要记住，<strong>补漆的范围越大，补漆的地方与周围的色差就越明显。</strong>对于普通车来讲，只要不是很严重，倒也可以接受，但是恩佐表示，这完全不能接受。为了追求漆面的完美，就只能把整个车身都重新喷漆，这要求的难度极高，可以肯定，国内做不了，估计要返到摩德纳来喷，整个过程的工时费、材料费、工时补偿和利润等所有的开销加起来 300 万，并不算是太夸张。这其中主要是工时费，要知道，我们公司请一个日本的技术人员来现场调试设备，一人一天的开销就是 2 万，这还不算贵，某个朋友公司里请一个美国人，每小时 400 美元，从他离开美国公司去机场的路上开始算，一直到他干完活回到美国公司结束。法拉利怎么来算这笔钱，说实话，我也不清楚，但可以肯定，不会便宜。事实上，这种方法对于恩佐而言，只是一个下策，上策是把整个车身换掉。把所有的零部件拆下来，再重新总装到新的车身上，这样可以让恩佐再次变得完美。这个方法的难点在于，要重启恩佐的生产线。要知道恩佐早已经停产了，生产线据说给废除了，重启生产线的话，费用平摊下来，估计单台车身也是百万级别的了。</p>\r\n<p>再啰嗦一句，<strong>恩佐是辆好车，《老炮儿》是部好电影，去看吧，值那个价儿。</strong></p>\r\n<p>@贰肆 在评论区里提了一个好问题<strong>&ldquo;直接换一个车门会不会便宜一些？&rdquo;</strong></p>\r\n<p>恩，其实这也是一个方案，但这个方案有两个问题。</p>\r\n<p>1、<strong>恩佐的生产线问题。</strong>恩佐已经停产，生产线据说废除了，由于车门是一个钣金件，即使生产一个车门，也得把冲压，焊接，涂装三大车间再走一遍，四大车间走了三个，差不多算是重启生产线了，重启恩佐的生产线是一件非常大的事情，花费可能更大，如果不走生产线，而只是手工把几块板材敲成完全合乎规格的车门，然后手工焊接，在手工涂装，那花费倒是小事，有没有人愿意做那是个大问题，毕竟能够完全手工做出一个完全合乎规格标准车门的人，即使法拉利也没有几个人吧。</p>\r\n<p>2、<strong>色差问题。</strong>凡是说起补漆，我就必定会提色差问题，色差就是涂装工程师一个终身的宿敌。<strong>所有的车漆从见到阳光的那一刻起，就会开始褪色，这是车漆的物理特性，上至千万级别的宾利，下至七八万的飞度都无法避免。</strong>优秀的车漆和劣质的车漆分别就在于好车漆褪色慢，并且褪色均匀，在车子的使用寿命之内，你很难看出车漆褪色了。如果给恩佐换一个车门，<strong>只要那个车门不是跟那一辆恩佐同时涂装的，那么它的褪色程度跟那辆恩佐就是不一样的，那样就破坏了恩佐的统一性。我说过，恩佐是为了纪念而诞生的艺术品，它天生是用作收藏，艺术品最重要的就是完美和统一。</strong>如果给那辆恩佐换一个车门，经过数十年时光的磨砺，忽然有一天，在午后明媚的阳光下，藏主发现那个车门的红色似乎与车身的红色不太一致，这一瞬间，艺术的完美就碎裂了，你说藏主会不会有一种内心崩溃的感觉。所以，为了艺术性的完美统一，单纯的换个车门是不行的，最好的做法是把整个车身换掉。</p>\r\n<p><strong>未经许可，禁止转载。（知乎日报已获得授权）</strong></p>\n</div>\n</div>\n\n\n<div class=\"view-more\"><a href=\"http://www.zhihu.com/question/38871911\">查看知乎讨论<span class=\"js-question-holder\"></span></a></div>\n\n</div>\n\n\n</div>\n</div>",
		   "image_source": "《老炮儿》",
		   "title": "李易峰划了车，吴亦凡让冯小刚赔十万，其实十万哪够啊",
		   "image": "http://pic1.zhimg.com/c1cf2f534dd11384facdd879ff209894.jpg",
		   "share_url": "http://daily.zhihu.com/story/7667220",
		   "js": [],
		   "ga_prefix": "123015",
		   "type": 0,
		   "id": 7667220,
		   "css": [
			   "http://news.at.zhihu.com/css/news_qa.auto.css?v=77778"
		   ]
	   };
			res.writeHead(200, {'Content-Type': 'application/json'});
			res.end(JSON.stringify(data));


});

router.get('/news/latest', function(req, res, next) {
	//var data = {"newsArray":[{"newsID": "1", "title": "基于MVC的快速开发框架 BeeFramework","body": "BeeFramework是一款iOS平台的MVC应用快速开发框架，使用Objective-C开发。 其早期原型曾经被应用在QQ空间 、QQ游戏大厅 等多款精品APP中。 BeeFramework 从根本上解决了iOS开发者长期困扰的各种问题，诸如：分层架构如何设计，层与层之间消息传递与处理，网..."},
	//        {"newsID": "2", "title": "OSCHINA iPhone 客户端","body": "这是 OSCHINA 官方开发的 iPhone 客户端软件，采用原生 API 开发，非 HTML 模式。 采用 GPL 授权协议，鼓励你在这基础上进行修改和完善，并与大家分享你的版本。 下载官方版本：http://www.oschina.net/app..."},
	//        {"newsID": "3", "title": "开源的移动分析应用 Countly","body": "Countly 是一个实时的、开源的移动分析应用，通过收集来自手机的数据，并将这些数据通过可视化效果展示出来以分析移动应用的使用和最终用户的行为。一旦你打开该程序的面板，你会发现数据的监控是那么的简单。 Countly 提供了 Android 和 iOS 两种版本的开..."},
	//        {"newsID": "4", "title": "Mac下的SVN图形客户端 SVNX","body": "SVNX是mac下一个开源的图形化操作工具，使用起来比较方便 .支持图形化查看需该，删除，提交，以及解决冲突文件。"},
	//        {"newsID": "5", "title": "OSX游戏模拟器 Open Emu","body": "OpenEmu 是一项开源计划，目的是将游戏模拟带入OS X，使用Cocoa、Core Animation和Quartz等现代OS X技术，使用Sparkle进行自动升级。 Open Emu使用模块化构架，支持游戏引擎插件，这意味着Open Emu可以支持不同的模拟引擎。Open Emu已经测试很长时间了，可..."},
	//        {"newsID": "6", "title": "基于MVVM 的IOS开发框架 EasyIOS","body": "Swift版本最新发布： https://github.com/EasyIOS/EasyIOS-Swift 全新基于MVVM(Model-View-ViewModel)编程模式架构，开启EasyIOS开发函数式编程新篇章。 EasyIOS 2.0类似AngularJs，最为核心的是：MVVM、ORM、模块化、自动化双向数据绑定、等等 关于有疑问..."},
	//        {"newsID": "7", "title": "正则表达式库 RegexKitLite","body": "RegexKitLite 是一个轻量级的 Objective-C 的正则表达式库，支持 Mac OS X 和 iOS，使用 ICU 库开发。 ; ..."},
	//        ],"totalNumber": "7"};
	//					 res.writeHead(200, {'Content-Type': 'application/json'});
	//        res.end(JSON.stringify(data));

	var data = {
		date : "20151226",
		stories : [{
			"ga_prefix":122614,
			 id:122614,
			images :["http://pic1.zhimg.com/7dfe6e3ad3f4099bbc4bc2828c143f30.jpg"],
			title  :"OSCHINA iPhone 客户端",
	        type : 0 },
			{
				"ga_prefix":122613,
				id:122613,
				images :["http://pic1.zhimg.com/7dfe6e3ad3f4099bbc4bc2828c143f30.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			},
			{
				"ga_prefix":122612,
				id:122612,
				images :["http://pic1.zhimg.com/7dfe6e3ad3f4099bbc4bc2828c143f30.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			},
			{
				"ga_prefix":122611,
				id:122611,
				images :["http://pic1.zhimg.com/7dfe6e3ad3f4099bbc4bc2828c143f30.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			},
			{
				"ga_prefix":122610,
				id:122610,
				images :["http://pic1.zhimg.com/7dfe6e3ad3f4099bbc4bc2828c143f30.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			}],
		"top_stories": [{
			"ga_prefix":122609,
			id:122609,
			images :["http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg"],
			title  :"OSCHINA iPhone 客户端",
			type : 0 },
			{
				"ga_prefix":122608,
				id:122608,
				images :["http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			},
			{
				"ga_prefix":122607,
				id:122607,
				images :["http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			},
			{
				"ga_prefix":122606,
				id:122606,
				images :["http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			},
			{
				"ga_prefix":122605,
				id:122605,
				images :["http://pic3.zhimg.com/16016ec9205571353c98213f4a3fb3b2.jpg"],
				title  :"OSCHINA iPhone 客户端",
				body:"OSCHINA iPhone 客户端",
				type : 0
			}]
	}

	res.writeHead(200, {'Content-Type': 'application/json'});
	res.end(JSON.stringify(data));

	//var keyword =  "7"//req.body.param.keyword;
	////keyword ="7";
	//news.getList(keyword, function(err, newsList_, fields){
	//	//if(!user_){
	//	console.log(newsList_);
	//	var jsonData = {"newsArray":newsList_,"totalNumber":newsList_.length};
    //
	//	res.writeHead(200, {'Content-Type': 'application/json'});
	//	//for(var i=0;i<newsList_.length;i++)
	//	//{
	//	//	jsonData[i]=newsList_[i];
	//	//}
	//	res.end(JSON.stringify(jsonData));
	//});
});

router.post('/newsArray', function(req, res, next) {
	//var data = {"newsArray":[{"newsID": "1", "title": "基于MVC的快速开发框架 BeeFramework","body": "BeeFramework是一款iOS平台的MVC应用快速开发框架，使用Objective-C开发。 其早期原型曾经被应用在QQ空间 、QQ游戏大厅 等多款精品APP中。 BeeFramework 从根本上解决了iOS开发者长期困扰的各种问题，诸如：分层架构如何设计，层与层之间消息传递与处理，网..."},
	//        {"newsID": "2", "title": "OSCHINA iPhone 客户端","body": "这是 OSCHINA 官方开发的 iPhone 客户端软件，采用原生 API 开发，非 HTML 模式。 采用 GPL 授权协议，鼓励你在这基础上进行修改和完善，并与大家分享你的版本。 下载官方版本：http://www.oschina.net/app..."},
	//        {"newsID": "3", "title": "开源的移动分析应用 Countly","body": "Countly 是一个实时的、开源的移动分析应用，通过收集来自手机的数据，并将这些数据通过可视化效果展示出来以分析移动应用的使用和最终用户的行为。一旦你打开该程序的面板，你会发现数据的监控是那么的简单。 Countly 提供了 Android 和 iOS 两种版本的开..."},
	//        {"newsID": "4", "title": "Mac下的SVN图形客户端 SVNX","body": "SVNX是mac下一个开源的图形化操作工具，使用起来比较方便 .支持图形化查看需该，删除，提交，以及解决冲突文件。"},
	//        {"newsID": "5", "title": "OSX游戏模拟器 Open Emu","body": "OpenEmu 是一项开源计划，目的是将游戏模拟带入OS X，使用Cocoa、Core Animation和Quartz等现代OS X技术，使用Sparkle进行自动升级。 Open Emu使用模块化构架，支持游戏引擎插件，这意味着Open Emu可以支持不同的模拟引擎。Open Emu已经测试很长时间了，可..."},
	//        {"newsID": "6", "title": "基于MVVM 的IOS开发框架 EasyIOS","body": "Swift版本最新发布： https://github.com/EasyIOS/EasyIOS-Swift 全新基于MVVM(Model-View-ViewModel)编程模式架构，开启EasyIOS开发函数式编程新篇章。 EasyIOS 2.0类似AngularJs，最为核心的是：MVVM、ORM、模块化、自动化双向数据绑定、等等 关于有疑问..."},
	//        {"newsID": "7", "title": "正则表达式库 RegexKitLite","body": "RegexKitLite 是一个轻量级的 Objective-C 的正则表达式库，支持 Mac OS X 和 iOS，使用 ICU 库开发。 ; ..."},
	//        ],"totalNumber": "7"};
	//					 res.writeHead(200, {'Content-Type': 'application/json'});
	//        res.end(JSON.stringify(data));

	var keyword =  "7"//req.body.param.keyword;
	//keyword ="7";
	news.getList(keyword, function(err, newsList_, fields){
		//if(!user_){
		console.log(newsList_);
		var jsonData = {"newsArray":newsList_,"totalNumber":newsList_.length};

		res.writeHead(200, {'Content-Type': 'application/json'});
		//for(var i=0;i<newsList_.length;i++)
		//{
		//	jsonData[i]=newsList_[i];
		//}
		res.end(JSON.stringify(jsonData));
	});
});

router.get('/newsArray', function(req, res, next) {
	var data = {"newsArray":[{"newsID": "1", "title": "基于MVC的快速开发框架 BeeFramework","body": "BeeFramework是一款iOS平台的MVC应用快速开发框架，使用Objective-C开发。 其早期原型曾经被应用在QQ空间 、QQ游戏大厅 等多款精品APP中。 BeeFramework 从根本上解决了iOS开发者长期困扰的各种问题，诸如：分层架构如何设计，层与层之间消息传递与处理，网..."},
	        {"newsID": "2", "title": "OSCHINA iPhone 客户端","body": "这是 OSCHINA 官方开发的 iPhone 客户端软件，采用原生 API 开发，非 HTML 模式。 采用 GPL 授权协议，鼓励你在这基础上进行修改和完善，并与大家分享你的版本。 下载官方版本：http://www.oschina.net/app..."},
	        {"newsID": "3", "title": "开源的移动分析应用 Countly","body": "Countly 是一个实时的、开源的移动分析应用，通过收集来自手机的数据，并将这些数据通过可视化效果展示出来以分析移动应用的使用和最终用户的行为。一旦你打开该程序的面板，你会发现数据的监控是那么的简单。 Countly 提供了 Android 和 iOS 两种版本的开..."},
	        {"newsID": "4", "title": "Mac下的SVN图形客户端 SVNX","body": "SVNX是mac下一个开源的图形化操作工具，使用起来比较方便 .支持图形化查看需该，删除，提交，以及解决冲突文件。"},
	        {"newsID": "5", "title": "OSX游戏模拟器 Open Emu","body": "OpenEmu 是一项开源计划，目的是将游戏模拟带入OS X，使用Cocoa、Core Animation和Quartz等现代OS X技术，使用Sparkle进行自动升级。 Open Emu使用模块化构架，支持游戏引擎插件，这意味着Open Emu可以支持不同的模拟引擎。Open Emu已经测试很长时间了，可..."},
	        {"newsID": "6", "title": "基于MVVM 的IOS开发框架 EasyIOS","body": "Swift版本最新发布： https://github.com/EasyIOS/EasyIOS-Swift 全新基于MVVM(Model-View-ViewModel)编程模式架构，开启EasyIOS开发函数式编程新篇章。 EasyIOS 2.0类似AngularJs，最为核心的是：MVVM、ORM、模块化、自动化双向数据绑定、等等 关于有疑问..."},
	        {"newsID": "7", "title": "正则表达式库 RegexKitLite","body": "RegexKitLite 是一个轻量级的 Objective-C 的正则表达式库，支持 Mac OS X 和 iOS，使用 ICU 库开发。 ; ..."},
	        ],"totalNumber": "7"};
	//					 res.writeHead(200, {'Content-Type': 'application/json'});
	//        res.end(JSON.stringify(data));
	var keyword =  "7"//req.body.param.keyword;
	//keyword ="7";
	news.getList(keyword, function(err, newsList_, fields){
		//if(!user_){
		console.log(newsList_);
		var jsonData = {"newsArray":newsList_,"totalNumber":newsList_.length};

		res.writeHead(200, {'Content-Type': 'application/json'});
		//for(var i=0;i<newsList_.length;i++)
		//{
		//	jsonData[i]=newsList_[i];
		//}
		res.end(JSON.stringify(jsonData));
	});
});

router.post('/newsUpdate', function(req, res, next) {
	//req.body.newsId = "7606ffe4-ec02-4703-98c1-238d5cd99b41";
	//req.body.title = "jdkobe"
	var news_ = new news({
		newsId: req.body.newsId,
		title: req.body.title
	});

	news_.update(function(err){
		if(err){
			throw err;
		}else{
			res.send(true);
		}
	});
});


router.post('/newsInsert', function(req, res, next) {
	var news_ = new news({
		title: req.body.title,
		body:req.body.body
	});

	news_.add(function(err){
		if(err){
			throw err;
		}else{
			res.send(true);
		}
	});
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

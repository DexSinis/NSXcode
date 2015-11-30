var http = require('http');

var data = {"newsArray":[{"newsID": "1", "title": "基于MVC的快速开发框架 BeeFramework","body": "BeeFramework是一款iOS平台的MVC应用快速开发框架，使用Objective-C开发。 其早期原型曾经被应用在QQ空间 、QQ游戏大厅 等多款精品APP中。 BeeFramework 从根本上解决了iOS开发者长期困扰的各种问题，诸如：分层架构如何设计，层与层之间消息传递与处理，网..."},
             {"newsID": "2", "title": "OSCHINA iPhone 客户端","body": "这是 OSCHINA 官方开发的 iPhone 客户端软件，采用原生 API 开发，非 HTML 模式。 采用 GPL 授权协议，鼓励你在这基础上进行修改和完善，并与大家分享你的版本。 下载官方版本：http://www.oschina.net/app..."},
             {"newsID": "3", "title": "开源的移动分析应用 Countly","body": "Countly 是一个实时的、开源的移动分析应用，通过收集来自手机的数据，并将这些数据通过可视化效果展示出来以分析移动应用的使用和最终用户的行为。一旦你打开该程序的面板，你会发现数据的监控是那么的简单。 Countly 提供了 Android 和 iOS 两种版本的开..."},
             {"newsID": "4", "title": "Mac下的SVN图形客户端 SVNX","body": "SVNX是mac下一个开源的图形化操作工具，使用起来比较方便 .支持图形化查看需该，删除，提交，以及解决冲突文件。"},
             {"newsID": "5", "title": "OSX游戏模拟器 Open Emu","body": "OpenEmu 是一项开源计划，目的是将游戏模拟带入OS X，使用Cocoa、Core Animation和Quartz等现代OS X技术，使用Sparkle进行自动升级。 Open Emu使用模块化构架，支持游戏引擎插件，这意味着Open Emu可以支持不同的模拟引擎。Open Emu已经测试很长时间了，可..."},
             {"newsID": "6", "title": "基于MVVM 的IOS开发框架 EasyIOS","body": "Swift版本最新发布： https://github.com/EasyIOS/EasyIOS-Swift 全新基于MVVM(Model-View-ViewModel)编程模式架构，开启EasyIOS开发函数式编程新篇章。 EasyIOS 2.0类似AngularJs，最为核心的是：MVVM、ORM、模块化、自动化双向数据绑定、等等 关于有疑问..."},
             {"newsID": "7", "title": "正则表达式库 RegexKitLite","body": "RegexKitLite 是一个轻量级的 Objective-C 的正则表达式库，支持 Mac OS X 和 iOS，使用 ICU 库开发。 ; ..."},
             ],"totalNumber": "7"};

var srv = http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'application/json'});
  res.end(JSON.stringify(data));
});

srv.listen(4000, function() {
  console.log('listening on localhost:4000');
});

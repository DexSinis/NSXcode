/**
 * 
 * Author:Liuchang
 * Date:2015-11-21
 * Email:lc9401@gmail.com
 *
 */

var express = require('express');
var router = express.Router();
var resource = require("../models/resource")
var http = require("http");
var url = require("url");
var querystring = require("querystring");
var fs = require("fs");
var formidable = require("formidable");

/*  express4.x 改动 multer被分离为单独模块 */
var multer  = require('multer');
var upload = multer({ dest: './public/resources/' });

router.post('/add', check_login);
router.post('/add', upload.array('resource', 12), function (req, res, next) {

	var path_ = "";
	var title_ = req.body.title;
	for (var i = req.files.length - 1; i >= 0; i--) {
		var tmp_path = req.files[i].path;
		var target_path = './public/resources/' + req.files[i].originalname;
		path_+=req.files[i].originalname+";";
		fs.rename(tmp_path, target_path, function(err){
			if(err){
				 throw err;
			}
		});
	};

	var resource_ = new resource({
		title: title_,
		author: req.session.user.name,
		url: path_
	});

	resource_.add(function(err, uuid, fields){
		if(err){
			throw err;
		}else{
			res.redirect("/home");
		}
	});
});



/*   此方法只能用作单文件上传  使用formidable   */
router.post('/add2', check_login);
router.post('/add2', function(req, res, next){

//没有使用中间件 所以拿不到files
  console.log(req.files);
  console.log(req)


	var form = new formidable.IncomingForm();
	//这句话千万别忘了,不然会指定到c盘的隐藏目录下 
	//    ./是当前项目根路径
	var path = form.uploadDir = "./public/resources";
	console.log("about to parse");
	form.parse(req, function(error, fields, files){
		//files.xxx.path   xxx对应的是表单中file的name属性,切记
		fs.renameSync(files.resource.path, path+"/"+files.resource.name);
		var obj = files.resource;
		
	});

});

router.get("/download", check_login);
router.get("/download", function(req, res, next){
	var parameter = url.parse(req.url, true).query;
	resource.get(parameter.id, function(err, result, fields){
		if(err){
			throw err;
		}else{
			var url = result.url.split(";");
			for (var i = url.length - 2; i >= 0; i--) {
				res.download("./public/resources/"+url[i]);
			};
		}
	});
})

router.get('/getList', check_login);
router.get('/getList', function(req, res, next){

	var parameter = url.parse(req.url, true).query;
	var keyword = parameter.keyword;
	console.log("kkk=="+keyword);
	resource.getList(keyword, function(err, result, fields){
		if (err) {
			result = [];
		}
		res.send({result:result});
	});
});



function check_login(req, res, next){
	console.log("in cehck_login");
	if (!req.session.user) {
		console.log("no user");
		return res.redirect('/'); 
	}else{
		console.log("pass")
		next(); 
	}
}

module.exports = router;

/**
 * 
 * Author:Liuchang
 * Date:2015-11-19
 * Email:lc9401@gmail.com
 *
 */

var express = require('express');
var router = express.Router();
var user = require("../models/user")
var http = require("http");
var url = require("url");

/* GET users listing. */
router.get('/logout',function(req, res){
req.session.user = null;
res.redirect("/");
});

router.get("/delete", check_login);
router.get("/delete", function(req, res, next){
	var parameter = url.parse(req.url, true).query;
	var user_ = new user({
		id: parameter.id
	});
	user_.delete(function(err){
		if(err){
			throw err;
		}else{
			res.send(true);
		}
	});
});

router.get("/toUpdate", check_login);
router.get("/toUpdate", function(req, res, next){
	var parameter = url.parse(req.url, true).query;
	user.get(parameter.name, function(err, u, fields){
		if(!u){
			res.send({status: false});
		}else{
			
			res.send({status: true, user:u});

		}
	});
});


router.get('/getList', check_login);
router.get('/getList', function(req, res, next){
	var parameter = url.parse(req.url, true).query;
	user.getList(parameter.keyword, function(err, result, fields){
		if (err) {
			result = [];
		}
		res.send({result:result});
	});
});

router.post('/add', check_login);
router.post('/add', function(req, res, next){
	var user_ = new user({
			name: req.body.name,
			password: req.body.password,
			u_level: req.body.level
		});

	//检查是否注册过相同名字
	user.get(req.body.name, function(err, u, fields){
		if(!u){
			user_.add(function(err, uuid, fields){
					if(err){
						console.log("err=="+err);
						res.send({status: false, msg:"服务器出现了什么问题"});
					}else{
						res.send({status: true, msg:"添加成功"});
					}
				});
		}else{
			console.log("已存在");
			res.send({status: false, msg:"用户名已存在"});

		}
	});
});

router.post("/update", check_login);
router.post("/update", function(req, res, next){
	var user_ =new user({
		id: req.body.id,
		name: req.body.name,
		password: req.body.password,
		u_level: req.body.level
	});
	user_.update(function(err){
		if(err){
			throw err;
		}else{
			res.send(true);
		}
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

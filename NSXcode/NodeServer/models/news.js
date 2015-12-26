
/**
 *
 * Author:Liuchang
 * Date:2015-11-19
 * Email:lc9401@gmail.com
 *
 */


var client = require("../database");
mysql = client.getDbCon();
var uuid = require("../utils/uuid")

function News(news) {
	this.newsId = news.newsId;
    this.title = news.title;
	this.body = news.body;
}
module.exports = News;

News.get = function(newsId, callback){
	var sql = "select * from news where newsId='"+newsId+"'";
	mysql.query(sql,function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}


News.getList = function(keyword, callback){
	var sql = "select * from news where 1=1 and newsId like'%"+keyword+"%'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}

News.prototype.add = function add(callback) {
	var news = {
		title: this.title,
		body: this.body
	};
	var uuid_ = uuid.v4();
	var sql = "insert into news(newsId,title,body) values(?,?,?)";
	mysql.query(sql, [uuid_,news.title,news.body], function(err, results, fields){
		if(err){
			throw err;
		}else{
			callback(err, uuid ,fields);
		}
	});
}

News.prototype.update = function(callback) {
	var news = {
		newsId: this.newsId,
		title: this.title,
		body:this.body

	}

	var sql = "update news set title=?,password=? where newsId=?";
	mysql.query(sql, [news.title,news.body,news.newsId], function(err, result, fields){
		console.log(news.title);
		console.log(news.newsId);
		console.log(sql);
		if(err){
			throw err;
		}
		callback(err);
	});
}


News.prototype.delete = function(callback){
	var news = {
		id: this.id
	}
	var sql = "delete from news where id='"+news.id+"'";
	mysql.query(sql ,function(err){
		if(err){
			throw err;
		}
		callback(err);
	});
}

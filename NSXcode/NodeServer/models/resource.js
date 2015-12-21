
/**
 * 
 * Author:Liuchang
 * Date:2015-11-21
 * Email:lc9401@gmail.com
 *
 */

var client = require("../database");
mysql = client.getDbCon();
var uuid = require("../utils/uuid");

function Resource(resource) {
	this.id = resource.id;
    this.title = resource.title;
    this.author = resource.author;
    this.url = resource.url;
}
module.exports = Resource;

Resource.prototype.add = function(callback){

	var resource = {
		title: this.title,
		author: this.author,
		url: this.url
	};
	var uuid_ = uuid.v4();

	var sql = "insert into resource values(?,?,?,?,?)";
	mysql.query(sql, [uuid_, resource.title, resource.author, new Date(), resource.url], function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, uuid_, fields);
		}
	});
}

Resource.getList = function(keyword, callback){
	var sql = "select * from resource where title like'%"+keyword+"%'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields)
		}
	});
}

Resource.get = function(id, callback){
	var sql = "select * from resource where id='"+id+"'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}
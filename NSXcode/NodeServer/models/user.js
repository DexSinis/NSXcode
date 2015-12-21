
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

function User(user) {
	this.id = user.id;
    this.name = user.name;
    this.password = user.password;
    this.u_level = user.u_level;
}
module.exports = User;

User.get = function(u_name, callback){
	var sql = "select * from user where name='"+u_name+"'";
	mysql.query(sql,function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}


User.getList = function(keyword, callback){
	var sql = "select * from user where 1=1 and name like'%"+keyword+"%'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}

User.prototype.add = function add(callback) {
	var user = {
		name: this.name,
		password: this.password,
		u_level: this.u_level
	};
	var uuid_ = uuid.v4();
	var sql = "insert into user(id,name,password,u_level) values(?,?,?,?)";
	mysql.query(sql, [uuid_,user.name,user.password,user.u_level], function(err, results, fields){
		if(err){
			throw err;
		}else{
			callback(err, uuid ,fields);
		}
	});
}

User.prototype.update = function(callback) {
	var user = {
		id: this.id,
		name: this.name,
		password: this.password,
		u_level: this.u_level
	}

	var sql = "update user set name=?,password=?,u_level=? where id=?";
	mysql.query(sql, [user.name, user.password, user.u_level, user.id], function(err, result, fields){
		if(err){
			throw err;
		}
		callback(err);
	});
}  


User.prototype.delete = function(callback){
	var user = {
		id: this.id
	}
	var sql = "delete from user where id='"+user.id+"'";
	mysql.query(sql ,function(err){
		if(err){
			throw err;
		}
		callback(err);
	});
}


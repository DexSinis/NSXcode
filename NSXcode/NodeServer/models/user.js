
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
	this.userID = user.userID;
	this.location = user.location;
	this.name = user.name;
	this.followersCount = user.followersCount;
	this.fansCount = user.fansCount;
	this.score = user.score;
	this.favoriteCount = user.favoriteCount;
	this.relationship = user.relationship;
	this.portraitURL = user.portraitURL;
	this.gender = user.gender;
	this.developPlatform = user.developPlatform;
	this.expertise = user.expertise;
	this.joinTime = user.joinTime;
	this.latestOnlineTime = user.latestOnlineTime;
	this.pinyin = user.pinyin;
	this.pinyinFirst = user.pinyinFirst;
    this.hometown = user.hometown;
    //this.password = user.password;
    //this.u_level = user.u_level;
}
module.exports = User;

User.get = function(u_userID, callback){
	var sql = "select * from t_user where userID ='"+u_userID+"'";
	mysql.query(sql,function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}


User.getList = function(keyword, callback){
	var sql = "select * from t_user where 1=1 and name like'%"+keyword+"%'";
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
		//this.userID = user.userID,
	location : this.location,
	name : this.name,
	followersCount : this.followersCount,
	fansCount : this.fansCount,
	score : this.score,
	favoriteCount : this.favoriteCount,
	relationship : this.relationship,
	portraitURL : this.portraitURL,
	gender : this.gender,
	developPlatform : this.developPlatform,
	expertise : this.expertise,
	joinTime : this.joinTime,
	latestOnlineTime : this.latestOnlineTime,
	pinyin : this.pinyin,
	pinyinFirst : this.pinyinFirst,
	hometown : this.hometown
	//this.password = user.password;
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
		userID : this.userID,
		location : this.location,
		name : this.name,
		followersCount : this.followersCount,
		fansCount : this.fansCount,
		score : this.score,
		favoriteCount : this.favoriteCount,
		relationship : this.relationship,
		portraitURL : this.portraitURL,
		gender : this.gender,
		developPlatform : this.developPlatform,
		expertise : this.expertise,
		joinTime : this.joinTime,
		latestOnlineTime : this.latestOnlineTime,
		pinyin : this.pinyin,
		pinyinFirst : this.pinyinFirst,
		hometown : this.hometown
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
		userId: this.userID
	}
	var sql = "delete from user where id='"+user.id+"'";
	mysql.query(sql ,function(err){
		if(err){
			throw err;
		}
		callback(err);
	});
}


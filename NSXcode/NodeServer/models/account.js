
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

function Account(account) {
    this.accountName = account.accountName;
	this.password = account.password;
	this.userID = account.userID;
}
module.exports = Account;

Account.get = function(accountName,password, callback){
	var sql = "select * from t_account where accountName ='"+accountName+"' and "+"password = '"+password+"'";
	mysql.query(sql,function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}


Account.getList = function(keyword, callback){
	var sql = "select * from account where 1=1 and accountId like'%"+keyword+"%'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}

Account.prototype.add = function add(callback) {
	var account = {
		accountName: this.accountName,
		password: this.password
	};
	var uuid_ = uuid.v4();
		var sql = "insert into t_account(accountName,password,userID) values(?,?,?)";
		mysql.query(sql, [account.accountName,account.password,uuid_], function(err, results, fields){
			if(err){
				throw err;
			}else{
				//var sql = "insert into t_user(userID,location,name,followersCount,fansCount,score,favoriteCount,relationship,portraitURL,gender,developPlatform,expertise,joinTime,latestOnlineTime,pinyin,pinyinFirst,hometown) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				var sql = "insert into t_user(userID) values(?)";
				mysql.query(sql, [uuid_], function(err, results, fields){
					if(err){
						throw err;
					}else{
						callback(err, uuid ,fields);
					}
				});
			}
		});
}


Account.prototype.update = function(callback) {
	var account = {
		accountId: this.accountId,
		title: this.title,
		body:this.body

	}

	var sql = "update account set title=?,password=? where accountId=?";
	mysql.query(sql, [account.title,account.body,account.accountId], function(err, result, fields){
		console.log(account.title);
		console.log(account.accountId);
		console.log(sql);
		if(err){
			throw err;
		}
		callback(err);
	});
}


Account.prototype.delete = function(callback){
	var account = {
		id: this.id
	}
	var sql = "delete from account where id='"+account.id+"'";
	mysql.query(sql ,function(err){
		if(err){
			throw err;
		}
		callback(err);
	});
}

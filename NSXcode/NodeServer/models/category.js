
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

function Category(category) {
	this.categoryid = category.categoryid;
    this.userid = category.userid;
	this.categoryname = category.categoryname;
}
module.exports = Category;

Category.get = function(categoryid, callback){
	var sql = "select * from category where categoryid='"+categoryid+"'";
	mysql.query(sql,function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}


Category.getList = function(keyword, callback){
	var sql = "select * from t_user_category where 1=1 and userid like'%"+keyword+"%'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}
Category.getTopList = function(keyword, callback){
	var sql = "select * from t_category where 1=1 and istopcategory = 'yes'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}

Category.prototype.add = function add(callback) {
	var category = {
		userid: this.userid,
		categoryid: this.categoryid,
		categoryname: this.categoryname
	};
	var uuid_ = uuid.v4();
	var sql = "insert into category(categoryid,userid,categoryname) values(?,?,?)";
	mysql.query(sql, [category.categoryid,category.userid,category.categoryname], function(err, results, fields){
		if(err){
			throw err;
		}else{
			callback(err, uuid ,fields);
		}
	});
}

Category.prototype.update = function(callback) {
	var category = {
		categoryid: this.categoryid,
		userid: this.userid,
		categoryname:this.categoryname

	}

	var sql = "update category set userid=?,password=? where categoryid=?";
	mysql.query(sql, [category.userid,category.categoryname,category.categoryid], function(err, result, fields){
		console.log(category.userid);
		console.log(category.categoryid);
		console.log(sql);
		if(err){
			throw err;
		}
		callback(err);
	});
}


Category.prototype.delete = function(callback){
	var category = {
		id: this.id
	}
	var sql = "delete from category where id='"+category.id+"'";
	mysql.query(sql ,function(err){
		if(err){
			throw err;
		}
		callback(err);
	});
}

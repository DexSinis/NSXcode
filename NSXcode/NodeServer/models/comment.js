
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

function Comment(comment) {
	this.commentId = comment.commentId;
	this.username = comment.username;
	this.address = comment.address;
	this.comment = comment.comment;
	this.timeString = comment.timeString;
	this.floor = comment.floor;
	this.newsId = comment.newsId;
	this.userId = comment.userId;
	this.likeCount = comment.likeCount;
	this.commentCount = comment.commentCount;
	this.storey= comment.storey
}
module.exports = Comment;

Comment.get = function(commentId, callback){
	var sql = "select * from t_comment where commentId='"+commentId+"'";
	mysql.query(sql,function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result[0], fields);
		}
	});
}


Comment.getList = function(keyword, callback){
	var sql = "select * from t_comment where 1=1 and commentId like'%"+keyword+"%'";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}
Comment.getTopList = function(keyword, callback){
	var sql = "select * from t_comment where 1=1 and likeCount > 250 order by storey,floor asc";
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}

Comment.getMaxFloor = function(newsId,commentId, callback){
	var sql = "select count(*) as currentfloor from t_comment where 1=1 and newsId='"+newsId+"'"+" and storey='"+commentId+"'" ;
	mysql.query(sql, function(err, result, fields){
		if(err){
			throw err;
		}else{
			callback(err, result, fields);
		}
	})
}

Comment.prototype.add = function add(callback) {
	var comment = {
		//title: this.title,
		//body: this.body
        //
		//commentId : this.commentId,
	    username : this.username,
	    address : this.address,
	    comment : this.comment,
	    timeString : this.timeString,
	    floor : this.floor,
	    newsId : this.newsId,
	    userId : this.userId,
	    likeCount : this.likeCount,
	    commentCount : this.commentCount,
		storey : this.storey
	};
	var uuid_ = uuid.v4();
	var sql = "insert into t_comment(commentId,username,address,comment,timeString,floor,newsId,userId,likeCount,commentCount,storey) values(?,?,?,?,?,?,?,?,?,?,?)";
	mysql.query(sql, [uuid_,comment.username,comment.address,comment.comment,comment.timeString,comment.floor,comment.newsId,comment.userId,comment.likeCount,comment.commentCount,comment.storey], function(err, results, fields){
		if(err){
			throw err;
		}else{
			callback(err, uuid ,fields);
		}
	});
}

Comment.prototype.update = function(callback) {
	var comment = {
		//commentId : this.commentId,
		username : this.username,
		address : this.address,
		comment : this.comment,
		timeString : this.timeString,
		floor : this.floor,
		newsId : this.newsId,
		userId : this.userId,
		likeCount : this.likeCount,
		commentCount : this.commentCount,
		storey : this.storey

	}

	var sql = "update comment set title=?,password=? where commentId=?";
	mysql.query(sql, [comment.title,comment.body,comment.commentId], function(err, result, fields){
		console.log(comment.title);
		console.log(comment.commentId);
		console.log(sql);
		if(err){
			throw err;
		}
		callback(err);
	});
}


Comment.prototype.delete = function(callback){
	var comment = {
		id: this.id
	}
	var sql = "delete from comment where id='"+comment.id+"'";
	mysql.query(sql ,function(err){
		if(err){
			throw err;
		}
		callback(err);
	});
}

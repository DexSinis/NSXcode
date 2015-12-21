/**
 * 
 * Author:Liuchang
 * Date:2015-11-21
 * Email:lc9401@gmail.com
 *
 */



function resourceAdd(){
	var html = "<div class='conetnt-title'>资源添加</div>";
	html+="<div class='content-main'><form class='form-resource-add' action='/resources/add' enctype=multipart/form-data method=post>";
	html+="支持批量上传<br>下载目录在/pubilc/resources下<br><br>";
	html+="标题：<input type='text' name='title' id='title' /><br>";
	html+="选择：<input type='file' id='resource' name='resource' multiple='multiple' /><br>";
	html+="<input type='submit' class='btn btn-resource-add' value='提交'/>";
	html+="</form></div>";
	$(".content").html(html);
}

function getResList(keyword){
	$.get("/resources/getList", {keyword: keyword}, function(result){
		var html = "<div class='list-title'>资源列表</div>";
		html+="<div class='list-main'><input type=text id='r_title' /><input type=button value='查找' class='btn btn-resource-search' />";
		html+="<div class='list-content'><table class='table tb-resource'><tbody>";
		html+="<tr><td>标题</td><td>上传账号</td><td>时间</td><td>操作</td></tr>";
		var data = eval(result);
		$.each(data.result, function(key, value){
			html+="<tr><td>"+value.title+"</td><td>"+value.author+"</td><td>"+value.createTime+"</td><td><a href=javascript:resDownload('"+value.id+"');>download</a></td></tr>";
		});
		html+="</tbody></table></div></div>"
		$(".content").html(html);
	})
}

function resDownload(param){
	location.href='/resources/download?id='+param;
}

$(function(){

	$(".content").delegate(".btn-resource-add", "click", function(){
		if($("input[type=text]").val().length<=0){
			alert("请填写标题");
			return false;
		}
		if($("input[type=file]").val()<=0){
			alert("还未选择上传文件");
			return false;
		}
	}).delegate(".btn-resource-search", "click", function(){
		getResList($("#r_title").val());
	});
});
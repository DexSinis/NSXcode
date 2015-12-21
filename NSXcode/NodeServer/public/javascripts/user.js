

/**
 * 
 * Author:Liuchang
 * Date:2015-11-19
 * Email:lc9401@gmail.com
 *
 */


function userAdd(){
	var html = "<div class='conetnt-title'>用户添加</div>";
	html+="<div class='content-main'><form class='form-user-add' method='post'>";
	html+="账&emsp;号：<input type='text' id='u_name' /><br>";
	html+="密&emsp;码：<input type='password' id='u_pwd'/><br>";
	html+="等&emsp;级：<select id='u_level' title='请选择用户等级以决定操作权限'>";
	html+="<option value=0>----</option><option value=1>1</option><option value=2>2</option><option value=3>3</option>";
	html+="</select><br><input type='button' class='btn btn-user-add' value='提交'/>";
	html+="</form></div>";
	$(".content").html(html);
}

function userDel(param){
	var url = "users/delete?id="+param;
	$.get(url, function(res){
		if(res){
			alert("删除成功");
			getUserList('');
		}else{
			alert("发生了某些问题,请刷新网页");
		}
	});
}

function userUpdate(param){
	var url = "users/toUpdate?name="+param;
	$.get(url, function(res){
		if(res.status){
			var html = "<div class='conetnt-title'>用户修改</div>";
			html+="<div class='content-main'><form class='form-user-add' method='post'>";
			var data = eval(res.user);
			html+="账&emsp;号：<input type='text' id='u_name' value="+data.name+" /><br>";
			html+="密&emsp;码：<input type='password' id='u_pwd' value="+data.password+"  /><br>";
			html+="等&emsp;级：<select id='u_level'>";
			if(data.u_level==1){
				html+="<option selected=selected value=1>1</option><option value=2>2</option><option value=3>3</option>";
			}
			if(data.u_level==2){
				html+="<option value=1>1</option><option selected=selected value=2>2</option><option value=3>3</option>";
			}
			if(data.u_level==3){
				html+="<option value=1>1</option><option value=2>2</option><option selected=selected value=3>3</option>";
			}
			html+="</select><br><input type='button' class='btn btn-user-update' value='提交'/><input type=hidden id=u_id value="+data.id+" />";
			html+="</form></div>";
			$(".content").html(html);
		}else{
			alert("发生了某些问题,请刷新网页");
		}
	});
}

function getUserList(keyword){
	$.get("/users/getList", {keyword: keyword}, function(result){
		var html = "<div class='list-title'>用户列表</div>";
		html+="<div class='list-main'><input type=text id='u_name' /><input type=button value='查找' class='btn btn-user-search' />";
		html+="<div class='list-content'><table class='table tb-user'><tbody>";
		html+="<tr><td>用户名</td><td>等级</td><td colspan=2>操作</td></tr>";
		var data = eval(result);
		$.each(data.result, function(key, value){
			html+="<tr><td>"+value.name+"</td><td>"+value.u_level+"</td><td><a href=javascript:userUpdate('"+value.name+"');>update</a></td><td><a href=javascript:userDel('"+value.id+"');>delete</a></td</tr>";
		});
		html+="</tbody></table></div></div>"
		$(".content").html(html);
	})
}

$(function(){

	//动态插入的html,需要委派事件处理
	$(".content").delegate(".btn-user-add", "click", function(){
		if($("#u_name").val()!=""&&$("#u_pwd").val()!=""&&$("#u_level").val()!=0){
			$.post("/users/add",{
				name: $("#u_name").val(),
				password: $("#u_pwd").val(),
				level: $("#u_level").val()
			}, function(res){
					alert(res.msg);
					getUserList('');
			});
		}else{
			alert("请检查，是否有空项");
		}
	}).delegate(".btn-user-update", "click", function(){
		if($("#u_name").val()!=""&&$("#u_pwd").val()!=""&&$("#u_level").val()!=0){
			$.post("/users/update",{
				id: $("#u_id").val(),
				name: $("#u_name").val(),
				password: $("#u_pwd").val(),
				level: $("#u_level").val()
			}, function(res){
					if(res){
						getUserList('');
					}else{
						alert("mjk")
					}
					
			});
		}else{
			alert("请检查，是否有空项");
		}
	}).delegate(".btn-user-search", "click", function(){
		var keyword = $("#u_name").val();
		getUserList(keyword);
	});

});
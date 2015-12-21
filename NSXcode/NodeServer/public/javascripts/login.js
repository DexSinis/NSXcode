
/**
 * 
 * Author:Liuchang
 * Date:2015-11-18
 * Email:lc9401@gmail.com
 *
 */

/* paramter list */
var account,pwd;

/*验证*/
function check(){
	var account_ = $("#account").val();
	var pwd_ = $("#pwd").val();
	if (account_==""||pwd_=="") {
		alert("账号或密码为空");
		return false
	}else{
		account = account_;
		pwd = pwd_;
		return true;
	};
}

/*登陆*/
function login(){

	if(check()){
		$.post("/login",
			{
				account:account,
				pwd:pwd
			},
			function(res){
				if(res){
					location.href="/home";
				}else{
					$("#account").val("");
					$("#pwd").val("");
					$(".error_msg").html("没有此账号记录");
				}
			});
	}else{
		return false;
	}
}

/*加载*/
$(function(){

	//登陆按钮事件
	$(".btn_login").unbind("click");
	$(".btn_login").bind("click", function(){
		login();
	});
	
	//绑定键盘事件
	document.onkeydown = function(e){ 
		var ev = document.all ? window.event : e;
		//Enter
		if(ev.keyCode==13) {
			login();
		}
	}

	

	
});
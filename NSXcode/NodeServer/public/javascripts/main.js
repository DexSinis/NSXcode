
/**
 * 
 * Author:Liuchang
 * Date:2015-11-18
 * Email:lc9401@gmail.com
 *
 */


/* 防止手滑 */
function ask(path){
	if(window.confirm("确定吗?")){
			location.href=path;
		}else{
			return false;
		}
}

$(function(){

	//左侧子菜单下滑
	$(".menu-li").unbind("click");
	$(".menu-li").bind("click",function(){
		$(this).next().slideToggle();
	});

	//光标变成小手
	$(".hand").mouseover(function(){  
		$(this).css("cursor","pointer");
	});

});
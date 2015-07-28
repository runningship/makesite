<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setAttribute("domain", request.getServerName());
%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>联信投资 - 后台登录</title>
	<script type="text/javascript" src="basejs/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="basejs/buildHtml.js"></script>
	<script type="text/javascript" src="layer-v1.9.3/layer/layer.js"></script>
	<link rel="stylesheet" href="style/login.css">
<script type="text/javascript">
function login(){
	var index;
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/user/login',
	    data: a,
	    beforeSend: function(XMLHttpRequest){
        	index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
        },
        complete: function(XMLHttpRequest, textStatus){
            layer.close(index);
        },
	    mysuccess: function(json){
	        window.location="admin/index.jsp";
	    },
	    error:function(data){
	    	  alert('用户名或密码错误');
	      }
	  });
}
$(function(){
	$(document).on('keyup',function(event){
		if(event.keyCode==13){
			login();
		}
	});
});
</script>
	</head>
	<body>
	<div id="container">
		<div class="logo">
			<a href="#"><img src="style/image/${domain }/logo.png" alt="" /></a>
		</div>
		<div id="box">
			<form name="form1">
			<p class="main">
				<label>账号: </label>
				<input name="account" value="" /> 
				<label>密码: </label>
				<input type="password" name="pwd" value="">	
			</p>

			<p class="space">
				
				<input type="button" value="登陆" onclick="login();" class="login" />
			</p>
			</form>
		</div>
	</div>

	</body>
</html>
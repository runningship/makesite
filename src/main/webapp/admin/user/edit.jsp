<%@page import="com.youwei.makesite.entity.User"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	User user = dao.get(User.class, id);
	request.setAttribute("user", user);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">
function save(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '/${projectName}/c/admin/user/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
	    },
	    complete:function(){
	        api.button({
	              name: '保存',
	              disabled:false
	          });
	    }
    });
}
</script>
<body style="background-color:white">
	<form name="form1" onsubmit="save();return false;" style="padding:20px">
	<input name="id" value="${user.id}" style="display:none" />
		<div class="form-group">
			<label>登录账号</label>
			<input name="account" value="${user.account}" class="form-input" />
		</div>
		<div class="form-group">
			<label>用户姓名</label>
			<input name="name" value="${user.name}" class="form-input"/>
		</div>
		<div class="form-group">
			<label>用户电话</label>
			<input name="tel" value="${user.tel}"  class="form-input"/>
		</div>
		<div class="form-group">
			<label>用户密码</label>
			<input name="pwd" class="form-input" placeholder="无需修改请不用填写" />
		</div>
	</form>
	<div style="padding-left: 50px;">
		<button onclick="save();return false;" class="form-button">保&nbsp;&nbsp;存</button>
	</div>
</body>
</html>
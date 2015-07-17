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
	var account = $('#account').val();
	var name = $('#name').val();
	if (account=="") {
		alert('用户账号不能为空');
		return;
	};
	if (name=="") {
		alert('用户名不能为空');
		return;
	};
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '/${projectName}/c/admin/user/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.reloadWindow();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}
</script>
<body style="background-color:white">
	<form name="form1" onsubmit="save();return false;" style="padding:20px">
	<input name="id" value="${user.id}" style="display:none" />
		<div class="form-group">
			<label>登录账号</label>
			<input name="account" id="account" value="${user.account}" class="form-input" />
		</div>
		<div class="form-group">
			<label>用户姓名</label>
			<input name="name" id="name" value="${user.name}" class="form-input"/>
		</div>
		<div class="form-group">
			<label>用户电话</label>
			<input name="tel" value="${user.tel}"  class="form-input"/>
		</div>
		<div class="form-group">
			<label>用户密码</label>
			<input name="pwd" class="form-input" placeholder="无需修改请不用填写" />
		</div>
		<div class="form-group action">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
	</form>
</body>
</html>
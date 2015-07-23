<%@page import="com.youwei.makesite.entity.Feedback"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Feedback fk = dao.get(Feedback.class, id);
	request.setAttribute("feedback", fk);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

$(function(){
});

</script>
<body style="background-color:white">

		<div class="form-group">
			<label class="label">联系方式：</label>
	        <span >${feedback.contact}</span>
		</div>
		<div id="conts" class="form-group">
			<label class="label">详细内容：</label>
	        <span >${feedback.conts}</span>
		</div>
</body>
</html>
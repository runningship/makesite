<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.SharedFile"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<SharedFile> p = new Page<SharedFile>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"from SharedFile where 1=1 order by id desc");
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
	initUploadHouseImage('fileUploadBtn' , '${projectName}');
});
</script>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<div class="title_bar">
						<h3>文件列表</h3>
						<button id="fileUploadBtn" style="float:right;margin-top:-35px;padding:5px;">上 &nbsp;传</button>
					</div>
					<table class="fileList" >
						<tr>
							<td>文件名</td>
							<td>文件大小</td>
							<td> 上传人</td>
							<td>上传时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="file">
						<tr>
							<td><a href='/${projectName }/upload/${file.path }' target="_blank "> ${file.name } </a></td>
							<td>${file.size/1000/1000 }M</td>
							<td>叶新舟</td>
							<td>${file.uploadTime }</td>
							<td><a href="#">删除</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>

				<jsp:include page="../inc/pagination.jsp"></jsp:include>


			</div>
		</div>

	</div>
</body>
</html>
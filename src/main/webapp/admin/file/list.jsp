<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.SharedFile"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<Map> p = new Page<Map>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"select sf.name as name, sf.id as fid, sf.uploadTime as uploadTime, sf.size as size, u.name as uname from SharedFile sf,User u where sf.uid = u.id order by sf.id desc",true,new Object[]{});
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件信息</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
	initUploadHouseImage('fileUploadBtn' , '${projectName}');
});

	function fileDel(id){
		YW.ajax({
		    type: 'POST',
		    url: '/${projectName}/c/admin/file/delete?id='+id,
		    mysuccess: function(data){
		        alert('删除成功');
		        window.location.reload();
		    }
	    });
	}
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
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>文件名</td>
							<td>文件大小</td>
							<td> 上传人</td>
							<td>上传时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="file" varStatus="status">
							<tr class="statue_${status.index%2}">
							<td><a href='/${projectName }/upload/${file.path }' target="_blank "> ${file.name } </a></td> 
							<c:choose>
								<c:when test="${file.size/1000/1000 >=0.99}">  
									<td><fmt:formatNumber type="number" value="${file.size/1000/1000 }" maxFractionDigits="1"/>M</td>
							  	</c:when> 
  								<c:otherwise>  
									<td><fmt:formatNumber type="number" value="${file.size/1000}" maxFractionDigits="1"/>K</td>
								</c:otherwise> 
							</c:choose>
							<td>${file.uname}</td>
							<td><fmt:formatDate value="${file.uploadTime }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td><a href="#"  onclick="fileDel(${file.fid})">删除</a></td>
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
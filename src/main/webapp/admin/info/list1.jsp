<%@page import="com.youwei.makesite.entity.Menu"%>
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
	Page<Menu> p = new Page<Menu>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"from Menu menu where parentId is null and _site =? order by menu.orderx asc, menu.id desc ", request.getServerName());
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>一级栏目</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
});

	function openAdd(){
		layer.open({
	    	type: 2,
	    	title: '添加一级栏目',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '700px'],
		    content: 'add1.jsp'
		}); 
	}

	function openAdd2(id){
		layer.open({
	    	type: 2,
	    	title: '添加二级栏目',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '700px'],
		    content: 'add2.jsp?parentId='+id
		}); 
	}

	function editThis(id){
		layer.open({
	    	type: 2,
	    	title: '修改栏目',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '650px'],
		    content: 'edit1.jsp?id='+id
		}); 
	}

function reloadWindow(){
	window.location.reload();
}

	function delThis(id){
		YW.ajax({
		    type: 'POST',
		    url: '/${projectName}/c/admin/menu/delete?id='+id,
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
						<h3>一级栏目</h3>
						<button style="float:right;margin-top: 5px;padding:5px;" onclick="openAdd();">添 &nbsp;加</button>
					</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>排序</td>
							<td>栏目名称</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="menu" varStatus="status">
							<tr class="statue_${status.index%2}">
							<td>${menu.orderx } </td> 
							<td>${menu.name }</td> 
							<td><a href="#" onclick="editThis(${menu.id})">修改</a>  <a href="#" onclick="delThis(${menu.id})">删除</a>
							<c:if test="${menu.type == 'menu'}">
								<a href="#" onclick="openAdd2(${menu.id});">添加子栏目</a>
							</c:if>
							</td>
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
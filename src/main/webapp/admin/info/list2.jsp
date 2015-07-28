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
	p  = dao.findPage(p,"select m2.id as id , m2.name as name , m2.type as type , m2.orderx as orderx , m1.name as fname from Menu m1 , Menu m2 where m2.parentId is not null and m1.id = m2.parentId and m1._site =? order by m1.orderx asc , m2.orderx asc ,m2.id desc",true,new Object[]{ request.getServerName()});
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>二级栏目</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
});

	function openAdd(id){
		layer.open({
	    	type: 2,
	    	title: '添加文章',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '700px'],
		    content: 'add3.jsp?parentId='+id
		}); 
	}

	function editThis(id){
		layer.open({
	    	type: 2,
	    	title: '修改栏目',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '700px'],
		    content: 'edit1.jsp?id='+id
		}); 
	}
	
function reloadWindow(){
	window.location.reload();
}

	function delThis(id){
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/menu/delete?id='+id,
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
						<h3>二级栏目</h3>
					</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>栏目名称</td>
							<td>父栏目</td>
							<td>排序</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="menu" varStatus="status">
							<tr class="statue_${status.index%2}">
							<td>${menu.name }</td> 
							<td>${menu.fname }</td> 
							<td>${menu.orderx }</td> 
							<td>
							<c:if test="${session_auth_list.indexOf('$info_modifyMenu')>-1 }"><a href="#" onclick="editThis(${menu.id})">修改</a></c:if> 
							<c:if test="${session_auth_list.indexOf('$info_delMenu')>-1 }"> <a href="#" onclick="delThis(${menu.id})">删除</a> </c:if>
							<c:if test="${menu.type == 'menu'}">
								<c:if test="${session_auth_list.indexOf('$info_modifyMenu')>-1 }">
								<a href="#" onclick="openAdd(${menu.id});">添加文章</a>
								</c:if>
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
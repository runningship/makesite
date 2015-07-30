<%@page import="com.youwei.makesite.util.DataHelper"%>
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
	p  = dao.findPageBySql(p,"select m1.id as id , m2.name as fname , m1.orderx as orderx , m1.name as name from Menu m1 left join "
			+" Menu m2 on m1.parentId = m2.id where m1._site =? order by m2.orderx asc,m1.orderx desc",new Object[]{ DataHelper.getServerName(request)});
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>栏目管理</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
});
function editOK(i,a,b){

}
	function editThis(id){
		layer.open({
	    	type: 2,
	    	title: '修改栏目',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['500px', '280px'],
		    content: 'edit1.jsp?id='+id,
		    btn: ['确定','取消'],
		    yes:function(index){
		    	$('[name=layui-layer-iframe'+index+']').contents().find('.save').click();
			    return false;
			}
		}); 
	}

function reloadWindow(){
	window.location.reload();
}
function openAdd(){
	layer.open({
    	type: 2,
    	title: '添加栏目',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['500px', '300px'],
	    content: 'addMenu.jsp'
	}); 
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
						<c:if test="${session_auth_list.indexOf('$info_addMenu')>-1 }">
							<button style="float:right;margin-top: 5px;padding:5px;cursor:pointer" onclick="openAdd();">添 &nbsp;加</button>
						</c:if>
					</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>栏目名称</td>
							<td>父栏目</td>
							<td>排序</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="menu" varStatus="status">
						<tr class="statue_${status.index%2}" id="tr${menu.id}">
							<td class="name">${menu.name }</td> 
							<td class="fname">${menu.fname }</td> 
							<td class="orders">${menu.orderx }</td> 
							<td>
							<c:if test="${session_auth_list.indexOf('$info_modifyMenu')>-1 }"><a href="#" onclick="editThis(${menu.id})">修改</a></c:if> 
							<c:if test="${session_auth_list.indexOf('$info_delMenu')>-1 }"> <a href="#" onclick="delThis(${menu.id})">删除</a> </c:if>
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
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
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
	String parentId =  request.getParameter("parentId");
	String _site =  DataHelper.getServerName(request);
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	List<Menu> yiji  = dao.listByParams(Menu.class, "from Menu where parentId is null and _site = ? order by orderx desc" , _site);
	StringBuilder hql = new StringBuilder("select m1.id as id , m2.name as fname , m1.orderx as orderx , m1.name as name from Menu m1 left join "
			+" Menu m2 on m1.parentId = m2.id where m1._site =?");
	List<Object> params = new ArrayList<Object>();
	params.add(_site);
	if(StringUtils.isNotEmpty(parentId)){
		hql.append(" and m1.parentId =?");
		params.add(Integer.valueOf(parentId));
	}
	hql.append(" order by m2.orderx asc,m1.orderx desc");
	p  = dao.findPageBySql(p, hql.toString(), params.toArray());
	request.setAttribute("page", p);
	request.setAttribute("yijiList", yiji);
	request.setAttribute("parentId", parentId);
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
	$('#mySelect').change(function(){
		$('#submit').click();
	})
});

function editOK(i,a,b){

}
	function editThis(id){
		layer.open({
	    	type: 2,
	    	title: '修改栏目',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['400px', '280px'],
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
					<div class="title_bar" style="height:50px;line-height:50px;">
					<form name="form1" type="form" method="post" action="menu.jsp?nav=lmgl" style="float:left;">
							<span style="">父栏目</span>
							<select name="parentId" style="height:32px;;margin-top: 11px;width:120px;word-wrap: normal;" id="mySelect">
								<option value="">全部</option>
							<c:forEach items="${yijiList }" var="first">
								<option <c:if test="${first.id==parentId}"> selected </c:if>  value="${first.id}">${first.name}</option>
							</c:forEach>
							</select>
							<input style="margin-right:20px;margin-top:12px;height:28px;width:60px;cursor:pointer;display:none" id="submit" type="submit" value="搜索"/>
					</form>
						<c:if test="${session_auth_list.indexOf('$info_addMenu')>-1 }">
							<button style="float:right;margin-top: 11px;padding:5px;margin-right:20px;cursor:pointer" onclick="openAdd();">添 &nbsp;加</button>
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
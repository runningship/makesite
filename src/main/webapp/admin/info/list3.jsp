<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
	Page<Map> p = new Page<Map>();
	String currentPageNo =  request.getParameter("currentPageNo");
	String searchText =  request.getParameter("searchText");
	String yijiId =  request.getParameter("yijiId");
	String erjiId =  request.getParameter("erjiId");
	String _site =  request.getServerName();
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	StringBuilder hql = new StringBuilder("select art.name as name, art.id as id , art.addtime as addtime , art.orderx as orderx, m2.name as fname from Article art,Menu m1,Menu m2 where m1.id=m2.parentId and art.parentId=m2.id ");
	List<Object> params = new ArrayList<Object>();
	if(StringUtils.isNotEmpty(yijiId)){
		hql.append(" and m1.id=?");
		params.add(Integer.valueOf(yijiId));
	}
	if(StringUtils.isNotEmpty(erjiId)){
		hql.append(" and m2.id=?");
		params.add(Integer.valueOf(erjiId));
	}
	if(StringUtils.isNotEmpty(searchText)){
		hql.append(" and art.name like ?");
		params.add("%"+searchText+"%");
	}
	if(StringUtils.isNotEmpty(_site)){
		hql.append(" and art._site like ?");
		params.add("%"+_site+"%");
	}
		hql.append(" order by m1.orderx desc , m2.orderx desc , art.orderx desc");
	p  = dao.findPage(p, hql.toString(),true, params.toArray());


	List<Menu> yiji  = dao.listByParams(Menu.class, "from Menu where parentId is null and type = 'menu' order by orderx desc");
	List<Menu> erji  = dao.listByParams(Menu.class, "from Menu where parentId is not null and type = 'menu' order by orderx desc");
	request.setAttribute("page", p);
	request.setAttribute("yijiList", yiji);
	request.setAttribute("erjiList", erji);

	request.setAttribute("yijiId", yijiId);
	request.setAttribute("erjiId", erjiId);
	request.setAttribute("searchText", searchText);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文章目录</title>

<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript"  src="../js/fileupload.js" ></script>
<script type="text/javascript" src="../js/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
$(function(){
});

	function infoDel(id){
		YW.ajax({
		    type: 'POST',
		    url: '/${projectName}/c/admin/article/delete?id='+id,
		    mysuccess: function(data){
		        alert('删除成功');
		        window.location.reload();
		    }
	    });
	}

function reloadWindow(){
	window.location.reload();
}

	function editThis(id){
		layer.open({
	    	type: 2,
	    	title: '修改文章',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['800px', '700px'],
		    content: 'editw.jsp?id='+id
		}); 
	}

var SearchId;
function setSearch(obj){
	SearchId = obj.value;
	if (SearchId=='') {
		$('.erji').show();
	}else{
		$('.erji').hide();
		$('option[type="'+SearchId+'"]').show();
	}
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
							<h3>文章目录</h3>
					<form name="form1" type="form" method="get" action="list3.jsp" style="float:right;width:700px;">
							<select name="yijiId" style="width:100px;" onchange="setSearch(this);">
								<option value="">全部</option>
							<c:forEach items="${yijiList }" var="first">
								<option <c:if test="${first.id==yijiId}"> selected </c:if>  value="${first.id}">${first.name}</option>
							</c:forEach>
							</select>
							<select name="erjiId" style="width:100px;margin-right: 30px;">
								<option value="">全部</option>
							<c:forEach items="${erjiList }" var="second">
								<option class="erji" type="${second.parentId}" value="${second.id}" >${second.name}</option>
							</c:forEach>
							</select>
							<input name="searchText" value="${searchText}"  style="margin-right: 30px;" placeholder="标题名称">
							<input style="margin-right: 50px;" type="submit" value="搜索"/>
					</form>
						</div>
					<table class="fileList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>文章名</td>
							<td>父栏目</td>
							<td>排序</td>
							<td>发布时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result }" var="article" varStatus="status">
							<tr class="statue_${status.index%2}">
							<td> ${article.name } </td> 
							<td>${article.fname}</td>
							<td>${article.orderx }</td> 
							<td><fmt:formatDate value="${article.addtime }" pattern="yyyy-MM-dd HH:mm"/></td> 
							<td><a href="#" onclick="editThis(${article.id})">修改</a>  <a href="#" onclick="infoDel(${article.id})">删除</a></td>
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
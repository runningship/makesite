<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Page<User> p = new Page<User>();
	String currentPageNo =  request.getParameter("currentPageNo");
	try{
		p.currentPageNo = Integer.valueOf(currentPageNo);
	}catch(Exception ex){
	}
	p  = dao.findPage(p,"from User where 1=1 order by id desc");
	request.setAttribute("page", p);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	function userAdd(){
		layer.open({
	    	type: 2,
	    	title: '添加用户',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['500px', '500px'],
		    content: 'add.jsp'
		}); 
	}

	function userEdit(id){
		layer.open({
	    	type: 2,
	    	title: '修改用户',
		    shadeClose: false,
		    shade: 0.5,
		    area: ['500px', '500px'],
		    content: 'edit.jsp?id='+id
		}); 
	}

function reloadWindow(){
	window.location.reload();
}

	function userDel(id){
		YW.ajax({
		    type: 'POST',
		    url: '${projectName }/c/admin/user/delete?id='+id,
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
						<h3>用户列表</h3>
					</div>
					<table class="userList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>账号</td>
							<td>手机号</td>
							<td>姓名</td>
							<td>最后登录时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.result}" var="user" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td>${user.account}</td>
								<td>${user.tel}</td>
								<td>${user.name}</td>
								<td><fmt:formatDate value="${user.lasttime }" pattern="yyyy-MM-dd HH:mm"/></td>
								<td>
									<a href="#" onclick="userEdit('${user.id}');return false">修改</a>
									<a href="#" onclick="userDel('${user.id}');return false">删除</a>
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
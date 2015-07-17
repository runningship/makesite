<%@page import="com.youwei.makesite.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	List<User> list  = dao.listByParams(User.class,"from User where 1=1");
	request.setAttribute("list", list);
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
		    shade: 0.8,
		    area: ['400px', '320px'],
		    content: 'add.jsp'
		}); 
	}

	function userEdit(id){
		layer.open({
	    	type: 2,
	    	title: '修改用户',
		    shadeClose: false,
		    shade: 0.8,
		    area: ['400px', '320px'],
		    content: 'edit.jsp?id='+id
		}); 
	}

	function userDel(id){
		YW.ajax({
		    type: 'POST',
		    url: '/${projectName}/c/admin/user/delete?id='+id,
		    mysuccess: function(data){
		        alert('删除成功');
		    },
		    complete:function(){
		        api.button({
		              name: '保存',
		              disabled:false
		          });
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
						<button onclick="userAdd();return false;" style="float:right;margin-top:-35px;padding:5px;">添 &nbsp;加</button>
					</div>
					<table class="userList" >
						<tr>
							<td>账号</td>
							<td>手机号</td>
							<td>姓名</td>
							<td>最后登录时间</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${list}" var="user">
							<tr>
								<td>${user.account}</td>
								<td>${user.tel}</td>
								<td>${user.name}</td>
								<td>${user.lasttime}</td>
								<td>
									<a href="#" onclick="userEdit('${user.id}');return false">修改</a>
									<a href="#" onclick="userDel('${user.id}');return false">删除</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>

				<div class="pagination_wrp">
					<div class="pagination">
						<span class="page_nav_area"> <a href="javascript:void(0);" class="btn page_first" style="display: none;"></a> <a href="javascript:void(0);" class="btn page_prev" style="display: none;"><i
								class="arrow"></i></a> <span class="page_num"> <label>1</label> <span class="num_gap">/</span> <label>5</label>
						</span> <a href="javascript:void(0);" class="btn page_next"><i class="arrow"></i></a> <a href="javascript:void(0);" class="btn page_last" style="display: none;"></a>
						</span> <span class="goto_area"> <input type="text"> <a href="javascript:void(0);" class="btn page_go">跳转</a>
						</span>

					</div>
				</div>


			</div>
		</div>

	</div>
</body>
</html>
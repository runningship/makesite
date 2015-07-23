<%@page import="java.io.File"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String roleId = request.getParameter("roleId");
	try {
		String text = FileUtils.readFileToString(new File(request.getServletContext().getRealPath("/")+File.separator+"auths.json"), "utf8");
		JSONArray jarr = JSONArray.fromObject(text);
		request.setAttribute("list", jarr);
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>功能授权</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	
</script>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<form name="form1">
					<table class="userList" cellspacing="0">
						<tr style="background: aliceblue;">
							<td>描述</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${list}" var="auth" varStatus="status">
							<tr class="statue_${status.index%2}">
								<td>${auth.module}</td>
								<td>
									<input type="checkbox"  name="authId" value="${auth.id }"/>
								</td>
							</tr>
						</c:forEach>
					</table>
					</form>
				</div>
				<jsp:include page="../inc/pagination.jsp"></jsp:include>
			</div>
		</div>

	</div>
</body>
</html>
<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String topId = request.getParameter("topArticleId");
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Article currentArticle = dao.getUniqueByParams(Article.class, new String[]{"id","_site"}, new Object[]{Integer.valueOf(topId) , DataHelper.getServerName(request)});
	request.setAttribute("currentArticle", currentArticle);
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript">

</script>


<style>
</style>
</head>
<body class="backgray">
<div class="body">
   	<jsp:include page="top.jsp"></jsp:include>
    <div class="hreader">
    	<jsp:include page="menu.jsp"></jsp:include>
    </div>
    <div class="mainer ">
        <div class="wbox newspage">
            <div class="wrap">
                <ul class="breadcrumb">
                  <li><a href="#">首页</a><span>/</span></li>
                  <li><a>${currentArticle.name }</a></li>
                </ul>
            </div>
            <div class="wrap table ">
                <div class="tr">
                    <div class="td r">
                        <div class="titlebox">
                            <h1 class="h1">${currentArticle.name}</h1>
                            <p></p>
                        </div>
                        <div class="content">${currentArticle.conts}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
		<jsp:include page="footer.jsp"></jsp:include>
    </div>
</div>
</body>
</html>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	List<Menu> topMenus = dao.listByParams(Menu.class, "from Menu where parentId is null and _site = ?", DataHelper.getServerName(request));
	//循环获取子目录,子文章
	for(Menu menu : topMenus){
		//加载子栏目列表
		List<Menu> menuList = dao.listByParams(Menu.class, "from Menu where parentId=?", menu.id);
		//加载文章列表
		List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=?", menu.id);
		menu.menuChildren = menuList;
		menu.articleChildren = articleList;
	}
	request.setAttribute("topMenus", topMenus);
	List<Article> topArticles = dao.listByParams(Article.class, "from Article where parentId is null and _site = ?", DataHelper.getServerName(request));
	//List<Menu> erji = dao.listByParams(Menu.class, "from Menu where parentId is not null and _site = ?", DataHelper.getServerName(request));
	
%>
    <div class="wbox clearfix">
        <div class="logo_box">
            <a href="#" class="logo"><img src="images/logoT.png" height="100" alt=""></a>
        </div>
        <div class="frbox">
        <ul class="nav clearfix">
            <li class="navli hv"><a href="index.jsp" class="a">首页</a></li>
		<c:forEach items="${topMenus}" var="topMenu">
            	<li class="navli hv">
            		<c:if test="${topMenu.menuChildren.size()>0 }"><a href="list.jsp?parentId=${topMenu.id }" class="a">${topMenu.name }</a></c:if>
            		<c:if test="${topMenu.menuChildren.size()<=0 && topMenu.articleChildren.size()>0}"><a href="new.jsp?parentId=${topMenu.id }" class="a">${topMenu.name }</a></c:if>
            		<c:if test="${topMenu.menuChildren.size()<=0 && topMenu.articleChildren.size()<=0}"><a href="#" class="a">${topMenu.name }</a></c:if>
            		
            	<c:if test="${topMenu.menuChildren.size()>0 ||  topMenu.articleChildren.size()>0}">
                 <ul class="subnav hvB"  >
					<c:forEach items="${topMenu.menuChildren}" var="menu">
	                      <li class="topMenuSubLi"><a href="list.jsp?id=${menu.id}&parentId=${topMenu.id}">${menu.name}</a></li>
	                 </c:forEach>
					<c:forEach items="${topMenu.articleChildren}" var="art">
	                      <li class="topMenuSubLi"><a href="new.jsp?id=${art.id}&parentId=${topMenu.id}">${art.name}</a></li>
	                 </c:forEach>
                 </ul>
                 </c:if>
                </li>
		</c:forEach>
            <li class="navli hv"><a href="contact.jsp?parentId=-1" class="a">联系我们</a></li>
            <li class="navli hv"><a href="book.jsp" class="a">反馈信息</a></li>
        </ul>
        </div>
    </div>
    <div class="bgb"></div>

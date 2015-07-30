<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String topId = request.getParameter("parentId");
	String menuId = request.getParameter("id");
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Menu topMenu = dao.get(Menu.class, Integer.valueOf(topId));
	Menu currentMenu = dao.get(Menu.class, Integer.valueOf(menuId));
	request.setAttribute("topMenu", topMenu);
	request.setAttribute("currentMenu", currentMenu);
	request.setAttribute("menuId", menuId);
	request.setAttribute("topId", topId);
	//加载子栏目列表
	List<Menu> menuList = dao.listByParams(Menu.class, "from Menu where parentId=?", Integer.valueOf(topId));
	//加载文章列表
	List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=?", Integer.valueOf(topId));
	request.setAttribute("menuList", menuList);
	request.setAttribute("articleList", articleList);
	
	//加载二级栏目下的文章列表 
	List<Article> articleList2 = dao.listByParams(Article.class, "from Article where parentId=?", Integer.valueOf(menuId));
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript">
$(document).on('click', '.selector', function(event) {
    event.preventDefault();
    /* Act on the event */
});
$(document).on({
      mouseenter: function(){
        var Thi=$(this),
        ThiB=Thi.find('.hvB');
        curHeight = ThiB.height();
        ThiB.stop().animate({height:'show'},
            500, function() {
        });
      },
      mouseleave: function(){
        var Thi=$(this),
        ThiB=Thi.find('.hvB');
        ThiB.stop().animate({height:'hide',overflow:'hidden'},
            500, function() {
        });
        // st=setTimeout(function(){
        //     Thi.find('.hvB').hide();
        //     clearTimeout(st);
        // },300);
      }
},'.hv');
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
        <div class="wbox newspage listpage">
            <div class="wrap">
                <ul class="breadcrumb">
                  <li><a href="#">首页</a><span>/</span></li>
                  <li><a href="#">行业动态</a></li>
                </ul>
            </div>
            <div class="wrap table ">
                <div class="tr">
                    <div class="td l">
                        <dl class="menutabs">
                            <dt>${topMenu.name }</dt>
                            <c:forEach items="${menuList}" var="menu">
                            	<dd <c:if test="${menu.id==menuId }"> class="active"</c:if>>
                            		<c:if test="${menu.id==menuId }"><a href="#">${menu.name }</a></c:if>
                            		<c:if test="${menu.id!=menuId }"><a href="list.jsp?id=${menu.id }&parentId=${topId}">${menu.name }</a></c:if> 
                            	</dd>
                            </c:forEach>
                            <c:forEach items="${articleList}" var="art">
                            	<dd ><a href="new.jsp?id=${art.id }&parentId=${topId}">${art.name }</a> </dd>
                            </c:forEach>
                        </dl>
                        <div class="aboutContent">
                            <h2>公司地址：</h2>
                            <p>投资管理的重要性12号。</p>
                            <h2>全国免费客服电话：</h2>
                            <p>4006-666-888</p>
                            <h2>服务邮箱：</h2>
                            <p>QQ123456@qq.com</p>
                        </div>
                    </div>
                    <div class="td r">
                        <div class="titlebox">
                            <h1 class="h1">${currentMenu.name }</h1>
                            <p></p>
                        </div>
                        <ul class="UList">
                        	<c:forEach items="${articleList}" var="art">
                            <li class="first">
                                <a href="#" title="${art.name }"><span>${art.addtime }</span>${art.name }</a>
                            </li>
                            </c:forEach>
                        </ul>
                        <ul class="pagelist">
                            <li><a href="#">首页</a></li>
                            <li><a href="#">上一页</a></li>
                            <li><a href="#" class="active">1</a></li>
                            <li><a href="#">2</a></li>
                            <li>...</li>
                            <li><a href="#">11</a></li>
                            <li><a href="#">12</a></li>
                            <li><a href="#">下一页</a></li>
                            <li><a href="#">尾页</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="wbox flink">
            <a href="#">首页</a>
            <a href="#">联系我们</a>
            <a href="#">法律声明</a>
        </div>
        <div class="copyright">
            <div class="wbox">
                <img src="images/logo_m.png" alt="">
                ©2015 中华国际 版权所有 　 皖ICP备11012870号
                <div class="fr">版权所有</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
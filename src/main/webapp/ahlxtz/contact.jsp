<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String topId = request.getParameter("parentId");
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	String[] params = new String[]{"name","parentId","_site"};
	Article currentArticle = dao.getUniqueByParams(Article.class, params, new Object[]{"contact", Integer.valueOf(topId) , DataHelper.getServerName(request)});
	request.setAttribute("currentArticle", currentArticle);
	//加载子栏目列表
	//加载文章列表
	List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=?", Integer.valueOf(topId));
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
        <div class="wbox newspage">
            <div class="wrap">
                <ul class="breadcrumb">
                  <li><a href="#">首页</a><span>/</span></li>
                  <li><a href="#">行业动态</a></li>
                </ul>
            </div>
            <div class="wrap table ">
                <div class="tr">
                    <div class="td r">
                        <div class="titlebox">
                            <h1 class="h1">联系我们</h1>
                            <p></p>
                        </div>
                        <div class="content">${currentArticle.conts}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
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
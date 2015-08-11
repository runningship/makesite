<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id = request.getParameter("parent2Id");
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Menu menu = dao.get(Menu.class, Integer.valueOf(id));
	String topId = String.valueOf(menu.parentId);
	Menu topMenu = dao.get(Menu.class, Integer.valueOf(topId));
	
	request.setAttribute("topMenu", topMenu);
	
	request.setAttribute("topId", topId);
	//加载子栏目列表
	List<Menu> menuList = dao.listByParams(Menu.class, "from Menu where parentId=?", Integer.valueOf(topId));
	//加载文章列表
	List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=?", Integer.valueOf(topId));
	request.setAttribute("menuList", menuList);
	request.setAttribute("articleList", articleList);
	
	String articleId = request.getParameter("id");
	Article currentArticle;
	if(StringUtils.isEmpty(articleId)){
		currentArticle=articleList.get(0);
	}else{
		currentArticle = dao.get(Article.class, Integer.valueOf(articleId));
	}
	request.setAttribute("currentArticle", currentArticle);
	Menu currentArticleMenu = dao.get(Menu.class, currentArticle.parentId);
	request.setAttribute("currentArticleMenu", currentArticleMenu);
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<!-- <link href="js/video-js/video-js.css" rel="stylesheet">   -->
<!-- <script src="js/video-js/video.dev.js" rel="stylesheet"></script>  -->
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

$(function(){
//     $('.video-js').each(function(index,obj){
//         videojs(obj).ready(function(){
//           var myPlayer = this;
//           myPlayer.play();
//           setTimeout(function(){
//               myPlayer.pause();
//           },300);
//         });
//     });
});

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
                  <li><a>首页</a><span>/</span></li>
                  <li><a>${topMenu.name }</a><span>/</span></li>
                  <li><a>${currentArticleMenu.name }</a><span>/</span></li>
                  <li><a>${currentArticle.name }</a></li>
                </ul>
            </div>
            <div class="wrap table ">
                <div class="tr">
                    <div class="td l">
                        <dl class="menutabs">
                            <dt>${topMenu.name }</dt>
                            <c:forEach items="${menuList}" var="menu">
                            	<dd <c:if test="${menu.id==currentArticle.parentId }"> class="active"</c:if> >
                            		<c:if test="${menu.id==menuId }"><a href="#">${menu.name }</a></c:if>
                            		<c:if test="${menu.id!=menuId }"><a href="list.jsp?id=${menu.id }&parentId=${topId}">${menu.name }</a></c:if> 
                            	</dd>
                            </c:forEach>
                            <c:forEach items="${articleList}" var="art">
                            	<dd >
                            		<c:if test="${art.id==currentArticle.id }"> <a href="#">${art.name }</a></c:if>
                            		<c:if test="${art.id!=currentArticle.id }"> <a href="new.jsp?id=${art.id }&parentId=${topId}">${art.name }</a></c:if>
                            	</dd>
                            </c:forEach>
                        </dl>
                        <div class="aboutContent">
                            <h2>地址：</h2>
                            <p>安徽省合肥市包河区大连路中段徽商总部广场A座11楼。</p>
                            <h2>电话：</h2>
                            <p>0551-63611301</p>
                            <h2>传真：</h2>
                            <p>0551-63611817</p>
                            <h2>邮箱：</h2>
                            <p>lxtz@ahlxtz.com</p>
                            <h2>网址：</h2>
                            <p>www.ahlxtz.com</p>
                        </div>
                    </div>
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
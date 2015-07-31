<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String topId = request.getParameter("parentId");
	
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Menu topMenu = dao.get(Menu.class, Integer.valueOf(topId));
	
	request.setAttribute("topMenu", topMenu);
	
	request.setAttribute("topId", topId);
	//加载子栏目列表
	List<Menu> menuList = dao.listByParams(Menu.class, "from Menu where parentId=?", Integer.valueOf(topId));
	
	String menuId = request.getParameter("id");
	if(StringUtils.isEmpty(menuId)){
		menuId = menuList.get(0).id.toString();
	}
	Menu currentMenu = dao.get(Menu.class, Integer.valueOf(menuId));
	request.setAttribute("currentMenu", currentMenu);
	request.setAttribute("menuId", menuId);
	
	//加载文章列表
	List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=?", Integer.valueOf(topId));
	request.setAttribute("menuList", menuList);
	request.setAttribute("articleList", articleList);
	
	Page<Article> p = new Page<Article>();
	p.setPageSize(1);
	String currentPageNo =  request.getParameter("currentPageNo");
	//加载二级栏目下的文章列表 
	p = dao.findPage(p, "from Article where parentId=?", Integer.valueOf(menuId));
	request.setAttribute("page", p);
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

function goPage(pageNo){
	window.location = window.location.href+"&currentPageNo="+pageNo;
}
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
                        	<c:forEach items="${page.result}" var="art">
                            <li class="first">
                                <a href="#" title="${art.name }"><span>${art.addtime }</span>${art.name }</a>
                            </li>
                            </c:forEach>
                        </ul>
                        <ul class="pagelist">
                            <li><a href="#">首页</a></li>
                            <c:forEach var="offset" begin="1" end="2" step="1">
                            	<c:if test="${page.currentPageNo-offset >0}">
                            	<li><a href="javascript:void(0)" onclick="goPage(${page.currentPageNo-offset})">${page.currentPageNo-offset }</a></li>
                            	</c:if>  
                            </c:forEach>
                            <li><a href="#" class="active">${page.currentPageNo}</a></li> 
                  			<c:forEach var="offset" begin="1" end="2" step="1">
                  				<c:if test="${page.currentPageNo+offset <page.totalPageCount}">
                            	<li><a href="javascript:void(0)" onclick="goPage(${page.currentPageNo+offset})">${page.currentPageNo+offset }</a></li>
                            	</c:if> 
                            </c:forEach>
                            <c:if test="${page.currentPageNo+offset <page.totalPageCount}">
                             	<li><a href="#">...</a></li>
                             </c:if>
                            <li><a href="#">尾页</a></li>
                        </ul>
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
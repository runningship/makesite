<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
		if(menuList.size()>0){
			menuId = menuList.get(0).id.toString();	
		}
	}
	if(StringUtils.isNotEmpty(menuId)){
		Menu currentMenu = dao.get(Menu.class, Integer.valueOf(menuId));
		request.setAttribute("currentMenu", currentMenu);
		request.setAttribute("menuId", menuId);
		
		Page<Article> p = new Page<Article>();
		//p.setPageSize(1);
		String currentPageNo =  request.getParameter("currentPageNo");
		try{
			p.currentPageNo = Integer.valueOf(currentPageNo);
		}catch(Exception ex){
			
		}
		//加载二级栏目下的文章列表 
		p = dao.findPage(p, "from Article where parentId=?", Integer.valueOf(menuId));
		request.setAttribute("page", p);
	}
	
	
	//加载文章列表
	List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=?", Integer.valueOf(topId));
	request.setAttribute("menuList", menuList);
	request.setAttribute("articleList", articleList);
	
	
	
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
	window.location = window.location.pathname+"?id=${menuId}&parentId=${topId}&currentPageNo="+pageNo;
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
                  <li><a>首页</a><span>/</span></li>
                  <li><a>${topMenu.name }</a><span>/</span></li>
                  <li><a>${currentMenu.name }</a></li>
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
                            <h2>地址：</h2>
                            <p>安徽省合肥市包河区大连路中段徽商总部广场A座11楼。</p>
                            <h2>电话：</h2>
                            <p>0551-63611301</p>
                            <h2>传真：</h2>
                            <p>055163611817</p>
                            <h2>邮箱：</h2>
                            <p>lxtz@ahlxtz.com</p>
                            <h2>网址：</h2>
                            <p>ahlxtz.com</p>
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
                                <a href="info.jsp?id=${art.id}&parent2Id=${art.parentId}" title="${art.name }"><span><fmt:formatDate value="${art.addtime }" pattern="yyyy-MM-dd"/></span>${art.name }</a>
                            </li>
                            </c:forEach>
                        </ul>
                        <c:if test="${page.totalPageCount >1 }">
                        <ul class="pagelist">
                            <li><a href="javascript:void(0)" onclick=goPage(1)>首页</a></li>
                            <c:if test="${page.currentPageNo-2 >1}">
                             	<li><span>...</span></li>
                             </c:if>
                            <c:forEach var="offset" begin="1" end="2" step="1">
                            	<c:if test="${page.currentPageNo+offset-3 >0}">
                            	<li><a href="javascript:void(0)" onclick="goPage(${page.currentPageNo+(offset-3)})">${page.currentPageNo+(offset-3) }</a></li>
                            	</c:if>  
                            </c:forEach>
                            <li><a href="#" class="active">${page.currentPageNo}</a></li> 
                  			<c:forEach var="offset" begin="1" end="2" step="1">
                  				<c:if test="${page.currentPageNo+offset <=page.totalPageCount}">
                            	<li><a href="javascript:void(0)" onclick="goPage(${page.currentPageNo+offset})">${page.currentPageNo+offset }</a></li>
                            	</c:if> 
                            </c:forEach>
                            <c:if test="${page.currentPageNo+2 <page.totalPageCount}">
                             	<li><span>...</span></li>
                             </c:if>
                            <li><a  href="javascript:void(0)" onclick="goPage(${page.totalPageCount})">尾页</a></li>
                        </ul>
                        </c:if>
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
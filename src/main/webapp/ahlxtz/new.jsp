<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Integer parentId = Integer.valueOf(request.getParameter("parentId"));
	List<Menu> yiji = dao.listByParams(Menu.class, "from Menu where parentId is null and _site = ?", DataHelper.getServerName(request));
	Article art = dao.get(Article.class, id);
	Menu parent2 = dao.get(Menu.class, art.parentId);
	if(parent2.parentId > 0){
		parentId = parent2.parentId;
	}
	List<Menu> parent = dao.listByParams(Menu.class, "from Menu where id = ? and _site = ?",parentId , DataHelper.getServerName(request));
	List<Menu> erji = dao.listByParams(Menu.class, "from Menu where parentId is not null and _site = ?", DataHelper.getServerName(request));
	request.setAttribute("article", art);
	request.setAttribute("yiji", yiji);
	request.setAttribute("parent", parent);
	request.setAttribute("erji", erji);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Examples</title>
<meta name="description" content="">
<meta name="keywords" content="">
<script src="js/jquery.min.js"></script>
<link href="css/reset.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">


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
    <div class="toper">
        <div class="wbox">
            <dl class="tMenu hv">
                <dt class="hvA">成员网站 +</dt>
                <dd class="hvB"><a href="#">站点1</a>
                <a href="#">站点2</a>
                <a href="#">站点3</a></dd>
            </dl>
            <ul class="tA">
                <li><a href="#">首页</a></li>
                <li><a href="#">加入收藏</a></li>
                <li><a href="#">设置首页</a></li>
            </ul>
        </div>
    </div>
    <div class="hreader">
        <div class="wbox clearfix">
            <!-- <div class="frbox">
                <div class="fl searchBox">
                    <img src="images/temp/search.jpg" alt="">
                </div>
            </div> -->
            <div class="logo_box">
                <a href="#" class="logo"><img src="images/logo.png" height="70" alt=""></a>
            </div>
        </div>
        <div class="wbox clearfix">
            <ul class="nav clearfix">
                <li class="navli hv"><a href="#" class="a">新闻中心</a>
                    <ul class="subnav hvB">
                        <li><a href="#">新闻1</a></li>
                        <li><a href="#">新闻2</a></li>
                        <li><a href="#">新闻3</a></li>
                        <li><a href="#">新闻4</a></li>
                    </ul>
                </li>
				<c:forEach items="${yiji}" var="yiji">
                	<li class="navli hv"><a href="#">${yiji.name }</a>
	                    <ul class="subnav hvB">
						<c:forEach items="${erji}" var="erji">
							<c:if test="${erji.parentId == yiji.id}">
		                        <li><a href="#">${erji.name}</a></li>
	                        </c:if>
	                    </c:forEach>
	                    </ul>
                    </li>
				</c:forEach>
            </ul>
        </div>
        <div class="bgb"></div>
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
                    <div class="td l">
                        <dl class="menutabs">
							<c:forEach items="${parent}" var="yiji">
	                            <dt>${yiji.name}</dt>
								<c:forEach items="${erji}" var="erji">
									<c:if test="${erji.parentId == yiji.id}">
			                            <dd><a href="#">${erji.name}</a> </dd>
			                        </c:if>
		                        </c:forEach>
                            </c:forEach>
                        </dl>
                        <div class="aboutContent">
                            <h2>公司地址：</h2>
                            <p>投资管理的重要性12号。</p>
                            <h2>全国免费客服电话：</h2>
                            <p>4006-666-888</p>
                            <h2>服务邮箱：</h2>
                            <p>QQ123456@qq.com</p>
                            <ul class="weixin">
                                <li><a href="#"><i class="iconfont">&#xe603;</i> 新浪微博</a></li>
                                <li><a href="#"><i class="iconfont">&#xe600;</i> 腾讯微博</a></li>
                                <li><a href="#"><i class="iconfont">&#xe615;</i> QQ空间</a></li>
                                <li><a href="#"><i class="iconfont">&#xe602;</i> 微信 </a> <a href="#" class="weixinlink"><i class="iconfont">&#xe61a;</i><div class="posa"><img src="http://www.zhongjiebao.com/images/indexErweima.png" alt=""></div></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="td r">
                        <div class="titlebox">
                            <h1 class="h1">${article.name}</h1>
                            <p></p>
                        </div>
                        <div class="content">${article.conts}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="wbox fline">
            <ul class="fline_list clearfix">
				<c:forEach items="${yiji}" var="yiji">
                <li class="a1">
                    <dl>
                        <dt class="lineTitle">${yiji.name} </dt>
						<c:forEach items="${erji}" var="erji">
							<c:if test="${erji.parentId == yiji.id}">
                        	<dd> <a href="about_fazhan.asp">${erji.name}</a> </dd>
                        	</c:if>
                        </c:forEach>
                    </dl>
                </li>
                </c:forEach>
                <li class="fr">
                    <dl>
                        <dt class="lineTitle">联系我们 </dt>
                        <h1>4006-666-888</h1>
                        <p>周一至周日 8:00-18:00<br/>（仅收市话费）</p>
                        <div><a href="#" class="btn">在线客服</a></div>
                    </dl>
                </li>
            </ul>
        </div>
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
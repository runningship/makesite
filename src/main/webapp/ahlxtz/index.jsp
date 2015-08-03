<%@page import="com.youwei.makesite.util.HTMLSpirit"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
request.setAttribute("projectName", request.getServletContext().getContextPath());
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
Article jianjie = dao.getUniqueByParams(Article.class, new String[]{"name" , "_site"}, new Object[]{"company" , DataHelper.getServerName(request)});
jianjie.conts = HTMLSpirit.delHTMLTag(jianjie.conts);
request.setAttribute("jianjie", jianjie);
//选择前4个栏目
List<Menu> menus = dao.listByParams(Menu.class, "from Menu where _site=? and parentId is null order by orderx asc", DataHelper.getServerName(request));
//循环获取子目录,子文章
for(Menu menu : menus){
	//加载子栏目列表
	List<Menu> menuList = dao.listByParams(Menu.class, "from Menu where parentId=? order by orderx asc", menu.id);
	//加载文章列表
	List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=? order by orderx asc", menu.id);
	menu.menuChildren = menuList;
	menu.articleChildren = articleList;
}
request.setAttribute("menus", menus);
if(menus.get(0).articleChildren!=null && menus.get(0).articleChildren.size()>0){
	request.setAttribute("firstArticle", menus.get(0).articleChildren.get(0));
	String firstArticleConts = HTMLSpirit.delHTMLTag(menus.get(0).articleChildren.get(0).conts);
	request.setAttribute("firstArticleConts", firstArticleConts);
}
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript">
$(document).on('click', '.btn_act', function(event) {
    var Thi=$(this),
    ThiType=Thi.data('type');
    if(ThiType=='submit'){
        $('[name=form1]').submit();
    }
    event.preventDefault();
})
$(document).ready(function(){
    $('.banner').flexslider({
        directionNav: true,
        pauseOnAction: false
    });
});
function login(){
	var index;
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/user/login',
	    data: a,
	    mysuccess: function(json){
		      window.location="admin/index.jsp";
	    },
	    error:function(data){
	    	  alert('用户名或密码错误');
	      }
	  });
}

</script>
<script>
$(function(){
    $('#slides').slides({
        preload: true,
        preloadImage: 'images/loading.gif',
        play: 3000,
        pause: 2500,
        hoverPause: true,
        animationStart: function(current){
            $('.caption').animate({
                bottom:-35
            },100);
            if (window.console && console.log) {
                // example return of current slide number
                //console.log('animationStart on slide: ', current);
            };
        },
        animationComplete: function(current){
            $('.caption').animate({
                bottom:0
            },200);
            if (window.console && console.log) {
                // example return of current slide number
                //console.log('animationComplete on slide: ', current);
                var thi=$('#slides img').eq(current-1);
                if(thi.hasClass('autoOK')){
                //console.log(!thi.hasClass('autoOK'))
                    thi.addClass('autoOK');
                    imgAutoBox(thi.parent())
                }
            };
        },
        slidesLoaded: function() {
            $('.caption').animate({
                bottom:0
            },200);
                imgAutoBox($('#slides img').eq(0).parent());
                $('#slides img').addClass('autoOK');
                // $('#slides img').each(function(index, el) {
                //     imgAutoBox($(this).parent())
                // });
        }
    });
});

</script>
<script type="text/javascript">
$(document).ready(function(){
	$(document).on('keyup',function(event){
		if(event.keyCode==13){
			login();
		}
	});
	
    $('.ul_pic_lists').bxSlider({
        slideWidth: 200, 
        auto: true,
        autoControls: true,
        minSlides: 3,
        maxSlides: 5,
        slideMargin: 10
    });
});
</script>


<style>
</style>
</head>
<body>
    <jsp:include page="top.jsp"></jsp:include>
    <div class="hreader">
     <jsp:include page="menu.jsp"></jsp:include>
    <div class="banner">
    <ul class="slides">
        <li style="background:url(images/temp/img1.jpg) 50% 0 no-repeat;"></li>
        <li style="background:url(images/temp/img2.jpg) 50% 0 no-repeat;"></li>
        <li style="background:url(images/temp/img3.jpg) 50% 0 no-repeat;"></li>
    </ul>
    </div>
    <div class="mainer">
        <div class="wbox PT30 clearfix">
            <div class="loginboxs">
                
                <form name="form1" onsubmit="login();return false;">
                <ul>
                    <li class="tit"><strong>登录</strong></li>
                    <li><label class="inputbox focus"><i class="iconfont iu">&#xe608;</i><input type="text" name="account" class="input u" value=""></label></li>
                    <li><label class="inputbox"><i class="iconfont iu">&#xe606;</i><input type="password" name="pwd" class="input p" value=""></label></li>
                    <li class="btnbox"><a href="#" class="btn btn_submit btn_act" data-type="submit">登　录</a></li>
                        <input type="submit" class="hidden submit" name="submit">
                </ul>
                </form>
            </div>
            <div class="aboutbox">
                <strong class="tita">${jianjie.name}</strong>
                <strong class="titb">COMPANY PROFILE</strong>
                <p style="height:130px;overflow:hidden;">${jianjie.conts}</p>
            </div>
        </div>
        <div class="wbox clearfix">

            <div class="newimgbox" id="slides">

                <div class="slides_container">
                    <div class="slide imgbox"><img src="images/temp/DSC02822.jpg" alt="安徽省武术散打基地三里镇训练中心揭牌仪式">
                        <div class="caption" style="bottom:0">
                            <p>安徽省武术散打基地三里镇训练中心揭牌仪式</p>
                        </div>
                    </div>

                    <div class="slide imgbox"><img src="images/temp/DSC02574.jpg" alt="安徽光太实业集团六一爱心捐赠活动">
                        <div class="caption">
                            <p>安徽光太实业集团六一爱心捐赠活动</p>
                        </div>
                    </div>

                    <div class="slide imgbox"><img src="images/temp/DSC02848.jpg" alt="合肥市新站区工商联企业家捐资助学仪式">
                        <div class="caption">
                            <p>合肥市新站区工商联企业家捐资助学仪式</p>
                        </div>
                    </div>

                </div>
                <a href="#" class="prev"><img src="images/prev.png" width="50" height="50" alt="Arrow Prev"></a>
                <a href="#" class="next"><img src="images/next.png" width="50" height="50" alt="Arrow Next"></a>
            </div>


            <div class="newbox">
                <div class="h2"><span class="fr">
                	<c:if test="${menus.get(0).menuChildren.size()>0 }"> <a href="list.jsp?parentId=${menus.get(0).id}">更多</a></c:if>
                	<c:if test="${menus.get(0).menuChildren.size()<=0 }"> <a href="new.jsp?parentId=${menus.get(0).id}">更多</a></c:if>
                </span><strong>${menus.get(0).name }</strong></div>
                <ul class="ul_news_list w360">
                	<c:if test="${firstArticle ne null }">
                		<li class="first">
	                        <strong><a href="#">${firstArticle.name }</a></strong>
	                        <p style="height:70px;overflow:hidden">${firstArticleConts }</p>
	                    </li>
                	</c:if>
                	<div style="height:160px;overflow:hidden">
                    <c:forEach items="${menus.get(0).articleChildren }" var="art"  begin="0" step="1" end="6">
                    	<li><a target="_blank" href="new.jsp?id=${art.id }&parentId=${menus.get(0).id }" class="inTit fl">${art.name }</a> <span class="fr"><fmt:formatDate value="${art.addtime }" pattern="yyyy-MM-dd"/></span></li>
                    </c:forEach>
                    </div>
                </ul>
            </div>
        </div>

        <div class="wbox clearfix imgLink">
            <ul class="imgLink_list">
                <li class="tal"><a href="#"><img src="images/a1.jpg" alt=""></a></li>
                <li class="tac"><a href="#"><img src="images/a2.jpg" alt=""></a></li>
                <li class="tar"><a href="#"><img src="images/a3.jpg" alt=""></a></li>
            </ul>
        </div>

        <div class="wbox clearfix">
            <div class="newbox w300 fl">
                <div class="h2"><span class="fr">
                	<c:if test="${menus.get(1).menuChildren.size()>0 }"> <a href="list.jsp?parentId=${menus.get(1).id}">更多</a></c:if>
                	<c:if test="${menus.get(1).menuChildren.size()<=0 }"> <a href="new.jsp?parentId=${menus.get(1).id}">更多</a></c:if>
                </span><strong>${menus.get(1).name }</strong></div>
                <ul class="ul_news_list">
                    <c:forEach items="${menus.get(1).articleChildren }" var="art"  begin="0" step="1" end="4">
                    	<li><a target="_blank" href="new.jsp?id=${art.id }&parentId=${menus.get(1).id }" class="inTit fl">${art.name }</a><span class="fr"><fmt:formatDate value="${art.addtime }" pattern="yyyy-MM-dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="newbox w300 fl m">
                <div class="h2"><span class="fr">
					<c:if test="${menus.get(2).menuChildren.size()>0 }"> <a href="list.jsp?parentId=${menus.get(2).id}">更多</a></c:if>
                	<c:if test="${menus.get(2).menuChildren.size()<=0 }"> <a href="new.jsp?parentId=${menus.get(2).id}">更多</a></c:if>
				</span><strong>${menus.get(2).name }</strong></div>
                <ul class="ul_news_list">
                    <c:forEach items="${menus.get(2).articleChildren }" var="art"  begin="0" step="1" end="4">
                    	<li><a target="_blank" href="new.jsp?id=${art.id }&parentId=${menus.get(2).id }" class="inTit fl">${art.name }</a><span class="fr"><fmt:formatDate value="${art.addtime }" pattern="yyyy-MM-dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="newbox w300 fl m">
                <div class="h2"><span class="fr">
                	<c:if test="${menus.get(3).menuChildren.size()>0 }"> <a href="list.jsp?parentId=${menus.get(3).id}">更多</a></c:if>
                	<c:if test="${menus.get(3).menuChildren.size()<=0 }"> <a href="new.jsp?parentId=${menus.get(3).id}">更多</a></c:if>
                </span><strong>${menus.get(3).name }</strong></div>
                <ul class="ul_news_list">
                    <c:forEach items="${menus.get(3).articleChildren }" var="art"  begin="0" step="1" end="4">
                    	<li><a target="_blank" href="new.jsp?id=${art.id }&parentId=${menus.get(3).id }" class="inTit fl">${art.name }</a><span class="fr"><fmt:formatDate value="${art.addtime }" pattern="yyyy-MM-dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <div class="wbox clearfix">
            <div class="picbox">

                <div class="pic_list_box">
                <div class="ul_pic_lists">
                    <div class="slide"><img src="images/temp/01.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/02.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/03.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/04.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/05.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/06.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/07.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/08.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/09.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/10.jpg" alt=""></div>
                    <div class="slide"><img src="images/temp/11.jpg" alt=""></div>
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
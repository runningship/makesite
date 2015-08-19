<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.Page"%>
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
	Page<Map> p = new Page<Map>();
	p.setPageSize(5);
	String sql = "select art.id as artId, art.name as name ,art._site ,art.conts as conts, art.addtime as addtime , art.orderx as orderx , tt.* from " 
			+"Article art left join (  SELECT m1.id as fid , m2.id as tfid ,  m1.name as fname ,m2.name as tfname FROM Menu m1 left join Menu m2 on m1.parentId=m2.id ) tt on art.parentId=tt.fid where art._site=? and art.parentId>=0 and (tt.tfid=? or tt.fid=?) order by art.orderx asc,art.id desc ";
	p  = dao.findPageBySql(p, sql, DataHelper.getServerName(request) , menu.id , menu.id);
	//List<Article> articleList = dao.listByParams(Article.class, "from Article where parentId=? order by orderx asc", menu.id);
	menu.menuChildren = menuList;
	menu.articleChildren = new ArrayList<Article>();
	for(Map map : p.getResult()){
		Article art = new Article();
		art.id = (Integer)map.get("artId");
		art.name = (String)map.get("name");
		art.conts = (String)map.get("conts");
		art.addtime = (Date)map.get("addtime");
		menu.articleChildren.add(art);
	}
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
<script src="js/jquery.carouFredSel-6.0.4-packed.js" type="text/javascript"></script>
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
		      console.log('登录成功');
	    },
	    error:function(data){
	    	  //console.log('用户名或密码错误');
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
	
});


function play(){
	var html = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="280" height="188">'
    					+'<param name="movie" value="images/videoPlayer.swf">'
    					+'<param name="quality" value="high">'
    					+'<param name="allowFullScreen" value="true">'
    					+'<param name="FlashVars" value="vcastr_file=http://ahlxtz.zhongjiebao.com/upload/ahlxtz/video.flv&amp;LogoText=www.zhlxtz.com&amp;BufferTime=1&amp;IsAutoPlay=1">'
    					+'<embed src="images/videoPlayer.swf" allowfullscreen="true" flashvars="vcastr_file=http://ahlxtz.zhongjiebao.com/upload/ahlxtz/video.flv&amp;LogoText=www.ahlxtz.com&amp;IsAutoPlay=1" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="280" height="188">'
						+'</object>';
	$('#index_video').html(html);
}
</script>

<script type="text/javascript">
    $(function() {
        $('.pic_list_box ul').carouFredSel({
            prev: '#prev',
            next: '#next',
            pagination: "#pager",
            scroll: 1000
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
    </div>
    <div class="banner">
    <ul class="slides">
        <li style="background:url(images/temp/img1.jpg) 50% 0 no-repeat;"></li>
        <li style="background:url(images/temp/img2.jpg) 50% 0 no-repeat;"></li>
        <li style="background:url(images/temp/img3.jpg) 50% 0 no-repeat;"></li>
    </ul>
    </div>
    <div class="mainer">
        <div class="wbox PT30 clearfix">
            <div class="loginboxs2" style="margin-top:10px;" id="index_video">
            	<img src="images/yulan.png" onclick="play();" style="cursor:pointer;margin-left:auto;display:block;"/>
            </div>
            <div class="aboutbox">
                <strong class="tita">${jianjie.name}</strong>
                <strong class="titb">COMPANY PROFILE</strong>
                <p style="height:129px;overflow:hidden;">${jianjie.conts}</p>
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
                    <c:forEach items="${menus.get(0).articleChildren }" var="art"  begin="0" step="1" end="6">
                    	<li><a target="_blank" href="new.jsp?id=${art.id }&parentId=${menus.get(0).id }" class="inTit fl">${art.name }</a> <span class="fr"><fmt:formatDate value="${art.addtime }" pattern="yyyy-MM-dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <div class="wbox clearfix imgLink">
            <ul class="imgLink_list">
                <li class=""><a href="http://gtjt.cc/gt/" target="_blank" ><img src="images/a4.jpg" alt=""></a></li>
                <li class=""><a href="new.jsp?parentId=26" target="_blank"><img src="images/a1.jpg" alt=""></a></li>
                <li class=""><a href="new.jsp?id=21&parentId=24" target="_blank"><img src="images/a2.jpg" alt=""></a></li>
                <li class=""><a href="topNews.jsp?topArticleId=54" target="_blank"><img src="images/a3.jpg" alt=""></a></li>
                
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

                <ul>
                    <li><img src="images/temp/01.jpg" alt="" /><span>Image1</span></li>
                    <li><img src="images/temp/02.jpg" alt="" /><span>Image2</span></li>
                    <li><img src="images/temp/03.jpg" alt="" /><span>Image3</span></li>
                    <li><img src="images/temp/04.jpg" alt="" /><span>Image4</span></li>
                    <li><img src="images/temp/05.jpg" alt="" /><span>Image5</span></li>
                    <li><img src="images/temp/06.jpg" alt="" /><span>Image6</span></li>                    
                </ul>
                <div class="clearfix"></div>
                <a id="prev" class="prev" href="#">&lt;</a>
                <a id="next" class="next" href="#">&gt;</a>
                <div id="pager" class="pager"></div>
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
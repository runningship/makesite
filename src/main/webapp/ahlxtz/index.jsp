<%@page import="com.youwei.makesite.entity.Article"%>
<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	List<Menu> yiji = dao.listByParams(Menu.class, "from Menu where parentId is null and _site = ?", DataHelper.getServerName(request));
	List<Menu> erji = dao.listByParams(Menu.class, "from Menu where parentId is not null and _site = ?", DataHelper.getServerName(request));
	String[] params = {"name" , "_site"};
	Article art = dao.getUniqueByParams(Article.class, params,new Object[] {"company" , DataHelper.getServerName(request) });
	request.setAttribute("contact", art);
	request.setAttribute("yiji", yiji);
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
<script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="js/jquery.bxslider.js"></script>
<script type="text/javascript" src="js/slides.min.jquery.js"></script>
<script type="text/javascript" src="js/jquery.imagesAutoBox.js"></script>


<link href="css/reset.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/jquery.bxslider.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
$(document).on('click', '.selector', function(event) {
    event.preventDefault();
    /* Act on the event */
});
$(document).on({
      mouseenter: function(){
        $(this).find('.hvB').show();
      },
      mouseleave: function(){
        var Thi=$(this),
        st=setTimeout(function(){
            Thi.find('.hvB').hide();
            clearTimeout(st);
        },300);
      }
},'.hv');
$(document).ready(function(){
    $('.banner').flexslider({
        directionNav: true,
        pauseOnAction: false
    });
});
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
<div class="body">
    <div class="toper">
        <div class="wbox">
            <dl class="tMenu hv">
                <dt class="hvA">成员网站 +</dt>
                <dd class="hvB"><a href="#">站点1站点1站点1站点1</a>
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
                
                <form name="form" action="">
                <ul>
                    <li class="tit"><strong>登录</strong></li>
                    <li><label class="inputbox focus"><i class="iconfont iu">&#xe608;</i><input type="text" name="u" class="input u" value=""></label></li>
                    <li><label class="inputbox"><i class="iconfont iu">&#xe606;</i><input type="text" name="p" class="input p" value=""></label></li>
                    <li class="btnbox"><a href="#" class="btn btn_submit btn_act" data-type="submit">登　录</a><input type="submit" class="submit hidden"></li>
                </ul>
                </form>
            </div>
            <div class="aboutbox">
                <strong class="tita">关于我们</strong>
                <strong class="titb">COMPANY PROFILE</strong>
                <p>${contact.conts}</p>
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
                <div class="h2"><span class="fr"><a href="#">更多</a></span><strong>要闻</strong></div>
                <ul class="ul_news_list w360">
                    <li class="first">
                        <strong><a href="#">新闻列表第一条信息，最重要的信息！</a></strong>
                        <p>新闻列表第一条信息，最重要的信息,新闻列表第一条信息，最重要的信息,新闻列表第一条信息，最重要的信息,新闻列表第一条信息，最重要的信息,新闻列表第一条信息，最重要的信息,新闻列表第一条信息，最重要的信息,新闻列表第一条信息，最重要的信息,</p>
                    </li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
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
            <div class="newbox w300 fr">
                <div class="h2"><span class="fr"><a href="#">更多</a></span><strong>媒体焦点</strong></div>
                <ul class="ul_news_list">
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                </ul>
            </div>
            <div class="newbox w300 fl">
                <div class="h2"><span class="fr"><a href="#">更多</a></span><strong>新闻</strong></div>
                <ul class="ul_news_list">
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                </ul>
            </div>
            <div class="newbox w300 fl m">
                <div class="h2"><span class="fr"><a href="#">更多</a></span><strong>公告</strong></div>
                <ul class="ul_news_list">
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
                    <li><a href="#" class="inTit">阿里巴巴集团战略合作伙伴<span>2015-04-20</span></a></li>
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
<!--                 <ul class="ul_pic_list">
                    <li class="slide first">
                        <div class="imgbox"><a href="#" class="">
                            <img src="images/temp/0.jpg" alt="">
                        </a></div>
                        <a href="#" class="inTit">产品图片展示</a> 
                    </li>
                    <li class="slide">
                        <div class="imgbox"><a href="#" class="">
                            <img src="images/temp/0.jpg" alt="">
                        </a></div>
                    </li>
                    <li class="slide">
                        <div class="imgbox"><a href="#" class="">
                            <img src="images/temp/0.jpg" alt="">
                        </a></div>
                    </li>
                    <li class="slide">
                        <div class="imgbox"><a href="#" class="">
                            <img src="images/temp/0.jpg" alt="">
                        </a></div>
                    </li>
                    <li class="slide">
                        <div class="imgbox"><a href="#" class="">
                            <img src="images/temp/0.jpg" alt="">
                        </a></div>
                    </li>
                </ul> -->
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
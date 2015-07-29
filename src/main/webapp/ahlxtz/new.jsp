<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <li class="navli hv"><a href="#" class="a">关于我们</a></li>
                <li class="navli hv"><a href="#" class="a">新闻中心</a>
                    <ul class="subnav hvB">
                        <li><a href="#">新闻1</a></li>
                        <li><a href="#">新闻2</a></li>
                        <li><a href="#">新闻3</a></li>
                        <li><a href="#">新闻4</a></li>
                    </ul>
                </li>
                <li class="navli hv"><a href="#">商务服务</a></li>
                <li class="navli hv"><a href="#">人才发展</a></li>
                <li class="navli hv"><a href="#">企业责任</a></li>
                <li class="navli hv"><a href="#">交流中心</a></li>
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
                            <dt>集团要闻</dt>
                            <dd class="active"><a href="#">集团新闻</a> </dd>
                            <dd><a href="#">品牌活动</a> </dd>
                            <dd><a href="#">产品新闻</a> </dd>
                            <dt>行业报道</dt>
                            <dd><a href="#">媒体报道</a> </dd>
                            <dd><a href="#">行业动态</a> </dd>
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
                            <h1 class="h1">投资管理的重要性</h1>
                            <p></p>
                        </div>
                        <div class="content">
为深入贯彻落实国务院总理李克强日前在工商总局考察时的重要讲话精神，国家工商总局2日召开全国工商和市场监管部门电视电话会议，总局党组书记、局长张茅在会上表示，今年，国家工商总局将狠抓各项改革措施的落地，进一步深化商事制度改革，释放改革红利。
<b>各类市场主体平等进入市场的机制</b>
张茅强调全国工商系统要从四方面深化商事制度改革，一是加快推进“三证合一”改革，加大部门协调力度，尽快出台推进“三证合一”登记制度改革指导意见，今年年底前在全国全面实行“一照一号”登记模式，推动社会统一信用代码在工商登记制度改革中有效运用。二是推进登记注册制度便利化，开展企业名称登记管理改革试点，改革经营登记范围，放宽住所登记，简化和完善企业注销流程。试行对个体工商户、未开业企业、无债权债务企业实行简易注销程序，着力构建便捷有序的市场退出机制。加快推进电子营业执照和企业注册全程电子化，加快国家法人库建设。三是尽快制定出台推进“先照后证”改革的措施，严格执行国务院正式公布的34项工商登记前置审批项目目录，目录外的一律不作为公司登记前置审批项目。四是积极探索市场准入负面清单管理模式，坚持市场主体法不禁止即可为，给予市场主体更大的经营自主权，推动形成各类市场主体平等进入市场的机制。
<b>各类市场主体平等进入市场的机制</b>
此外，国家工商总局还将进一步强化市场监管，加强事中事后监管和竞争执法工作，依法查处扰乱市场秩序的行为；落实好扶持小微企业发展的政策措施，简化办理手续，加大扶持力度，确保小微企业能便利地享受到各项政策；进一步加强消费维权工作。为深入贯彻落实国务院总理李克强日前在工商总局考察时的重要讲话精神，国家工商总局2日召开全国工商和市场监管部门电视电话会议，总局党组书记、局长张茅在会上表示，今年，国家工商总局将狠抓各项改革措施的落地，进一步深化商事制度改革，释放改革红利。
张茅强调全国工商系统要从四方面深化商
<b>各类市场主体平等进入市场的机制</b>事制度改革，一是加快推进“三证合一”改革，加大部门协调力度，尽快出台推进“三证合一”登记制度改革指导意见，今年年底前在全国全面实行“一照一号”登记模式，推动社会统一信用代码在工商登记制度改革中有效运用。二是推进登记注册制度便利化，开展企业名称登记管理改革试点，改革经营登记范围，放宽住所登记，简化和完善企业注销流程。试行对个体工商户、未开业企业、无债权债务企业实行简易注销程序，着力构建便捷有序的市场退出机制。加快推进电子营业执照和企业注册全程电子化，加快国家法人库建设。三是尽快制定出台推进“先照后证”改革的措施，严格执行国务院正式公布的34项工商登记前置审批项目目录，目录外的一律不作为公司登记前置审批项目。四是积极探索市场准入负面清单管理模式，坚持市场主体法不禁止即可为，给予市场主体更大的经营自主权，推动形成各类市场主体平等进入市场的机制。
此外，国家工商总局还将进一步强化市场监管，加强事中事后监管和竞争执法工作，依法查处扰乱市场秩序的行为；落实好扶持小微企业发展的政策措施，简化办理手续，加大扶持力度，确保小微企业能便利地享受到各项政策；进一步加强消费维权工作。
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="wbox fline">
            <ul class="fline_list clearfix">
                <li class="a1">
                    <dl>
                        <dt class="lineTitle">关于我们 </dt>
                        <dd> <a href="about_fazhan.asp">发展历程</a> </dd>
                        <dd> <a href="about_ceo.asp">CEO寄语</a></dd>
                        <dd> <a href="about_wenhua.asp">企业文化</a> </dd>
                        <dd> <a href="about_honor.asp">资质荣誉</a> </dd>
                        <dd> <a href="about_team.asp">团队风采</a> </dd>
                    </dl>
                </li>
                <li class="a2">
                    <dl>
                        <dt class="lineTitle">客户服务 </dt>
                        <dd> <a href="/service_plan.asp">服务政策</a> </dd>
                        <dd> <a href="/service_faq.asp">常见问题</a> </dd>
                        <dd> <a href="/service_network.asp">服务网络</a></dd>
                        <dd> <a href="/service_ad.asp">广告欣赏</a> </dd>
                        <dd> <a href="/service_guestbook.asp">意见反馈</a> </dd>
                        <dd> <a href="/service_buy.asp">投资通道</a> </dd>
                        <dd> <a href="/service_download.asp">资料下载</a> </dd>
                  </dl>
                </li>
                <li class="a3">
                    <dl>
                        <dt class="lineTitle">新闻动态 </dt>
                        <dd><a href="/news.asp?id=1">公司新闻</a> </dd>
                        <dd><a href="/news.asp?id=2">行业动态</a> </dd>
                        <dd><a href="/news.asp?id=5">产品新闻</a> </dd>
                        <dd><a href="/news.asp?id=6">媒体报道</a> </dd>
                        <dd><a href="/news.asp?id=7">品牌活动</a> </dd>
                    </dl>
                </li>
                <li class="a4">
                    <dl>
                        <dt class="lineTitle">关于我们 </dt>
                        <dd> <a href="about_wenhua.asp">企业文化</a> </dd>
                        <dd> <a href="about_network.asp">销售网络</a> </dd>
                        <dd> <a href="about_honor.asp">资质荣誉</a> </dd>
                        <dd> <a href="about_team.asp">团队风采</a> </dd>
                    </dl>
                </li>
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
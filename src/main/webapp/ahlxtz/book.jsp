<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
request.setAttribute("projectName", request.getServletContext().getContextPath());
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	List<Menu> yiji = dao.listByParams(Menu.class, "from Menu where parentId is null and _site = ?", DataHelper.getServerName(request));
	List<Menu> erji = dao.listByParams(Menu.class, "from Menu where parentId is not null and _site = ?", DataHelper.getServerName(request));
	
	request.setAttribute("yiji", yiji);
	request.setAttribute("erji", erji);
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Examples</title>
<meta name="description" content="">
<meta name="keywords" content="">
<script src="js/jquery.min.js"></script>
<link href="css/reset.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">


<script type="text/javascript">

$(document).on('click', '.btn_act', function(event) {
    var Thi=$(this),
    ThiType=Thi.data('type');
    if(ThiType=='submit'){
        $('.submit').click();
    }
    event.preventDefault();
})
$(document).ready(function() {
    
    $('.navli').hover(function(){
        $(this).addClass('hover');
        $(this).find('.subnav').show().slideDown(200);
    },function(){
        $(this).removeClass('hover');
        $(this).find('.subnav').stop(true,true).slideUp(200);
    });
});

function save(){
	var index;
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/feedback/save',
	    data: a,
	    mysuccess: function(json){
	    	  alert('成功');
// 	        window.location="../admin/index.jsp";
	    },
	    error:function(data){
	    	  alert('失败');
	      }
	  });
}
</script>

<script type="text/javascript">
$(document).ready(function(){
    $(document).on('keyup',function(event){
        if(event.keyCode==13){
            login();
        }
    });
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
        <div class="wbox bookpage">
            <div class="bookbox">
                <strong>如果您对我们有什么建议、投诉、需求，可以通过留言告诉我们,</strong>
                <b>我们会在第一时间了解并及时与您联系。</b>
                <form name="form1" onsubmit="save();return false">
                <ul class="bookcont">
                    <li><label><span>我怎么称呼您：</span><input type="text" class="input" name="name"></label></li>
                    <li><label><span>您的联系方式：</span><input type="text" class="input" name="contact" placeholder="多种方式：电话：138****7714;QQ：987****147"></label></li>
                    <li><label><span>您想要说的话：</span><textarea class="textarea" name="conts" cols="30" rows="10"></textarea></label></li>
                    <li>
                        <a href="#" class="btn btn_act btn_submit" data-type="submit"><span>提交</span></a>
                        <input type="submit" class="hidden submit" name="submit">
                    </li>
                </ul>
                </form>
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
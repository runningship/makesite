<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setAttribute("domainSize",DataHelper.getDiskSize(request.getServerName()));
%>
<!DOCTYPE html>
<html>
<head>
<title>微信公众平台</title>
<jsp:include page="inc/header.jsp"></jsp:include>
<script type="text/javascript">
function openWin(){
	layer.open({
	    type: 2,
	    area: ['700px', '530px'],
	    fix: false, //不固定
	    maxmin: true,
	    content: 'http://www.baidu.com'
	});
}
</script>
<style type="text/css">
.mp_news_item a{color:#459ae9}
</style>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<a href="#" ></a>
					<div class="title_bar">
						<h3>系统信息</h3>
					</div>
					<ul class="mp_news_list">

						<li class="mp_news_item"><a > <strong>一级栏目数
							</strong> <span class="read_more">8个</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>二级栏目数
							</strong> <span class="read_more">8个</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>文章数量
							</strong> <span class="read_more">8篇</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>用户数
							</strong> <span class="read_more">8人</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>在线用户数
							</strong> <span class="read_more">8人</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>收收到的通知
							</strong> <span class="read_more">8条</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>我发的通知
							</strong> <span class="read_more">8条</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>共享文件数
							</strong> <span class="read_more">8</span>
						</a></li>
						<li class="mp_news_item"><a target="_blank"> <strong>占用磁盘空间
							</strong> <span class="read_more">${domainSize/1024/1024 }M</span>
						</a></li>
					</ul>

				</div>

			</div>
		</div>

	</div>
	<div class="foot"></div>
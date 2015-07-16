<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link rel="stylesheet" href="list.css">
</head>
<script type="text/javascript">
	function userAdd(){
		layer.open({
    	type: 2,
    	title: '添加用户',
	    shadeClose: true,
	    shade: 0.8,
	    area: ['400px', '320px'],
	    content: 'AddUser.jsp' //iframe的url
}); 
	}
</script>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<div class="title_bar">
						<h3>用户列表</h3>
						<button onclick="userAdd();return false;" style="float:right;margin-top:-35px;padding:5px;">添 &nbsp;加</button>
					</div>
					<table class="userList" >
						<tr>
							<td>账号</td>
							<td>姓名</td>
							<td>最后登录时间</td>
						</tr>
						<tr>
							<td>ceshi</td>
							<td>测试</td>
							<td>2015-06-21 15:45:20</td>
						</tr>
					</table>
				</div>

				<div class="pagination_wrp">
					<div class="pagination">
						<span class="page_nav_area"> <a href="javascript:void(0);" class="btn page_first" style="display: none;"></a> <a href="javascript:void(0);" class="btn page_prev" style="display: none;"><i
								class="arrow"></i></a> <span class="page_num"> <label>1</label> <span class="num_gap">/</span> <label>5</label>
						</span> <a href="javascript:void(0);" class="btn page_next"><i class="arrow"></i></a> <a href="javascript:void(0);" class="btn page_last" style="display: none;"></a>
						</span> <span class="goto_area"> <input type="text"> <a href="javascript:void(0);" class="btn page_go">跳转</a>
						</span>

					</div>
				</div>


			</div>
		</div>

	</div>
</body>
</html>
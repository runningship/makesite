<%@page import="com.youwei.makesite.util.DataHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
 List<Menu> list1 = dao.listByParams(Menu.class, "from Menu where parentId is null and _site=?" , DataHelper.getServerName(request));
 request.setAttribute("list1", list1);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.yw.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="add.css">
<style type="text/css">
select{
width: 100px;
  height: 30px;
  margin-left: 6px;
}
</style>
</head>
<script type="text/javascript">
function save(){
	if (!$('#name').val()) {
    	alert('栏目名称不能为空');
    	return;
    }
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/menu/save',
	    data:a,
	    mysuccess: function(data){
	        alert('添加成功');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.reloadWindow();
			parent.layer.close(index); //再执行关闭   
	    }
    });
}

function closeThis(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}

$(function(){
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
		<div class="form-group">
			<label class="label">父栏目</label>
			<select name="parentId">
				<option value="">无</option>
				<c:forEach items="${list1 }" var="menu" >
				<option value="${menu.id }">${menu.name}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<label class="label">&nbsp;&nbsp;名&nbsp;&nbsp;称</label>
			<input name="name" id="name" class="form-input" />
		</div>
		<div class="form-group">
			<label class="label">&nbsp;&nbsp;排&nbsp;&nbsp;序</label>
			<input name="orderx" value="100" class="form-input" />
		</div>
		
		<div class="form-group action">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
	</form>
</body>
</html>
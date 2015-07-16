<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>
<script type="text/javascript">
function save(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '/c/UserService/add',
	    data:a,
	    mysuccess: function(data){
	        alert('添加成功');
	    },
	    complete:function(){
	        api.button({
	              name: '保存',
	              disabled:false
	          });
	    }
    });
}
</script>
<body>
	<form name="form1" role="form" onsubmit="save();" style="padding:20px">
		<div>
			<span>用户账号</span>
			<input name="account" />
		</div>
		<div>
			<span>用户姓名</span>
			<input name="name" />
		</div>
		<div>
			<span>用户电话</span>
			<input name="tel" />
		</div>
		<div>
			<span>用户密码</span>
			<input name="pwd" />
		</div>
	</form>
	<div>
		<button onclick="save();return false;">保存</button>
	</div>
</body>
</html>
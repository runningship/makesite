<%@page import="com.youwei.makesite.entity.Menu"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	Integer id = Integer.valueOf(request.getParameter("id"));
	Menu menu = dao.get(Menu.class, id);
	request.setAttribute("menu", menu);
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
</head>
<script type="text/javascript">
function save(){
	var conts = ue.getContent();
    if ($('#type').val()=='conts') {
    	if (conts==null||conts=='') {
	    	alert('内容不能为空');
	    	return;
	    }
    };
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '${projectName }/c/admin/menu/update',
	    data:a,
	    mysuccess: function(data){
	        alert('修改成功');
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

var ue;
$(function(){
	ue = UE.getEditor('editor',{
        toolbars: [
            ['forecolor', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
            ]
        ],
  });
    ue.addListener( 'ready', function( editor ) {
        ue.setContent($('#menu_conts').html());
    });
    if ($('#type').val()=='menu') {
		var index = parent.layer.getFrameIndex(window.name);
    	$('#conts').css('display','none');
		parent.layer.style(index, {
		    width: '400px',
		    height:'300px'
		}); 
    };
});

</script>
<body style="background-color:white">
	<form name="form1" class="add-form" onsubmit="save();">
	<input name="id" value="${menu.id}" style="display:none">
	<input name="type" id="type" value="${menu.type}" style="display:none">
		<div class="form-group">
			<label class="label">&nbsp;&nbsp;标&nbsp;&nbsp;题</label>
			<input name="name" value="${menu.name}" class="form-input" />
		</div>
		<div class="form-group">
			<label class="label">&nbsp;&nbsp;排&nbsp;&nbsp;序</label>
			<input name="orderx" value="${menu.orderx}" class="form-input" />
		</div>
		<div id="conts" class="form-group">
			<label class="label">文章内容</label>
	        <span id="editor" type="text/plain" name="conts" style="height:330px;width:98%;"></span>
		</div>
		
		<div class="form-group action">
			<label class="label" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<div class="form-input btn-wrap" >
				<button onclick="save();return false;" class="form-button save">保&nbsp;&nbsp;存</button>
				<button onclick="closeThis();return false;" class="form-button cancel">取&nbsp;&nbsp;消</button>
			</div>
		</div>
		<div id="menu_conts" style="display:none">${menu.conts}</div>
	</form>
</body>
</html>
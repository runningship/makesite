<%@page import="org.bc.sdak.Page"%>
<%@page import="com.youwei.makesite.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<link href="../js/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<link href="../js/zTree_v3/css/div.css" rel="stylesheet">
<link href="list.css" rel="stylesheet">
<script type="text/javascript" src="../js/zTree_v3/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
var parentGroupId='';
var parentGroupName='';
var currentUid='';
var showMenu;
var setting = {
  view: {
    showIcon: false,
    addDiyDom: addDiyDom,
    dblClickExpand: false,
  },
  data: {
  },
  callback: {
    onClick: OnRightClick,
    onAsyncSuccess: zTreeOnAsyncSuccess
  },
  check:{
    enable:true
  }
};

function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	if(msg.indexOf('login.jsp')>-1){
		window.location='/${projectName}/login.jsp';
	}
	if(!treeNode){
		//顶层
		
	}
};

$(function(){
	YW.ajax({
	    type: 'POST',
	    url: '/${projectName}/c/admin/user/getUserTree',
	    mysuccess: function(data){
			$.fn.zTree.init($("#treeDemo"), setting ,data);
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	 		treeObj.expandAll2();
	    }
    });
	
	document.oncontextmenu=function(){
		window.event.returnValue=false;
		return false;
	};
});

function addDiyDom(treeId, treeNode) {
	  console.log(treeId);
	  var aObj = $("#" + treeNode.tId + "_a");
	  aObj.css('display','inline');

	  aObj.parent().addClass('a_'+treeNode.type);
	  if(treeNode.cnum!=null){
	    var cnumStr = '<span class="">'+ treeNode.cnum +' </span>';
	    aObj.prepend(cnumStr);  
	  }
	}
	
function zTreeBeforeAsync(treeId, treeNode) {
	if(treeNode){
		parentGroupId = treeNode.id;
	}
};

function onCheck(event, treeId, treeNode){
  console.log(treeNode.id);
}

function banUser(){
	YW.ajax({
	    type: 'POST',
	    url: '/${projectName}/c/admin/user/banUser?groupId='+parentGroupId+'&uid='+currentUid,
	    mysuccess: function(data){
	        alert('移出成功');
			window.location.reload();
	    }
    });
}

function sendNotice(){
	window.location="/${projectName}/admin/notice/add.jsp?nav=ftz&groupId="+parentGroupId;
}

function addTopGroup(){
	layer.open({
    	type: 2,
    	title: '添加用户组',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '250px'],
	    content: '../group/add.jsp'
	}); 
}
function addGroup(){
	layer.open({
    	type: 2,
    	title: '添加用户组',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '250px'],
	    content: '../group/add.jsp?parentId='+parentGroupId+'&parentName='+parentGroupName
	}); 
}

function addUser(){
	layer.open({
    	type: 2,
    	title: '添加新用户',
	    shadeClose: false,
	    shade: 0.5,
		area: ['500px', '500px'],
	    content: 'add.jsp?groupId='+parentGroupId
	}); 
}

function inviteUser(){
	layer.open({
    	type: 2,
    	title: '添加已有用户',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['700px', '600px'],
	    content: 'selectUser.jsp?groupId='+parentGroupId
	}); 
}




function OnRightClick(event, treeId, treeNode) {
  var treeObj = $.fn.zTree.getZTreeObj(treeId);
  treeObj.selectNode(treeNode);
  if(treeNode.type=='group'){
	  $('#userMenu').hide();
	  $('#groupMenu').show();
	  parentGroupId = treeNode.id;
	  parentGroupName = treeNode.name;
  }else{
	  currentUid = treeNode.id;
	  $('#groupMenu').hide();
	  $('#userMenu').show();
  }
  
  // blockAlert(event.target.offsetTop);
  // showRMenu(treeNode.type, event.clientX, event.target.parentElement.parentElement.offsetTop+10);
  var Y = event.clientY;
  // if(Y+250>$('#sideCont')[0].clientHeight){
  //   Y-=250;
  // }
  showRMenu(treeNode.type, event.clientX, Y);
  showMenu=true;
}
function showRMenu(type, x, y) {
	var rMenu = $("#rMenu");
   $("#rMenu a").show();
  // if(type=="comp"){
  //   $('#m_edit_group1').hide();
  // }
  var menuHeight = rMenu[0].clientHeight;
  rMenu.css({"top":y+"px", "left":x+"px", "display":"block" , "visibility":"visible"});
}
function hideRMenu() {
	if(showMenu){
		showMenu = false;
		return;
	}
   $("#rMenu").css({"visibility": "hidden"});
}
</script>
<style type="text/css">
.list-group-item {
  position: relative;
  display: block;
  padding: 10px 15px;
  margin-bottom: -1px;
  background-color: #fff;
  border: 1px solid #ddd;
}
div#rMenu {
  width: 150px;
  text-align: left;
}
#rMenu.list-group {
  box-shadow: 0px 2px 10px #999;
  padding: 0;
  width:140px;
}
#rMenu.list-group a:hover{
background: #428bca;
  color: white;
}
</style>
</head>

<body onclick="hideRMenu();">
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<div class="title_bar">
						<h3>用户组织架构</h3>
						<button onclick="addTopGroup();return false;" class="add">添 &nbsp;加</button>
					</div>
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>

			</div>
		</div>

	</div>
	
</body>
<div id="rMenu"   class="list-group" style="position:absolute;z-index:999;display:none;" onclick="hideRMenu();">
	<span id="groupMenu">
  <a href="javascript:void(0)" auth="sz_comp_edit" id="m_edit_comp" onclick="addGroup();" class="list-group-item">添加子用户组</a>
  <a href="javascript:void(0)" auth="sz_comp_del" id="m_del_comp" onclick="addUser()" class="list-group-item">加入新用户</a>
  <a href="javascript:void(0)" auth="sz_comp_del" id="m_del_comp" onclick="inviteUser()" class="list-group-item">加入已有用户</a>
  <a href="javascript:void(0)" auth="sz_comp_del" id="m_del_comp" onclick="inviteUser()" class="list-group-item">删除用户组</a>
  <a href="javascript:void(0)" auth="sz_comp_del" id="m_del_comp" onclick="sendNotice()" class="list-group-item">发送通知</a>
  </span>
  <span id="userMenu">
  <a href="javascript:void(0)" auth="sz_comp_del" id="m_del_comp" onclick="banUser()" class="list-group-item">移出用户组</a>
  </span>
</div>
</html>
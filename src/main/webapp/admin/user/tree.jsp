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
var setting = {
  view: {
    showIcon: false,
    addDiyDom: addDiyDom,
    dblClickExpand: false,
  },
  data: {
    simpleData: {
      enable: true
    }
  },
  callback: {
    onClick: OnRightClick,
    beforeAsync: zTreeBeforeAsync
  },
  check:{
    enable:true
  },
  async: {
		enable: true,
		url:"/${projectName}/c/admin/user/getOrgData",
		autoParam:["id"],
		otherParam:{}
	}
};

function zTreeBeforeAsync(treeId, treeNode) {
	if(treeNode){
		parentGroupId = treeNode.id;
	}
};

function onCheck(event, treeId, treeNode){
  console.log(treeNode.id);
}

function initUserTree(treeId){
  $.ajax({
    type: 'POST',
    url: '/c/admin/user/getUserTree',
    data:'',
    success: function(data){
        var result=JSON.parse(data);
        $.fn.zTree.init($("#"+treeId), setting, result.result);
    }
  });
}


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
    	title: '添加用户组',
	    shadeClose: false,
	    shade: 0.5,
	    area: ['400px', '400px'],
	    content: '../user/add.jsp?groupId='+parentGroupId
	}); 
}

$(function(){
	$.fn.zTree.init($("#treeDemo"), setting);
	document.oncontextmenu=function(){
		window.event.returnValue=false;
		return false;
	};
});


function OnRightClick(event, treeId, treeNode) {
  var treeObj = $.fn.zTree.getZTreeObj(treeId);
  treeObj.selectNode(treeNode);
  if(treeNode.type!='group'){
    return;
  }
  parentGroupId = treeNode.id;
  parentGroupName = treeNode.name;
  // blockAlert(event.target.offsetTop);
  // showRMenu(treeNode.type, event.clientX, event.target.parentElement.parentElement.offsetTop+10);
  var Y = event.clientY;
  // if(Y+250>$('#sideCont')[0].clientHeight){
  //   Y-=250;
  // }
  showRMenu(treeNode.type, event.clientX, Y);
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
  width:120px;
}
</style>
</head>

<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<div class="title_bar">
						<h3>用户列表</h3>
						<button onclick="addTopGroup();return false;" class="add">添 &nbsp;加</button>
					</div>
					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>

			</div>
		</div>

	</div>
	<div id="rMenu" class="list-group" style="position:absolute;z-index:999;display:none;" onclick="hideRMenu();">
	  <a href="javascript:void(0)" auth="sz_comp_edit" id="m_edit_comp" onclick="addGroup();" class="list-group-item">添加子用户组</a>
	  <a href="javascript:void(0)" auth="sz_comp_del" id="m_del_comp" onclick="addUser()" class="list-group-item">增加用户</a>
	</div>
</body>
</html>
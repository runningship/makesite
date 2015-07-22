<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户信息</title>
<jsp:include page="../inc/header.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/ueditor.all.yw.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<link href="../js/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<link href="../js/zTree_v3/css/div.css" rel="stylesheet">
<script type="text/javascript" src="../js/zTree_v3/js/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet" href="add.css">
</head>
<script type="text/javascript">
function send(){
	if(!$('#title').val()){
		alert('标题不能为空');
		return;
	}
	var conts = ue.getContent();
    if (conts==null||conts=='') {
    	alert('内容不能为空');
    	return;
    };
    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    var nodes = treeObj.getCheckedNodes();
    var receiverIds = '';
    for(var i=0;i<nodes.length;i++){
    	if(nodes[i].type=='user'){
    		receiverIds+=nodes[i].id+',';
    	}
    }
    if(!receiverIds){
    	alert('请选择接收人');
    	return;
    }
    $('#receiverIds').val(receiverIds);
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'POST',
	    url: '/${projectName}/c/admin/notice/save',
	    data:a,
	    mysuccess: function(data){
	        alert('发送成功');
	    }
    });
}


var ue;
$(function(){
	ue = UE.getEditor('editor',{
        toolbars: [
            ['forecolor', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
            ]
        ],
  });
});

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

$(function(){
	$.fn.zTree.init($("#treeDemo"), setting);
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
	
</script>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="../inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="mp_news_area notices_box">
					<form name="form1" class="add-form" onsubmit="return false;">
						<input type="hidden" name="receiverIds" id="receiverIds" />
						<table style="width:100%" >
							<tr class="form-group">
								<td style="text-align:left;"><label class="label">标题</label></td>
								<td><input name="title" id="title" class="form-input" /></td>
							</tr>
							<tr class="form-group">
								<td style="vertical-align: top;width:50px;text-align:left;"><label class="label">接收人</label></td>
								<td><div class="zTreeDemoBackground left">
									<ul id="treeDemo" class="ztree"></ul>
								</div>
								</td>
							</tr>
							<tr class="form-group">
								<td style="vertical-align: top;text-align:left;"><label class="label">正文</label></td>
								<td><span id="editor" type="text/plain" name="conts" style="height:370px;width:100%;"></span></td>
							</tr>
							<tr>
							<td colspan="2">
								<button onclick="send();return false;" class="form-button save" style="float:right;cursor:pointer">发&nbsp;&nbsp;送</button>
							</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

	</div>
</body>
</html>
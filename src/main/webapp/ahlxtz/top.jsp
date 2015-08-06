<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="js/javascript.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
<script type="text/javascript">
//设为首页 www.ecmoban.com
function SetHome(obj,url){
    try{
        obj.style.behavior='url(#default#homepage)';
       obj.setHomePage(url);
   }catch(e){
       if(window.netscape){
          try{
              netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
         }catch(e){
              alert("抱歉，此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车然后将[signed.applets.codebase_principal_support]设置为'true'");
          }
       }else{
        alert("抱歉，您所使用的浏览器无法完成此操作。\n您需要手动将我们设置为首页。");
       }
  }
}
 
//收藏本站 bbs.ecmoban.com
function AddFavorite(title, url) {
  try {
      window.external.addFavorite(url, title);
  }
catch (e) {
     try {
       window.sidebar.addPanel(title, url, "");
    }
     catch (e) {
         alert("抱歉，您所使用的浏览器无法完成此操作。\n加入收藏失败，请使用Ctrl+D进行添加");
     }
  }
}
</script>
<div class="toper">
    <div class="wbox">
        <dl class="tMenu hv">
            <dt class="hvA">成员网站 +</dt>
            <dd class="hvB"><a href="#">站点1站点1站点1站点1</a>
            <a href="#">站点2</a>
            <a href="#">站点3</a></dd>
        </dl>
        <ul class="tA">
            <li><a href="javascript:void(0);" onclick="AddFavorite('联信投资',location.href)">加入收藏</a></li>
            <li><a href="javascript:void(0);" onclick="SetHome(this,'http://192.168.1.5:8080/makesite/index.jsp');">设为首页</a></li>
                <!-- <li><a href="#" class="btn_act" data-type="addFavorite">加入收藏</a></li>
                <li><a href="#" class="btn_act" data-type="addHome">设置首页</a></li> -->
        </ul>
    </div>
</div>
   
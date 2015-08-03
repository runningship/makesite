/**
* js all
*/

$(document).on({
    mouseenter: function(){
        $(this).siblings().find('.hvB').hide();
        $(this).find('.hvB').show();
    },
    mouseleave: function(){
        var Thi=$(this),
        st=setTimeout(function(){
            Thi.find('.hvB').hide();
            clearTimeout(st);
        },  300);
    }
},'.hv');


$(document).on('click', '.btn_act', function(event) {
    var Thi=$(this),
    ThiType=Thi.data('type');
    if(ThiType=='addHome'){
        shoucang(document.title,window.location);
    }else if(ThiType=='addFavorite'){
        addFavorite2();
    }
    event.preventDefault();
})
















/*
加入收藏设为首页
*/
// 设置为主页 
function SetHome(obj,vrl){ 
    try{ 
        obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl); 
    }catch(e){ 
        if(window.netscape) { 
            try { 
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
            }catch (e) { 
                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。"); 
            } 
            var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
            prefs.setCharPref('browser.startup.homepage',vrl); 
        }else{ 
            alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入："+vrl+"点击确定。"); 
        } 
    } 
} 
// 加入收藏 兼容360和IE6 
function shoucang(sTitle,sURL) { 
    try { 
        window.external.addFavorite(sURL, sTitle); 
    } catch (e) { 
        try { 
            window.sidebar.addPanel(sTitle, sURL, ""); 
        }catch (e) { 
            alert("加入收藏失败，请使用Ctrl+D进行添加"); 
        } 
    } 
} 

// 加入收藏
function addFavorite2() {
    var url = window.location;
    var title = document.title;
    var ua = navigator.userAgent.toLowerCase();
    if (ua.indexOf("360se") > -1) {
        alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
    }else if (ua.indexOf("msie 8") > -1) {
        window.external.AddToFavoritesBar(url, title); //IE8
    }else if (document.all) {
        try{
            window.external.addFavorite(url, title);
        }catch(e){
            alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
        }
    }else if (window.sidebar) {
        window.sidebar.addPanel(title, url, "");
    }else {
        alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
    }
}
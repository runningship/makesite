<%@page import="com.youwei.makesite.MakesiteConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//String authList = (String)request.getSession().getAttribute(MakesiteConstant.Session_Auth_List);
//request.setAttribute(MakesiteConstant.Session_Auth_List, authList);
%>
    <script type="text/javascript">
    $(function(){
    	var nav = getParam('nav');
    	$('a[data-id='+nav+']').addClass('selected');
    });
</script>
<div class="col_side">
	<div class="menu_box">
		<c:if test="${session_auth_list.indexOf('$info')>-1 }">
			<dl class="menu no_extra">
			<dt class="menu_title">
				<i class="iconfont">&#xe60c;</i>
				信息发布
			</dt>

			<dd class="menu_item ">
				<a data-id="yjcd" href="${projectName }/admin/info/list1.jsp?nav=yjcd">一级栏目</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="ejcd" href="${projectName }/admin/info/list2.jsp?nav=ejcd">二级栏目</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="wzlb" href="${projectName }/admin/info/list3.jsp?nav=wzlb">文章列表</a>
			</dd>
		</dl>
		</c:if>
		
		<dl class="menu no_extra">
			<dt class="menu_title">
				<i class="iconfont">&#xe60d;</i>
				通知管理
			</dt>

			<dd class="menu_item ">
				<a data-id="sjx" href="${projectName }/admin/notice/inList.jsp?nav=sjx">收件箱</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="fjx" href="${projectName }/admin/notice/outList.jsp?nav=fjx">已发送</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="ftz" href="${projectName }/admin/notice/add.jsp?nav=ftz">发通知</a>
			</dd>
		</dl>
		<dl class="menu ">
			<dt class="menu_title clickable">
				<a data-id="wjgx" href="${projectName }/admin/file/list.jsp?nav=wjgx">
				<i class="iconfont">&#xe617;</i>
				文件共享
				</a>
			</dt>
		</dl>
		<c:if test="${session_auth_list.indexOf('$feedback')>-1 }">
		<dl class="menu ">
			<dt class="menu_title clickable">
				<a data-id="fk" href="${projectName }/admin/feedback/list.jsp?nav=fk">
				<i class="iconfont">&#xe611;</i>
				留言反馈
				</a>
			</dt>
		</dl>
		</c:if>
		<dl class="menu ">
			<dt class="menu_title clickable">
				<a data-id="me" href="${projectName }/admin/user/info.jsp?nav=me">
				<i class="iconfont">&#xe60f;</i>
				我的资料
				</a>
			</dt>
		</dl>
		<dl class="menu ">
			<dt class="menu_title">
				<i class="iconfont">&#xe601;</i>
				用户管理
			</dt>

			<dd class="menu_item ">
				<a data-id="zzjg" href="${projectName }/admin/user/tree.jsp?nav=zzjg">组织架构</a>
			</dd>
			<dd class="menu_item ">
				<a href="${projectName }/admin/role/roleList.jsp">职位权限</a>
			</dd>
			<dd class="menu_item ">
				<a data-id="yglb" href="${projectName }/admin/user/list.jsp?nav=yglb">员工列表</a>
			</dd>
		</dl>
		<dl class="menu ">
			<dt class="menu_title">
				<i class="iconfont">&#xe60e;</i>
				公司信息
			</dt>

			<dd class="menu_item ">
				<a data-id="zzjg" href="${projectName }/admin/company/contact.jsp">联系我们</a>
			</dd>
			<dd class="menu_item ">
				<a href="${projectName }/admin/company/compinfo.jsp">公司简介</a>
			</dd>
		</dl>
	</div>

</div>
<%@page import="com.youwei.makesite.MakesiteConstant"%>
<%@page import="java.util.List"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	List<String> authList = (List<String>)request.getSession().getAttribute(MakesiteConstant.Session_Auth_List);
	request.setAttribute(MakesiteConstant.Session_Auth_List, authList);
	request.setAttribute("user", request.getSession().getAttribute("user"));
%>
<div class="head">
	<div class="head_box">
		<div class="inner wrp">
			<div class="logo">
				<img src="../style/getheadimg"  style="height:38px;float:left;padding-right:10px;"/><div style="float:right;"><span>联信</span> · 管理后台</div>
			</div>
			<div class="account">
				<div class="account_meta account_info account_meta_primary">
					<a href="#" class="nickname">${user.name }</a><span style="color:#ddd">|</span><a class="logout" href="/${projectName }/c/admin/user/logout">退出</a>
				</div>
			</div>
		</div>
	</div>
</div>
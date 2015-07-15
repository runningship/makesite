<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<% String projectName=request.getSession().getServletContext().getServletContextName();
	request.setAttribute("projectName", projectName);
	System.out.println(projectName);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="/${projectName }/admin/style/head.css">
<link rel="stylesheet" type="text/css" href="/${projectName }/admin/style/base.css">
<link rel="stylesheet" href="/${projectName }/admin/style/pageIndex.css">
<link charset="utf-8" rel="stylesheet" href="/${projectName }/admin/style/pagination.css">
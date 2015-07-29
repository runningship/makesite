package com.youwei.makesite;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bc.sdak.GException;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;

import com.youwei.makesite.entity.User;
import com.youwei.makesite.util.DataHelper;

public class SiteFilter implements Filter {

	// Filter注销方法
	@Override
	public void destroy() {

	}

	// filter要实现的功能
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req  = (HttpServletRequest)request;
		ThreadSession.setHttpSession(req.getSession());
		String path = req.getServletPath();
		System.out.println(path);
		if(path.contains("admin") || path.contains("login") || path.contains("assets")){
			chain.doFilter(request, response);
		}else{
			RequestDispatcher rd = req.getRequestDispatcher("/"+DataHelper.getServerName(req)+path);
			rd.forward(request, response);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println();
	}

}

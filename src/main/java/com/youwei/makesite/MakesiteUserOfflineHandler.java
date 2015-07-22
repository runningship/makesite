package com.youwei.makesite;

import java.io.IOException;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bc.web.UserOfflineHandler;

public class MakesiteUserOfflineHandler implements UserOfflineHandler{


	@Override
	public void handle(HttpServletRequest req, ServletResponse response) {
		try {
			HttpServletResponse resp = (HttpServletResponse)response;
			resp.setHeader("userOffline", "true");
			response.getWriter().write("<script type='text/javascript'>window.location='"+req.getServletContext().getContextPath()+"/admin/login.jsp'</script>");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

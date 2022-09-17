<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="portfolio1.*" %>
<%
	request.setCharacterEncoding("utf-8");
	PortMgr pMgr = new PortMgr();
	
	String id = request.getParameter("id");
	int num = Integer.parseInt(request.getParameter("num"));
	String comment = request.getParameter("comment");
	
	if(request.getParameter("type").equals("normal")){
		pMgr.insertComment(num, id, comment, 0, 0);	
	} else {
		int ref = Integer.parseInt(request.getParameter("ref"));
		pMgr.insertRefComment(num, id, comment, ref);
	}
	pMgr.increaseReview(num);
	
	response.sendRedirect("post.jsp?num="+num);
%>
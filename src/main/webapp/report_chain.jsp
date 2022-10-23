<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="portfolio1.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int boardType = Integer.parseInt(request.getParameter("boardType"));
	String reportType = request.getParameter("reportType");
	String comment = request.getParameter("comment");
	
	PortMgr pMgr = new PortMgr();
	pMgr.insertReportBoard(num, boardType, reportType, comment);
	out.println("<script>window.close()</script>");
%>
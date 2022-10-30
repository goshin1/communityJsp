<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="portfolio1.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int rNum = Integer.parseInt(request.getParameter("rNum"));
	int bNum = Integer.parseInt(request.getParameter("bNum"));
	String write_date = request.getParameter("write_date");
	int addDate = Integer.parseInt(request.getParameter("day"));
	try {
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Calendar cal = Calendar.getInstance();
		Date dt = dtFormat.parse(write_date);
		
		cal.setTime(dt);
		cal.add(Calendar.DATE, addDate);
		
		String modifyDate = dtFormat.format(cal.getTime());
		
		PortMgr pMgr = new PortMgr();
		String writer = pMgr.selectWriter(bNum);
		pMgr.setStopDate(writer, modifyDate);
		pMgr.deleteReport(rNum);
		out.println("<script>window.close()</script>");
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
%>
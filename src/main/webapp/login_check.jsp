<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="portfolio1.*" %>
<%

	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	if (id.equals("") || pwd.equals("") || id == null || pwd == null){
		out.println("<script>alert('로그인에 실패하였습니다.')</script>");
		response.sendRedirect("login.jsp");
	}
	
	PortMgr pMgr = new PortMgr();
	String login = pMgr.login(id, pwd);
	String report = pMgr.problemMemberCheck(id);
	if(login.equals("login_fall")){
		out.println("<script>alert('로그인에 실패하였습니다.');history.back();</script>");
		
	} 
	else if(!report.equals("sucess")){
		out.println("<script>alert('" + report + "까지 로그인 할 수 없습니다.');history.back();</script>");
		
	} else{
		session.setAttribute("id", id);
		response.sendRedirect("index.jsp");	
	}
	
%>
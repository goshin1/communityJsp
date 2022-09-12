<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="portfolio1.*" %>
<%
	request.setCharacterEncoding("utf-8");	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	PortMgr pMgr = new PortMgr();
	String res = pMgr.sign(id, pwd, name, email);
	if(res.equals("overlap")){
		out.println("<script>alert('이미 중복된 아이디 또는 이메일 입니다.');'</script>");
		response.sendRedirect("login.jsp");
	} else if(res.equals("fall")){
		out.println("<script>alert('회원가입에 실패하였습니다.');'</script>");
		response.sendRedirect("login.jsp");
	} else {
		session.setAttribute("id",id);
		response.sendRedirect("index.jsp");
	}
%>


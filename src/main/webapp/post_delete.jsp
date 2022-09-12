<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="portfolio1.*" %>
<%
	PortMgr pMgr = new PortMgr();
	int res = pMgr.deleteBoard(Integer.parseInt(request.getParameter("num")));
	if(res <= 0){
		out.println("<script>alert('게시글 작성에 실패하였습니다.'); history.back();</script>");
	}else{
		response.sendRedirect("index.jsp");	
	}

%>

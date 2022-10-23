<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="portfolio1.*" %>
<%	
	int num = Integer.parseInt(request.getParameter("num"));
	PortMgr pMgr = new PortMgr();
	if(request.getParameter("rNum") != null){
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		pMgr.deleteReport(rNum);
	}
	pMgr.deleteCommentList(num);
	int res = pMgr.deleteBoard(num);
	if(res <= 0){
		out.println("<script>alert('게시글 삭제에 실패하였습니다.'); history.back();</script>");
	}else{
		response.sendRedirect("index.jsp");	
	}

%>

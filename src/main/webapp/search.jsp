<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
	String search = "";
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	
		

%>

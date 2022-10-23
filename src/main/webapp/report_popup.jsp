<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int rNum = Integer.parseInt(request.getParameter("rNum"));
	int bNum = Integer.parseInt(request.getParameter("bNum"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style/popup_style.css?ver=1" type="text/css" rel="stylesheet">
    <title>report</title>
</head>
<body>
    <div><img src="imgs/logo.png" alt="logo_none"></div>
    
    <form method="post" action="report_popupChain.jsp">
        <select name="day" id="report_type" >
            <option value="1">1일</option>
            <option value="3">3일</option>
            <option value="7">7일</option>
            <option value="30">30일</option>
        </select>
        <br/>
        <input type="submit">
        <input type="hidden" name="num" value="">
        
    </form>
</body>
</html>
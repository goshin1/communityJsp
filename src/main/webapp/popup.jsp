<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int type = Integer.parseInt(request.getParameter("type"));
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
    
    <form method="post" action="report_chain.jsp">
        <select name="reportType" id="report_type" >
            <option value="홍보 게시글">홍보 게시글</option>
            <option value="유해한 게시글">유해한 게시글</option>
            <option value="특정 게시글 비방">특정 게시글 비방</option>
            <option value="기타">기타</option>
        </select>
        <br/>
        <textarea name="comment" placeholder="신고 사유를 적어주세요"></textarea><br/>
        <input type="submit">
        <input type="hidden" name="boardType" value="<%=type%>">
        <input type="hidden" name="num" value="<%=num%>">
        
    </form>
</body>
</html>
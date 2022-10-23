<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");
	int totalRecord = Integer.parseInt(request.getParameter("totalRecord"));
	int numPerPage = 10;
	int pagePerBlock = 15;
	int totalPage = 0;
	int totalBlock= 0;
	int nowPage = 1;
	int nowBlock = 1;
	
	int start = 0;
	int end = 10;
	int listSize = 0;
	
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;
	
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);
	
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	
</script>
</head>
<body>

</body>
</html>
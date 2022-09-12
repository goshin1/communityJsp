<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="portfolio1.*" %>
<%
	request.setCharacterEncoding("utf-8");
	PortMgr pMgr = new PortMgr();
	Vector<BoardBean> v = null;
	String search = request.getParameter("search");
	
	
	
	if(search != null){
		if (!search.equals("null"))
			v = pMgr.getBoardList(search);
		else
			v = pMgr.getBoardList("");
	} else {
		v = pMgr.getBoardList("");
	}
	
	int start = 0;
	if(request.getParameter("start") != null){
		start = Integer.parseInt(request.getParameter("start"));	
	}

	
	int rowRange = 10;
	int pageRange = 5;
	int rowStart = start * rowRange;
	
	int totalSize = v.size();
	int nextPage = (start + 5) > (totalSize / 10) ? totalSize / 10 : start + pageRange;
	int pageLimit = (start + pageRange) > (totalSize / 10) ? totalSize / 10 : start + pageRange;
	int prevPage = start - 5 > 0 ? start - 5 : start - start;
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main</title>
    <link href="style/style.css" type="text/css" rel="stylesheet">
    <script>
    	function pageing(num){
    		document.pageForm.start.value = num;
    		document.pageForm.submit();
    	}
    </script>
</head>
<body>
    <%@include file="header.jsp"%>

    <div id="content">
        <aside id="aside_first">
            광고
        </aside>
        <div id="notice">
            <a href="#" id="main_post">
                <img src="imgs/test1.PNG" alt="">
                <h2>어제의 인기글</h2>
                <p>해당 글의 내용</p>
            </a>
            <div id="sub_post">
                <div class="notice_block">
                    <span>글제목</span>
                    <span class="notice_comments">댓글수</span>
                    <span class="notice_users">글쓴이</span>
                    <span class="notice_views">조회수</span>
                    <span class="notice_date">일자</span>
                </div>
				<%
					int rowLimit = rowStart + rowRange > totalSize ? rowStart + totalSize % 10 : rowStart + rowRange;
					
					for(int i = rowStart; i < rowLimit; i++){
						
						BoardBean bean = v.get(i);
						String date = bean.getWrite_date().substring(0, 10);
						String subject = bean.getSubject();
						int review = bean.getReview();
						String writer = bean.getWriter();
						int views = bean.getViews();
						int bNum = bean.getNum();
						
				%>
                <div class="notice_block">
                    <a href="post.jsp?num=<%=bNum%>"><%=subject %></a>
                    <span class="notice_comments"><%=review %><img src="imgs/balloon.png"></span>
                    <span class="notice_users"><%=writer %></span>
                    <span class="notice_views"><%=views %></span>
                    <span class="notice_date"><%=date %></span>
                </div>
				<%
					}
				%>

			<%if(id != null){ %>
            <a id="post_btn" href="write.jsp">글쓰기</a>
			<%} %>
            <div id="pageing">
            <%
            // 마지막 페이지 단락 
            if(totalSize / rowRange == (start + 1) && totalSize % rowRange > 0){
            	
            	if(start > 0){
            		
            %>	
            	<a href="javascript:pageing(<%=prevPage %>)" class="page_block">&lt;</a>
           <% 
            	}
            	pageLimit = start + (totalSize % rowRange) + 1 > totalSize / 10 + 1 ? totalSize / 10 + 1 : start + (totalSize % rowRange) + 1;
            	
            	for(int i = start; i < pageLimit; i++){
           %>
            	
            	<%if (i != start){ %>
                <a href="javascript:pageing(<%=i %>)" class="page_block"><%=i + 1 %></a>
                <%}else{ %>
                <a href="javascript:pageing(<%=i %>)" class="page_block" style="color:skyblue"><%=i + 1 %></a>
                <%} %>
            	
            <%
            	}
            } else {
            // 평소 페이지 단락
            	if(start > 0){
            	
            %>
                <a href="javascript:pageing(<%=prevPage %>)" class="page_block">&lt;</a>
            <%}
          
            %>
            
            
            <% 	
				for(int i = start; i < pageLimit; i++){
			%>
					<%if (i != start){ %>
                <a href="javascript:pageing(<%=i %>)" class="page_block"><%=i + 1 %></a>
                	<%}else{ %>
                <a href="javascript:pageing(<%=i %>)" class="page_block" style="color:skyblue"><%=i + 1 %></a>
                	<%} %>
            <%
				}
				
	            if(totalSize > start){
            %>
                <a href="javascript:pageing(<%=nextPage %>)" class="page_block">&gt;</a>
            <%	} %>
            
            <%
            } // 151개일경우 10개씩 할 경우 1개가 남는데 이러한 경우가 아닐경우 
            
            %>
            
            </div>
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div>
    <form method="get" name="pageForm" action="index.jsp">
    	<input type="hidden" name="start" value="<%=start %>">
    	<input type="hidden" name="search" value="<%=search %>">
    </form>
</body>
</html>
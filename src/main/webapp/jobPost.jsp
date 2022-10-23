<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="portfolio1.*" %>
<%
	final String SAVEFOLDER = "./fileupload";
	request.setCharacterEncoding("utf-8");
	PortMgr pMgr = new PortMgr();
	
	int num = Integer.parseInt(request.getParameter("num"));
	JobBoardBean bean = pMgr.portJobContent(num);
	String fileName = bean.getFile_name();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Post</title>
    <link href="style/jobs_post.css" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/favicon.ico" type="image/x-icon">
	<script>
		function showPopup(){
			var width = 220;
			var height = 400;
			
			var left = (window.screen.width / 2) - (width/2);
			var top = (window.screen.height / 4);
			
			var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=no, titlebar=yes';
			
		    const url = "popup.jsp?num=<%=num%>&type=2";
	
			window.open(url, "report", windowStatus);
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
            <div id="post_head"> 
                <a href="javascript:showPopup()" id="siren">
                    <img src="imgs/siren.png" alt="siren">
                </a>
                <br/>
                <div id="post_info">
                	<span><%=bean.getJob() %></span>
                	<span><%=bean.getDegree() %></span>
                	<span><%=bean.getExp() %></span>
                	<span><%=bean.getMain_area() %></span>
                	<span><%=bean.getSub_area() %></span>
                	<span><%=bean.getCompany() %></span>
                </div>
                <div id="post_title">
                    <span><%=bean.getSubject() %></span>
                    <span><%=bean.getWrite_date().substring(0, 10) %></span>
                    <span><%=bean.getWriter() %></span>
                </div>
            </div>


            <div id="post_body">
            	<%
            	 if(!fileName.equals("")){
		             String[] fileArray = fileName.split(",");
	            	 if(fileArray.length > 0){
		            	 for(int i = 0; i < fileArray.length; i++){ 
	            		
            	%>
            		<img src="<%=SAVEFOLDER+"/"+fileArray[i] %>" alt="image" class="content_img"><br/>
	            <%
		            	}
	            	}
            	 }
            	%>
            	<br/>
               	<span><%=bean.getContent() %></span>

                <p>
                	<!-- 수정, 삭제 버튼은 session의 ID를 저장하여 해당 글의 글쓴이와 동일할 경우에만 활성화 -->
                    
                    <%if(id.equals(bean.getWriter())){ %>
                    <a class="btn" href="jobModify.jsp?num=<%=num%>">수정</a>
                    <a class="btn" href="jobs_delete.jsp?num=<%=num%>">삭제</a>
                    <%} %>
                    <a class="btn" href="index.jsp">목록</a>
                </p>
            </div>
         </div>
       </div>
</body>
</html>
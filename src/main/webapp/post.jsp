<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="portfolio1.*" %>
<%
	final String SAVEFOLDER = "./fileupload";
	request.setCharacterEncoding("utf-8");
	PortMgr pMgr = new PortMgr();
	
	int num = Integer.parseInt(request.getParameter("num"));
	BoardBean bean = pMgr.portContent(num);
	pMgr.increaseView(num);
	
	String fileName =  bean.getFile_name();
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post</title>
    <link href="style/post_style.css?ver=1" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/favicon.ico" type="image/x-icon">
</head>
<body>
    <%@include file="header.jsp"%>

    <div id="content">
        <aside id="aside_first">
            광고
        </aside>
        <div id="notice">
            <div id="post_head"> 
                <a href="#" id="siren">
                    <img src="imgs/siren.png" alt="siren">
                </a>
                <br/>
                <div id="post_title">
                    <span><%=bean.getSubject() %></span>
                    <span><%=bean.getWrite_date().substring(0, 10) %></span>
                    <span><%=bean.getViews() %></span>
                    <span><%=bean.getWriter() %></span>
                </div>
            </div>


            <div id="post_body">
            	<%
	             String[] fileArray = fileName.split(",");
            	 if(fileArray.length > 1){
	            	 for(int i = 0; i < fileArray.length; i++){ 
	            		String[] strFormat = {"jpg","JPG","png","PNG","jpeg","JPEG", "gif", "GIF", "webp", "WEBP"};
	            		int leng = fileArray[i].length();
	            		for(int j = 0; j < strFormat.length; j++){
	            			if (fileArray[i].substring(leng - 4, leng).contains(strFormat[0])){
	            			
            	%>
            		<img src="<%=SAVEFOLDER+"/"+fileArray[i] %>" alt="image" class="content_img"><br/>
	            <%				break;
	            			}	
	            		}
            	  	}
            	}%>
            	<br/>
               	<span><%=bean.getContent() %></span>

                <p>
                	<!-- 수정, 삭제 버튼은 session의 ID를 저장하여 해당 글의 글쓴이와 동일할 경우에만 활성화 -->
                    
                    <%if(id.equals(bean.getWriter())){ %>
                    <a class="btn" href="#">수정</a>
                    <a class="btn" href="post_delete.jsp?num=<%=num%>">삭제</a>
                    <%} %>
                    <a class="btn" href="index.jsp">목록</a>
                </p>
            </div>

            <div id="post_footer">
            	
                <div class="comments">
                    <span>익명</span>
                    <span>질문의 답변</span>
                    <a href="#"><img src="imgs/check.png" alt=""></a>
                </div>
                <div class="comments_after">
                    <span>익명</span>
                    <span>질문의 답변</span>
                    <a href="#"><img src="imgs/check.png" alt=""></a>
                </div>
                <form method="post" action="comment.jsp?num=<%=num %>" class="comment_insert">
                    <input type="text" name="comment" placeholder="내용을 입력하고 엔터를 쳐주세요.">
                </form>
            </div>
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div> 
</body>
</html>
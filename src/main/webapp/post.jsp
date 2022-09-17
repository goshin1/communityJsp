<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="portfolio1.*" %>
<%
	final String SAVEFOLDER = "./fileupload";
	request.setCharacterEncoding("utf-8");
	PortMgr pMgr = new PortMgr();
	
	int num = Integer.parseInt(request.getParameter("num"));
	int dNum = 0;
	if(request.getParameter("dNum") != null){
		dNum = Integer.parseInt(request.getParameter("dNum"));
		int res = pMgr.deleteComment(dNum);
		if(res <= 0)
			out.println("<script>alert('댓글 삭제에 실패하였습니다.');</script>");
		pMgr.decreaseReview(num);
	}
	
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
    <link href="style/post_style.css" rel="stylesheet" type="text/css">
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
	            		
            	%>
            		<img src="<%=SAVEFOLDER+"/"+fileArray[i] %>" alt="image" class="content_img"><br/>
	            <%
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
            	<%
            		Vector<CommentBean> v = pMgr.CommentList(num);
            		for(int i = 0; i < v.size(); i++){
            			CommentBean cbean = v.get(i);
            			String cWriter = cbean.getcWriter();
            			String comment = cbean.getComment();
            			int cNum = cbean.getcNum();
            			int ref = cbean.getRef();
            			if(ref == 0){
            	%>
                <div class="comments">
                    <span><%=cWriter %></span>
                    <span><%=comment %></span>
                    		<%if(id.equals(cWriter)){ %>
                    <a href="post.jsp?num=<%=num%>&dNum=<%=cNum%>">
                    	<img src="imgs/check.png" alt="">
                    </a>
                    		<%} %>
                   	<form method="post" action="comment.jsp?num=<%=num %>&ref=<%=cNum %>" class="recomment_insert">
	                	<label for="comment"><%=id%><input type="text" name="comment" placeholder="내용을 입력하고 엔터를 쳐주세요."></label>
	                	<input type="hidden" name="id" value="<%=id %>">
	                	<input type="hidden" name="type" value="answer">
	                </form>
                </div>
                
                
                <%		}
                		Vector<CommentBean> rev = pMgr.ReCommentList(cNum);
	                	for(int j = 0; j < rev.size(); j++){
	                		CommentBean reBean = rev.get(j);
	                		String recWriter = reBean.getcWriter();
	                		String recomment = reBean.getComment();
	                		int recNum = reBean.getcNum();
                %>
                <div class="comments_after">
                    <span><%=recWriter %></span>
                    <span><%=recomment %></span>
                    		<%if(id.equals(recWriter)){ %>
                    <a href="post.jsp?num=<%=num%>&dNum=<%=recNum%>">
                    	<img src="imgs/check.png" alt="">
                    </a>
                    		<%} %>
                </div>
                
                
                <%
	                	}
            		}// 댓글 for문 끝
                %>
                <%if(id != ""){ %>
                <form method="post" action="comment.jsp?num=<%=num %>" class="comment_insert">
                	<label for="comment"><%=id%><input type="text" name="comment" placeholder="내용을 입력하고 엔터를 쳐주세요."></label>
                	<input type="hidden" name="id" value="<%=id %>">
                	<input type="hidden" name="type" value="normal">
                </form>
                <%} %>
            </div>
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div>
    <%if(id != ""){ %>
    <script>
    	var comments = document.getElementsByClassName("comments");
    	for(var i = 0; i < comments.length; i++){
    		var count = 0;
    		comments[i].addEventListener("click", function(){
    			this.style.height = "130px";
    		});
    		
    		comments[i].addEventListener("dblclick", function(){
    			this.style.height = "50px";
    		});
    	}
    </script>
    <%} %>
</body>
</html>
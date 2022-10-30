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

	String fileName =  bean.getFile_name();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style/modify_style.css" type="text/css" rel="stylesheet">
    <title>Modify</title>
</head>
<body>
    <%@include file="header.jsp"%>

    <div id="content">
        <aside id="aside_first">
            광고
        </aside>
        <div id="notice">
            <form name="writeBoard" id="write" method="post" action="modify_chain.jsp?num=<%=num %>" enctype="multipart/form-data">
                <input type="text" name="title" placeholder="제목을 입력해주세요." value="<%=bean.getSubject()%>">

                <div id="write_body">
                	<textarea name="content">
<%=bean.getContent() %>
                    </textarea>
                	<div>
                        <input type="file" multiple="multiple" onchange="createList(this)" onclick="checkFile()" name="fileobj" accept=".jpg, .jpeg, .png, .webp"> 이미지는 최대 5개까지 업로드 가능합니다.
                    </div>
                </div>
                <input id="submit_btn" type="submit" value="작성">
                <input type="hidden" name="file_list" value="<%=fileName%>">
            </form>

            
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div>
    	<script>

    		function createList(obj){
				if(obj.files.length > 5){
					alert("파일은 최대 5개까지 가능합니다.");
					obj.value = "";
				}
				
				var list = document.writeBoard.fileobj.files;
				var res = list[0].name;
				for(var i = 1; i < list.length; i++){
					res += ","+list[i].name;
				}
				
				document.writeBoard.file_list.value = res;
			}
			
    </script>
</body>
</html>
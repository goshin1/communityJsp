<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style/write_style.css?ver=1" type="text/css" rel="stylesheet">
    <title>Write</title>
</head>
<body>
    <%@include file="header.jsp"%>

    <div id="content">
        <aside id="aside_first">
            광고
        </aside>
        <div id="notice">
            <form name="writeBoard" id="write" method="post" action="write_chain.jsp" enctype="multipart/form-data">
                <input type="text" name="title" placeholder="제목을 입력해주세요.">

                <div id="write_body">
                    <textarea name="content"></textarea>
                	<div>
                        <input type="file" multiple="multiple" onchange="createList(this)" name="fileobj" accept=".jpg, .jpeg, .png, .webp"> 이미지는 최대 5개까지 업로드 가능합니다.
                    </div>
                </div>
                <input id="submit_btn" type="button" value="작성">
                <input type="hidden" name="file_list">
            </form>

            
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div>
    	<script>
    		document.getElementById("submit_btn").addEventListener("click", function(){
    			if(document.writeBoard.title.value == ""){
    				alert("제목을 입력해주세요.");
    				return;
    			}
    			if(document.writeBoard.content.value == ""){
    				alert("내용을 입력해주세요.");
    				return;
    			}
    			
    			document.writeBoard.submit();
    		});
    	
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
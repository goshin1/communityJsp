<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager</title>
    <link href="style/manager.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@include file="header.jsp"%>
    <div id="content">
        <div id="notice">
            <p>신고글</p>
            <table>
                <tr>
                    <td>이름</td>
                    <td>제목</td>
                    <td>사유</td>
                    <td>삭제</td>
                    <td>차단</td>
                </tr>

                <tr>
                        <td>익명</td>
                        <td>수익률 100% 안전 토토 늦으면 손해!</td>
                        <td>불법광고</td>
                        <!-- 글 삭제나 수정은 for문을 통해 tr을 만들때 delete.jsp&postNum=2222-->
                        <!-- 이런식으로 get방식으로 전달  -->
                        <td><a href=""><img src="imgs/check.png" alt="check"></a></td>
                        <td><a href=""><img src="imgs/check.png" alt="check"></a></td>
                    </tr>
                    <tr>
                        <td>익명</td>
                        <td>삼성 이번 인턴 사원 전부 해고 한다고 합니다.</td>
                        <td>허위사실</td>
                        <td><a href=""><img src="imgs/check.png" alt="check"></a></td>
                        <td><a href=""><img src="imgs/check.png" alt="check"></a></td>
                    </tr>
            </table>
        </div>

    </div> 
</body>
</html>


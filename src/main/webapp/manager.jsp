<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.LocalDate" %>
<%@ page import="portfolio1.*" %>
<%
	Vector<ReportBean> v = new Vector<ReportBean>();
	PortMgr pMgr = new PortMgr();
	v = pMgr.getReportBoardList();
	
	if(request.getParameter("cancel") != null){
		pMgr.deleteReport(Integer.parseInt(request.getParameter("cancel")));
	}
	
	String now  = LocalDate.now().toString();
	pMgr.deleteStopDate(now);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager</title>
    <link href="style/manager.css?ver=2" type="text/css" rel="stylesheet">
    <script>
		function showPopup(rNum, bNum, write_date){
			var width = 220;
			var height = 400;
			
			var left = (window.screen.width / 2) - (width/2);
			var top = (window.screen.height / 4);
			
			var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=no, titlebar=yes';
			
		    const url = "report_popup.jsp?rNum="+rNum+"&bNum="+bNum+"&write_date="+write_date;
	
			window.open(url, "report", windowStatus);
		}
	</script>
</head>
<body>
	<%@include file="header.jsp"%>
    <div id="content">
        <div id="notice">
            <p>신고글</p>
            <table>
                <tr>
                    <td>번호</td>
                    <td>신고타입</td>
                    <td>사유</td>
                    <td>삭제</td>
                    <td>차단</td>
                    <td>취소</td>
                </tr>
				
				<% 
				for(int i = 0; i < v.size(); i++){ 
					ReportBean bean = v.get(i);
					int rNum = bean.getNum();
					int bNum = bean.getrNum();
					String write_date = bean.getWrite_date();
				%>
                <tr>
                    <td>
                    <%if(bean.getBoardType() == 2){ %>
                    	<a href="jobPost.jsp?num=<%=bNum%>"><%=rNum%></a>
                    <%} else {%>
                    	<a href="post.jsp?num=<%=bNum%>"><%=rNum%></a>
                    <%} %>
                    </td>
                    <td><%=bean.getReportType() %></td>
                    <td><%=bean.getComment() %></td>
                     
                    <%if(bean.getBoardType() == 2){ %>
                    <td><a href="jobs_delete.jsp?num=<%=bNum %>"><img src="imgs/check.png" alt="check"></a></td>
                    <td><a href="javascript:showPopup(<%=rNum%>, <%=bNum%>, '<%=write_date%>')"><img src="imgs/check.png" alt="check"></a></td>
                    <%} else {%>
                    <td><a href="post_delete.jsp?num=<%=bNum %>&rNum=<%=rNum%>"><img src="imgs/check.png" alt="check"></a></td>
                    <td><a href="javascript:showPopup(<%=rNum%>, <%=bNum%>, '<%=write_date%>')"><img src="imgs/check.png" alt="check"></a></td>
                    <%} %>
                    <td><a href="manager.jsp?cancel=<%=rNum%>"><img src="imgs/check.png" alt="check"></a></td>
                </tr>
                <%} %>
                
            </table>
        </div>

    </div> 
</body>
</html>


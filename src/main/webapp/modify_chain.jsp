<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,
				com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="portfolio1.*" %>
<% 
	String saveFolder = "C:/Users/gci91/eclipse-workspace/portfolio1/src/main/webapp/fileupload";
	String encType = "utf-8";
	int maxSize = 100*1024*1024;


	int num = Integer.parseInt(request.getParameter("num"));
	String user = (String)session.getAttribute("id");
	String title = "";
	String content = "";
	String Filename = "";
	
	
	try{
		MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());

		title = multi.getParameter("title");
		content = multi.getParameter("content");
		
		
		File dir = new File(saveFolder+"/");
		String dbFiles = "";
		int totalSize = 0;
		
		
		if(multi.getParameter("file_list") != null && !multi.getParameter("file_list").equals("")){
			String[] fileList = multi.getParameter("file_list").split(",");
			for(int i = 0; i < fileList.length; i++){
					
				int idx = fileList[i].lastIndexOf(".");
				String pattern = fileList[i].substring(0, idx);
				

				FilenameFilter filter = new FilenameFilter(){
					public boolean accept(File f, String name){
						return name.startsWith(pattern);
					}
				};
				
				
				File files[] = dir.listFiles(filter);

				int sel = 0;
				if(files.length > 1)
					sel = files.length - 1;
				dbFiles += files[sel].getName()+",";
				totalSize += files[sel].length();
			}	
		}
		
		
		
		PortMgr pMgr = new PortMgr();
		int res = pMgr.modifyBoard(num, user, title, content, dbFiles, totalSize);
		if(res <= 0){
			out.println("<script>alert('게시글 수정에 실패하였습니다.'); history.back();</script>");
		}else{
			response.sendRedirect("post.jsp?num="+num);	
		}
	}catch(IOException ioe){
		System.out.println(ioe);
	}catch(Exception ex){
		System.out.println(ex);
	}
%>

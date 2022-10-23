<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.text.*, java.lang.*, java.util.*, java.net.*" %>


<%
	request.setCharacterEncoding("utf-8");
	String root = getServletContext().getRealPath("/");
	String savePath = root + "fileupload";
	
	String filename = request.getParameter("filename");
	String origname = request.getParameter("origname");
	
	InputStream in = null;
	OutputStream os = null;
	File file = null;
	boolean skip = false;
	String client = "";
	
	try{
		
		// 해당 파일 가져오기
		try{
			file = new File(savePath, filename);
			in = new FileInputStream(file);
		}catch(FileNotFoundException fe){
			skip = true;
		}
		
		client = request.getHeader("User-Agent");
		// 파일 다운로드 헤더 지정
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Date");
		
		if(!skip){
			// IE
			if(client.indexOf("MSIE") != -1){
				response.setHeader("Content-Description", "attachment; filename="+new String(origname.getBytes("KSC5601"), "ISO8859_1"));
			} else {
				origname = new String(origname.getBytes("utf-8"), "iso-8859-1");
				
				response.setHeader("Content-Disposition", "attachment; filename=\""+origname+"\"");
				response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
			}
			
			response.setHeader("Content-Length",""+file.length());
			
			os = response.getOutputStream();
			byte b[] = new byte[(int)file.length()];
			int leng = 0;
			
			while((leng = in.read(b)) > 0){
				os.write(b, 0, leng);
			}
		} else {
			response.setContentType("text/html;charset=utf-8");
			out.println("<script>alert('파일을 찾을 수 없습니다.'); history.back();</script>");
		}
		
		in.close();
		os.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>

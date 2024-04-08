<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String saveDirectory = application.getRealPath("/Uploads");
	String saveFileName = request.getParameter("sName");
	String originalFileName = request.getParameter("oName");
	
	try {
		//파일을 찾아 입력 스트림 생성
		File file = new File(saveDirectory, saveFileName);
		InputStream inStream = new FileInputStream(file);
		
		//한글 파일명 깨짐 방지
		//User-Agent로 웹 브라우저 종류 알아내기 =>/13FileUpload/UserAgent.jsp 파일 참고
		String client = request.getHeader("User-Agent");
		if (client.indexOf("WOW64") == -1) {
			originalFileName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
		} else {
			originalFileName = new String(originalFileName.getBytes("KSC5601"), "ISO-8859-1");
		}
		
		/*
			*** 참고사항
			- 파일명에 []와 같은 특수 기호가 포함되어 있다면 파일ㄹ 다운로드 시 IllegalArgumentException 에러 발생.
			- 해당 에러를 방지하려면 sever.xml의 Connector 속성에 'relaxedQueryChars = "[]()^|&quot;""를 추가하면 됨
			ex) <Connector connectionTimeout="20000" port="8080" protocol="HTTP/1.1" redirectPort="8443" relaxedQueryChars="[]()^|&quot;" />
		*/
		
		
		//파일 다운로드용 응답 헤더 설정
		response.reset(); //응답 헤더 초기화
		/*
			파일 다운로드 창을 띄우기 위한 콘텐츠 타입 지정
			octet-stream은 8비트 단위의 바이너리 데이터를 의미함.
			응답 헤더로 설정하게 되면 파일의 종류에 상관없이 웹 브라우저는 다운로드 창을 띄우게 됨.
		*/
		response.setContentType("application/octet-stream");
		//웹 브라우저에 파일 다운로드 창이 뜰 때 원본 파일명이 기본으로 입력되어 있도록 설정
		response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFileName + "\"");
		response.setHeader("Content-Length", "" + file.length());
		
		/*
			새로운 출력 스트림을 생성하기 위해 출력 스트림 초기화. 
			JSP가 열린 상태에서 다운로드를 위해 또 다른 JSP를 열면 출력 스트림이 중복으로 생성되기 때문에 이 부분이 없으면 예외가 발생함.
		*/
		out.clear();
		
		//response 내장 객체로부터 새로운 출력 스트림 생성
		OutputStream outStream = response.getOutputStream();
		
		//출력 스트림에 읽어온 파일(file 참조 변수) 내용 출력
		byte b[] = new byte[(int) file.length()];
		int readBuffer = 0;
		
		//inStream에서 읽어서 outStream으로 출력
		while ((readBuffer = inStream.read(b)) > 0) {
			outStream.write(b, 0, readBuffer);
		}
	
		//입/출력 스트림 닫음
		inStream.close();
		outStream.close();
		
	} catch(FileNotFoundException e) {
		JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
	} catch(Exception e) {
		JSFunction.alertBack("예외가 발생하였습니다.", out);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Download.jsp</title>
</head>
<body>

</body>
</html>
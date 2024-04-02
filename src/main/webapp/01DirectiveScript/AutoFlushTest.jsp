<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    buffer="1kb"
    autoFlush="false"%> <%-- buffer 1kb로 설정(기본값 8kb) / autoFlush false로 설정 --%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page 지시어 - buffer, autoFlush 속성</title>
</head>
<body>
<%
	for(int i = 1; i <= 100; i++) { // 2. 버퍼 채우기
		out.println("abcde12345");
	}
%>
</body>
</html>
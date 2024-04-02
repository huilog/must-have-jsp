<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="IncludeFile.jsp" %> <%-- 1. 해당 페이지에 다른 JSP 파일(IncludeFile.jsp) 포함 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 2. IncludeFile.jsp에서 선언한 변수 사용
	out.println("오늘 날짜 : " + today);
	out.println("<br />");
	out.println("내일 날짜 : " + tomorrow);
%>
</body>
</html>
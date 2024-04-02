<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    errorPage="IsErrorPage.jsp"%> <%-- errorPage 속성 추가 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int myAge = Integer.parseInt(request.getParameter("age")); // 1.최초 실행 시 매개변수가 없으므로 null 값이 전달되어 예외 발생
out.println("10년 후 당신의 나이는 " + myAge + "입니다."); //실행되지 않음
%>
</body>
</html>
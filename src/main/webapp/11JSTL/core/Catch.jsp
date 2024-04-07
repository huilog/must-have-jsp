<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- catch 태그는 발생한 예외를 잡아 처리하는 역할을 함.
	예외가 발생하면 지정한 변수에 에러 메시지가 저장되어 전달됨.
 --%>
<title>JSTL - catch</title>
</head>
<body>
	<h4>자바 코드에서의 예외</h4>
	<%
		int num1 = 100;
	%>
	<c:catch var="eMessage">
		<%
			int result = num1 / 0;
		%>
	</c:catch>
	예외 내용 : ${ eMessage }
	
	<h4>EL에서의 예외</h4>
	<c:set var="num2" value="200" />
	
	<c:catch var="eMessage">
		${"일" + num2 }
	</c:catch>
	예외 내용 : ${ eMessage }
</body>
</html>
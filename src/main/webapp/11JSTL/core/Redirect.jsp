<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <c:redirect> 태그는 response 내장 객체의 sendRedirect()와 동일하게 페이지 이동을 처리함. --%>
<title>JSTL - redirect</title>
</head>
<body>
	<!-- redirect는 forward와 달리 request 영역이 공유되지 않으므로, 이동한 페이지에서 requestVar 변수가 출력되지 않음 -->
	<c:set var="requestVar" value="MustHave" scope="request" />
	<c:redirect url="/11JSTL/inc/OtherPage.jsp">
		<c:param name="user_param1" value="출판사" />
		<c:param name="user_param2" value="골든래빗" />
	</c:redirect>
</body>
</html>
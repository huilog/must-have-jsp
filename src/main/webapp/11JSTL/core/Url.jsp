<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <c:url> 태그는 지정한 경로와 매개변수를 이용해서 컨택스트 루트를 포함한 URL을 생성함.
	 생성된 URL은 <a> 태그의 href 속성이나, <form> 태그의 action 속성에 사용할 수 있음.
 --%>
<title>JSTL - Url</title>
</head>
<body>
	<h4>url 태그로 링크 걸기</h4>
	<c:url value="/11JSTL/inc/OtherPage.jsp" var="url">
		<c:param name="user_param1" value="Must" />
		<c:param name="user_param2">Have</c:param>
	</c:url>
	<a href="${ url }">OtherPage.jsp 바로가기</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forTokens</title>
</head>
<%-- 
	Token이란?
	: 일반적으로 토큰은 '문법적으로 의미있는 최소 단위'를 말한다.
	여기서는 문자열을 구분할 구분자(delimiter)로 분리되는 문자열의 구성 요소를 의미한다.
 --%>
<body>
	<%
	String rgba = "Red,Green,Blue,Black";
	%>
	<h4>JSTL의 forTokens 태그 사용</h4>
	<!-- items 속성에는 문자열만 사용할 수 있고, 배열 및 컬렉션은 사용할 수 없다. -->
	<!-- 구분자(delims)를 기준으로 분리된 토큰은 var 속성에 지정한 color 변수에 저장됨 -->
	<c:forTokens items="<%= rgba %>" delims="," var="color">
		<span style="color:${ color };">${ color }</span> <br />
	</c:forTokens>
</body>
</html>
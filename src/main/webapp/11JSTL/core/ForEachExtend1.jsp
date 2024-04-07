<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forEach2</title>
</head>
<body>
	<h4>향상된 for문 형태의 forEach 태그</h4>
	<%
		String[] rgba = {"Red", "Green", "Blue", "Black"};
	%>
	
	<c:forEach items="<%= rgba %>" var="c">
		<span style="color:${ c };">${ c }</span>
	</c:forEach>
	
	<h4>varStatus 속성 살펴보기</h4>
	<table border="1">
	<!-- 일반 for문과 비슷하지만 current와 index의 속성값이 다른 것을 확인할 수 있다. -->
	<!-- 
		향상된 for문에서는 시작과 종료가 items에 지정된 객체에 따라 결정되므로 index는 0부터 시작하지만,
		current는 현재 루프의 객체가 반환된다.
	 -->
		<c:forEach items="<%= rgba %>" var="c" varStatus="loop">
			<tr>
				<td>count : ${ loop.count }</td>
				<td>index : ${ loop.index }</td>
				<td>current : ${ loop.current}</td>
				<td>first : ${ loop.first }</td>
				<td>last : ${ loop.last }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <c:out> 태그는 JSP의 표현식처럼 변수를 출력할 때 사용함. --%>
<title>JSTL - out</title>
</head>
<body>
	<c:set var="iTag">
		i 태그는 <i>기울임</i>을 표현합니다.
	</c:set>
	
	<h4>기본 사용</h4>
	<%-- 위에서 선언한 iTag 출력. 이때 <i> 태그는 HTML로 인식되지 않고, 텍스트 상태 그대로 화면에 출력됨 --%>
	<c:out value="${ iTag }" />
	
	<%-- escapeXml 속성을 false로 지정하면 HTML 태그를 해석하여 마크업이 적용된 상태로 출력됨 --%>
	<h4>escapeXml 속성</h4>
	<c:out value="${iTag }" escapeXml="false" />
	
	<h4>default 속성</h4>
	<%-- default 속성으로는 변수값이 null인 경우 출력할 값을 지정할 수 있음. 처음 실행할 경우네는 매개변수가 없으므로 "이름 없음"이 출력됨. --%>	
	<c:out value="${ param.name }" default="이름 없음" />
	<%-- 빈 문자열도 하나의 값이기 때문에 null이 아니라서 default에 지정한 값이 출력되지 않음 --%>
	<c:out value="" default="빈 문자열도 값입니다." />
</body>
</html>
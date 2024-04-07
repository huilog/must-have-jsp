<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - if</title>
</head>
<body>
	<!--  변수 선언 -->
	<c:set var="number" value="100" />
	<c:set var="string" value="JSP" />
	
	<h4>JSTL의 if 태그로 짝수/홀수 판단하기</h4>
	<c:if test="${ number mod 2 eq 0 }" var="result">
		${ number }는 짝수입니다. <br />
	</c:if>
	result = ${ result } <br />
	
	<h4>문자열 비교와 else 구문 흉내내기</h4>
	<!-- string 변수에 저장된 문자열과 'Java'를 비교해 결과는 result2에 저장 -->
	<c:if test="${ string eq 'Java' }" var="result2">
		문자열은 Java입니다. <br />
	</c:if>
	<c:if test="${ not result2 }">
		'Java'가 아닙니다. <br />
	</c:if>
	
	<h4>조건식 주의사항</h4>
	<!-- test 속성에 EL이 아닌 일반 값이 오면 무조건 false 반환.(단, 일반 값으로 true가 사용되는 것은 예외) -->
	<c:if test="100" var="result3">
		EL이 아닌 정수를 지정하면 false
	</c:if>
	result3: ${ result3 } <br/>
	<!-- 문자열 true는 대소문자 상관없이 항상 true를 반환함 -->
	<c:if test="tRue" var="result4">
		대소문자 구분 없이 "tRue"인 경우 true <br />
	</c:if>
	result4 : ${ result4 } <br />
	<!-- test 속성에 EL을 통해 조건식 사용 시, 공백이 삽입되면 무조건 false를 반환함. -->
	<c:if test=" ${ true } " var="result5">
		EL 양쪽에 빈 공백이 있는 경우 false <br />
	</c:if>
	result5 : ${ result5 } <br />

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--
	JSTL의 Formatting 태그는 국제화 태그로, 국가별로 다양한 언어, 날짜, 시간, 숫자 형싣을 설정할 때 사용함.
	국제화 태그를 사용하려면 먼저 다음의 지시어를 선언해야 함. 접두어로는 'fmt'를 이용.
	<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
 --%>
<title>JSTL - fmt 1</title>
</head>
<body>
	<h4>숫자 포맷 설정</h4>
	<c:set var="number1" value="12345" />
	콤마 O: <fmt:formatNumber value="${ number1 }" /> <br />
	<!-- groupingUsed 속성은 세 자리마다 콤마를 출력할지 여부를 결정. 기본값은 true임 -->
	콤마 X: <fmt:formatNumber value="${ number1 }" groupingUsed="false"/> <br />
	<!-- type 속성을 지정하여 통화기호 또는 퍼센트(백분율)로 표시. var 속성을 사용해서 즉시 선언하지 않고 지정한 위치에 출력함. -->
	<fmt:formatNumber value="${ number1 }" type="currency" var="printNum1" />
	통화기호 : ${ printNum1 } <br />
	<fmt:formatNumber value="0.03" type="percent" var="printNum2" />
	퍼센트 : ${ printNum2 }
	
	<!--  parseNumber: 문자열을 숫자로 파싱. -->
	<h4>문자열을 숫자로 변경</h4>
	<c:set var="number2" value="6,789.01" />
	<fmt:parseNumber value="${ number2 }" pattern="00,000.00" var="printNum3" />
	소수점까지: ${ printNum3 } <br />
	<!-- integerOnly 속성을 사용하여 정수부만 파싱해 출력함 -->
	<fmt:parseNumber value="${ number2 }" integerOnly="true" var="printNum4" />
	정수 부분만: ${ printNum4 }
</body>
</html>
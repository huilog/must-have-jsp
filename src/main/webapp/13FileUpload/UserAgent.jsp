<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User-Agent 확인하기</title>
</head>
<body>
	<h2>User-Agent로 웹 브라우저 종류 알아내기</h2>
	<%
		String client = request.getHeader("User-Agent");
	%>
	<%= client %>
	
	<%--
		인터넷 익스플로러의 실행 결과에서 출력되는 "WOW64"는 "Windows on Windows 64-bit"라는 뜻으로,
		64비트 버전의 윈도우에서 32비트 응용프로그램을 실행할 수 있다는 의미를 가지고 있다.
		인터넷 익스플로러는 2021년 현재 과거에 비해 사용 빈도가 많이 줄긴 했지만, 국내에서는 아직 많이 사용되고 있으므로,
		인터넷 익스플로러에 대한 처리도 해주는 것이 좋다.
		이번 에제를 테스트한 환경은 Windows 10이고, 인터넷 익스플로러 버전은 11이다.
	 --%>
</body>
</html>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>3. HTTP 요청 헤더 정보 출력하기</h2>
	<%
		//1. getHeaderNames() 메서드는 모든 요청 헤더의 이름을 반환함.
		Enumeration headers = request.getHeaderNames();
		
		//2. Enumeration Type의 hasMoreElements() 메서드를 사용해 출력할 요청 헤더명이 더 있는지 확인
		while(headers.hasMoreElements()) {
			//3. 요청 header의 키(key) 가져오기
			String headerName = (String)headers.nextElement();
			//3. 요청 header의 값(value) 가져오기
			String headerValue = request.getHeader(headerName);
			out.print("헤더명: " + headerName + ", 헤더값: " + headerValue + "</br>");
		}
		
		/* 
			특징적인 header 정보에 대해서 간단히 정리
			
			1. user-agent: 웹 브라우저의 종류를 알 수 있음. 각각의 브라우저에서 테스트 해보면 조금씩 다른 결과가 출력됨.
			2. referer: '리퍼러'는 웹을 서핑하면서 링크를 통해 다른 사이트로 방문 시 남는 흔적을 말함. 웹 사이트 방문객이 어떤 경로로 접속하였는지 알아볼 때 유용함.
			3. cookie: 요청 헤더를 통해 쿠키도 확인할 수 있음.
		*/
	%>
	<p>이 파일을 직접 실행하면 referer 정보는 출력되지 않습니다. </p>
</body>
</html>
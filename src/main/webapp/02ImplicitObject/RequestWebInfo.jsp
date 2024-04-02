<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - request</title>
</head>
<body>
	<h2>1. 클라이언트와 서버의 환경정보 읽기</h2>
	<ul>
		<%-- 1. GET, POST와 같은 전송 방식 반환 --%>
		<li>데이터 전송 방식: <%=request.getMethod() %></li>
		
		<%-- 2. 클라이언트 요청 주소 반환. URL은 호스트를 포함한 전체 주소를 반환함.(쿼리스트링 제외 - 주소가 아님.) --%>
		<li>URL: <%=request.getRequestURL() %></li>
		
		<%-- 3. 클라이언트 요청 주소 반환. URI는 호스트를 제외하고 컨텍스트 루트(contextRoot)부터의 주소를 반환함. - port 번호 뒷 부분부터 반환 (쿼리스트링 제외 - 주소가 아님.)--%>
		<li>URI: <%=request.getRequestURI() %></li>
		
		<li>프로토콜: <%=request.getProtocol() %></li> 
		<li>서버명: <%=request.getServerName() %></li> 
		<li>서버 포트: <%=request.getServerPort() %></li> 
		
		<%-- 4. 클라이언트의 IP 주소 반환. localhost로 접속했을때는 '0:0:0:0:0:0:0:1'과 같이 출력됨.
		     윈도우에서는 IPv6를 반환하는게 기본이기 때문.
		     WAS 설정을 IPv4로 변경하면 127.0.0.1로 출력됨
		--%>
		<li>클라이언트 IP 주소: <%=request.getRemoteAddr() %></li>
		
		<%-- 5. 클라이언트 요청 주소 뒷부분의 매개변수 전달을 위한 쿼리스트링 전체를 반환함.
				클라이언트가 GET 방식으로 쿼리스트링에 키 값을 전달했을때만 값이 존재함.
				(POST 방식으로 요청했을 경우에는 null 값 출력)
		--%>
		<li>쿼리스트링: <%=request.getQueryString() %></li>
		
		<%-- 6. 사용자가 요청하면서 보낸 특정 키 값을 가져오기 위한 메서드로, 가져오고자 하는 키 값을 인수(argument)로 넘기면 됨. --%>
		<li>전송된 값 1: <%=request.getParameter("eng") %></li>
		<li>전송된 값 2: <%=request.getParameter("han") %></li>
	</ul>
	
</body>
</html>
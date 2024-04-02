<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - request</title>
</head>
<body>
<h2>2. 클라이언트의 요청 매개변수 출력하기</h2>
<%
//톰캣의 버전에 따라 POST 방식으로 전송된 값이 한글인 경우 깨짐 현상이 발생할 수 있으므로, 다국어를 지원하는 UTF-8로 인코딩
request.setCharacterEncoding("UTF-8");

/*
	전송되는 값이 하나라면 getParameter() 메서드로 받을 수 있음.
	주로 type 속성이 text, radio, password인 경우 사용됨.
*/
String id = request.getParameter("id");
String sex = request.getParameter("sex");

/* 
	checkbox type도 선택값이 하나인 경우에는 getParameter를 통해 값을 받을 수 있으나,
	보통 checkbox type은 값을 여러 개 선택하기 위해 사용하므로 getParameterValues를 사용함.
	값이 두 개 이상이므로 String 배열로 반환함.
*/
String[] favo = request.getParameterValues("favo");
String favoStr = "";

if (favo != null) { //String 배열로 반환된 관심사항 값들을 문자열로 합치기
	for (int i = 0; i < favo.length; i++) {
		if( i == (favo.length -1)){
			favoStr += favo[i];			
		}else {
			favoStr += favo[i] + ", ";
		}
	}
}
//enter는 특수 기호 \r\n으로 입력되므로, 화면에 HTML 문서로 출력하기 위해 줄바꿈 태그인 </br>로 치환 
String intro = request.getParameter("intro").replace("\r\n", "<br/>");
%>
<ul>
	<li>아이디: <%=id %></li>
	<li>성별: <%=sex %></li>
	<li>관심사항: <%=favoStr %></li>
	<li>자기소개: <%=intro %></li>
</ul>
</body>
</html>
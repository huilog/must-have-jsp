<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>session 영역</title></head>
<body>
    <h2>페이지 이동 후 session 영역의 속성 읽기</h2>
    <%
    /*  실제로 session 객체의 영역을 시험해보기위해 웹 브라우저를 종료한 후 새로 연 다음
		session에 lists를 저장하는 로직을 가진 SessionMain.jsp를 실행하지않고,
		바로 SessionLocation.jsp, 즉 현재 페이지를 실행하면 NullPointerException이 발생하는걸 확인할 수 있다.
	*/
    ArrayList<String> lists = (ArrayList<String>)session.getAttribute("lists"); 
    for (String str : lists)
        out.print(str + "<br/>");
    %>    
</body>
</html>

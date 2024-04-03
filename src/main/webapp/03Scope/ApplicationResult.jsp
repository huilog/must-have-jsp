<%@ page import="java.util.Set"%>
<%@ page import="common.Person"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>application 영역</title></head>
<body>
    <h2>application 영역의 속성 읽기</h2>
    <%
    /*  실제로 application 객체의 영역을 시험해보기위해 웹 서버를 재기동 한 후
    	application에 maps를 저장하는 로직을 가진 ApplicationMain.jsp를 실행하지않고,
    	바로 ApplicationResult.jsp, 즉 현재 페이지를 실행하면 NullPointerException이 발생하는걸 확인할 수 있다.
    */
    Map<String, Person> maps
            = (Map<String, Person>)application.getAttribute("maps");
    Set<String> keys = maps.keySet(); 
    for (String key : keys) {
        Person person = maps.get(key);
        out.print(String.format("이름 : %s, 나이 : %d<br/>", 
                person.getName(), person.getAge()));
    }  
    %>
</body>
</html>
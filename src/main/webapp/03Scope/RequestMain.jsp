<%@ page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setAttribute("requestString", "request 영역의 문자열");
request.setAttribute("requestPerson", new Person("안중근", 31)); 
%>
<html>
<head><title>request 영역</title></head>
<body>
    <h2>request 영역의 속성값 삭제하기</h2>
    <%
        request.removeAttribute("requestString"); 
        request.removeAttribute("requestInteger"); // 에러 없음
    %>
    <h2>request 영역의 속성값 읽기</h2>
    <%
    Person rPerson = (Person)(request.getAttribute("requestPerson"));
    %>
    <ul>
        <li>String 객체 : <%= request.getAttribute("requestString") %></li>
        <li>Person 객체 : <%= rPerson.getName() %>, <%= rPerson.getAge() %></li>
    </ul>
    <h2>포워드된 페이지에서 request 영역 속성값 읽기</h2>
    <%
    //request 내장 객체를 통해 forward를 수행하는 코드
    //포워드 시 쿼리스트링으로 매개변수를 전달할 수도 있음
    request.getRequestDispatcher("RequestForward.jsp?paramHan=한글&paramEng=English")  
        .forward(request, response);
    
    /*
    상기 코드는 아래와 같이 작성할 수도 있음
    RequestDispatcher 객체가 요청을 다른 페이지로 넘겨주는 기능을 수행함.
    RequestDispatcher rd = request.getRequestDispatcher("RequestForward.jsp?paramHan=한글&paramEng=English");
    rd.forward(request, response);
    */
    %>
</body>
</html>
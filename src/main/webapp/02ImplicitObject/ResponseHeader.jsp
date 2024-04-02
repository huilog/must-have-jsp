<%@ page import="java.util.Collection"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 응답 헤더에 추가할 값 준비 
SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm");
long add_date = s.parse(request.getParameter("add_date")).getTime(); 

//form 태그를 통해 전송되는 값은 항상 String 타입이므로, add_int도 문자열로 얻어짐
//따라서, 해당 값을 정수 형태로 사용하기 위해서는 형변환을 해야함.
int add_int = Integer.parseInt(request.getParameter("add_int"));

String add_str = request.getParameter("add_str");

// 응답 헤더에 값 추가.
// response 내장 객체는 응답 헤더에 정보를 추가하는 기능을 제공함.
// 정보 추가용 메서드는 add 계열과 set 계열이 있음
// add 계열은 헤더값을 새로 추가할 떄 사용하고, set 계열은 기존 값을 수정할 때 사용함.
response.addDateHeader("myBirthday", add_date);

response.addIntHeader("myNumber", add_int);
//바로 위에 myMumber라는 헤더값을 추가했으나, add를 사용해서 추가하고 있으므로 같은 header명으로 값이 추가됨
response.addIntHeader("myNumber", 1004);
response.addHeader("myName", add_str);
//set을 사용해서 데이터를 추가할때는 기존 헤더값이 새로 추가하는 값으로 수정됨
response.setHeader("myName", "안중근");  // 수정
%>
<html>
<head><title>내장 객체 - response</title></head>
<body>
    <h2>응답 헤더 정보 출력하기</h2>
    <%
    Collection<String> headerNames = response.getHeaderNames();
    for (String hName : headerNames) {
        String hValue = response.getHeader(hName);
    %>
        <li><%= hName %> : <%= hValue %></li>
    <%
    }   
    %>
    
    <h2>myNumber만 출력하기</h2>
    <%
    //getHeader() 메서드는 해당 header명으로 값이 여러개여도 항상 첫번째 값만 가져오기 때문에
    //해당 header명 값이 여러개일 경우 배열을 통해 확인할 수 있음
	Collection<String> myNumber = response.getHeaders("myNumber");
	for (String myNum : myNumber) {
	%>
		<li>myNumber : <%= myNum %></li>
	<%
	}
	%>
</body>
</html>
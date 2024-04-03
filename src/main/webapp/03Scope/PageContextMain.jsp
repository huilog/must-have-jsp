<%-- 1. common.Person import --%>
<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//2. 속성 저장
/* description
	: pageContext 내장 객체를 이용해 page 영역에 속성값 저장
	  객체가 아닌 기본 타입 값들은 해당 래퍼 클래스(Wrapper Class)로 AutoBoxing 된 후 저장됨.(Integer, Float 등)
*/ 
pageContext.setAttribute("pageInteger", 1000);
pageContext.setAttribute("pageString", "페이지 영역의 문자열");
pageContext.setAttribute("pagePerson", new Person("한석봉", 99));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page 영역</title>
</head>
<body>
	<h2>page 영역의 속성 값 읽기</h2>
	<%	
		//3. 속성 읽기
		/* description
			: 2번에서 저장한 속성 값 읽어오기.
			  단, 모든 속성이 Object 타입으로 저장되어 있으므로 다시 원래의 타입으로 다운캐스팅 함.
			  String 타입은 다운캐스팅하지 않고 toString() 메서드를 사용해 문자열로 변환해서 변수에 대입함.
		*/ 
		int pInteger = (Integer)(pageContext.getAttribute("pageInteger"));
		String pString = pageContext.getAttribute("pageString").toString();
		Person pPerson = (Person)(pageContext.getAttribute("pagePerson"));
	%>
	<ul>
		<li>Integer 객체: <%=pInteger %></li>
		<li>String 객체: <%=pString%></li>
		<li>Person 객체: <%=pPerson.getName()%>, <%=pPerson.getAge()%></li>
	</ul>
	
	<%-- Description
		 : include 지시어로 다른 JSP 파일을 현재 파일에 포함시키는 것.
		   말 그대로 '포함 관계'이기 때문에 두 개의 페이지는 같은 페이지가 된다.
		   따라서, page 영역이 그대로 유지된다.
	--%>
	<h2>include 된 파일에서 page 영역 읽어오기</h2>
	<%@ include file="PageInclude.jsp" %>
	
	<%-- Description
		 : 다른 페이지로 '이동' 시에는 현재 page 영역이 소멸된다.
	--%>	
	<h2>페이지 이동 후 page 영역 읽어오기</h2>
	<a href="PageLocation.jsp">PageLocation.jsp 바로가기</a>
</body>
</html>
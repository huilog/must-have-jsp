<%@page import="common.Person"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL Core 태그 지시어 선언 -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - set 1</title>
</head>
<%--
	- <c:set> 태그는 EL에서 사용할 변수나 자바빈즈를 생성할 때 사용함.
	- JSP에서 영역에 속성을 저장할 때 사용하는 setAttribute() 메서드와 같은 역할을 함.
 --%>
<body>
	<!--  변수 선언 -->
	<c:set var="directVar" value="100" /> 
	<c:set var="elVar" value=" ${ directVar mod 5 }" /> 
	<c:set var="expVar" value="<%= new Date() %>" /> 
	<c:set var="betweenVar">변수값 요렇게 설정</c:set>
	
	<!-- scope 속성을 사용하지 않았으므로 모두 page 영역에 저장됨 -->
	<h4>EL을 이용해 변수 출력</h4>
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar : ${ expVar }</li>
		<li>betweenVar : ${ betweenVar }</li>
	</ul> 
	
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<c:set var="personVar1" value='<%= new Person("박문수", 50) %>' scope="request" />
	<ul>
		<li>이름: ${ requestScope.personVar1.name }</li>
		<li>나이: ${ personVar1.age }</li>
	</ul>
	
	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<c:set var="personVar2" value="<%= new Person() %>" scope="request" />
	<!-- target 속성에는 변수를 지정하고, property 속성에는 멤버 변수명을 지정해서 사용하면 됨 -->
	<c:set target="${personVar2 }" property="name" value="정약용" />
	<c:set target="${personVar2 }" property="age" value="60" />
	<ul>
		<li>나이: ${ personVar2.name }</li>
		<li>이름: ${ requestScope.personVar2.age }</li>
	</ul>
</body>
</html>
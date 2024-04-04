<%@page import="el.MyELClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/MyTagLib.tld" %>
<%
MyELClass myClass = new MyELClass(); //객체 생성
pageContext.setAttribute("myClass", myClass); //EL에서 사용하기 위해 page 영역에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 메서드 호출</title>
</head>
<body>
	<h3>영역에 저장 후 메서드 호출하기</h3>
	001225-3000000 => ${ myClass.getGender("001225-3000000") } <br />
	001225-2000000 => ${ myClass.getGender("001225-2000000") }
	
	<h3>클래스명을 통해 정적 메서드 호출하기</h3>
	${ MyELClass.showGugudan(7) }
	
	
	<!-- Tag Library Descriptor란, 사용자 정의 태그나 JSTL 태그들을 설정하기 위한 XML 파일이다.
		TLD는 JSP 2.0(톰캣 5.5)부터 사용하던 방식이다.
		클래스명을 통해 정적 메서드를 호출하는 것이 훨씬 간단하지만, 실무에서는 예전 코드를 이어받아 관리해야 할 일도 많기 때문에 해당 방식도 설명함.
	 -->
	<h3>TLD(Tag Library Descriptor) 파일 등록 후 정적 메서드 호출하기</h3>
	<ul>
		<li>mytag:isNumber("100") => ${ mytag:isNumber("100") }</li>
		<li>mytag:isNumber("이백") => ${ mytag:isNumber("이백") }</li>
	</ul>
	
</body>
</html>
<%--
	Description
	: include로 포함시킬 파일을 작성할 때는 page 지시어를 제외한 나머지 HTML 코드를 모두 삭제한 후 작성하도록 한다.
	  include는 문서 안에 또 다른 문서를 포함하는 형태이므로 태그가 중복될 수 있기 때문이다.
 --%>

<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4>Include 페이지</h4>
<%
	int pInteger2 = (Integer)pageContext.getAttribute("pageInteger");
	//String pString2 = pageContext.getAttribute("pageString").toString();
	Person pPerson2 = (Person)pageContext.getAttribute("pagePerson");
%>

<ul>
	<li>Integer 객체: <%=pInteger2 %></li>
	<%-- 저장한 객체가 문자열이거나, 기본 타입의 래퍼 클래스라면 별도의 형변환 없이 출력해도 됨 --%>
	<li>String 객체: <%=pageContext.getAttribute("pageString") %></li>
	<li>Person 객체: <%=pPerson2.getName()%>, <%=pPerson2.getAge()%></li>
</ul>

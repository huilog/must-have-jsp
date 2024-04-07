<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>      
<html>
<%--
	<fmt:formatDate> 태그는 날짜와 시간 포맷을 지정하는 태그임.
 --%>
<head><title>JSTL - fmt 2</title></head>
<body>
    <c:set var="today" value="<%= new java.util.Date() %>" />
    
    <%-- 날짜 포맷을 출력하기 위해 type을 date로 설정. 날짜 스타일은 dateStyle 속성에 각각 지정함. --%>
    <h4>날짜 포맷</h4>
    full : <fmt:formatDate value="${ today }" type="date" dateStyle="full"/> <br /> 
    short : <fmt:formatDate value="${ today }" type="date" dateStyle="short"/> <br />
    long : <fmt:formatDate value="${ today }" type="date" dateStyle="long"/> <br />
    default : <fmt:formatDate value="${ today }" type="date" dateStyle="default"/>

	<%-- 시간 포맷을 출력하기 위해 type을 time으로 설정. 시간 스타일은 timeStyle 속성에 각각 지정함. --%>
    <h4>시간 포맷</h4> 
    full : <fmt:formatDate value="${ today }" type="time" timeStyle="full"/> <br /> 
    short : <fmt:formatDate value="${ today }" type="time" timeStyle="short"/> <br />
    long : <fmt:formatDate value="${ today }" type="time" timeStyle="long"/> <br />
    default : <fmt:formatDate value="${ today }" type="time" timeStyle="default"/>
    
    <%-- 날짜와 시간을 동시에 출력함. 스타일 대신 pattern 속성을 직접 지정할 수도 있음 --%>
    <h4>날짜/시간 표시</h4>    
    <fmt:formatDate value="${ today }" type="both" dateStyle="full" timeStyle="full"/> 
    <br />
    <fmt:formatDate value="${ today }" type="both" pattern="yyyy-MM-dd hh:mm:ss"/> 
    
    <!-- 시간대(타임존)를 별도로 설정하지 않으면 시스템의 시간대가 반영됨 -->
    <h4>타임존 설정</h4>
    <!-- GMT - 세계 협정 시로, 대한민국보다 9시간 빠름. -->
    <fmt:timeZone value="GMT"> 
        <fmt:formatDate value="${ today }" type="both" dateStyle="full" timeStyle="full"/>
        <br />    
    </fmt:timeZone>
    <!-- 특정 지역명으로도 설정 가능 -->
    <fmt:timeZone value="America/Chicago">
        <fmt:formatDate value="${ today }" type="both" dateStyle="full" timeStyle="full"/>
    </fmt:timeZone>
</body>
</html>
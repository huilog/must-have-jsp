<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="x" uri="jakarta.tags.xml" %>
<html>
<%--
	JSTL의 xml 태그는 XML 문서를 처리하기 위한 것으로, XML 파싱 및 출력, 흐름 제어 등의 기능을 제공함.
	XML 태그를 사용하려면 다음의 지시어가 선언되어야 함. 접두어는 'x' 사용
	<%@ taglib prefix="x" uri="jakarta.tags.xml" %>
 --%>
<%--
	XML(eXtensible Markup Language)이란?
	: 확장이 가능한 마크업 언어로, HTML과 비슷하게 태그로 데이터를 표현하지만 XML은 태그를 개발자가 직접 정의할 수 있고 데이터를 기술할 수 있는 언어이다.
	또한 데이터를 보여주는게 목적인 HTML과 달리, XML은 데이터를 저장하고 전달할 목적으로 만들어졌다.
	따라서, 웹 애플리케이션 사이에서 데이터를 전달하는 역할을 한다.
 --%>
<head><title>JSTL - xml</title></head>
<body>
	<c:set var="booklist">
		<%-- 외부의 xml 문서를 사용하기 위해 import core 태그 사용
		 외부 문서를 파싱할 때는 charEncoding 속성으로 인코딩 방식을 정확히 지정해야 한글이 깨지지 않음
		 --%>
    	<c:import url="/11JSTL/inc/BookList.xml" charEncoding="UTF-8" />
    </c:set>
	
	<%-- 위에서 set 태그로 선언한 변수를 파싱해줄 x:parse 태그를 선언 --%>
    <x:parse xml="${booklist}" var="blist" />
     
    <%-- x:out 태그를 이용해 파싱된 내용을 출력함. select 속성의 값이 바로 XPath임.
    	XPath는 EL과 다르게 {}(중괄호)를 사용하지 않음. 일반적인 경로를 기술할 때와 마찬가지로 /(슬래시)로 노드를 타고 들어가면 됨.--%>
    <h4>파싱 1</h4>
    제목 : <x:out select="$blist/booklist/book[1]/name" /> <br />
    저자 : <x:out select="$blist/booklist/book[1]/author" /> <br />
    가격 : <x:out select="$blist/booklist/book[1]/price" /> <br />
    
    <h4>파싱 2</h4>
    <table border="1">
        <tr>
            <th>제목</th><th>저자</th><th>가격</th>
        </tr>
        <%-- 반복되는 경로가 있을때는 x:foreach 태그를 사용하는 것이 편함.
        	 여기서 반복되는 노드는 book이므로, select 속성에 지정한 후 그 개수만큼 반복한다.
        	 선택된 요소는 var 속성에 지정한 'item'을 사용해 출력하면 됨.
         --%>
        <x:forEach select="$blist/booklist/book" var="item">
        <tr>
            <td><x:out select="$item/name" /></td>
            <td><x:out select="$item/author" /></td>
            <td>
                <x:choose>
                    <x:when select="$item/price >= 20000"> 
                        2만 원 이상 <br />
                    </x:when>
                    <x:otherwise>
                        2만 원 미만 <br />
                    </x:otherwise>
                </x:choose>
            </td>        
        </tr>
        </x:forEach>
    </table> 
        
    <h4>파싱 3</h4>
    <table border="1">
        <x:forEach select="$blist/booklist/book" var="item">
        <tr>
            <td><x:out select="$item/name" /></td>
            <td><x:out select="$item/author" /></td>
            <td><x:out select="$item/price" /></td>
            <%-- x:if 태그를 사용해 문자열을 비교함. XML 태그에서는 비교 연산자로 == 대신 =을 사용하니 주의해야 함. --%>
            <td><x:if select="$item/name = '총,균,쇠'">구매함</x:if></td> 
        </tr>
        </x:forEach>    
    </table>
</body>
</html>
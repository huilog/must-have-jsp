<%@page import="java.awt.Checkbox"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginId = CookieManager.readCookie(request, "loginId");
	String cookieChk = "";
	
	if(!loginId.equals("")) {
		cookieChk = "checked";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 저장하기</title>
</head>
<body>
	<h2>로그인 페이지</h2>
	<form method="post" action="IdSaveProcess.jsp">
		ID: <input type="text" name="user_id" value="<%=loginId%>"/>
		<input type="checkbox" name="save_check" value="Y" <%=cookieChk%>/>
		아이디 저장하기
		</br>
		PWD: <input type="text" name="user_pwd"/>
		</br>
		<input type="submit" value="로그인하기"/>
	</form>
</body>
</html>
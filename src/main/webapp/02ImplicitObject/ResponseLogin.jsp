<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - Response</title>
</head>
<body>
<%
	//1. request 내장 객체로 전송된 매개변수 얻어오기
	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");
	
	//2. 회원 인증 진행. 데이터베이스를 연결하지 않았음으로 계정 정보를 must/1234로 하드코딩
	if(id.equalsIgnoreCase("must") && pwd.equalsIgnoreCase("1234")) {
		//3. 인증 성공 시 sendRedirect() 메서드에 인수로 입력한 페이지로 이동 (js의 location.href와 같은 기능)
		response.sendRedirect("ResponseWelcome.jsp");
	} else {
		//4. 인증 실패 시 request 내장 객체를 통해 로그인 페이지(ResponseMain.jsp)로 forward(전달)됨.
		//포워드는 페이지 이동과는 다르게 제어 흐름을 넘겨주고자 할 때 사용함.
		//해당 코드는 쿼리스트링으로 loginErr의 값을 1로 넘겨 로그인 성공 여부를 알려주고 있음.
		//forward를 사용하면 브라우저 화면에는 ResponseMain.jsp의 내용이 출력되지만, URL은 그대로 ResponseLogin.jsp로 표시됨
		//forward는 이처럼 실행의 흐름만 특정한 페이지로 넘겨주는 역할을 함
		request.getRequestDispatcher("ResponseMain.jsp?loginErr=1").forward(request, response);
	}
%>
</body>
</html>
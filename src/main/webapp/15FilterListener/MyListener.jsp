<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//매개변수로 전송된 mode 값 받아오기
	String mode = request.getParameter("mode");
	//최초 실행 시에는 매개변수가 없으므로 아래 if문 실행되지않음
	if (mode != null && mode.equals("1")) {
		session.setAttribute("mySession", "세션 영역");
	} else if ((mode != null && mode.equals("2"))) {
		session.removeAttribute("mySession");		
	} else if((mode != null && mode.equals("3"))) {
		session.invalidate(); //세션 무효화
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyListener.jsp</title>
<script>
function formSubmit(form, modeValue) {
	form.mode.value = modeValue;
	form.submit();
}
</script>
</head>
<body>
	<h2>리스너 활용하기</h2>
	<form>
		<input type="hidden" name="mode" />
		
		<input type="button" value="세션 속성 저장" onclick="formSubmit(this.form, 1);" /> 
		<input type="button" value="세션 속성 삭제" onclick="formSubmit(this.form, 2);" /> 
		<input type="button" value="세션 전체 삭제" onclick="formSubmit(this.form, 3);" /> 
	</form>
</body>
</html>
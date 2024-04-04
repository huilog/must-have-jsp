<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
//폼값 받기
String num= request.getParameter("num");

//DAO 객체를 통해 DB에 DTO 저장
BoardDAO dao = new BoardDAO(application);
BoardDTO dto = dao.selectView(num);

String sessionId = session.getAttribute("UserId").toString();

if(sessionId.equals(dto.getId())){
	int result = dao.deletePost(dto);
	dao.close();

	//성공 or 실패?
	if (result == 1) {
		//삭제 성공 시 목록 페이지로 이동
		JSFunction.alertLocation("삭제되었습니다", "List.jsp", out);
	} else {
		//실패 시 이전 페이지로 이동
		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}	
}else{
	JSFunction.alertBack("본인만 삭제할 수 있습니다", out);
	return;
}

%>

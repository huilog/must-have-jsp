<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
//폼값 받기
String num= request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

//폼값 을 DTO 객체에 저장
BoardDTO dto = new BoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

//DAO 객체를 통해 DB에 DTO 저장
BoardDAO dao = new BoardDAO(application);
int result = dao.updateEdit(dto);
dao.close();

//성공 or 실패?
if (result == 1) {
	//수정 성공 시 상세 페이지로 이동
	response.sendRedirect("View.jsp?num="+dto.getNum());
} else {
	//실패 시 이전 페이지로 이동
	JSFunction.alertBack("수정에 실패하였습니다.", out);
}
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
</head>
<body>
	<h2>회원 추가 테스트(executeUpdate() 사용)</h2>
	<%
	//JDBC 프로그래밍은 다음 순서로 진행됨
	//테이블에 따라 쿼리문만 달라질 뿐, 전체적인 순서는 항상 동일하다.
	
	//1. JDBC 드라이버 로드 및 DB에 연결
	JDBConnect jdbc = new JDBConnect(application);
	
	//2. 쿼리문 작성
	String sql = "SELECT id, pass, name, regidate FROM member";
	
	//3. 쿼리문(Statement 계열) 객체 생성
	Statement stmt = jdbc.con.createStatement();
	
	//4. 쿼리 실행
	ResultSet rs = stmt.executeQuery(sql);
	
	//5. 실행 결과 처리
	while(rs.next()) {
		String id = rs.getString(1);
		String pw = rs.getString(2);
		String name = rs.getString("name");
		java.sql.Date regidate = rs.getDate("regidate");
		
		out.println(String.format("%s %s %s %s", id, pw, name, regidate) + "</br>");
	}
	
	//6. 연결 해제
	jdbc.close();
	%>
</body>
</html>
package servlet;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import membership.MemberDAO;
import membership.MemberDTO;

public class MemberAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberDAO dao;
       
	@Override
	public void init() throws ServletException { //서블릿 초기화 시 JDBC 연결하여 dao 객체 생성
		// application 내장 객체 얻기
		ServletContext application = this.getServletContext();
		
		//web.xml에서 DB 연결 정보 얻기
		String driver = application.getInitParameter("OracleDriver");
		String connectUrl = application.getInitParameter("OracleURL");
		String oId = application.getInitParameter("OracleId");
		String oPass = application.getInitParameter("OraclePwd");
		
		//DAO 생성
		dao = new MemberDAO(driver, connectUrl, oId, oPass);
	}


	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { //클라이언트 요청 처리할 service 메서드 정의
		// 서블릿 초기화 매개변수에서 관리자 ID 받기
		String admin_id = this.getInitParameter("admin_id");
		
		//인증을 요청한 ID/패스워드
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		//회원 테이블에서 인증 요청한 ID/패스워드에 해당하는 회원 찾기
		MemberDTO memberDTO = dao.getMemberDTO(id, pass);
		
		//찾은 회원의 이름에 따른 처리
		String memberName = memberDTO.getName();
		
		if(memberName != null) { //일치하는 회원 찾음
			request.setAttribute("authMessage", memberName + "회원님 방가방가^^*");
		} else { //일치하는 회원 없음
			if (admin_id.equals(id)) { //관리자
				request.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			}else {
				request.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
			}
		}
		request.getRequestDispatcher("/12Servlet/MemberAuth.jsp").forward(request, response);
	}

	@Override
	public void destroy() {//서블릿 객체 소멸 시 DAO 객체의 close() 메서드를 호출하여 JDBC에서 사용하던 객체를 메모리에서 소멸시킴.
		dao.close();
	}
	
}

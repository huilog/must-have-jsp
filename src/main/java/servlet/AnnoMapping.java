package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet 애너테이션을 이용해 이 서블릿이 요청명 "/12Servlet/AnnoMapping.do"를 처리할 것임을 선언.
//요청명은 web.xml에서 <url-pattern>에 입력한 값과 똑같이, 컨텍스트 루트를 제외한 경로를 입력하면 됨.
@WebServlet("/12Servlet/AnnoMapping.do")
public class AnnoMapping extends HttpServlet {
	/* 직렬화 된 클래스의 버전 관리에 사용되는 식별자.
	 * 선언하지 않더라도 실행에는 문제가 없지만, Warning(경고)으로 표시되므로 명시적으로 선언해주는 것이 좋음.
	*/
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setAttribute("message", "@WebServlet으로 매핑");
		//request 영역에 저장된 데이터는 포워드 된 페이지까지 공유되므로 해당 속성을 출력할 수 있음
		req.getRequestDispatcher("/12Servlet/AnnoMapping.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}

}

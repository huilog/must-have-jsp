package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet {
	/* 직렬화 된 클래스의 버전 관리에 사용되는 식별자.
	 * 선언하지 않더라도 실행에는 문제가 없지만, Warning(경고)으로 표시되므로 명시적으로 선언해주는 것이 좋음.
	*/
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setAttribute("message", "Hello Servlet..!!");
		//request 영역에 저장된 데이터는 포워드 된 페이지까지 공유되므로 해당 속성을 출력할 수 있음
		req.getRequestDispatcher("/12Servlet/HelloServlet.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}

}

package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import membership.MemberDAO;
import membership.MemberDTO;
import utils.JSFunction;

@WebFilter(filterName = "LoginFilter", urlPatterns = "/15FilterListener/LoginFilter.jsp")
public class LoginFilter implements Filter{
	//회원 정보를 얻어오기 위해 필요한 데이터베이스 접속 정보
	String oracleDriver, oracleURL, oracleId, oraclePwd;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		ServletContext application = filterConfig.getServletContext();
		
		oracleDriver = application.getInitParameter("OracleDriver");
		oracleURL = application.getInitParameter("OracleURL");
		oracleId = application.getInitParameter("OracleId");
		oraclePwd = application.getInitParameter("OraclePwd");
		
		System.out.println("LoginFilter init() call");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//doFilter 매개변수 request와 response를 Http용 타입으로 형변환
		//HttpServletRequest와 HttpServletResponse는 ServletRequest와 ServletResponse에 HTTP 관련 기능을 추가한 하위 타입임.(다형성)
		//따라서, session 내장 객체나 HTTP 전송 방식(메서드)과 같은 HTTP 개념을 활용하려면 이렇게 형변환을 해줘야 함.(다운캐스팅)
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		HttpSession session = req.getSession();
		String method = req.getMethod();
		
		if(method.equals("POST")) { //로그인 처리
			//로그인 정보와 일치하는 회원 확인
			String user_id = request.getParameter("user_id");
			String user_pw = request.getParameter("user_pw");
			
			MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
			MemberDTO dto = dao.getMemberDTO(user_id, user_pw);
			dao.close();
			
			if(dto.getId() != null) { //일치하는 회원 존재
				//세션에 로그인 정보 저장
				session.setAttribute("UserId", dto.getId());
				session.setAttribute("UserName", dto.getName());
				
				//다음 페이지로 이동
				String backUrl = request.getParameter("backUrl");
				if( backUrl != null && !backUrl.equals("")) {
					JSFunction.alertLocation(resp, "로그인 전 요청한 페이지로 이동합니다.", backUrl);
					return;
				} else {
					resp.sendRedirect("../15FilterListener/LoginFilter.jsp");
				}
			} else { //일치하는 회원 없음
				req.setAttribute("LoginErrMsg", "로그인에 실패했습니다.");
				req.getRequestDispatcher("../15FilterListener/LoginFilter.jsp").forward(req, resp);
			}
		} else if(method.equals("GET")) { //로그아웃 처리
			String mode = request.getParameter("mode");
			if (mode != null && mode.equals("logout")) {
				session.invalidate();
			}
		}
		chain.doFilter(request, response);
	}

}

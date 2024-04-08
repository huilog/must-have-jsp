package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", req.getParameter("mode"));
		req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//매개변수 저장
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		
		//비밀번호 확인
		MVCBoardDAO dao = new MVCBoardDAO();
		boolean confirmed = dao.confirmPassword(pass, idx);
		dao.close();
		
		if(confirmed) { //비밀번호 일치
			if(mode.equals("edit")) {//수정 모드
				HttpSession session = req.getSession();
				session.setAttribute("pass", pass);
				resp.sendRedirect("../mvcboard/edit.do?idx=" + idx);
				
				/*
				 * 비밀번호를 session 영역에 저장한 이유
				 * : 수정하기 페이지의 요청명은 "edit.do?idx=일련번호" 형태임.
				 * 만약 사용자가 이 URL 패턴을 이미 알고 있다면 비밀번호 검증 없이도 곧바로 수정하기 페이지에 접속할 수 있게됨.
				 * 비밀번호 검증을 건너뛰고 수정하기 페이지에 접속하여 게시물을 수정하는 것을 방지하기 위해 검증이 완료된 비밀번호를 session 영역에 저장해놓고,
				 * 수정 시 저장된 비밀번호가 없다면 정상적인 경로로 접속하지 않은 것으로 판단하기 위해 session 영역에 비밀번호를 저장함.
				 */
			}else if(mode.equals("delete")) {//삭제 모드
				dao = new MVCBoardDAO();
				MVCBoardDTO dto = dao.selectView(idx);
				int result = dao.deletePost(idx); //게시물 삭제
				dao.close();
				if(result == 1) { //게시물 삭제 성공 시 첨부 파일도 삭제
					String saveFileName = dto.getSfile();
					FileUtil.deleteFile(req, "/Uploads", saveFileName);
				}
				JSFunction.alertLocation(resp, "삭제되었습니다", "../mvcboard/list.do");
			}
		} else { //비밀번호 불일치
			JSFunction.alertBack(resp, "비밀번호 검증에 실패했습니다.");
		}
	}
}

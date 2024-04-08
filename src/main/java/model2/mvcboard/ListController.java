package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.BoardPage;

public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//DAO 생성
    	MVCBoardDAO dao = new MVCBoardDAO();
    	
    	//뷰에 전달할 매개변수 저장용 맵 생성;
    	Map<String, Object> map = new HashMap<String, Object>();
    	String searchField = request.getParameter("searchField");
    	String searchWord = request.getParameter("searchWord");
    	if(searchWord != null) {
    		//쿼리 스트링으로 전달받은 매개변수 중 검색어가 있다면 map에 저장
    		map.put("searchField", searchField);
    		map.put("searchWord", searchWord);
    	}
    	int totalCount = dao.selectCount(map);
    	
    	/*페이지 처리 start*/
    	ServletContext application = getServletContext();
    	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
    	int blockpage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
    	
    	//현재 페이지 확인
    	int pageNum = 1; //기본값
    	String pageTemp = request.getParameter("pageNum");
    	if(pageTemp != null && !pageTemp.equals("")) {
    		pageNum = Integer.parseInt(pageTemp); //요청받은 페이지로 수정
    	}
    	
    	//목록에 출력할 게시물 범위 계산
    	int start = (pageNum - 1) * pageSize + 1; //첫 게시물 번호
    	int end = pageNum * pageSize; //마지막 게시물 번호
    	map.put("start", start);
    	map.put("end", end);
    	/* 페이지 처리 end */
    	
    	//게시물 목록 받기
    	List<MVCBoardDTO> boardLists = dao.selectListPage(map);
    	dao.close();//DB 연결 닫기
    	
    	//뷰에 전달할 매개변수 추가
    	String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockpage, pageNum, "../mvcboard/list.do");
    	//페이지 바로가기 영역 HTML 문자열
    	map.put("pagingImg", pagingImg);
    	//게시물 개수
    	map.put("totalCount", totalCount);
    	//페이지당 게시물 개수
    	map.put("pageSize", pageSize);
    	//현재 페이지
    	map.put("pageNum", pageNum);
    	
    	//전달할 데이터를 request 영역에 저장 후 List.jsp로 포워드
    	request.setAttribute("boardLists", boardLists);
    	request.setAttribute("map", map);
    	request.getRequestDispatcher("/14MVCBoard/List.jsp").forward(request, response);
    }
}

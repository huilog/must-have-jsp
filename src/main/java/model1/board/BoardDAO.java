package model1.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class BoardDAO extends JDBConnect{

	public BoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	//검색 조건에 맞는 게시물의 개수를 반환함
	public int selectCount(Map<String, Object> map) {
		//결과(게시물 수)를 담을 변수
		int totalCount = 0;
		
		//게시물 수를 얻어오는 쿼리문 작성
		String query = "SELECT COUNT(*) FROM board";
		if (map.get("searchWord") != null) {
			query += " WHERE" + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'"; 
		}
		try {
			stmt = con.createStatement(); //쿼리문 생성
			rs = stmt.executeQuery(query); //쿼리 실행
			rs.next();//커서를 첫 번째 행으로 이동
			totalCount = rs.getInt(1); //첫 번째 컬럼 값을 가져옴
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<BoardDTO> selectList(Map<String, Object> map) {
		List<BoardDTO> bbs = new ArrayList<BoardDTO>(); //결과(게시물 목록)을 담을 변수 선언 및 초기화
		
		String query = "SELECT * FROM board";
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
			query += " ORDER BY num DESC ";
		
		try {
			stmt = con.createStatement(); //쿼리문 생성
			rs = stmt.executeQuery(query); //쿼리문 실행
			
			while(rs.next()) {//결과를 순회하며
				//한 행(게시물 하나)의 내용을 DTO에 저장
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num")); //일련번호
				dto.setTitle(rs.getString("title")); //제목
				dto.setContent(rs.getString("content")); //내용
				dto.setPostdate(rs.getDate("postdate")); //작성일
				dto.setId(rs.getString("id")); //작성자 아이디
				dto.setVisitcount(rs.getString("Visitcount")); //조회수
				
				bbs.add(dto); //결과 목록에 저장
			}
			
		} catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
			
		return bbs;
	}
	
	//검색 조건에 맞는 게시물 목록 반환(페이징 기능 지원)
	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		List<BoardDTO> bbs = new ArrayList<BoardDTO>(); //결과(게시물 목록)을 담을 변수 선언 및 초기화
		
		String query = "SELECT * FROM ("
						+ "SELECT Tb.*, rownum rNum FROM ( "
						+ " SELECT * FROM board "; 
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
			query += " ORDER BY num DESC "
					+  " ) Tb"
					+ ") WHERE rNum BETWEEN ? AND ? ";
		
		try {
			psmt = con.prepareStatement(query); //쿼리문 생성
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			
			rs = psmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {//결과를 순회하며
				//한 행(게시물 하나)의 내용을 DTO에 저장
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num")); //일련번호
				dto.setTitle(rs.getString("title")); //제목
				dto.setContent(rs.getString("content")); //내용
				dto.setPostdate(rs.getDate("postdate")); //작성일
				dto.setId(rs.getString("id")); //작성자 아이디
				dto.setVisitcount(rs.getString("visitcount")); //조회수
				
				bbs.add(dto); //결과 목록에 저장
			}
			
		} catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
			
		return bbs;
	}
	
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			//INSERT 쿼리문 작성
			String query = "INSERT INTO board ("
					 		+ " num, title, content, id, visitcount)"
					 		+ " VALUES ("
					 		+ " seq_board_num.NEXTVAL, ?, ?, ?, 0)";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//지정한 게시물을 찾아 내용을 반환
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		
		//쿼리문 준비
		String query = "SELECT B.*, M.name "
						+ " FROM member M INNER JOIN board B "
						+ " ON M.id = B.id "
						+ " WHERE num = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			//결과 처리
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	//지정한 게시물의 조회수 1 증가
	public void updateVisitCount(String num) {
		//쿼리문 준비
		String query = "UPDATE board SET"
					+ " visitcount=visitcount+1"
					+ " WHERE num = ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num); //인파라미터를 일련번호로 설정
			psmt.executeQuery();	//쿼리 실행
		} catch(Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	//지정한 게시물 내용 수정
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		//쿼리문 준비
		String query = "UPDATE board SET"
					+ " title=?, content=?"
					+ " WHERE num = ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			result = psmt.executeUpdate();	//쿼리 실행
		} catch(Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int deletePost(BoardDTO dto) {
		int result = 0;
		try {
			String query = "DELETE FROM board WHERE num = ? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("삭제 처리 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

}

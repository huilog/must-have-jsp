package fileupload;

import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import common.DBConnPool;

public class MyFileDAO extends DBConnPool {
	// 새로운 게시물 입력
	public int insertFile(MyFileDTO dto) {
		int applyResult = 0;
		try {
			String query = "INSERT INTO myfile ("
					+ "idx, title, cate, ofile, sfile) "
					+ "VALUES ("
					+ "seq_board_num.nextval, ?, ?, ?,?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getCate());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			
			applyResult = psmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("INSERT 중 예외 발생");
			e.printStackTrace();
		}
		return applyResult;
	}
	
	//파일 목록 반환
	public List<MyFileDTO> myFileList() {
		List<MyFileDTO> fileList = new Vector<MyFileDTO>();
		
		try {
			//쿼리문 작성
			String query = "SELECT * FROM myfile ORDER BY idx DESC";
			stmt = con.createStatement();	//statement 객체 생성
			rs = stmt.executeQuery(query); // 쿼리 실행
			
			while(rs.next()) { //목록 안의 파일 수만큼 반복
				//DTO에 저장
				MyFileDTO dto = new MyFileDTO();
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setCate(rs.getString("cate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setPostdate(rs.getString("postdate"));
				
				fileList.add(dto); //목록에 추가
			}
		} catch (SQLException e) {
			System.out.println("첨부파일 목록 SELECT 시 예외 발생");
			e.printStackTrace();
		}
		
		return fileList;
	}

}

package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletContext;

public class JDBConnect {
	//데이터베이스와 연결 담당
	public Connection con;
	//인파라미터가 없는 정적 쿼리문을 실행할 때 사용
	public Statement stmt;
	/*	- 인파라미터가 있는 동적 쿼리문을 실행할 때 사용.
		- 인파라미터는 쿼리문 작성 시 매개변수로 전달된 값을 설정할 때 사용. ?(물음표)로 표현함.
	*/
	public PreparedStatement psmt;
	//SELECT 쿼리문의 결과를 저장할 때 사용
	public ResultSet rs;
	
	public JDBConnect() {
		try {
			//JDBC 드라이버 로드
			//forName() : new 키워드 대신 클래스명을 통해 직접 객체를 생성한 후 메모리에 로드하는 메서드
			Class.forName("oracle.jdbc.OracleDriver");
			
			//DB에 연결
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String id = "musthave";
			String pwd = "1234";
			
			//DBMS 연결에 성공하면 connection 객체가 반환됨. 해당 connection 객체를 통해 오라클에 연결하는 것.
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(기본 생성자)");
			
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public JDBConnect(String driver, String url, String id, String pwd) {
		try {
			//JDBC 드라이버 로드
			//forName() : new 키워드 대신 클래스명을 통해 직접 객체를 생성한 후 메모리에 로드하는 메서드
			Class.forName(driver);
			
			//DBMS 연결에 성공하면 connection 객체가 반환됨. 해당 connection 객체를 통해 오라클에 연결하는 것.
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(인수 생성자1)");
			
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public JDBConnect(ServletContext application) {
		try {
			
			String driver = application.getInitParameter("OracleDriver");
			//JDBC 드라이버 로드
			//forName() : new 키워드 대신 클래스명을 통해 직접 객체를 생성한 후 메모리에 로드하는 메서드
			Class.forName(driver);
			
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			
			//DBMS 연결에 성공하면 connection 객체가 반환됨. 해당 connection 객체를 통해 오라클에 연결하는 것.
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(인수 생성자2)");
			
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//연결 해제(자원 반납)
	public void close() {
		//DB 관련 작업을 모두 마쳤다면 자원을 절약하기 위해 연결을 해제해주는게 좋음.
		try {
			//멤버 변수로 선언된 객체 각각을 닫아줌.
			//if문을 통해 사용된 적이 있는 객체들만 자원을 해제하고 있음.
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (psmt != null) psmt.close();
			if (con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}

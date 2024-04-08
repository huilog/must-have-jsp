package fileupload;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/13FileUpload/MultipleProcess.do")
/*
 * 파일 업로드를 처리하기 위한 서블릿 구성 에너테이션.
 * 이를 통해 멀티파트 요청을 처리할 수 있고, Part 객체를 사용하여 업로드 된 파일의 정보에 접근할 수 있음
 * maxFileSize: 업로드 할 개별 파일의 최대 크기로, 1MB로 지정.
 * maxRequestSize: 멀티파트 요청에 포함된 전체 파일의 크기로, 10MB로 지정.
 */
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)
public class MultipleProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			/*Uploads 폴더의 '물리적 경로' 얻어오기.
			 * 물리적 경로란, 웹 서버의 절대 경로를 의미한다.
			 * 운영체제에 따라 드라이브나 경로를 표현하는 방법이 다르기 때문에 물리적 경로가 필요하다.
			*/
			String saveDirectory = getServletContext().getRealPath("/Uploads");
			//Uploads 폴더에 파일 업로드
			ArrayList<String> listFileName = FileUtil.multipleFile(request, saveDirectory);
			//서버에 저장된 파일명 변경 및 DB에 데이터 저장
			for(String originalFileName : listFileName) {
				String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
				insertMyFile(request, originalFileName, savedFileName);
			}
			
			//저장을 마쳤다면 파일리스트로 이동
			response.sendRedirect("FileList.jsp");
			
		} catch (Exception e) {
			//개별 파일의 크기가 1MB를 초과할 시 예외가 발생하므로, request 영역에 메시지를 저장한 후 FileUploadMain.jsp로 포워드
			e.printStackTrace();
			request.setAttribute("errorMessage", "파일 업로드 오류");
			request.getRequestDispatcher("MultiUploadMain.jsp").forward(request, response);
		}
	}
	
	private void insertMyFile(HttpServletRequest request, String oFileName, String sFileName) {
		String title = request.getParameter("title");
		String[] cateArray = request.getParameterValues("cate");
		StringBuffer cateBuf = new StringBuffer();
		if(cateArray == null) {
			cateBuf.append("선택한 항목 없음");
		} else {
			for(int i = 0; i < cateArray.length; i++) {
				if(i == (cateArray.length - 1)) {
					cateBuf.append(cateArray[i]);
					break;
				}
				cateBuf.append(cateArray[i] + ", ");
			}
		}
		
		MyFileDTO dto = new MyFileDTO();
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(oFileName);
		dto.setSfile(sFileName);
		
		MyFileDAO dao = new MyFileDAO();
		dao.insertFile(dto);
		dao.close();
	}

}

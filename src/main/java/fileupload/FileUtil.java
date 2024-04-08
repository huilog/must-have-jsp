package fileupload;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class FileUtil {

	public static String uploadFile(HttpServletRequest req, String sDirectory)
			//getPart()와 write() 메서드는 각각 ServletException, IOException에 대한 예외처리를 해야함
			throws ServletException, IOException {
		//request 내장 객체의 getPart() 메서드로 file 타입으로 전송된 폼값을 받아 Part 객체에 저장
		Part part = req.getPart("ofile");
		//content-disposition 헤더값 읽어오기. input 태그의 name 속성과 파일명이 포함되어있음
		String partHeader = part.getHeader("content-disposition");
		//헤더의 내용에서 파일명을 추출하기 위해 split() 메서드로 분리한 후 더블쿼테이션 제거
		String[] phArr = partHeader.split("filename=");
		String originalFileName = phArr[1].trim().replace("\"", "");
		//파일명이 빈 값이 아니라면 디렉터리에 파일 저장
		if(!originalFileName.isEmpty()) {
			part.write(sDirectory + File.separator + originalFileName);
		}
		
		//저장된 원본파일명 반환
		return originalFileName;
	}
	
	//파일명 변경
	public static String renameFile(String sDirectory, String fileName) {
		//원본 파일명 확장자 분리
		//lastIndexOf() 메서드를 사용하여 확장자를 가져오는 이유
		// => 파일명에 점(.)이 2개 이상 포함될 수 있으므로, 맨 끝 자리에서 구분자로 문자를 잘라서 가져와야 함.
		String ext = fileName.substring(fileName.lastIndexOf("."));
		//"현재날짜_시간" 형식의 문자열을 생성
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		//생성한 문자열과 원본 파일 확장자를 연결하여 새로운 파일명 생성
		String newFileName = now + ext;
		//원본 파일과 새로운 파일에 대한 File 객체를 생성한 후 파일명을 변경함
		File oldFile = new File(sDirectory + File.separator + fileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		
		//변경된 파일명 반환
		return newFileName;
	}
	
	//multiple 속성 추가로 2개 이상의 파일 업로드
	public static ArrayList<String> multipleFile (HttpServletRequest request, String sDirectory)
					throws ServletException, IOException {
		
		ArrayList<String> listFileName = new ArrayList<>();
		Collection<Part> parts = request.getParts();
		
		for(Part part : parts) {
			if(!part.getName().equals("ofile")) {
				continue;
			}
			
			String partHeader = part.getHeader("content-disposition");
			String[] phArr = partHeader.split("filename=");
			String originalFileName = phArr[1].trim().replace("\"", "");
			
			if (!originalFileName.isEmpty()) {
				part.write(sDirectory + File.separator + originalFileName);
			}
			
			listFileName.add(originalFileName);
		}
		
		return listFileName;
	}

}

package fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
	
	//명시한 파일을 찾아 다운로드
	public static void download(HttpServletRequest req, HttpServletResponse resp, String directory, String sfileName, String ofileName) {
		String sDirectory = req.getServletContext().getRealPath(directory);
		try {
			//파일을 찾아 입력 스트림 생성
			File file = new File(sDirectory, sfileName);
			InputStream iStream = new FileInputStream(file);
			
			//한글 파일명 깨짐 방지
			String client = req.getHeader("User-Agent");
			if(client.indexOf("WOW64") == -1) {
				ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
			} else {
				ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
			}
			
			//파일 다운로드용 응답 헤더 설정
			resp.reset();
			resp.setContentType("application/octet-stream");
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + ofileName + "\"");
			resp.setHeader("Content-Length", "" + file.length());
			
			
			//out.clear(); //출력 스트림 초기화 => JSP에서는 이 코드가 없으면 예외가 발생하지만, 서블릿에서는 예외가 발생하지않음
			
			//response 내장 객체로부터 새로운 출력 스트림 생성
			OutputStream oStream = resp.getOutputStream();
			
			//출력 스트림에 파일 내용 출력
			byte b[] = new byte[(int)file.length()];
			int readBuffer = 0;
			while( ( readBuffer = iStream.read(b)) > 0) {
				oStream.write(b, 0, readBuffer);
			}
			
			//입/출력 스트림 닫음
			iStream.close();
			oStream.close();
			
		} catch (FileNotFoundException e) {
		System.out.println("파일을 찾을 수 없습니다.");
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("예외가 발생하였습니다.");
			e.printStackTrace();
		}
	}
	
	//지정한 위치의 파일을 삭제
	public static void deleteFile(HttpServletRequest req, String directory, String filename) {
		String sDirectory = req.getServletContext().getRealPath(directory);
		File file = new File(sDirectory + File.separator + filename);
		if(file.exists()) {
			file.delete();
		}
	}

}

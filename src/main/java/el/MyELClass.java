package el;

public class MyELClass {

	//주민번호를 입력받아 성별 반환
	public String getGender(String jumin) {
		String returnStr = "";
		int beingIdx = jumin.indexOf("-") + 1;
		String genderStr = jumin.substring(beingIdx, beingIdx + 1);
		int genderInt = Integer.parseInt(genderStr);
		if(genderInt == 1 || genderInt == 3) {
			returnStr = "남자";
		} else if (genderInt == 2 || genderInt == 4) {
			returnStr = "여자";
		} else {
			returnStr = "주민번호 오류입니다.";
		}
		
		return returnStr;
	}
	
	//입력받은 문자열이 숫자인지 판별
	public static boolean isNumber(String value) {
		char[] chArr = value.toCharArray();
		//문자열에 숫자 이외의 문자가 하나라도 포함된다면 false 반환
		for (int i = 0; i <chArr.length; i++) {
			if (!(chArr[i] >= '0' && chArr[i] <= '9')) {
				return false;
			}
		}
		//전체가 숫자일때만 true 반환
		return true;
	}
	
	//입력받은 정수까지의 구구단을 HTML 테이블로 출력
	public static String showGugudan(int limitDan) {
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("<table border='1'>");
			for (int i = 2; i <= limitDan; i++) {
				sb.append("<tr>");
				for(int j = 1; j <= 9; j++) {
					sb.append("<td> &nbsp;" + i + " * " + j + " = " + (i * j) +"&nbsp; </td>");
				}
				sb.append("</tr>");
			}
			sb.append("</table>");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return sb.toString();
	}
	

}

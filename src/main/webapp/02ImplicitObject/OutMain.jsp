<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>내장 객체 - out</title></head>
<body>
	<%--
		- out 내장 객체: 웹 브라우저에 변수 등의 값을 출력할 때 사용
		- <%= %> 표현식이나, EL을 통해 편리하게 출력할 수 있으므로 out 내장 객체는 잘 사용하지 않지만,
		  <% %> 스크립틀릿 내에서 변수를 웹 브라우저에 출력해야한다면, 표현식보다는 out 객체를 사용하는 것이 좋음
		- out 내장 객체는 버퍼를 사용함. 출력되는 모든 정보는 버퍼에 먼저 저장된 후 웹 브라우저에 출력됨
		
		- 다음 과정을 통해 print()를 사용하면서 버퍼가 채워지다가 flush()로 출력한 후 buffer의 크기가 모두 복원된 것을 확인할 수 있음.
    	
    	* print 외에 println() 메서드도 있는데, 제일 끝에 줄바꿈 문자(\r\n)가 추가되는 것 말고는 다른 점이 없다.
    	  HTML에서 줄을 개행하기 위해서는 줄바꿈 문자(\r\n)가 아니라, 줄바꿈 태그(</br>)를 사용해야 함.
    	  따라서 HTML에서 print()와 println()의 차이는 띄어쓰기 한 칸이 적용되는 정도이다. 
	 --%>
    <%     
    // 버퍼 내용 삭제하기
    out.print("출력되지 않는 텍스트");  // 버퍼에 저장  
    out.clearBuffer();  // 버퍼를 비움(윗 줄의 출력 결과 사라짐) 

    out.print("<h2>out 내장 객체</h2>");

    // 버퍼 크기 정보 확인 - 따로 page 지시어에 buffer 속성을 선언하지 않았기 때문에 기본값인 8KB로 설정되어있음.
    out.print("출력 버퍼의 크기 : " + out.getBufferSize() + "<br>"); // getBufferSize() : 현재 페이지에 설정된 버퍼 크기 반환. Byte 단위로 출력됨.
    out.print("남은 버퍼의 크기 : " + out.getRemaining() + "<br>");  // getRemaining() : 사용하고 남은 버퍼 크기 반환.  Byte 단위로 출력됨.
	
    // 버퍼 내용 출력
    out.flush(); //flush(): 버퍼에 담긴 내용을 강제로 플러시함. 버퍼는 원래 모두 채워졌을 때 플러시되면서 내용을 출력하지만, 필요한 경우에는 이처럼 즉시 출력할 수 있음. 
    out.print("flush 후 버퍼의 크기 : " + out.getRemaining() + "<br>");

    // 다양한 타입의 값 출력
    out.print(1);
    out.print(false);
    out.print('가');
    %>
</body>
</html>
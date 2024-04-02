<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>내장 객체 - application</title></head>
<body>
    <h2>web.xml에 설정한 내용 읽어오기</h2>
    초기화 매개변수 : <%= application.getInitParameter("INIT_PARAM") %>

    <h2>서버의 물리적 경로 얻어오기</h2>
    application 내장 객체 : <%= application.getRealPath("/02ImplicitObject") %>

    <h2>선언부에서 application 내장 객체 사용하기</h2>
    <%!
    // 선언부에서 application 내장 객체를 사용하는 것은 불가능 함.
    // WHY? JSP의 내장 객체들은 _jspService() 메서드 내에 선언해서 사용하는 것이기 때문.
    // 따라서, this 키워드를 통해 application 내장 객체를 얻어오거나(get), 인수로 applicaiton 객체를 전달받아야 접근 가능함.
    public String useImplicitObject() {
        return this.getServletContext().getRealPath("/02ImplicitObject");
    }
    
    public String useImplicitObject(ServletContext app) {
        return app.getRealPath("/02ImplicitObject");
    }
    %>
    <ul>
    	<%--
    		output: "application 내장 객체 : C:\02Workspaces\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\mustHaveJSP\02ImplicitObject"
    		
    		-> 출력 내용이 실제 JSP 파일이 존재하는 위치와 다른 이유?
    		  : 이클립스를 사용했기 때문. 작성한 JSP 파일을 실행하면 이클립스는 별도의 디렉토리를 생성하여 서블릿 변환과 컴파일을 진행함.
    		  차후 톰캣에 배포한 후 실행하면 JSP 파일이 있는 위치가 그대로 출력될 것임.
    	 --%>
        <li>this 사용 : <%= useImplicitObject() %></li>
        <li>내장 객체를 인수로 전달 : <%= useImplicitObject(application) %></li>
    </ul>
</body>
</html>

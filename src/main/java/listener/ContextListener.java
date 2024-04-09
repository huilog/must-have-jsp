package listener;

import java.util.Enumeration;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

//웹 애플리케이션의 시작 및 종료 이벤트를 감지하기 위한 리스너 클래스 선언
public class ContextListener implements ServletContextListener{

	@Override
	public void contextInitialized(ServletContextEvent sce) { //웹 애플리케이션 시작 이벤트 감지
		Enumeration<String> apps = sce.getServletContext().getInitParameterNames();
		while(apps.hasMoreElements()) {
			System.out.println("[리스너] 컨텍스트 초기화 매개변수 생성 : " + apps.nextElement());
		}
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) { //웹 애플리케이션 종료 이벤트 감지
		Enumeration<String> apps = sce.getServletContext().getInitParameterNames();
		while(apps.hasMoreElements()) {
			System.out.println("[리스너] 컨텍스트 초기화 매개변수 소멸 : " + apps.nextElement());
		}
	}

}
